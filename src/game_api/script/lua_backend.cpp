#include "lua_backend.hpp"

#include "aliases.hpp"
#include "entities_chars.hpp"
#include "level_api.hpp"
#include "lua_console.hpp"
#include "lua_vm.hpp"
#include "overloaded.hpp"
#include "rpc.hpp"
#include "script_util.hpp"
#include "sound_manager.hpp"
#include "state.hpp"
#include "strings.hpp"

#include "usertypes/gui_lua.hpp"
#include "usertypes/level_lua.hpp"
#include "usertypes/save_context.hpp"
#include "usertypes/vanilla_render_lua.hpp"

#include "lua_libs/lua_libs.hpp"

#include <sol/sol.hpp>

std::recursive_mutex g_all_backends_mutex;
std::vector<LuaBackend*> g_all_backends;

LuaBackend::LuaBackend(SoundManager* sound_mgr, LuaConsole* con)
    : lua{get_lua_vm(sound_mgr), sol::create}, vm{acquire_lua_vm(sound_mgr)}, sound_manager{sound_mgr}, console{con}
{
    g_state = get_state_ptr();

    auto players = get_players();
    if (!players.empty())
        state.player = players.at(0);
    else
        state.player = nullptr;
    state.screen = g_state->screen;
    state.time_level = g_state->time_level;
    state.time_total = g_state->time_total;
    state.time_global = get_frame_count();
    state.frame = get_frame_count();
    state.loading = g_state->loading;
    state.reset = (g_state->quest_flags & 1);
    state.quest_flags = g_state->quest_flags;

    populate_lua_env(lua);

    std::lock_guard lock{g_all_backends_mutex};
    g_all_backends.push_back(this);
}
LuaBackend::~LuaBackend()
{
    {
        std::lock_guard lock{g_all_backends_mutex};
        std::erase(g_all_backends, this);
    }

    {
        auto& global_vm = *vm;
        for (const std::string& module : loaded_modules)
        {
            global_vm["package"]["loaded"][module] = sol::nil;
            global_vm["_G"][module] = sol::nil;
        }
    }

    clear_all_callbacks();
}

void LuaBackend::clear()
{
    std::lock_guard gil_guard{gil};

    clear_all_callbacks();

    (get_unsafe()
         ? expose_unsafe_libraries
         : hide_unsafe_libraries)(lua);
}
void LuaBackend::clear_all_callbacks()
{
    std::lock_guard gil_guard{gil};

    // Clear all callbacks on script reload to avoid running them
    // multiple times.
    level_timers.clear();
    global_timers.clear();
    callbacks.clear();
    for (auto id : vanilla_sound_callbacks)
    {
        sound_manager->clear_callback(id);
    }
    vanilla_sound_callbacks.clear();
    pre_tile_code_callbacks.clear();
    post_tile_code_callbacks.clear();
    pre_entity_spawn_callbacks.clear();
    post_entity_spawn_callbacks.clear();
    for (auto id : chance_callbacks)
    {
        g_state->level_gen->data->unregister_chance_logic_provider(id);
    }
    chance_callbacks.clear();
    for (auto id : extra_spawn_callbacks)
    {
        g_state->level_gen->data->undefine_extra_spawn(id);
    }
    extra_spawn_callbacks.clear();
    for (auto& [ent_uid, id] : entity_hooks)
    {
        if (Entity* ent = get_entity_ptr(ent_uid))
        {
            ent->unhook(id);
        }
    }
    for (auto& [ent_uid, id] : entity_dtor_hooks)
    {
        if (Entity* ent = get_entity_ptr(ent_uid))
        {
            ent->unhook(id);
        }
    }
    for (auto& [screen_id, id] : screen_hooks)
    {
        if (Screen* screen = get_screen_ptr(screen_id))
        {
            screen->unhook(id);
        }
    }
    for (auto& console_command : console_commands)
    {
        console->unregister_command(this, console_command);
    }
    entity_hooks.clear();
    clear_entity_hooks.clear();
    entity_dtor_hooks.clear();
    screen_hooks.clear();
    clear_screen_hooks.clear();
    options.clear();
    required_scripts.clear();
    console_commands.clear();
    lua["on_guiframe"] = sol::lua_nil;
    lua["on_frame"] = sol::lua_nil;
    lua["on_camp"] = sol::lua_nil;
    lua["on_start"] = sol::lua_nil;
    lua["on_level"] = sol::lua_nil;
    lua["on_transition"] = sol::lua_nil;
    lua["on_death"] = sol::lua_nil;
    lua["on_win"] = sol::lua_nil;
    lua["on_screen"] = sol::lua_nil;
}

bool LuaBackend::reset()
{
    clear();
    return true;
}

bool LuaBackend::update()
{
    if (!get_enabled())
        return true;

    if (!pre_update())
    {
        return false;
    }

    try
    {
        std::lock_guard gil_guard{gil};
        // Deprecated =======

        /// Use `set_callback(function, ON.FRAME)` instead
        sol::optional<sol::function> on_frame = lua["on_frame"];
        /// Use `set_callback(function, ON.CAMP)` instead
        sol::optional<sol::function> on_camp = lua["on_camp"];
        /// Use `set_callback(function, ON.LEVEL)` instead
        sol::optional<sol::function> on_level = lua["on_level"];
        /// Use `set_callback(function, ON.START)` instead
        sol::optional<sol::function> on_start = lua["on_start"];
        /// Use `set_callback(function, ON.TRANSITION)` instead
        sol::optional<sol::function> on_transition = lua["on_transition"];
        /// Use `set_callback(function, ON.DEATH)` instead
        sol::optional<sol::function> on_death = lua["on_death"];
        /// Use `set_callback(function, ON.WIN)` instead
        sol::optional<sol::function> on_win = lua["on_win"];
        /// Use `set_callback(function, ON.SCREEN)` instead
        sol::optional<sol::function> on_screen = lua["on_screen"];

        // ==========

        std::vector<Player*> players = get_players();
        lua["players"] = std::vector<Player*>(players);

        if (g_state->loading == 1 && g_state->loading != state.loading && g_state->screen_next != (int)ON::OPTIONS && g_state->screen != (int)ON::OPTIONS && g_state->screen_last != (int)ON::OPTIONS)
        {
            level_timers.clear();
            script_input.clear();
            clear_custom_shopitem_names();
        }
        if (g_state->screen != state.screen)
        {
            if (on_screen)
                on_screen.value()();
        }
        if (on_frame && g_state->time_level != state.time_level && g_state->screen == (int)ON::LEVEL)
        {
            on_frame.value()();
        }
        if (g_state->screen == (int)ON::CAMP && g_state->screen_last != (int)ON::OPTIONS && g_state->loading != state.loading && g_state->loading == 3)
        {
            if (on_camp)
                on_camp.value()();
        }
        if (g_state->screen == (int)ON::LEVEL && g_state->screen_last != (int)ON::OPTIONS && g_state->loading != state.loading && g_state->loading == 3)
        {
            if (g_state->level_count == 0)
            {
                if (on_start)
                    on_start.value()();
            }
            if (on_level)
                on_level.value()();
        }
        if (g_state->screen == (int)ON::TRANSITION && state.screen != (int)ON::TRANSITION)
        {
            if (on_transition)
                on_transition.value()();
        }
        if (g_state->screen == (int)ON::DEATH && state.screen != (int)ON::DEATH)
        {
            if (on_death)
                on_death.value()();
        }
        if ((g_state->screen == (int)ON::WIN && state.screen != (int)ON::WIN) || (g_state->screen == (int)ON::CONSTELLATION && state.screen != (int)ON::CONSTELLATION))
        {
            if (on_win)
                on_win.value()();
        }

        for (auto id : clear_callbacks)
        {
            level_timers.erase(id);
            global_timers.erase(id);
            callbacks.erase(id);
            load_callbacks.erase(id);

            std::erase_if(pre_tile_code_callbacks, [id](auto& cb)
                          { return cb.id == id; });
            std::erase_if(post_tile_code_callbacks, [id](auto& cb)
                          { return cb.id == id; });
            std::erase_if(pre_entity_spawn_callbacks, [id](auto& cb)
                          { return cb.id == id; });
            std::erase_if(post_entity_spawn_callbacks, [id](auto& cb)
                          { return cb.id == id; });
        }
        clear_callbacks.clear();

        for (auto& [ent_uid, id] : clear_entity_hooks)
        {
            auto it = std::find(entity_hooks.begin(), entity_hooks.end(), std::pair{ent_uid, id});
            if (it != entity_hooks.end())
            {
                Entity* entity = get_entity_ptr(ent_uid);
                if (entity)
                {
                    entity->unhook(id);
                }
                entity_hooks.erase(it);

                const int32_t entity_uid = ent_uid; // Clang doesn't let us reference a local binding in a lambda capture
                const size_t hooks_left_for_entity = std::count_if(entity_hooks.begin(), entity_hooks.end(), [entity_uid](auto& hook)
                                                                   { return hook.first == entity_uid; });
                if (hooks_left_for_entity == 0)
                {
                    auto dtor_it = std::find_if(entity_dtor_hooks.begin(), entity_dtor_hooks.end(), [entity_uid](auto& dtor_hook)
                                                { return dtor_hook.first == entity_uid; });
                    if (dtor_it != entity_dtor_hooks.end())
                    {
                        if (entity)
                        {
                            entity->unhook(dtor_it->second);
                        }
                        entity_dtor_hooks.erase(dtor_it);
                    }
                }
            }
        }
        clear_entity_hooks.clear();
        for (auto& [screen_id, id] : clear_screen_hooks)
        {
            auto it = std::find(screen_hooks.begin(), screen_hooks.end(), std::pair{screen_id, id});
            if (it != screen_hooks.end())
            {
                auto screen = get_screen_ptr(screen_id);
                if (screen != nullptr)
                {
                    screen->unhook(id);
                }
                screen_hooks.erase(it);
            }
        }
        clear_screen_hooks.clear();

        for (auto it = global_timers.begin(); it != global_timers.end();)
        {
            int now = get_frame_count();
            if (auto cb = std::get_if<IntervalCallback>(&it->second))
            {
                if (now >= cb->lastRan + cb->interval && !is_callback_cleared(it->first))
                {
                    set_current_callback(-1, it->first, CallbackType::Normal);
                    std::optional<bool> keep_going = handle_function_with_return<bool>(cb->func);
                    clear_current_callback();
                    cb->lastRan = now;
                    if (!keep_going.value_or(true))
                    {
                        it = global_timers.erase(it);
                        continue;
                    }
                }
                ++it;
            }
            else if (auto cbt = std::get_if<TimeoutCallback>(&it->second))
            {
                if (now >= cbt->timeout && !is_callback_cleared(it->first))
                {
                    set_current_callback(-1, it->first, CallbackType::Normal);
                    handle_function(cbt->func);
                    clear_current_callback();
                    it = global_timers.erase(it);
                }
                else
                {
                    ++it;
                }
            }
            else
            {
                ++it;
            }
        }

        auto now = get_frame_count();
        for (auto& [id, callback] : load_callbacks)
        {
            if (callback.lastRan < 0)
            {
                set_current_callback(-1, id, CallbackType::Normal);
                handle_function(callback.func, LoadContext{get_root(), get_name()});
                clear_current_callback();
                callback.lastRan = now;
            }
        }

        for (auto& [id, callback] : callbacks)
        {
            if (is_callback_cleared(id))
                continue;

            set_current_callback(-1, id, CallbackType::Normal);
            if ((ON)g_state->screen == callback.screen && g_state->screen != state.screen && g_state->screen_last != (int)ON::OPTIONS) // game screens
            {
                handle_function(callback.func);
                callback.lastRan = now;
            }
            else if (callback.screen == ON::LEVEL && g_state->screen == (int)ON::LEVEL && g_state->screen_last != (int)ON::OPTIONS && state.loading != g_state->loading && g_state->loading == 3)
            {
                handle_function(callback.func);
                callback.lastRan = now;
            }
            else if (callback.screen == ON::CAMP && g_state->screen == (int)ON::CAMP && g_state->screen_last != (int)ON::OPTIONS && state.loading != g_state->loading && g_state->loading == 3)
            {
                handle_function(callback.func);
                callback.lastRan = now;
            }
            else
            {
                switch (callback.screen)
                {
                case ON::FRAME:
                {
                    if (g_state->time_level != state.time_level && g_state->screen == (int)ON::LEVEL)
                    {
                        handle_function(callback.func);
                        callback.lastRan = now;
                    }
                    break;
                }
                case ON::GAMEFRAME:
                {
                    if (!g_state->pause && get_frame_count() != state.time_global &&
                        ((g_state->screen >= (int)ON::CAMP && g_state->screen <= (int)ON::DEATH) || g_state->screen == (int)ON::ARENA_MATCH))
                    {
                        handle_function(callback.func);
                        callback.lastRan = now;
                    }
                    break;
                }
                case ON::SCREEN:
                {
                    if (g_state->screen != state.screen)
                    {
                        handle_function(callback.func);
                        callback.lastRan = now;
                    }
                    break;
                }
                case ON::START:
                {
                    if (g_state->screen == (int)ON::LEVEL && g_state->screen_last != (int)ON::OPTIONS && g_state->level_count == 0 && g_state->loading != state.loading && g_state->loading == 3)
                    {
                        handle_function(callback.func);
                        callback.lastRan = now;
                    }
                    break;
                }
                case ON::LOADING:
                {
                    if (g_state->loading > 0 && g_state->loading != state.loading)
                    {
                        handle_function(callback.func);
                        callback.lastRan = now;
                    }
                    break;
                }
                case ON::RESET:
                {
                    if ((g_state->quest_flags & 1) > 0 && (g_state->quest_flags & 1) != state.reset)
                    {
                        handle_function(callback.func);
                        callback.lastRan = now;
                    }
                    break;
                }
                case ON::SAVE:
                {
                    if (g_state->loading != state.loading && g_state->loading == 1)
                    {
                        handle_function(callback.func, SaveContext{get_root(), get_name()});
                        callback.lastRan = now;
                    }
                    break;
                }
                default:
                    break;
                }
            }
            clear_current_callback();
        }
        const int now_l = g_state->time_level;
        for (auto it = level_timers.begin(); it != level_timers.end();)
        {
            if (auto cb = std::get_if<IntervalCallback>(&it->second))
            {
                if (now_l >= cb->lastRan + cb->interval && !is_callback_cleared(it->first))
                {
                    set_current_callback(-1, it->first, CallbackType::Normal);
                    std::optional<bool> keep_going = handle_function_with_return<bool>(cb->func);
                    clear_current_callback();
                    cb->lastRan = now_l;
                    if (!keep_going.value_or(true))
                    {
                        it = level_timers.erase(it);
                        continue;
                    }
                }
                ++it;
            }
            else if (auto cbt = std::get_if<TimeoutCallback>(&it->second))
            {
                if (now_l >= cbt->timeout && !is_callback_cleared(it->first))
                {
                    set_current_callback(-1, it->first, CallbackType::Normal);
                    handle_function(cbt->func);
                    clear_current_callback();
                    it = level_timers.erase(it);
                }
                else
                {
                    ++it;
                }
            }
            else
            {
                ++it;
            }
        }

        if (!players.empty())
            state.player = players.at(0);
        else
            state.player = nullptr;
        state.screen = g_state->screen;
        state.time_level = g_state->time_level;
        state.time_total = g_state->time_total;
        state.time_global = get_frame_count();
        state.frame = get_frame_count();
        state.loading = g_state->loading;
        state.reset = (g_state->quest_flags & 1);
        state.quest_flags = g_state->quest_flags;
    }
    catch (const sol::error& e)
    {
        result = e.what();
        return false;
    }
    return true;
}

void LuaBackend::draw(ImDrawList* dl)
{
    if (!get_enabled())
        return;

    draw_list = dl;
    try
    {
        std::lock_guard gil_guard{gil};

        if (!pre_draw())
        {
            return;
        }

        // Deprecated
        /// Use `set_callback(function, ON.GUIFRAME)` instead
        sol::optional<sol::function> on_guiframe = lua["on_guiframe"];

        GuiDrawContext draw_ctx(this, dl);

        if (on_guiframe)
        {
            on_guiframe.value()(draw_ctx);
        }

        for (auto& [id, callback] : callbacks)
        {
            if (is_callback_cleared(id))
                continue;

            auto now = get_frame_count();
            if (callback.screen == ON::GUIFRAME)
            {
                set_current_callback(-1, id, CallbackType::Normal);
                handle_function(callback.func, draw_ctx);
                clear_current_callback();
                callback.lastRan = now;
            }
        }
    }
    catch (const sol::error& e)
    {
        result = e.what();
    }
    draw_list = nullptr;
}

void LuaBackend::render_options()
{
    ImGui::PushID(get_id());
    for (auto& name_option_pair : options)
    {
        std::visit(
            overloaded{
                [&](IntOption& option)
                {
                    if (ImGui::DragInt(name_option_pair.second.desc.c_str(), &option.value, 0.5f, option.min, option.max))
                    {
                        auto& name = name_option_pair.first;
                        lua["options"][name] = option.value;
                    }
                },
                [&](FloatOption& option)
                {
                    if (ImGui::DragFloat(name_option_pair.second.desc.c_str(), &option.value, 0.5f, option.min, option.max))
                    {
                        auto& name = name_option_pair.first;
                        lua["options"][name] = option.value;
                    }
                },
                [&](BoolOption& option)
                {
                    if (ImGui::Checkbox(name_option_pair.second.desc.c_str(), &option.value))
                    {
                        auto& name = name_option_pair.first;
                        lua["options"][name] = option.value;
                    }
                },
                [&](StringOption& option)
                {
                    if (InputString(name_option_pair.second.desc.c_str(), &option.value, 0, nullptr, nullptr))
                    {
                        auto& name = name_option_pair.first;
                        lua["options"][name] = option.value;
                    }
                },
                [&](ComboOption& option)
                {
                    if (ImGui::Combo(name_option_pair.second.desc.c_str(), &option.value, option.options.c_str()))
                    {
                        auto& name = name_option_pair.first;
                        lua["options"][name] = option.value + 1;
                    }
                },
                [&](ButtonOption& option)
                {
                    if (ImGui::Button(name_option_pair.second.desc.c_str()))
                    {
                        uint64_t now =
                            std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
                        auto& name = name_option_pair.first;
                        lua["options"][name] = now;
                        handle_function(option.on_click);
                    }
                },
            },
            name_option_pair.second.option_impl);
        if (!name_option_pair.second.long_desc.empty())
        {
            ImGui::TextWrapped("%s", name_option_pair.second.long_desc.c_str());
        }
    }
    ImGui::PopID();
}

bool LuaBackend::is_callback_cleared(int32_t callback_id)
{
    return std::find(clear_callbacks.begin(), clear_callbacks.end(), callback_id) != clear_callbacks.end();
}
bool LuaBackend::is_entity_callback_cleared(std::pair<int, uint32_t> callback_id)
{
    return std::find(clear_entity_hooks.begin(), clear_entity_hooks.end(), callback_id) != clear_entity_hooks.end();
}
bool LuaBackend::is_screen_callback_cleared(std::pair<int, uint32_t> callback_id)
{
    return std::find(clear_screen_hooks.begin(), clear_screen_hooks.end(), callback_id) != clear_screen_hooks.end();
}

bool LuaBackend::pre_tile_code(std::string_view tile_code, float x, float y, int layer, uint16_t room_template)
{
    if (!get_enabled())
        return false;

    for (auto& callback : pre_tile_code_callbacks)
    {
        if (is_callback_cleared(callback.id))
            continue;

        if (callback.tile_code == tile_code)
        {
            if (handle_function_with_return<bool>(callback.func, x, y, layer, room_template).value_or(false))
            {
                return true;
            }
        }
    }
    return false;
}
void LuaBackend::post_tile_code(std::string_view tile_code, float x, float y, int layer, uint16_t room_template)
{
    if (!get_enabled())
        return;

    for (auto& callback : post_tile_code_callbacks)
    {
        if (is_callback_cleared(callback.id))
            continue;

        if (callback.tile_code == tile_code)
        {
            set_current_callback(-1, callback.id, CallbackType::Normal);
            handle_function(callback.func, x, y, layer, room_template);
            clear_current_callback();
        }
    }
}

void LuaBackend::pre_load_level_files()
{
    if (!get_enabled())
        return;

    auto now = get_frame_count();

    std::lock_guard lock{gil};
    for (auto& [id, callback] : callbacks)
    {
        if (is_callback_cleared(id))
            continue;

        if (callback.screen == ON::PRE_LOAD_LEVEL_FILES)
        {
            set_current_callback(-1, id, CallbackType::Normal);
            handle_function(callback.func, PreLoadLevelFilesContext{});
            clear_current_callback();
            callback.lastRan = now;
        }
    }
}
void LuaBackend::pre_level_generation()
{
    if (!get_enabled())
        return;

    auto now = get_frame_count();

    std::lock_guard lock{gil};

    lua["players"] = std::vector<Player*>(get_players());

    for (auto& [id, callback] : callbacks)
    {
        if (is_callback_cleared(id))
            continue;

        if (callback.screen == ON::PRE_LEVEL_GENERATION)
        {
            set_current_callback(-1, id, CallbackType::Normal);
            handle_function(callback.func);
            clear_current_callback();
            callback.lastRan = now;
        }
    }
}
void LuaBackend::post_room_generation()
{
    if (!get_enabled())
        return;

    auto now = get_frame_count();

    std::lock_guard lock{gil};
    for (auto& [id, callback] : callbacks)
    {
        if (is_callback_cleared(id))
            continue;

        if (callback.screen == ON::POST_ROOM_GENERATION)
        {
            set_current_callback(-1, id, CallbackType::Normal);
            handle_function(callback.func, PostRoomGenerationContext{});
            clear_current_callback();
            callback.lastRan = now;
        }
    }
}
void LuaBackend::post_level_generation()
{
    if (!get_enabled())
        return;

    auto now = get_frame_count();

    std::lock_guard lock{gil};

    lua["players"] = std::vector<Player*>(get_players());

    for (auto& [id, callback] : callbacks)
    {
        if (is_callback_cleared(id))
            continue;

        if (callback.screen == ON::POST_LEVEL_GENERATION)
        {
            set_current_callback(-1, id, CallbackType::Normal);
            handle_function(callback.func);
            clear_current_callback();
            callback.lastRan = now;
        }
    }
}

std::string LuaBackend::pre_get_random_room(int x, int y, uint8_t layer, uint16_t room_template)
{
    if (!get_enabled())
        return std::string{};

    auto now = get_frame_count();

    std::lock_guard lock{gil};
    for (auto& [id, callback] : callbacks)
    {
        if (is_callback_cleared(id))
            continue;

        if (callback.screen == ON::PRE_GET_RANDOM_ROOM)
        {
            callback.lastRan = now;
            set_current_callback(-1, id, CallbackType::Normal);
            std::string return_value = handle_function_with_return<std::string>(callback.func, x, y, layer, room_template).value_or(std::string{});
            clear_current_callback();
            if (!return_value.empty())
            {
                return return_value;
            }
        }
    }
    return std::string{};
}
LuaBackend::PreHandleRoomTilesResult LuaBackend::pre_handle_room_tiles(LevelGenRoomData room_data, int x, int y, uint16_t room_template)
{
    if (!get_enabled())
        return {false, std::nullopt};

    auto now = get_frame_count();

    PreHandleRoomTilesContext ctx{room_data};

    std::lock_guard lock{gil};
    for (auto& [id, callback] : callbacks)
    {
        if (is_callback_cleared(id))
            continue;

        if (callback.screen == ON::PRE_HANDLE_ROOM_TILES)
        {
            callback.lastRan = now;
            set_current_callback(-1, id, CallbackType::Normal);
            if (handle_function_with_return<bool>(callback.func, x, y, room_template, ctx).value_or(false))
            {
                clear_current_callback();
                return {true, ctx.modded_room_data};
            }
            clear_current_callback();
        }
    }
    return {false, ctx.modded_room_data};
}

Entity* LuaBackend::pre_entity_spawn(std::uint32_t entity_type, float x, float y, int layer, Entity* overlay, int spawn_type_flags)
{
    if (!get_enabled())
        return nullptr;

    for (auto& callback : pre_entity_spawn_callbacks)
    {
        if (is_callback_cleared(callback.id))
            continue;

        bool mask_match = callback.entity_mask == 0 || (get_type(entity_type)->search_flags & callback.entity_mask);
        bool flags_match = callback.spawn_type_flags & spawn_type_flags;
        if (mask_match && flags_match)
        {
            bool type_match = callback.entity_types.empty() || std::count(callback.entity_types.begin(), callback.entity_types.end(), entity_type) > 0;
            if (type_match)
            {
                set_current_callback(-1, callback.id, CallbackType::Normal);
                if (auto spawn_replacement = handle_function_with_return<std::uint32_t>(callback.func, entity_type, x, y, layer, overlay, spawn_type_flags))
                {
                    clear_current_callback();
                    return get_entity_ptr(spawn_replacement.value());
                }
                clear_current_callback();
            }
        }
    }
    return nullptr;
}
void LuaBackend::post_entity_spawn(Entity* entity, int spawn_type_flags)
{
    if (!get_enabled())
        return;

    for (auto& callback : post_entity_spawn_callbacks)
    {
        if (is_callback_cleared(callback.id))
            continue;

        bool mask_match = callback.entity_mask == 0 || (entity->type->search_flags & callback.entity_mask);
        bool flags_match = callback.spawn_type_flags & spawn_type_flags;
        if (mask_match && flags_match)
        {
            bool type_match = callback.entity_types.empty() || std::count(callback.entity_types.begin(), callback.entity_types.end(), entity->type->id) > 0;
            if (type_match)
            {
                set_current_callback(-1, callback.id, CallbackType::Normal);
                handle_function(callback.func, lua["cast_entity"](entity), spawn_type_flags);
                clear_current_callback();
            }
        }
    }
}

void LuaBackend::process_vanilla_render_callbacks(ON event)
{
    if (!get_enabled())
        return;

    auto now = get_frame_count();
    VanillaRenderContext render_ctx;
    for (auto& [id, callback] : callbacks)
    {
        if (is_callback_cleared(id))
            continue;

        if (callback.screen == event)
        {
            set_current_callback(-1, id, CallbackType::Normal);
            handle_function(callback.func, render_ctx);
            clear_current_callback();
            callback.lastRan = now;
        }
    }
}

void LuaBackend::process_vanilla_render_draw_depth_callbacks(ON event, uint8_t draw_depth, const AABB& bbox)
{
    if (!get_enabled())
        return;

    auto now = get_frame_count();
    VanillaRenderContext render_ctx;
    render_ctx.bounding_box = bbox;
    for (auto& [id, callback] : callbacks)
    {
        if (is_callback_cleared(id))
            continue;

        if (callback.screen == event)
        {
            set_current_callback(-1, id, CallbackType::Normal);
            handle_function(callback.func, render_ctx, draw_depth);
            clear_current_callback();
            callback.lastRan = now;
        }
    }
}

void LuaBackend::process_vanilla_render_journal_page_callbacks(ON event, JournalPageType page_type, JournalPage* page)
{
    if (!get_enabled())
        return;

    auto now = get_frame_count();
    VanillaRenderContext render_ctx;
    for (auto& [id, callback] : callbacks)
    {
        if (is_callback_cleared(id))
            continue;

        if (callback.screen == event)
        {
            set_current_callback(-1, id, CallbackType::Normal);
            handle_function(callback.func, render_ctx, page_type, page);
            clear_current_callback();
            callback.lastRan = now;
        }
    }
}

void LuaBackend::hook_entity_dtor(Entity* entity)
{
    if (std::count_if(entity_dtor_hooks.begin(), entity_dtor_hooks.end(), [entity](auto& dtor_hook)
                      { return dtor_hook.first == entity->uid; }) == 0)
    {
        std::uint32_t dtor_hook_id = entity->set_on_dtor([this](Entity* _entity)
                                                         { pre_entity_destroyed(_entity); });
        entity_dtor_hooks.push_back({entity->uid, dtor_hook_id});
    }
}
void LuaBackend::pre_entity_destroyed(Entity* entity)
{
    [[maybe_unused]] auto num_erased_hooks = std::erase_if(entity_hooks, [entity](auto& hook)
                                                           { return hook.first == entity->uid; });
    assert(num_erased_hooks != 0);
    [[maybe_unused]] auto num_erased_dtors = std::erase_if(entity_dtor_hooks, [entity](auto& dtor_hook)
                                                           { return dtor_hook.first == entity->uid; });
    assert(num_erased_dtors == 1);
}

std::u16string LuaBackend::pre_speach_bubble(Entity* entity, char16_t* buffer)
{
    if (!get_enabled())
        return std::u16string{no_return_str};

    auto now = get_frame_count();
    std::lock_guard lock{gil};

    std::optional<std::u16string> return_value = std::nullopt;

    for (auto& [id, callback] : callbacks)
    {
        if (is_callback_cleared(id))
            continue;

        if (callback.screen == ON::SPEECH_BUBBLE)
        {
            callback.lastRan = now;
            set_current_callback(-1, id, CallbackType::Normal);
            if (auto speech_value = handle_function_with_return<std::u16string>(callback.func, lua["cast_entity"](entity), buffer))
            {
                if (!return_value)
                {
                    return_value = speech_value;
                }
            }
            clear_current_callback();
        }
    }
    return return_value.value_or(std::u16string{no_return_str});
}

std::u16string LuaBackend::pre_toast(char16_t* buffer)
{
    if (!get_enabled())
        return std::u16string{no_return_str};

    auto now = get_frame_count();
    std::lock_guard lock{gil};

    std::optional<std::u16string> return_value = std::nullopt;

    for (auto& [id, callback] : callbacks)
    {
        if (is_callback_cleared(id))
            continue;

        if (callback.screen == ON::TOAST)
        {
            callback.lastRan = now;
            set_current_callback(-1, id, CallbackType::Normal);
            if (auto toast_value = handle_function_with_return<std::u16string>(callback.func, buffer))
            {
                if (!return_value)
                {
                    return_value = toast_value;
                }
            }
            clear_current_callback();
        }
    }
    return return_value.value_or(std::u16string{no_return_str});
}

void LuaBackend::for_each_backend(std::function<bool(LuaBackend&)> fun)
{
    std::lock_guard lock{g_all_backends_mutex};
    for (auto* backend : g_all_backends)
    {
        if (!fun(*backend))
        {
            break;
        }
    }
}
LuaBackend* LuaBackend::get_backend(std::string_view id)
{
    std::lock_guard lock{g_all_backends_mutex};
    for (auto* backend : g_all_backends)
    {
        if (backend->get_path() == id)
        {
            return backend;
        }
    }
    return nullptr;
}
LuaBackend* LuaBackend::get_backend_by_id(std::string_view id, std::string_view ver)
{
    std::lock_guard lock{g_all_backends_mutex};
    for (auto* backend : g_all_backends)
    {
        if (backend->get_id() == id && (ver == "" || ver == backend->get_version()))
        {
            return backend;
        }
    }
    return nullptr;
}
LuaBackend* LuaBackend::get_calling_backend()
{
    static const sol::state& lua = get_lua_vm();
    auto get_script_id = lua["get_script_id"];
    if (get_script_id.get_type() == sol::type::function)
    {
        auto script_id = get_script_id();
        if (script_id.get_type() == sol::type::string)
        {
            return LuaBackend::get_backend(script_id.get<std::string_view>());
        }
    }
    return nullptr;
}

CurrentCallback LuaBackend::get_current_callback()
{
    return current_cb;
}

void LuaBackend::set_current_callback(int uid, int id, CallbackType type)
{
    current_cb.uid = uid;
    current_cb.id = id;
    current_cb.type = type;
}

void LuaBackend::clear_current_callback()
{
    current_cb.uid = -1;
    current_cb.id = -1;
    current_cb.type = CallbackType::None;
}
