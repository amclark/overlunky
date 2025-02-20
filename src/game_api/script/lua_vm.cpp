#include "lua_vm.hpp"

#include <csignal>

#include "entities_items.hpp"
#include "entities_monsters.hpp"
#include "entity.hpp"
#include "game_manager.hpp"
#include "items.hpp"
#include "level_api.hpp"
#include "online.hpp"
#include "rpc.hpp"
#include "savedata.hpp"
#include "settings_api.hpp"
#include "spawn_api.hpp"
#include "state.hpp"
#include "strings.hpp"

#include "lua_backend.hpp"
#include "lua_console.hpp"
#include "lua_require.hpp"
#include "script_util.hpp"

#include "usertypes/char_state_lua.hpp"
#include "usertypes/drops_lua.hpp"
#include "usertypes/entities_activefloors_lua.hpp"
#include "usertypes/entities_backgrounds_lua.hpp"
#include "usertypes/entities_chars_lua.hpp"
#include "usertypes/entities_decorations_lua.hpp"
#include "usertypes/entities_floors_lua.hpp"
#include "usertypes/entities_fx_lua.hpp"
#include "usertypes/entities_items_lua.hpp"
#include "usertypes/entities_liquids_lua.hpp"
#include "usertypes/entities_logical_lua.hpp"
#include "usertypes/entities_monsters_lua.hpp"
#include "usertypes/entities_mounts_lua.hpp"
#include "usertypes/entity_casting_lua.hpp"
#include "usertypes/entity_lua.hpp"
#include "usertypes/flags_lua.hpp"
#include "usertypes/game_manager_lua.hpp"
#include "usertypes/gui_lua.hpp"
#include "usertypes/hitbox_lua.hpp"
#include "usertypes/level_lua.hpp"
#include "usertypes/particles_lua.hpp"
#include "usertypes/player_lua.hpp"
#include "usertypes/prng_lua.hpp"
#include "usertypes/save_context.hpp"
#include "usertypes/screen_arena_lua.hpp"
#include "usertypes/screen_lua.hpp"
#include "usertypes/socket_lua.hpp"
#include "usertypes/sound_lua.hpp"
#include "usertypes/state_lua.hpp"
#include "usertypes/texture_lua.hpp"
#include "usertypes/vanilla_render_lua.hpp"

#include "lua_libs/lua_libs.hpp"

void load_libraries(sol::state& lua)
{
    lua.open_libraries(sol::lib::math, sol::lib::base, sol::lib::string, sol::lib::table, sol::lib::coroutine, sol::lib::package);
    require_json_lua(lua);
    require_inspect_lua(lua);
    require_format_lua(lua);

    register_custom_require(lua);
}
void load_unsafe_libraries(sol::state& lua)
{
    lua.open_libraries(sol::lib::io, sol::lib::os, sol::lib::ffi, sol::lib::debug);
    require_serpent_lua(lua);
    NSocket::register_usertypes(lua);
}
void populate_lua_state(sol::state& lua, SoundManager* sound_manager)
{
    auto infinite_loop = [](lua_State* argst, [[maybe_unused]] lua_Debug* argdb)
    {
        luaL_error(argst, "Hit Infinite Loop Detection of 1bln instructions");
    };

    lua_sethook(lua.lua_state(), NULL, 0, 0);
    lua_sethook(lua.lua_state(), infinite_loop, LUA_MASKCOUNT, 1000000000);

    lua.safe_script(R"(
-- This function walks up the stack until it finds an _ENV that is not _G
-- That _ENV has to be the environment of a script where we can look up the scripts id
get_script_id = function()
    -- Not available in Lua 5.2+
    local getfenv = getfenv or function(f)
        f = (type(f) == 'function' and f or debug.getinfo(f + 1, 'f').func)
        local name, val
        local up = 0
        repeat
            up = up + 1
            name, val = debug.getupvalue(f, up)
        until name == '_ENV' or name == nil
        return val
    end

    local env
    local up = 1
    repeat
        up = up + 1
        env = getfenv(up)
    until env ~= _G and env ~= nil
    return env.__script_id
end
)");

    NHitbox::register_usertypes(lua);
    NSound::register_usertypes(lua, sound_manager);
    NLevel::register_usertypes(lua);
    NGui::register_usertypes(lua);
    NVanillaRender::register_usertypes(lua);
    NTexture::register_usertypes(lua);
    NEntity::register_usertypes(lua);
    NEntitiesChars::register_usertypes(lua);
    NEntitiesFloors::register_usertypes(lua);
    NEntitiesActiveFloors::register_usertypes(lua);
    NEntitiesBG::register_usertypes(lua);
    NEntitiesDecorations::register_usertypes(lua);
    NEntitiesLogical::register_usertypes(lua);
    NEntitiesMounts::register_usertypes(lua);
    NEntitiesMonsters::register_usertypes(lua);
    NEntitiesItems::register_usertypes(lua);
    NEntitiesFX::register_usertypes(lua);
    NEntitiesLiquids::register_usertypes(lua);
    NParticles::register_usertypes(lua);
    NSaveContext::register_usertypes(lua);
    NGM::register_usertypes(lua);
    NState::register_usertypes(lua);
    NPRNG::register_usertypes(lua);
    NScreen::register_usertypes(lua);
    NScreenArena::register_usertypes(lua);
    NPlayer::register_usertypes(lua);
    NDrops::register_usertypes(lua);
    NCharacterState::register_usertypes(lua);
    NEntityFlags::register_usertypes(lua);
    NEntityCasting::register_usertypes(lua);

    /// A bunch of [game state](#StateMemory) variables. Your ticket to almost anything that is not an Entity.
    lua["state"] = get_state_ptr();
    /// The GameManager gives access to a couple of Screens as well as the pause and journal UI elements
    lua["game_manager"] = get_game_manager();
    /// The Online object has information about the online lobby and its players
    lua["online"] = get_online();
    /// An array of [Player](#Player) of the current players. This is just a list of existing Player entities in order, i.e., `players[1]` is not guaranteed to be P1 if they have been gibbed for example. See get_player().
    lua["players"] = std::vector<Player*>(get_players());

    auto get_player = sol::overload(
        [&lua](int8_t slot) -> sol::object // -> Player
        {
            for (auto player : get_players())
            {
                if (player->inventory_ptr->player_slot == slot - 1)
                    return sol::make_object_userdata(lua, player);
            }
            return sol::nil;
        },
        [&lua](int8_t slot, bool or_ghost) -> sol::object
        {
            for (auto player : get_players())
            {
                if (player->inventory_ptr->player_slot == slot - 1)
                    return sol::make_object_userdata(lua, player);
            }
            if (or_ghost)
            {
                for (auto uid : get_entities_by(to_id("ENT_TYPE_ITEM_PLAYERGHOST"), 0x8u, LAYER::BOTH))
                {
                    auto player = get_entity_ptr(uid)->as<PlayerGhost>();
                    if (player->inventory->player_slot == slot - 1)
                        return sol::make_object_userdata(lua, player);
                }
            }
            return sol::nil;
        });

    /// Returns Player (or PlayerGhost if `get_player(1, true)`) with this player slot
    // lua["get_player"] = [](int8_t slot, bool or_ghost = false) -> Player
    lua["get_player"] = get_player;

    /// Returns PlayerGhost with this player slot 1..4
    lua["get_playerghost"] = [](int8_t slot) -> PlayerGhost*
    {
        for (auto uid : get_entities_by(to_id("ENT_TYPE_ITEM_PLAYERGHOST"), 0x8u, LAYER::BOTH))
        {
            auto player = get_entity_ptr(uid)->as<PlayerGhost>();
            if (player->inventory->player_slot == slot - 1)
                return player;
        }
        return nullptr;
    };
    /// Provides a read-only access to the save data, updated as soon as something changes (i.e. before it's written to savegame.sav.)
    lua["savegame"] = State::get().savedata();

    /// Standard lua print function, prints directly to the console but not to the game
    lua["lua_print"] = lua["print"];
    /// Print a log message on screen.
    lua["print"] = [](std::string message) -> void
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        backend->messages.push_back({message, std::chrono::system_clock::now(), ImVec4(1.0f, 1.0f, 1.0f, 1.0f)});
        if (backend->messages.size() > 20)
            backend->messages.pop_front();
        backend->lua["lua_print"](message);
    };

    /// Same as `print`
    lua["message"] = [&lua](std::string message) -> void
    { lua["print"](message); };
    /// Prints any type of object by first funneling it through `inspect`, no need for a manual `tostring` or `inspect`.
    lua["prinspect"] = [&lua](sol::variadic_args objects) -> void
    {
        if (objects.size() > 0)
        {
            std::string message;
            for (const auto& obj : objects)
            {
                message += lua["inspect"](obj);
                message += ", ";
            }
            message.pop_back();
            message.pop_back();

            lua["print"](std::move(message));
        }
    };
    /// Same as `prinspect`
    lua["messpect"] = [&lua](sol::variadic_args objects) -> void
    { lua["prinspect"](objects); };

    /// Adds a command that can be used in the console.
    lua["register_console_command"] = [](std::string name, sol::function cmd)
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        if (backend->console)
        {
            backend->console_commands.insert(name);
            backend->console->register_command(backend, std::move(name), std::move(cmd));
        }
    };

    /// Returns unique id for the callback to be used in [clear_callback](#clear_callback). You can also return `false` from your function to clear the callback.
    /// Add per level callback function to be called every `frames` engine frames. Timer is paused on pause and cleared on level transition.
    lua["set_interval"] = [](sol::function cb, int frames) -> CallbackId
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        auto luaCb = IntervalCallback{cb, frames, -1};
        backend->level_timers[backend->cbcount] = luaCb;
        return backend->cbcount++;
    };
    /// Returns unique id for the callback to be used in [clear_callback](#clear_callback).
    /// Add per level callback function to be called after `frames` engine frames. Timer is paused on pause and cleared on level transition.
    lua["set_timeout"] = [](sol::function cb, int frames) -> CallbackId
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        int now = backend->g_state->time_level;
        auto luaCb = TimeoutCallback{cb, now + frames};
        backend->level_timers[backend->cbcount] = luaCb;
        return backend->cbcount++;
    };
    /// Returns unique id for the callback to be used in [clear_callback](#clear_callback). You can also return `false` from your function to clear the callback.
    /// Add global callback function to be called every `frames` engine frames. This timer is never paused or cleared.
    lua["set_global_interval"] = [](sol::function cb, int frames) -> CallbackId
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        auto luaCb = IntervalCallback{cb, frames, -1};
        backend->global_timers[backend->cbcount] = luaCb;
        return backend->cbcount++;
    };
    /// Returns unique id for the callback to be used in [clear_callback](#clear_callback).
    /// Add global callback function to be called after `frames` engine frames. This timer is never paused or cleared.
    lua["set_global_timeout"] = [](sol::function cb, int frames) -> CallbackId
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        int now = get_frame_count();
        auto luaCb = TimeoutCallback{cb, now + frames};
        backend->global_timers[backend->cbcount] = luaCb;
        return backend->cbcount++;
    };
    /// Returns unique id for the callback to be used in [clear_callback](#clear_callback).
    /// Add global callback function to be called on an [event](#ON).
    lua["set_callback"] = [](sol::function cb, int screen) -> CallbackId
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        auto luaCb = ScreenCallback{cb, (ON)screen, -1};
        if (luaCb.screen == ON::LOAD)
            backend->load_callbacks[backend->cbcount] = luaCb; // Make sure load always runs before other callbacks
        else
            backend->callbacks[backend->cbcount] = luaCb;
        return backend->cbcount++;
    };
    /// Clear previously added callback `id` or call without arguments inside any callback to clear that callback after it returns.
    // lua["clear_callback"] = [](sol::optional<CallbackId> id) -> void {};
    lua["clear_callback"] = sol::overload(
        [](CallbackId id)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->clear_callbacks.push_back(id);
        },
        []()
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            auto caller = backend->get_current_callback();
            switch (caller.type)
            {
            case CallbackType::Normal:
                backend->clear_callbacks.push_back(caller.id);
                break;
            case CallbackType::Entity:
                backend->clear_entity_hooks.push_back({caller.uid, caller.id});
                break;
            case CallbackType::Screen:
                backend->clear_screen_hooks.push_back({caller.uid, caller.id});
                break;
            case CallbackType::None:
                // DEBUG("No callback to clear");
            default:
                break;
            }
        });

    /// Table of options set in the UI, added with the [register_option_functions](#register_option_int).
    lua["options"] = lua.create_named_table("options");

    /// Load another script by id "author/name" and import its `exports` table
    // lua["import"] = [](string id, optional<string> version) -> table
    lua["import"] = sol::overload(
        [&lua](std::string id)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->required_scripts.push_back(sanitize(id));
            LuaBackend* import_backend = LuaBackend::get_backend_by_id(std::string_view(sanitize(id)));
            if (!import_backend)
            {
                luaL_error(lua, "Imported script not found");
                return sol::make_object(lua, sol::lua_nil);
            }
            if (!import_backend->get_enabled())
            {
                import_backend->set_enabled(true);
                import_backend->update();
            }
            return sol::make_object(lua, import_backend->lua["exports"]);
        },
        [&lua](std::string id, std::string version)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->required_scripts.push_back(sanitize(id));
            LuaBackend* import_backend = LuaBackend::get_backend_by_id(std::string_view(sanitize(id)), std::string_view(version));
            if (!import_backend)
            {
                luaL_error(lua, "Imported script not found");
                return sol::make_object(lua, sol::lua_nil);
            }
            if (!import_backend->get_enabled())
            {
                import_backend->set_enabled(true);
                import_backend->update();
            }
            return sol::make_object(lua, import_backend->lua["exports"]);
        });

    /// Deprecated
    /// Same as import().
    lua["load_script"] = lua["import"];

    /// Get your sanitized script id to be used in import.
    lua["get_id"] = []() -> std::string
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        return backend->get_id();
    };

    /// Deprecated
    /// Read the game prng state. Use [prng](#PRNG):get_pair() instead.
    lua["read_prng"] = []() -> std::vector<int64_t>
    { return read_prng(); };
    /// Show a message that looks like a level feeling.
    lua["toast"] = [](std::wstring message)
    {
        auto toast = get_toast();
        toast(message.data());
    };
    /// Show a message coming from an entity
    lua["say"] = [](uint32_t entity_uid, std::wstring message, int unk_type, bool top)
    {
        auto say = get_say();
        auto entity = get_entity_ptr(entity_uid);
        if (entity == nullptr)
            return;
        say((void*)get_say_context(), entity, message.data(), unk_type, top);
    };
    /// Add an integer option that the user can change in the UI. Read with `options.name`, `value` is the default. Keep in mind these are just soft
    /// limits, you can override them in the UI with double click.
    // lua["register_option_int"] = [](std::string name, std::string desc, std::string long_desc, int value, int min, int max)
    lua["register_option_int"] = sol::overload(
        [&lua](std::string name, std::string desc, std::string long_desc, int value, int min, int max)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->options[name] = {desc, long_desc, IntOption{value, min, max}};
            lua["options"][name] = value;
        },
        [&lua](std::string name, std::string desc, int value, int min, int max)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->options[name] = {desc, "", IntOption{value, min, max}};
            lua["options"][name] = value;
        });
    /// Add a float option that the user can change in the UI. Read with `options.name`, `value` is the default. Keep in mind these are just soft
    /// limits, you can override them in the UI with double click.
    // lua["register_option_float"] = [](std::string name, std::string desc, std::string long_desc, float value, float min, float max)
    lua["register_option_float"] = sol::overload(
        [&lua](std::string name, std::string desc, std::string long_desc, float value, float min, float max)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->options[name] = {desc, long_desc, FloatOption{value, min, max}};
            lua["options"][name] = value;
        },
        [&lua](std::string name, std::string desc, float value, float min, float max)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->options[name] = {desc, "", FloatOption{value, min, max}};
            lua["options"][name] = value;
        });
    /// Add a boolean option that the user can change in the UI. Read with `options.name`, `value` is the default.
    // lua["register_option_bool"] = [&lua](std::string name, std::string desc, std::string long_desc, bool value)
    lua["register_option_bool"] = sol::overload(
        [&lua](std::string name, std::string desc, std::string long_desc, bool value)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->options[name] = {desc, long_desc, BoolOption{value}};
            lua["options"][name] = value;
        },
        [&lua](std::string name, std::string desc, bool value)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->options[name] = {desc, "", BoolOption{value}};
            lua["options"][name] = value;
        });
    /// Add a string option that the user can change in the UI. Read with `options.name`, `value` is the default.
    // lua["register_option_string"] = [&lua](std::string name, std::string desc, std::string long_desc, std::string value)
    lua["register_option_string"] = sol::overload(
        [&lua](std::string name, std::string desc, std::string long_desc, std::string value)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->options[name] = {desc, long_desc, StringOption{value}};
            lua["options"][name] = value;
        },
        [&lua](std::string name, std::string desc, std::string value)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->options[name] = {desc, "", StringOption{value}};
            lua["options"][name] = value;
        });
    /// Add a combobox option that the user can change in the UI. Read the int index of the selection with `options.name`. Separate `opts` with `\0`,
    /// with a double `\0\0` at the end.
    // lua["register_option_combo"] = [&lua](std::string name, std::string desc, std::string long_desc, std::string opts)
    lua["register_option_combo"] = sol::overload(
        [&lua](std::string name, std::string desc, std::string long_desc, std::string opts)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->options[name] = {desc, long_desc, ComboOption{0, opts}};
            lua["options"][name] = 1;
        },
        [&lua](std::string name, std::string desc, std::string opts)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->options[name] = {desc, "", ComboOption{0, opts}};
            lua["options"][name] = 1;
        });
    /// Add a button that the user can click in the UI. Sets the timestamp of last click on value and runs the callback function.
    // lua["register_option_button"] = [&lua](std::string name, std::string desc, std::string long_desc, sol::function on_click)
    lua["register_option_button"] = sol::overload(
        [&lua](std::string name, std::string desc, std::string long_desc, sol::function callback)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->options[name] = {desc, long_desc, ButtonOption{callback}};
            lua["options"][name] = -1;
        },
        [&lua](std::string name, std::string desc, sol::function callback)
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            backend->options[name] = {desc, "", ButtonOption{callback}};
            lua["options"][name] = -1;
        });
    auto spawn_liquid = sol::overload(
        static_cast<void (*)(ENT_TYPE, float, float)>(::spawn_liquid),
        static_cast<void (*)(ENT_TYPE, float, float, float, float, uint32_t, uint32_t)>(::spawn_liquid_ex),
        static_cast<void (*)(ENT_TYPE, float, float, float, float, uint32_t, uint32_t, float)>(::spawn_liquid));
    /// Spawn liquids, always spawns in the front layer, will have fun effects if `entity_type` is not a liquid (only the short version, without velocity etc.).
    /// Don't overuse this, you are still restricted by the liquid pool sizes and thus might crash the game.
    /// `liquid_flags` - not much known about, 2 - will probably crash the game, 3 - pause_physics, 6-12 is probably agitation, surface_tension etc. set to 0 to ignore
    /// `amount` - it will spawn amount x amount (so 1 = 1, 2 = 4, 3 = 6 etc.), `blobs_separation` is optional
    lua["spawn_liquid"] = spawn_liquid;
    /// Spawn an entity in position with some velocity and return the uid of spawned entity.
    /// Uses level coordinates with [LAYER.FRONT](#LAYER) and LAYER.BACK, but player-relative coordinates with LAYER.PLAYERn.
    lua["spawn_entity"] = spawn_entity_abs;
    /// Short for [spawn_entity](#spawn_entity).
    lua["spawn"] = spawn_entity_abs;
    /// Spawns an entity directly on the floor below the tile at the given position.
    /// Use this to avoid the little fall that some entities do when spawned during level gen callbacks.
    lua["spawn_entity_snapped_to_floor"] = spawn_entity_snap_to_floor;
    /// Short for [spawn_entity_snapped_to_floor](#spawn_entity_snapped_to_floor).
    lua["spawn_on_floor"] = spawn_entity_snap_to_floor;
    /// Spawn a grid entity, such as floor or traps, that snaps to the grid.
    lua["spawn_grid_entity"] = spawn_entity_snap_to_grid;
    /// Same as `spawn_entity` but does not trigger any pre-entity-spawn callbacks, so it will not be replaced by another script
    lua["spawn_entity_nonreplaceable"] = spawn_entity_abs_nonreplaceable;
    /// Short for [spawn_entity_nonreplaceable](#spawn_entity_nonreplaceable).
    lua["spawn_critical"] = spawn_entity_abs_nonreplaceable;
    /// Spawn a door to another world, level and theme and return the uid of spawned entity.
    /// Uses level coordinates with LAYER.FRONT and LAYER.BACK, but player-relative coordinates with LAYER.PLAYERn
    lua["spawn_door"] = spawn_door_abs;
    /// Short for [spawn_door](#spawn_door).
    lua["door"] = spawn_door_abs;
    /// Spawn a door to backlayer.
    lua["spawn_layer_door"] = spawn_backdoor_abs;
    /// Short for [spawn_layer_door](#spawn_layer_door).
    lua["layer_door"] = spawn_backdoor_abs;
    /// Spawns apep with the choice if it going left or right, if you want the game to choose use regular spawn functions with `ENT_TYPE.MONS_APEP_HEAD`
    lua["spawn_apep"] = spawn_apep;
    auto spawn_tree = sol::overload(
        static_cast<void (*)(float, float, LAYER)>(::spawn_tree),
        static_cast<void (*)(float, float, LAYER, uint16_t)>(::spawn_tree));

    /// Spawns and grows a tree
    lua["spawn_tree"] = spawn_tree;

    auto spawn_mushroom = sol::overload(
        static_cast<int32_t (*)(float, float, LAYER)>(::spawn_mushroom),
        static_cast<int32_t (*)(float, float, LAYER, uint16_t)>(::spawn_mushroom));
    /// Spawns and grows mushroom, height relates to the trunk, without it, it will roll the game default 3-5 height
    /// Regardless, if there is not enough space, it will spawn shorter one or if there is no space even for the smallest one, it will just not spawn at all
    /// Returns uid of the base or -1 if it wasn't able to spawn
    lua["spawn_mushroom"] = spawn_mushroom;
    /// NoDoc
    /// Spawns an impostor lake, `top_threshold` determines how much space on top is rendered as liquid but does not have liquid physics, fill that space with real liquid
    /// There needs to be other liquid in the level for the impostor lake to be visible, there can only be one impostor lake in the level
    lua["spawn_impostor_lake"] = spawn_impostor_lake;
    /// Spawn a player in given location, if player of that slot already exist it will spawn clone, the game may crash as this is very unexpected situation
    /// If you want to respawn a player that is a ghost, set in his inventory `health` to above 0, and `time_of_death` to 0 and call this function, the ghost entity will be removed automatically
    lua["spawn_player"] = spawn_player;
    /// Add a callback for a spawn of specific entity types or mask. Set `mask` to `MASK.ANY` to ignore that.
    /// This is run before the entity is spawned, spawn your own entity and return its uid to replace the intended spawn.
    /// In many cases replacing the intended entity won't have the indended effect or will even break the game, so use only if you really know what you're doing.
    /// The callback signature is `optional<int> pre_entity_spawn(entity_type, x, y, layer, overlay_entity, spawn_flags)`
    lua["set_pre_entity_spawn"] = [](sol::function cb, SPAWN_TYPE flags, int mask, sol::variadic_args entity_types) -> CallbackId
    {
        std::vector<ENT_TYPE> types;
        sol::type va_type = entity_types.get_type();
        if (va_type == sol::type::number)
        {
            types = std::vector<uint32_t>(entity_types.begin(), entity_types.end());
        }
        else if (va_type == sol::type::table)
        {
            types = entity_types.get<std::vector<uint32_t>>(0);
        }
        std::vector<ENT_TYPE> proper_types = get_proper_types(std::move(types));

        LuaBackend* backend = LuaBackend::get_calling_backend();
        backend->pre_entity_spawn_callbacks.push_back(EntitySpawnCallback{backend->cbcount, mask, std::move(proper_types), flags, std::move(cb)});
        return backend->cbcount++;
    };
    /// Add a callback for a spawn of specific entity types or mask. Set `mask` to `MASK.ANY` to ignore that.
    /// This is run right after the entity is spawned but before and particular properties are changed, e.g. owner or velocity.
    /// The callback signature is `nil post_entity_spawn(entity, spawn_flags)`
    lua["set_post_entity_spawn"] = [](sol::function cb, SPAWN_TYPE flags, int mask, sol::variadic_args entity_types) -> CallbackId
    {
        std::vector<ENT_TYPE> types;
        sol::type va_type = entity_types.get_type();
        if (va_type == sol::type::number)
        {
            types = std::vector<uint32_t>(entity_types.begin(), entity_types.end());
        }
        else if (va_type == sol::type::table)
        {
            types = entity_types.get<std::vector<uint32_t>>(0);
        }
        std::vector<ENT_TYPE> proper_types = get_proper_types(std::move(types));

        LuaBackend* backend = LuaBackend::get_calling_backend();
        backend->post_entity_spawn_callbacks.push_back(EntitySpawnCallback{backend->cbcount, mask, std::move(proper_types), flags, std::move(cb)});
        return backend->cbcount++;
    };

    /// Warp to a level immediately.
    lua["warp"] = warp;
    /// Set seed and reset run.
    lua["set_seed"] = set_seed;
    /// Enable/disable godmode for players.
    lua["god"] = [](bool g)
    { State::get().godmode(g); };
    /// Enable/disable godmode for companions.
    lua["god_companions"] = [](bool g)
    { State::get().godmode_companions(g); };
    /// Deprecated
    /// Set level flag 18 on post room generation instead, to properly force every level to dark
    lua["force_dark_level"] = [](bool g)
    { State::get().darkmode(g); };
    /// Set the zoom level used in levels and shops. 13.5 is the default.
    lua["zoom"] = [](float level)
    { State::get().zoom(level); };
    /// Enable/disable game engine pause.
    /// This is just short for `state.pause == 32`, but that produces an audio bug
    /// I suggest `state.pause == 2`, but that won't run any callback, `state.pause == 16` will do the same but `set_global_interval` will still work
    lua["pause"] = [](bool p)
    {
        if (p)
            set_pause(0x20);
        else
            set_pause(0);
    };
    auto move_entity_abs = sol::overload(
        static_cast<void (*)(uint32_t, float, float, float, float)>(::move_entity_abs),
        static_cast<void (*)(uint32_t, float, float, float, float, LAYER)>(::move_entity_abs));
    /// Teleport entity to coordinates with optional velocity
    lua["move_entity"] = move_entity_abs;
    /// Teleport grid entity, the destination should be whole number, this ensures that the collisions will work properly
    lua["move_grid_entity"] = move_grid_entity;
    /// Make an ENT_TYPE.FLOOR_DOOR_EXIT go to world `w`, level `l`, theme `t`
    lua["set_door_target"] = set_door_target;
    /// Short for [set_door_target](#set_door_target).
    lua["set_door"] = set_door_target;
    /// Get door target `world`, `level`, `theme`
    lua["get_door_target"] = get_door_target;
    /// Set the contents of ENT_TYPE.ITEM_POT, ENT_TYPE.ITEM_CRATE or ENT_TYPE.ITEM_COFFIN `uid` to ENT_TYPE... `item_entity_type`
    lua["set_contents"] = set_contents;
    /// Get the Entity behind an uid, converted to the correct type. To see what type you will get, consult the [entity hierarchy list](https://github.com/spelunky-fyi/overlunky/blob/main/docs/entities-hierarchy.md)
    // lua["get_entity"] = [](uint32_t uid) -> Entity* {};
    /// NoDoc
    /// Get the [Entity](#Entity) behind an uid, without converting to the correct type (do not use, use `get_entity` instead)
    lua["get_entity_raw"] = get_entity_ptr;
    lua.script(R"##(
        function cast_entity(entity_raw)
            if entity_raw == nil then
                return nil
            end

            local cast_fun = TYPE_MAP[entity_raw.type.id]
            if cast_fun ~= nil then
                return cast_fun(entity_raw)
            else
                return entity_raw
            end
        end
        function get_entity(ent_uid)
            if ent_uid == nil then
                return nil
            end

            local entity_raw = get_entity_raw(ent_uid)
            if entity_raw == nil then
                return nil
            end

            return cast_entity(entity_raw)
        end
        )##");
    /// Get the [EntityDB](#EntityDB) behind an ENT_TYPE...
    lua["get_type"] = get_type;
    /// Gets a grid entity, such as floor or spikes, at the given position and layer.
    lua["get_grid_entity_at"] = get_grid_entity_at;
    /// Deprecated
    /// Use `get_entities_by(0, MASK.ANY, LAYER.BOTH)` instead
    lua["get_entities"] = get_entities;
    /// Returns a list of all uids in `entities` for which `predicate(get_entity(uid))` returns true
    lua["filter_entities"] = [&lua](std::vector<uint32_t> entities, sol::function predicate) -> std::vector<uint32_t>
    {
        return filter_entities(std::move(entities), [&lua, pred = std::move(predicate)](Entity* entity) -> bool
                               { return pred(lua["cast_entity"](entity)); });
    };

    auto get_entities_by = sol::overload(
        static_cast<std::vector<uint32_t> (*)(ENT_TYPE, uint32_t, LAYER)>(::get_entities_by),
        static_cast<std::vector<uint32_t> (*)(std::vector<ENT_TYPE>, uint32_t, LAYER)>(::get_entities_by));
    /// Get uids of entities by some conditions. Set `entity_type` or `mask` to `0` to ignore that, can also use table of entity_types
    lua["get_entities_by"] = get_entities_by;
    /// Get uids of entities matching id. This function is variadic, meaning it accepts any number of id's.
    /// You can even pass a table!
    lua["get_entities_by_type"] = [](sol::variadic_args va) -> std::vector<uint32_t>
    {
        sol::type type = va.get_type();
        if (type == sol::type::number)
        {
            auto args = std::vector<uint32_t>(va.begin(), va.end());
            auto get_func = sol::resolve<std::vector<uint32_t>(std::vector<uint32_t>)>(get_entities_by_type);
            return get_func(args);
        }
        else if (type == sol::type::table)
        {
            auto args = va.get<std::vector<uint32_t>>(0);
            auto get_func = sol::resolve<std::vector<uint32_t>(std::vector<uint32_t>)>(get_entities_by_type);
            return get_func(args);
        }
        return std::vector<uint32_t>({});
    };
    /// Deprecated
    /// Use `get_entities_by(0, mask, LAYER.BOTH)` instead
    lua["get_entities_by_mask"] = get_entities_by_mask;
    /// Deprecated
    /// Use `get_entities_by(0, MASK.ANY, layer)` instead
    lua["get_entities_by_layer"] = get_entities_by_layer;

    auto get_entities_at = sol::overload(
        static_cast<std::vector<uint32_t> (*)(ENT_TYPE, uint32_t, float, float, LAYER, float)>(::get_entities_at),
        static_cast<std::vector<uint32_t> (*)(std::vector<ENT_TYPE>, uint32_t, float, float, LAYER, float)>(::get_entities_at));
    /// Get uids of matching entities inside some radius. Set `entity_type` or `mask` to `0` to ignore that, can also use table of entity_types
    lua["get_entities_at"] = get_entities_at;

    auto get_entities_overlapping = sol::overload(
        static_cast<std::vector<uint32_t> (*)(ENT_TYPE, uint32_t, float, float, float, float, LAYER)>(::get_entities_overlapping),
        static_cast<std::vector<uint32_t> (*)(std::vector<ENT_TYPE>, uint32_t, float, float, float, float, LAYER)>(::get_entities_overlapping));
    /// Deprecated
    /// Use `get_entities_overlapping_hitbox` instead
    lua["get_entities_overlapping"] = get_entities_overlapping;

    auto get_entities_overlapping_hitbox = sol::overload(
        static_cast<std::vector<uint32_t> (*)(ENT_TYPE, uint32_t, AABB, LAYER)>(::get_entities_overlapping_hitbox),
        static_cast<std::vector<uint32_t> (*)(std::vector<ENT_TYPE>, uint32_t, AABB, LAYER)>(::get_entities_overlapping_hitbox));
    /// Get uids of matching entities overlapping with the given hitbox. Set `entity_type` or `mask` to `0` to ignore that, can also use table of entity_types
    lua["get_entities_overlapping_hitbox"] = get_entities_overlapping_hitbox;
    /// Attaches `attachee` to `overlay`, similar to setting `get_entity(attachee).overlay = get_entity(overlay)`.
    /// However this function offsets `attachee` (so you don't have to) and inserts it into `overlay`'s inventory.
    lua["attach_entity"] = attach_entity_by_uid;
    /// Get the `flags` field from entity by uid
    lua["get_entity_flags"] = get_entity_flags;
    /// Set the `flags` field from entity by uid
    lua["set_entity_flags"] = set_entity_flags;
    /// Get the `more_flags` field from entity by uid
    lua["get_entity_flags2"] = get_entity_flags2;
    /// Set the `more_flags` field from entity by uid
    lua["set_entity_flags2"] = set_entity_flags2;
    /// Deprecated
    /// As the name is misleading. use entity `move_state` field instead
    lua["get_entity_ai_state"] = get_entity_ai_state;
    /// Get `state.level_flags`
    lua["get_level_flags"] = get_level_flags;
    /// Set `state.level_flags`
    lua["set_level_flags"] = set_level_flags;
    /// Get the ENT_TYPE... of the entity by uid
    lua["get_entity_type"] = get_entity_type;
    /// Get the current set zoom level
    lua["get_zoom_level"] = []() -> float
    { return State::get_zoom_level(); };
    /// Get the game coordinates at the screen position (`x`, `y`)
    lua["game_position"] = [](float x, float y) -> std::pair<float, float>
    { return State::click_position(x, y); };
    /// Translate an entity position to screen position to be used in drawing functions
    lua["screen_position"] = [](float x, float y) -> std::pair<float, float>
    { return State::screen_position(x, y); };
    /// Translate a distance of `x` tiles to screen distance to be be used in drawing functions
    lua["screen_distance"] = screen_distance;
    /// Get position `x, y, layer` of entity by uid. Use this, don't use `Entity.x/y` because those are sometimes just the offset to the entity
    /// you're standing on, not real level coordinates.
    lua["get_position"] = get_position;
    /// Get interpolated render position `x, y, layer` of entity by uid. This gives smooth hitboxes for 144Hz master race etc...
    lua["get_render_position"] = get_render_position;
    /// Get velocity `vx, vy` of an entity by uid. Use this, don't use `Entity.velocityx/velocityy` because those are relative to `Entity.overlay`.
    lua["get_velocity"] = get_velocity;
    /// Remove item by uid from entity
    lua["entity_remove_item"] = entity_remove_item;
    /// Spawns and attaches ball and chain to `uid`, the initial position of the ball is at the entity position plus `off_x`, `off_y`
    lua["attach_ball_and_chain"] = attach_ball_and_chain;
    /// Spawn an entity of `entity_type` attached to some other entity `over_uid`, in offset `x`, `y`
    lua["spawn_entity_over"] = spawn_entity_over;
    /// Short for [spawn_entity_over](#spawn_entity_over)
    lua["spawn_over"] = spawn_entity_over;
    /// Check if the entity `uid` has some specific `item_uid` by uid in their inventory
    lua["entity_has_item_uid"] = entity_has_item_uid;

    auto entity_has_item_type = sol::overload(
        static_cast<bool (*)(uint32_t, ENT_TYPE)>(::entity_has_item_type),
        static_cast<bool (*)(uint32_t, std::vector<ENT_TYPE>)>(::entity_has_item_type));
    /// Check if the entity `uid` has some ENT_TYPE `entity_type` in their inventory, can also use table of entity_types
    lua["entity_has_item_type"] = entity_has_item_type;

    auto entity_get_items_by = sol::overload(
        static_cast<std::vector<uint32_t> (*)(uint32_t, ENT_TYPE, uint32_t)>(::entity_get_items_by),
        static_cast<std::vector<uint32_t> (*)(uint32_t, std::vector<ENT_TYPE>, uint32_t)>(::entity_get_items_by));
    /// Gets uids of entities attached to given entity uid. Use `entity_type` and `mask` to filter, set them to 0 to return all attached entities.
    lua["entity_get_items_by"] = entity_get_items_by;
    /// Kills an entity by uid. `destroy_corpse` defaults to `true`, if you are killing for example a caveman and want the corpse to stay make sure to pass `false`.
    lua["kill_entity"] = kill_entity;
    /// Pick up another entity by uid. Make sure you're not already holding something, or weird stuff will happen.
    lua["pick_up"] = pick_up;
    /// Drop an entity by uid
    lua["drop"] = drop;
    /// Unequips the currently worn backitem
    lua["unequip_backitem"] = unequip_backitem;
    /// Returns the uid of the currently worn backitem, or -1 if wearing nothing
    lua["worn_backitem"] = worn_backitem;
    /// Apply changes made in [get_type](#get_type)() to entity instance by uid.
    lua["apply_entity_db"] = apply_entity_db;
    /// Try to lock the exit at coordinates
    lua["lock_door_at"] = lock_door_at;
    /// Try to unlock the exit at coordinates
    lua["unlock_door_at"] = unlock_door_at;
    /// Get the current global frame count since the game was started. You can use this to make some timers yourself, the engine runs at 60fps.
    lua["get_frame"] = get_frame_count;
    /// Get the current timestamp in milliseconds since the Unix Epoch.
    lua["get_ms"] = []()
    { return std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now().time_since_epoch()).count(); };
    /// Make `mount_uid` carry `rider_uid` on their back. Only use this with actual mounts and living things.
    lua["carry"] = carry;
    /// Deprecated
    /// Use `replace_drop(DROP.ARROWTRAP_WOODENARROW, new_arrow_type)` and `replace_drop(DROP.POISONEDARROWTRAP_WOODENARROW, new_arrow_type)` instead
    lua["set_arrowtrap_projectile"] = set_arrowtrap_projectile;
    /// Sets the amount of blood drops in the Kapala needed to trigger a health increase (default = 7).
    lua["set_kapala_blood_threshold"] = set_kapala_blood_threshold;
    /// Sets the hud icon for the Kapala (0-6 ; -1 for default behaviour).
    /// If you set a Kapala treshold greater than 7, make sure to set the hud icon in the range 0-6, or other icons will appear in the hud!
    lua["set_kapala_hud_icon"] = set_kapala_hud_icon;
    /// Changes characteristics of (all) sparktraps: speed, rotation direction and distance from center
    /// Speed: expressed as the amount that should be added to the angle every frame (use a negative number to go in the other direction)
    /// Distance from center: if you go above 3.0 the game might crash because a spark may go out of bounds!
    lua["modify_sparktraps"] = modify_sparktraps;
    /// Activate custom variables for speed and distance in the `ITEM_SPARK`
    /// note: because those the variables are custom and game does not initiate then, you need to do it yourself for each spark, recommending `set_post_entity_spawn`
    /// default game values are: speed = -0.015, distance = 3.0
    lua["activate_sparktraps_hack"] = activate_sparktraps_hack;
    /// Set layer to search for storage items on
    lua["set_storage_layer"] = set_storage_layer;
    /// Sets the multiplication factor for blood droplets upon death (default/no Vlad's cape = 1, with Vlad's cape = 2)
    /// Due to changes in 1.23.x only the Vlad's cape value you provide will be used. The default is automatically Vlad's cape value - 1
    lua["set_blood_multiplication"] = set_blood_multiplication;
    /// Flip entity around by uid. All new entities face right by default.
    lua["flip_entity"] = flip_entity;
    /// Sets the Y-level at which Olmec changes phases
    lua["set_olmec_phase_y_level"] = set_olmec_phase_y_level;
    /// Forces Olmec to stay on phase 0 (stomping)
    lua["force_olmec_phase_0"] = force_olmec_phase_0;
    /// Determines when the ghost appears, either when the player is cursed or not
    lua["set_ghost_spawn_times"] = set_ghost_spawn_times;
    /// Determines whether the time ghost appears, including the showing of the ghost toast
    lua["set_time_ghost_enabled"] = set_time_ghost_enabled;
    /// Determines whether the time jelly appears in cosmic ocean
    lua["set_time_jelly_enabled"] = set_time_jelly_enabled;
    /// Enables or disables the journal
    lua["set_journal_enabled"] = set_journal_enabled;
    /// Enables or disables the default position based camp camera bounds, to set them manually yourself
    lua["set_camp_camera_bounds_enabled"] = set_camp_camera_bounds_enabled;
    /// Sets which entities are affected by a bomb explosion. Default = MASK.PLAYER | MASK.MOUNT | MASK.MONSTER | MASK.ITEM | MASK.ACTIVEFLOOR | MASK.FLOOR
    lua["set_explosion_mask"] = set_explosion_mask;
    /// Sets the maximum length of a thrown rope (anchor segment not included). Unfortunately, setting this higher than default (6) creates visual glitches in the rope, even though it is fully functional.
    lua["set_max_rope_length"] = set_max_rope_length;
    /// Checks whether a coordinate is inside a room containing an active shop. This function checks whether the shopkeeper is still alive.
    lua["is_inside_active_shop_room"] = is_inside_active_shop_room;
    /// Checks whether a coordinate is inside a shop zone, the rectangle where the camera zooms in a bit. Does not check if the shop is still active!
    lua["is_inside_shop_zone"] = is_inside_shop_zone;
    /// Returns how many of a specific entity type Waddler has stored
    lua["waddler_count_entity"] = waddler_count_entity;
    /// Store an entity type in Waddler's storage. Returns the slot number the item was stored in or -1 when storage is full and the item couldn't be stored.
    lua["waddler_store_entity"] = waddler_store_entity;
    /// Removes an entity type from Waddler's storage. Second param determines how many of the item to remove (default = remove all)
    lua["waddler_remove_entity"] = waddler_remove_entity;
    /// Gets the 16-bit meta-value associated with the entity type in the associated slot
    lua["waddler_get_entity_meta"] = waddler_get_entity_meta;
    /// Sets the 16-bit meta-value associated with the entity type in the associated slot
    lua["waddler_set_entity_meta"] = waddler_set_entity_meta;
    /// Gets the entity type of the item in the provided slot
    lua["waddler_entity_type_in_slot"] = waddler_entity_type_in_slot;
    /// Spawn a companion (hired hand, player character, eggplant child)
    lua["spawn_companion"] = spawn_companion;

    /// Calculate the tile distance of two entities by uid
    lua["distance"] = [](uint32_t uid_a, uint32_t uid_b) -> float
    {
        Entity* ea = get_entity_ptr(uid_a);
        Entity* eb = get_entity_ptr(uid_b);
        if (ea == nullptr || eb == nullptr)
            return -1.0f;
        else
            return (float)sqrt(pow(ea->position().first - eb->position().first, 2) + pow(ea->position().second - eb->position().second, 2));
    };
    /// Basically gets the absolute coordinates of the area inside the unbreakable bedrock walls, from wall to wall. Every solid entity should be
    /// inside these boundaries. The order is: top left x, top left y, bottom right x, bottom right y
    lua["get_bounds"] = []() -> std::tuple<float, float, float, float>
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        return std::make_tuple(2.5f, 122.5f, backend->g_state->w * 10.0f + 2.5f, 122.5f - backend->g_state->h * 8.0f);
    };
    /// Gets the current camera position in the level
    lua["get_camera_position"] = get_camera_position;
    /// Deprecated
    /// this doesn't actually work at all. See State -> Camera the for proper camera handling
    lua["set_camera_position"] = set_camera_position;

    /// Set a bit in a number. This doesn't actually change the bit in the entity you pass it, it just returns the new value you can use.
    lua["set_flag"] = [](Flags flags, int bit) -> Flags
    { return flags | (1U << (bit - 1)); };
    /// Deprecated
    lua["setflag"] = lua["set_flag"];
    /// Clears a bit in a number. This doesn't actually change the bit in the entity you pass it, it just returns the new value you can use.
    lua["clr_flag"] = [](Flags flags, int bit) -> Flags
    { return flags & ~(1U << (bit - 1)); };
    /// Deprecated
    lua["clrflag"] = lua["clr_flag"];
    /// Returns true if a bit is set in the flags
    lua["test_flag"] = [](Flags flags, int bit) -> bool
    { return (flags & (1U << (bit - 1))) > 0; };
    /// Deprecated
    lua["testflag"] = lua["test_flag"];

    /// Gets the resolution (width and height) of the screen
    lua["get_window_size"] = []() -> std::tuple<int, int>
    { return {(int)ImGui::GetIO().DisplaySize.x, (int)ImGui::GetIO().DisplaySize.y}; };

    /// Steal input from a Player or HH.
    lua["steal_input"] = [](int uid)
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        if (backend->script_input.find(uid) != backend->script_input.end())
            return;
        Player* player = get_entity_ptr(uid)->as<Player>();
        if (player == nullptr)
            return;
        ScriptInput* newinput = new ScriptInput();
        newinput->next = 0;
        newinput->current = 0;
        newinput->orig_input = player->input_ptr;
        newinput->orig_ai = player->ai;
        player->input_ptr = reinterpret_cast<PlayerInputs*>(newinput);
        player->ai = 0;
        backend->script_input[uid] = newinput;
        // DEBUG("Steal input: {:x} -> {:x}", newinput->orig_input, player->input_ptr);
    };
    /// Return input
    lua["return_input"] = [](int uid)
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        if (backend->script_input.find(uid) == backend->script_input.end())
            return;
        Player* player = get_entity_ptr(uid)->as<Player>();
        if (player == nullptr)
            return;
        // DEBUG("Return input: {:x} -> {:x}", player->input_ptr, backend->script_input[uid]->orig_input);
        player->input_ptr = backend->script_input[uid]->orig_input;
        player->ai = backend->script_input[uid]->orig_ai;
        backend->script_input.erase(uid);
    };
    /// Send input
    lua["send_input"] = [](int uid, INPUTS buttons)
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        if (backend->script_input.find(uid) != backend->script_input.end())
        {
            backend->script_input[uid]->current = buttons;
            backend->script_input[uid]->next = buttons;
        }
    };
    /// Read input
    lua["read_input"] = [](int uid) -> INPUTS
    {
        Player* player = get_entity_ptr(uid)->as<Player>();
        if (player == nullptr)
            return (uint16_t)0;
        ScriptInput* readinput = reinterpret_cast<ScriptInput*>(player->input_ptr);
        if (!IsBadReadPtr(readinput, 20))
        {
            return readinput->next;
        }
        return (uint16_t)0;
    };
    /// Read input that has been previously stolen with steal_input
    lua["read_stolen_input"] = [](int uid) -> INPUTS
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        if (backend->script_input.find(uid) == backend->script_input.end())
        {
            // this means that the input is attacked to the real input and not stolen so return early
            return (uint16_t)0;
        }
        Player* player = get_entity_ptr(uid)->as<Player>();
        if (player == nullptr)
            return (uint16_t)0;
        ScriptInput* readinput = reinterpret_cast<ScriptInput*>(player->input_ptr);
        if (!IsBadReadPtr(readinput, 20))
        {
            readinput = reinterpret_cast<ScriptInput*>(readinput->orig_input);
            if (!IsBadReadPtr(readinput, 20))
            {
                return readinput->next;
            }
        }
        return (uint16_t)0;
    };

    /// Clears a callback that is specific to a screen.
    lua["clear_screen_callback"] = [](int screen_id, CallbackId cb_id)
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        backend->clear_screen_hooks.push_back({screen_id, cb_id});
    };

    /// Returns unique id for the callback to be used in [clear_screen_callback](#clear_screen_callback) or `nil` if screen_id is not valid.
    /// Sets a callback that is called right before the screen is drawn, return `true` to skip the default rendering.
    lua["set_pre_render_screen"] = [](int screen_id, sol::function fun) -> sol::optional<CallbackId>
    {
        if (Screen* screen = get_screen_ptr(screen_id))
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            std::uint32_t id = screen->reserve_callback_id();
            screen->set_pre_render(
                id,
                [=, fun = std::move(fun)](Screen* self)
                {
                    if (!backend->get_enabled() || backend->is_screen_callback_cleared({screen_id, id}))
                    {
                        return false;
                    }

                    VanillaRenderContext render_ctx;
                    backend->set_current_callback(screen_id, id, CallbackType::Screen);
                    auto return_value = backend->handle_function_with_return<bool>(fun, self, render_ctx).value_or(false);
                    backend->clear_current_callback();
                    return return_value;
                });
            backend->screen_hooks.push_back({screen_id, id});
            return id;
        }
        return sol::nullopt;
    };
    /// Returns unique id for the callback to be used in [clear_screen_callback](#clear_screen_callback) or `nil` if screen_id is not valid.
    /// Sets a callback that is called right after the screen is drawn.
    lua["set_post_render_screen"] = [](int screen_id, sol::function fun) -> sol::optional<CallbackId>
    {
        if (Screen* screen = get_screen_ptr(screen_id))
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            std::uint32_t id = screen->reserve_callback_id();
            screen->set_post_render(
                id,
                [=, fun = std::move(fun)](Screen* self)
                {
                    if (!backend->get_enabled() || backend->is_screen_callback_cleared({screen_id, id}))
                    {
                        return;
                    }
                    VanillaRenderContext render_ctx;
                    backend->set_current_callback(screen_id, id, CallbackType::Screen);
                    backend->handle_function(fun, self, render_ctx);
                    backend->clear_current_callback();
                });
            backend->screen_hooks.push_back({screen_id, id});
            return id;
        }
        return sol::nullopt;
    };

    /// Clears a callback that is specific to an entity.
    lua["clear_entity_callback"] = [](int uid, CallbackId cb_id)
    {
        LuaBackend* backend = LuaBackend::get_calling_backend();
        backend->clear_entity_hooks.push_back({uid, cb_id});
    };
    /// Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
    /// `uid` has to be the uid of a `Movable` or else stuff will break.
    /// Sets a callback that is called right before the statemachine, return `true` to skip the statemachine update.
    /// Use this only when no other approach works, this call can be expensive if overused.
    /// Check [here](https://github.com/spelunky-fyi/overlunky/blob/main/docs/virtual-availability.md) to see whether you can use this callback on the entity type you intend to.
    lua["set_pre_statemachine"] = [&lua](int uid, sol::function fun) -> sol::optional<CallbackId>
    {
        if (Movable* movable = get_entity_ptr(uid)->as<Movable>())
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            std::uint32_t id = movable->reserve_callback_id();
            movable->set_pre_statemachine(
                id,
                [=, &lua, fun = std::move(fun)](Movable* self)
                {
                    if (!backend->get_enabled() || backend->is_entity_callback_cleared({uid, id}))
                        return false;
                    backend->set_current_callback(uid, id, CallbackType::Entity);
                    auto return_value = backend->handle_function_with_return<bool>(fun, lua["cast_entity"](self)).value_or(false);
                    backend->clear_current_callback();
                    return return_value;
                });
            backend->hook_entity_dtor(movable);
            backend->entity_hooks.push_back({uid, id});
            return id;
        }
        return sol::nullopt;
    };
    /// Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
    /// `uid` has to be the uid of a `Movable` or else stuff will break.
    /// Sets a callback that is called right after the statemachine, so you can override any values the satemachine might have set (e.g. `animation_frame`).
    /// Use this only when no other approach works, this call can be expensive if overused.
    /// Check [here](https://github.com/spelunky-fyi/overlunky/blob/main/docs/virtual-availability.md) to see whether you can use this callback on the entity type you intend to.
    lua["set_post_statemachine"] = [&lua](int uid, sol::function fun) -> sol::optional<CallbackId>
    {
        if (Movable* movable = get_entity_ptr(uid)->as<Movable>())
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            std::uint32_t id = movable->reserve_callback_id();
            movable->set_post_statemachine(
                id,
                [=, &lua, fun = std::move(fun)](Movable* self)
                {
                    if (!backend->get_enabled() || backend->is_entity_callback_cleared({uid, id}))
                        return;
                    backend->set_current_callback(uid, id, CallbackType::Entity);
                    backend->handle_function(fun, lua["cast_entity"](self));
                    backend->clear_current_callback();
                });
            backend->hook_entity_dtor(movable);
            backend->entity_hooks.push_back({uid, id});
            return id;
        }
        return sol::nullopt;
    };
    /// Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
    /// Sets a callback that is called right when an entity is destroyed, e.g. as if by `Entity.destroy()` before the game applies any side effects.
    /// The callback signature is `nil on_destroy(Entity self)`
    /// Use this only when no other approach works, this call can be expensive if overused.
    lua["set_on_destroy"] = [&lua](int uid, sol::function fun) -> sol::optional<CallbackId>
    {
        if (Entity* entity = get_entity_ptr(uid))
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            std::uint32_t id = entity->reserve_callback_id();
            entity->set_on_destroy(
                id,
                [=, &lua, fun = std::move(fun)](Entity* self)
                {
                    if (!backend->get_enabled() || backend->is_entity_callback_cleared({uid, id}))
                        return;
                    backend->set_current_callback(uid, id, CallbackType::Entity);
                    backend->handle_function(fun, lua["cast_entity"](self));
                    backend->clear_current_callback();
                });
            backend->hook_entity_dtor(entity);
            backend->entity_hooks.push_back({uid, id});
            return id;
        }
        return sol::nullopt;
    };
    /// Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
    /// Sets a callback that is called right when an entity is eradicated (killing monsters that leave a body behind will not trigger this), before the game applies any side effects.
    /// The callback signature is `nil on_kill(Entity self, Entity killer)`
    /// Use this only when no other approach works, this call can be expensive if overused.
    lua["set_on_kill"] = [&lua](int uid, sol::function fun) -> sol::optional<CallbackId>
    {
        if (Entity* entity = get_entity_ptr(uid))
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            std::uint32_t id = entity->reserve_callback_id();
            entity->set_on_kill(
                id,
                [=, &lua, fun = std::move(fun)](Entity* self, Entity* killer)
                {
                    if (!backend->get_enabled() || backend->is_entity_callback_cleared({uid, id}))
                        return;
                    backend->set_current_callback(uid, id, CallbackType::Entity);
                    backend->handle_function(fun, lua["cast_entity"](self), lua["cast_entity"](killer));
                    backend->clear_current_callback();
                });
            backend->hook_entity_dtor(entity);
            backend->entity_hooks.push_back({uid, id});
            return id;
        }
        return sol::nullopt;
    };
    /// Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
    /// Sets a callback that is called right when an player/hired hand is crushed/insta-gibbed, return `true` to skip the game's crush handling.
    /// The callback signature is `bool on_player_instagib(Entity self)`
    /// The game's instagib function will be forcibly executed (regardless of whatever you return in the callback) when the entity's health is zero.
    /// This is so that when the entity dies (from other causes), the death screen still gets shown.
    /// Use this only when no other approach works, this call can be expensive if overused.
    lua["set_on_player_instagib"] = [&lua](int uid, sol::function fun) -> sol::optional<CallbackId>
    {
        if (Entity* entity = get_entity_ptr(uid))
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            std::uint32_t id = entity->reserve_callback_id();
            entity->set_on_player_instagib(
                id,
                [=, &lua, fun = std::move(fun)](Entity* self)
                {
                    if (!backend->get_enabled() || backend->is_entity_callback_cleared({uid, id}))
                        return false;
                    backend->set_current_callback(uid, id, CallbackType::Entity);
                    auto return_value = backend->handle_function_with_return<bool>(fun, lua["cast_entity"](self)).value_or(false);
                    backend->clear_current_callback();
                    return return_value;
                });
            backend->hook_entity_dtor(entity);
            backend->entity_hooks.push_back({uid, id});
            return id;
        }
        return sol::nullopt;
    };
    /// Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
    /// Sets a callback that is called right before an entity is damaged, return `true` to skip the game's damage handling.
    /// The callback signature is `bool on_damage(Entity self, Entity damage_dealer, int damage_amount, float velocity_x, float velocity_y, int stun_amount, int iframes)`
    /// Note that damage_dealer can be nil ! (long fall, ...)
    /// DO NOT CALL `self:damage()` in the callback !
    /// Use this only when no other approach works, this call can be expensive if overused.
    /// Check [here](https://github.com/spelunky-fyi/overlunky/blob/main/docs/virtual-availability.md) to see whether you can use this callback on the entity type you intend to.
    lua["set_on_damage"] = [&lua](int uid, sol::function fun) -> sol::optional<CallbackId>
    {
        if (Entity* entity = get_entity_ptr(uid))
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            std::uint32_t id = entity->reserve_callback_id();
            entity->set_on_damage(
                id,
                [=, &lua, fun = std::move(fun)](Entity* self, Entity* damage_dealer, int8_t damage_amount, float velocity_x, float velocity_y, uint16_t stun_amount, uint8_t iframes)
                {
                    if (!backend->get_enabled() || backend->is_entity_callback_cleared({uid, id}))
                        return false;
                    backend->set_current_callback(uid, id, CallbackType::Entity);
                    auto return_value = backend->handle_function_with_return<bool>(fun, lua["cast_entity"](self), lua["cast_entity"](damage_dealer), damage_amount, velocity_x, velocity_y, stun_amount, iframes).value_or(false);
                    backend->clear_current_callback();
                    return return_value;
                });
            backend->hook_entity_dtor(entity);
            backend->entity_hooks.push_back({uid, id});
            return id;
        }
        return sol::nullopt;
    };
    /// Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
    /// Sets a callback that is called right when a container is opened via up+door, or weapon is shot.
    /// The callback signature is `nil on_open(Entity entity_self, Entity opener)`
    /// Use this only when no other approach works, this call can be expensive if overused.
    /// Check [here](https://github.com/spelunky-fyi/overlunky/blob/main/docs/virtual-availability.md) to see whether you can use this callback on the entity type you intend to.
    lua["set_on_open"] = [&lua](int uid, sol::function fun) -> sol::optional<CallbackId>
    {
        if (Container* entity = get_entity_ptr(uid)->as<Container>())
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            std::uint32_t id = entity->reserve_callback_id();
            entity->set_on_open(
                id,
                [=, &lua, fun = std::move(fun)](Entity* self, Movable* opener)
                {
                    if (!backend->get_enabled() || backend->is_entity_callback_cleared({uid, id}))
                        return;
                    backend->set_current_callback(uid, id, CallbackType::Entity);
                    backend->handle_function(fun, lua["cast_entity"](self), lua["cast_entity"](opener));
                    backend->clear_current_callback();
                });
            backend->hook_entity_dtor(entity);
            backend->entity_hooks.push_back({uid, id});
            return id;
        }
        return sol::nullopt;
    };
    /// Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
    /// Sets a callback that is called right before the collision 1 event, return `true` to skip the game's collision handling.
    /// Use this only when no other approach works, this call can be expensive if overused.
    /// Check [here](https://github.com/spelunky-fyi/overlunky/blob/main/docs/virtual-availability.md) to see whether you can use this callback on the entity type you intend to.
    lua["set_pre_collision1"] = [&lua](int uid, sol::function fun) -> sol::optional<CallbackId>
    {
        if (Entity* e = get_entity_ptr(uid))
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            std::uint32_t id = e->reserve_callback_id();
            e->set_pre_collision1(
                id,
                [=, &lua, fun = std::move(fun)](Entity* self, Entity* collision_entity)
                {
                    if (!backend->get_enabled() || backend->is_entity_callback_cleared({uid, id}))
                        return false;
                    backend->set_current_callback(uid, id, CallbackType::Entity);
                    auto return_value = backend->handle_function_with_return<bool>(fun, lua["cast_entity"](self), lua["cast_entity"](collision_entity)).value_or(false);
                    backend->clear_current_callback();
                    return return_value;
                });
            backend->hook_entity_dtor(e);
            backend->entity_hooks.push_back({uid, id});
            return id;
        }
        return sol::nullopt;
    };
    /// Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
    /// Sets a callback that is called right before the collision 2 event, return `true` to skip the game's collision handling.
    /// Use this only when no other approach works, this call can be expensive if overused.
    /// Check [here](https://github.com/spelunky-fyi/overlunky/blob/main/docs/virtual-availability.md) to see whether you can use this callback on the entity type you intend to.
    lua["set_pre_collision2"] = [&lua](int uid, sol::function fun) -> sol::optional<CallbackId>
    {
        if (Entity* e = get_entity_ptr(uid))
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            std::uint32_t id = e->reserve_callback_id();
            e->set_pre_collision2(
                id,
                [=, &lua, fun = std::move(fun)](Entity* self, Entity* collision_entity)
                {
                    if (!backend->get_enabled() || backend->is_entity_callback_cleared({uid, id}))
                        return false;
                    backend->set_current_callback(uid, id, CallbackType::Entity);
                    auto return_value = backend->handle_function_with_return<bool>(fun, lua["cast_entity"](self), lua["cast_entity"](collision_entity)).value_or(false);
                    backend->clear_current_callback();
                    return return_value;
                });
            backend->hook_entity_dtor(e);
            backend->entity_hooks.push_back({uid, id});
            return id;
        }
        return sol::nullopt;
    };
    /// Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
    /// Sets a callback that is called right after the entity is rendered. The signature of the callback is `bool pre_render(render_ctx, entity)`
    /// where `render_ctx` is a `VanillaRenderContext`. Return `true` to skip the original rendering function and all later pre_render callbacks.
    /// Use this only when no other approach works, this call can be expensive if overused.
    lua["set_pre_render"] = [&lua](int uid, sol::function fun) -> sol::optional<CallbackId>
    {
        if (Entity* e = get_entity_ptr(uid))
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            std::uint32_t id = e->reserve_callback_id();
            e->set_pre_render(
                id,
                [=, &lua, fun = std::move(fun)](Entity* self)
                {
                    if (!backend->get_enabled() || backend->is_entity_callback_cleared({uid, id}))
                        return false;
                    VanillaRenderContext render_ctx{};
                    backend->set_current_callback(uid, id, CallbackType::Entity);
                    auto return_value = backend->handle_function_with_return<bool>(fun, render_ctx, lua["cast_entity"](self)).value_or(false);
                    backend->clear_current_callback();
                    return return_value;
                });
            backend->hook_entity_dtor(e);
            backend->entity_hooks.push_back({uid, id});
            return id;
        }
        return sol::nullopt;
    };
    /// Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
    /// Sets a callback that is called right after the entity is rendered. The signature of the callback is `nil post_render(render_ctx, entity)`
    /// where `render_ctx` is a `VanillaRenderContext`.
    /// Use this only when no other approach works, this call can be expensive if overused.
    lua["set_post_render"] = [&lua](int uid, sol::function fun) -> sol::optional<CallbackId>
    {
        if (Entity* e = get_entity_ptr(uid))
        {
            LuaBackend* backend = LuaBackend::get_calling_backend();
            std::uint32_t id = e->reserve_callback_id();
            e->set_post_render(
                id,
                [=, &lua, fun = std::move(fun)](Entity* self)
                {
                    if (!backend->get_enabled() || backend->is_entity_callback_cleared({uid, id}))
                        return;
                    VanillaRenderContext render_ctx{};
                    backend->set_current_callback(uid, id, CallbackType::Entity);
                    backend->handle_function(fun, render_ctx, lua["cast_entity"](self));
                    backend->clear_current_callback();
                });
            backend->hook_entity_dtor(e);
            backend->entity_hooks.push_back({uid, id});
            return id;
        }
        return sol::nullopt;
    };

    /// Raise a signal and probably crash the game
    lua["raise"] = std::raise;

    /// Convert the hash to stringid
    /// Check [strings00_hashed.str](game_data/strings00_hashed.str) for the hash values, or extract assets with modlunky and check those.
    lua["hash_to_stringid"] = hash_to_stringid;

    /// Get string behind STRINGID (don't use stringid diretcly for vanilla string, use `hash_to_stringid` first)
    /// Will return the string of currently choosen language
    lua["get_string"] = get_string;

    /// Change string at the given id (don't use stringid diretcly for vanilla string, use `hash_to_stringid` first)
    /// This edits custom string and in game strings but changing the language in settings will reset game strings
    lua["change_string"] = [](STRINGID id, std::u16string str)
    {
        return change_string(id, str);
    };

    /// Add custom string, currently can only be used for names of shop items (Entitydb->description)
    /// Returns STRINGID of the new string
    lua["add_string"] = add_string;

    /// Adds custom name to the item by uid used in the shops
    /// This is better alternative to `add_string` but instead of changing the name for entity type, it changes it for this particular entity
    lua["add_custom_name"] = add_custom_name;

    /// Clears the name set with `add_custom_name`
    lua["clear_custom_name"] = clear_custom_name;

    /// Calls the enter door function, position doesn't matter, can also enter closed doors (like COG, EW) without unlocking them
    lua["enter_door"] = enter_door;

    /// Change ENT_TYPE's spawned by `FLOOR_SUNCHALLENGE_GENERATOR`, by default there are 4:
    /// {MONS_WITCHDOCTOR, MONS_VAMPIRE, MONS_SORCERESS, MONS_NECROMANCER}
    /// Because of the game logic number of entity types has to be a power of 2: (1, 2, 4, 8, 16, 32), if you want say 30 types, you need to write two entities two times (they will have higher "spawn chance")
    /// Use empty table as argument to reset to the game default
    lua["change_sunchallenge_spawns"] = change_sunchallenge_spawns;

    /// Change ENT_TYPE's spawned in dice shops (Madame Tusk as well), by default there are 25:
    /// {ITEM_PICKUP_BOMBBAG, ITEM_PICKUP_BOMBBOX, ITEM_PICKUP_ROPEPILE, ITEM_PICKUP_COMPASS, ITEM_PICKUP_PASTE, ITEM_PICKUP_PARACHUTE, ITEM_PURCHASABLE_CAPE, ITEM_PICKUP_SPECTACLES, ITEM_PICKUP_CLIMBINGGLOVES, ITEM_PICKUP_PITCHERSMITT,
    /// ENT_TYPE_ITEM_PICKUP_SPIKESHOES, ENT_TYPE_ITEM_PICKUP_SPRINGSHOES, ITEM_MACHETE, ITEM_BOOMERANG, ITEM_CROSSBOW, ITEM_SHOTGUN, ITEM_FREEZERAY, ITEM_WEBGUN, ITEM_CAMERA, ITEM_MATTOCK, ITEM_PURCHASABLE_JETPACK, ITEM_PURCHASABLE_HOVERPACK,
    /// ITEM_TELEPORTER, ITEM_PURCHASABLE_TELEPORTER_BACKPACK, ITEM_PURCHASABLE_POWERPACK}
    /// Min 6, Max 255, if you want less then 6 you need to write some of them more then once (they will have higher "spawn chance")
    /// If you use this function in the level with diceshop in it, you have to update `item_ids` in the [ITEM_DICE_PRIZE_DISPENSER](#PrizeDispenser)
    /// Use empty table as argument to reset to the game default
    lua["change_diceshop_prizes"] = change_diceshop_prizes;

    /// Change ENT_TYPE's spawned when you damage the altar, by default there are 6:
    /// {MONS_BAT, MONS_BEE, MONS_SPIDER, MONS_JIANGSHI, MONS_FEMALE_JIANGSHI, MONS_VAMPIRE}
    /// Max 255 types
    /// Use empty table as argument to reset to the game default
    lua["change_altar_damage_spawns"] = change_altar_damage_spawns;

    /// Change ENT_TYPE's spawned when Waddler dies, by default there are 3:
    /// {ITEM_PICKUP_COMPASS, ITEM_CHEST, ITEM_KEY}
    /// Max 255 types
    /// Use empty table as argument to reset to the game default
    lua["change_waddler_drop"] = change_waddler_drop;

    /// Poisons entity, to cure poison set `poison_tick_timer` to -1
    lua["poison_entity"] = poison_entity;

    /// Change how much health the ankh gives you after death, with every beat (the heart beat effect) it will add `beat_add_health` to your health,
    /// `beat_add_health` has to be divisor of `health` and can't be 0, otherwise the function does nothing, Set `health` to 0 return to game default values,
    /// If you set `health` above the game max health it will be forced down to the game max
    lua["modify_ankh_health_gain"] = modify_ankh_health_gain;

    /// Adds entity as shop item, has to be movable (haven't tested many)
    lua["add_item_to_shop"] = add_item_to_shop;

    /// Change the amount of frames after the damage from poison is applied
    lua["change_poison_timer"] = change_poison_timer;

    auto create_illumination = sol::overload(
        static_cast<Illumination* (*)(Color color, float size, float x, float y)>(::create_illumination),
        static_cast<Illumination* (*)(Color color, float size, uint32_t uid)>(::create_illumination));
    /// Creates a new Illumination. Don't forget to continuously call `refresh_illumination`, otherwise your light emitter fades out! Check out the illumination.lua script for an example
    lua["create_illumination"] = create_illumination;
    /// Refreshes an Illumination, keeps it from fading out
    lua["refresh_illumination"] = refresh_illumination;

    /// Removes all liquid that is about to go out of bounds, which crashes the game.
    lua["fix_liquid_out_of_bounds"] = fix_liquid_out_of_bounds;

    /// Gets the specified setting, values might need to be interpreted differently per setting
    lua["get_setting"] = get_setting;

    /// Return the name of an unknown number in an enum table
    // lua["enum_get_name"] = [](table enum, int value) -> string
    lua["enum_get_name"] = lua.safe_script(R"(
        return function(table, value)
            for k,v in pairs(table) do
                if v == value then return k end
            end
        end
    )");

    /// Spawn a Shopkeeper in the coordinates and make the room their shop. Returns the Shopkeeper uid. Also see spawn_roomowner.
    // lua["spawn_shopkeeper"] = [](float x, float, y, LAYER layer, ROOM_TEMPLATE room_template = ROOM_TEMPLATE.SHOP) -> uint32_t
    lua["spawn_shopkeeper"] = sol::overload(
        [](float x, float y, LAYER layer)
        {
            return spawn_shopkeeper(x, y, layer);
        },
        [](float x, float y, LAYER layer, ROOM_TEMPLATE room_template)
        {
            return spawn_shopkeeper(x, y, layer, room_template);
        });

    /// Spawn a RoomOwner (or a few other like CavemanShopkeeper) in the coordinates and make them own the room, optionally changing the room template. Returns the RoomOwner uid.
    // lua["spawn_roomowner"] = [](ENT_TYPE owner_type, float x, float, y, LAYER layer, ROOM_TEMPLATE room_template = -1) -> uint32_t
    lua["spawn_roomowner"] = sol::overload(
        [](ENT_TYPE owner_type, float x, float y, LAYER layer)
        {
            return spawn_roomowner(owner_type, x, y, layer);
        },
        [](ENT_TYPE owner_type, float x, float y, LAYER layer, int16_t room_template)
        {
            return spawn_roomowner(owner_type, x, y, layer, room_template);
        });

    lua.create_named_table("INPUTS", "NONE", 0, "JUMP", 1, "WHIP", 2, "BOMB", 4, "ROPE", 8, "RUN", 16, "DOOR", 32, "MENU", 64, "JOURNAL", 128, "LEFT", 256, "RIGHT", 512, "UP", 1024, "DOWN", 2048);

    lua.create_named_table(
        "ON",
        "LOGO",
        ON::LOGO,
        "INTRO",
        ON::INTRO,
        "PROLOGUE",
        ON::PROLOGUE,
        "TITLE",
        ON::TITLE,
        "MENU",
        ON::MENU,
        "OPTIONS",
        ON::OPTIONS,
        "LEADERBOARD",
        ON::LEADERBOARD,
        "SEED_INPUT",
        ON::SEED_INPUT,
        "CHARACTER_SELECT",
        ON::CHARACTER_SELECT,
        "TEAM_SELECT",
        ON::TEAM_SELECT,
        "CAMP",
        ON::CAMP,
        "LEVEL",
        ON::LEVEL,
        "TRANSITION",
        ON::TRANSITION,
        "DEATH",
        ON::DEATH,
        "SPACESHIP",
        ON::SPACESHIP,
        "WIN",
        ON::WIN,
        "CREDITS",
        ON::CREDITS,
        "SCORES",
        ON::SCORES,
        "CONSTELLATION",
        ON::CONSTELLATION,
        "RECAP",
        ON::RECAP,
        "ARENA_MENU",
        ON::ARENA_MENU,
        "ARENA_INTRO",
        ON::ARENA_INTRO,
        "ARENA_MATCH",
        ON::ARENA_MATCH,
        "ARENA_SCORE",
        ON::ARENA_SCORE,
        "ONLINE_LOADING",
        ON::ONLINE_LOADING,
        "ONLINE_LOBBY",
        ON::ONLINE_LOBBY,
        "GUIFRAME",
        ON::GUIFRAME,
        "FRAME",
        ON::FRAME,
        "GAMEFRAME",
        ON::GAMEFRAME,
        "SCREEN",
        ON::SCREEN,
        "START",
        ON::START,
        "LOADING",
        ON::LOADING,
        "RESET",
        ON::RESET,
        "SAVE",
        ON::SAVE,
        "LOAD",
        ON::LOAD,
        "PRE_LOAD_LEVEL_FILES",
        ON::PRE_LOAD_LEVEL_FILES,
        "PRE_LEVEL_GENERATION",
        ON::PRE_LEVEL_GENERATION,
        "POST_ROOM_GENERATION",
        ON::POST_ROOM_GENERATION,
        "POST_LEVEL_GENERATION",
        ON::POST_LEVEL_GENERATION,
        "PRE_GET_RANDOM_ROOM",
        ON::PRE_GET_RANDOM_ROOM,
        "PRE_HANDLE_ROOM_TILES",
        ON::PRE_HANDLE_ROOM_TILES,
        "SCRIPT_ENABLE",
        ON::SCRIPT_ENABLE,
        "SCRIPT_DISABLE",
        ON::SCRIPT_DISABLE,
        "RENDER_PRE_HUD",
        ON::RENDER_PRE_HUD,
        "RENDER_POST_HUD",
        ON::RENDER_POST_HUD,
        "RENDER_PRE_PAUSE_MENU",
        ON::RENDER_PRE_PAUSE_MENU,
        "RENDER_POST_PAUSE_MENU",
        ON::RENDER_POST_PAUSE_MENU,
        "RENDER_PRE_DRAW_DEPTH",
        ON::RENDER_PRE_DRAW_DEPTH,
        "RENDER_POST_DRAW_DEPTH",
        ON::RENDER_POST_DRAW_DEPTH,
        "RENDER_POST_JOURNAL_PAGE",
        ON::RENDER_POST_JOURNAL_PAGE,
        "SPEECH_BUBBLE",
        ON::SPEECH_BUBBLE,
        "TOAST",
        ON::TOAST);
    /* ON
    // GUIFRAME
    // Params: `GuiDrawContext draw_ctx`
    // Runs every frame the game is rendered, thus runs at selected framerate. Drawing functions are only available during this callback through a `GuiDrawContext`
    // FRAME
    // Runs while playing the game while the player is controllable, not in the base camp or the arena mode
    // GAMEFRAME
    // Runs whenever the game engine is actively running. This includes base camp, arena, level transition and death screen
    // SCREEN
    // Runs whenever state.screen changes
    // START
    // Runs on the first ON.SCREEN of a run
    // RESET
    // Runs when resetting a run
    // PRE_LOAD_LEVEL_FILES
    // Params: `PreLoadLevelFilesContext load_level_ctx`
    // Runs right before level files would be loaded
    // PRE_LEVEL_GENERATION
    // Runs before any level generation, no entities should exist at this point
    // POST_ROOM_GENERATION
    // Params: `PostRoomGenerationContext room_gen_ctx`
    // Runs right after all rooms are generated before entities are spawned
    // POST_LEVEL_GENERATION
    // Runs right level generation is done, before any entities are updated
    // PRE_GET_RANDOM_ROOM
    // Params: `int x,::int y, LAYER layer, ROOM_TEMPLATE room_template`
    // Return: `string room_data`
    // Called when the game wants to get a random room for a given template. Return a string that represents a room template to make the game use that.
    // If the size of the string returned does not match with the room templates expected size the room is discarded.
    // White spaces at the beginning and end of the string are stripped, not at the beginning and end of each line.
    // PRE_HANDLE_ROOM_TILES
    // Params: `int x, int y, ROOM_TEMPLATE room_template, PreHandleRoomTilesContext room_ctx`
    // Return: `bool last_callback` to determine whether callbacks of the same type should be executed after this
    // Runs after a random room was selected and right before it would spawn entities for each tile code
    // Allows you to modify the rooms content in the front and back layer as well as add a backlayer if not yet existant
    // SAVE
    // Params: `SaveContext save_ctx`
    // Runs at the same times as ON.SCREEN, but receives the save_ctx
    // LOAD
    // Params: `LoadContext load_ctx`
    // Runs as soon as your script is loaded, including reloads, then never again
    // RENDER_PRE_HUD
    // Params: `VanillaRenderContext render_ctx`
    // Runs before the HUD is drawn on screen. In this event, you can draw textures with the `draw_screen_texture` function of the render_ctx
    // RENDER_POST_HUD
    // Params: `VanillaRenderContext render_ctx`
    // Runs after the HUD is drawn on screen. In this event, you can draw textures with the `draw_screen_texture` function of the render_ctx
    // RENDER_PRE_PAUSE_MENU
    // Params: `VanillaRenderContext render_ctx`
    // Runs before the pause menu is drawn on screen. In this event, you can draw textures with the `draw_screen_texture` function of the render_ctx
    // RENDER_POST_PAUSE_MENU
    // Params: `VanillaRenderContext render_ctx`
    // Runs after the pause menu is drawn on screen. In this event, you can draw textures with the `draw_screen_texture` function of the render_ctx
    // RENDER_PRE_DRAW_DEPTH
    // Params: `VanillaRenderContext render_ctx, int draw_depth`
    // Runs before the entities of the specified draw_depth are drawn on screen. In this event, you can draw textures with the `draw_world_texture` function of the render_ctx
    // RENDER_POST_DRAW_DEPTH
    // Params: `VanillaRenderContext render_ctx, int draw_depth`
    // Runs right after the entities of the specified draw_depth are drawn on screen. In this event, you can draw textures with the `draw_world_texture` function of the render_ctx
    // RENDER_POST_JOURNAL_PAGE
    // Params: `VanillaRenderContext render_ctx, JOURNAL_PAGE_TYPE page_type, JournalPage page`
    // Runs after the journal page is drawn on screen. In this event, you can draw textures with the `draw_screen_texture` function of the render_ctx
    // The page_type parameter values can be found in the JOURNAL_PAGE_TYPE ENUM
    // The JournalPage parameter gives you access to the specific fields of the page. Be sure to cast it to the correct type, the following functions are available to do that:
    // `page:as_journal_page_progress()`
    // `page:as_journal_page_journalmenu()`
    // `page:as_journal_page_places()`
    // `page:as_journal_page_people()`
    // `page:as_journal_page_bestiary()`
    // `page:as_journal_page_items()`
    // `page:as_journal_page_traps()`
    // `page:as_journal_page_story()`
    // `page:as_journal_page_feats()`
    // `page:as_journal_page_deathcause()`
    // `page:as_journal_page_deathmenu()`
    // `page:as_journal_page_recap()`
    // `page:as_journal_page_playerprofile()`
    // `page:as_journal_page_lastgameplayed()`
    // SPEECH_BUBBLE
    // Params: `Entity speaking_entity, string text`
    // Runs before any speech bubble is created, even the one using `say` function
    // Return behavior: if you don't return anything it will execute the speech bubble function normally with default message
    // if you return empty string, it will not create the speech bubble at all, if you return string, it will use that instead of the original
    // The first script to return string (empty or not) will take priority, the rest will receive callback call but the return behavior won't matter
    // TOAST
    // Params: `string text`
    // Runs before any toast is created, even the one using `toast` function
    // Return behavior: if you don't return anything it will execute the toast function normally with default message
    // if you return empty string, it will not create the toast at all, if you return string, it will use that instead of the original message
    // The first script to return string (empty or not) will take priority, the rest will receive callback call but the return behavior won't matter
    */

    lua.create_named_table(
        "SPAWN_TYPE",
        "LEVEL_GEN",
        SPAWN_TYPE_LEVEL_GEN,
        "LEVEL_GEN_TILE_CODE",
        SPAWN_TYPE_LEVEL_GEN_TILE_CODE,
        "LEVEL_GEN_PROCEDURAL",
        SPAWN_TYPE_LEVEL_GEN_PROCEDURAL,
        "LEVEL_GEN_FLOOR_SPREADING",
        SPAWN_TYPE_LEVEL_GEN_FLOOR_SPREADING,
        "LEVEL_GEN_GENERAL",
        SPAWN_TYPE_LEVEL_GEN_GENERAL,
        "SCRIPT",
        SPAWN_TYPE_SCRIPT,
        "SYSTEMIC",
        SPAWN_TYPE_SYSTEMIC,
        "ANY",
        SPAWN_TYPE_ANY);
    /* SPAWN_TYPE
    // LEVEL_GEN
    // For any spawn happening during level generation, even if the call happened from the Lua API during a tile code callback.
    // LEVEL_GEN_TILE_CODE
    // Similar to LEVEL_GEN but only triggers on tile code spawns.
    // LEVEL_GEN_PROCEDURAL
    // Similar to LEVEL_GEN but only triggers on random level spawns, like snakes or bats.
    // LEVEL_GEN_FLOOR_SPREADING
    // Only procs during floor spreading, both horizontal and vertical
    // LEVEL_GEN_GENERAL
    // Covers all spawns during level gen that are not covered by the other two.
    // SCRIPT
    // Runs for any spawn happening through a call from the Lua API, also during level generation.
    // SYSTEMIC
    // Covers all other spawns, such as items from crates or the player throwing bombs.
    // ANY
    // Covers all of the above.
    */
    /// Some arbitrary constants of the engine
    lua.create_named_table("CONST", "ENGINE_FPS", 60, "ROOM_WIDTH", 10, "ROOM_HEIGHT", 8, "MAX_TILES_VERT", g_level_max_y, "MAX_TILES_HORIZ", g_level_max_x, "NOF_DRAW_DEPTHS", 53, "MAX_PLAYERS", 4);
    /* CONST
    // ENGINE_FPS
    // The framerate at which the engine updates, e.g. at which `ON.GAMEFRAME` and similar are called.
    // Independent of rendering framerate, so it does not correlate with the call rate of `ON.GUIFRAME` and similar.
    // ROOM_WIDTH
    // Width of a 1x1 room, both in world coordinates and in tiles.
    // ROOM_HEIGHT
    // Height of a 1x1 room, both in world coordinates and in tiles.
    // MAX_TILES_VERT
    // Maximum number of working floor tiles in vertical axis, 126 (0-125 coordinates)
    // Floors spawned above or below will not have any collision
    // MAX_TILES_HORIZ
    // Maximum number of working floor tiles in horizontal axis, 86 (0-85 coordinates)
    // Floors spawned above or below will not have any collision
    // NOF_DRAW_DEPTHS
    // Number of draw_depths, 53 (0-52)
    // MAX_PLAYERS
    // Just the max number of players in multiplayer
    */
    /// After setting the WIN_STATE, the exit door on the current level will lead to the chosen ending
    lua.create_named_table(
        "WIN_STATE",
        "NO_WIN",
        0,
        "TIAMAT_WIN",
        1,
        "HUNDUN_WIN",
        2,
        "COSMIC_OCEAN_WIN",
        3);

    /// Used in the `render_ctx:draw_text` and `render_ctx:draw_text_size` functions of the ON.RENDER_PRE/POST_xxx event
    lua.create_named_table(
        "VANILLA_TEXT_ALIGNMENT",
        "LEFT",
        0,
        "CENTER",
        1,
        "RIGHT",
        2);

    /// Used in the `render_ctx:draw_text` and `render_ctx:draw_text_size` functions of the ON.RENDER_PRE/POST_xxx event
    /// There are more styles, we just didn't name them all
    lua.create_named_table(
        "VANILLA_FONT_STYLE",
        "NORMAL",
        0,
        "ITALIC",
        1,
        "BOLD",
        2);

    /// Paramater to `get_setting()`
    lua.create_named_table("GAME_SETTING"
                           //, "DAMSEL_STYLE", 0
                           //, "", ...check__[game_settings.txt]\[game_data/game_settings.txt\]...
                           //, "CROSSPROGRESS_AUTOSYNC", 47
    );
    for (auto [setting_name_view, setting_index] : get_settings_names_and_indices())
    {
        std::string setting_name{setting_name_view};
        std::transform(setting_name.begin(), setting_name.end(), setting_name.begin(), [](unsigned char c)
                       { return (unsigned char)std::toupper(c); });
        lua["GAME_SETTING"][std::move(setting_name)] = setting_index;
    }
}

std::vector<std::string> safe_fields{};
std::vector<std::string> unsafe_fields{};

std::shared_ptr<sol::state> acquire_lua_vm(class SoundManager* sound_manager)
{
    static std::shared_ptr<sol::state> global_vm = [sound_manager]()
    {
        std::shared_ptr<sol::state> global_vms = std::make_shared<sol::state>();
        sol::state& lua_vm = *global_vms;
        load_libraries(lua_vm);
        populate_lua_state(lua_vm, sound_manager);

        for (auto& [k, v] : lua_vm["_G"].get<sol::table>())
        {
            if (k.get_type() == sol::type::string)
            {
                std::string_view key = k.as<std::string_view>();
                if (key != "debug" && key != "package")
                {
                    safe_fields.push_back(std::string{key});
                }
            }
        }

        load_unsafe_libraries(lua_vm);

        for (auto& [k, v] : lua_vm["_G"].get<sol::table>())
        {
            if (k.get_type() == sol::type::string)
            {
                std::string_view key = k.as<std::string_view>();
                auto it = std::find(safe_fields.begin(), safe_fields.end(), key);
                if (it == safe_fields.end())
                {
                    unsafe_fields.push_back(std::string{key});
                }
            }
        }

        return global_vms;
    }();
    return global_vm;
}
sol::state& get_lua_vm(SoundManager* sound_manager)
{
    static sol::state& global_vm = *acquire_lua_vm(sound_manager);
    return global_vm;
}

sol::protected_function_result execute_lua(sol::environment& env, std::string_view code)
{
    static sol::state& global_vm = get_lua_vm();
    return global_vm.safe_script(code, env);
}

void populate_lua_env(sol::environment& env)
{
    static const sol::state& global_vm = get_lua_vm();
    for (auto& field : safe_fields)
    {
        env[field] = global_vm["_G"][field];
    }
    env["_G"] = env;
}
void hide_unsafe_libraries(sol::environment& env)
{
    for (auto& field : unsafe_fields)
    {
        env[field] = sol::nil;
    }
}
void expose_unsafe_libraries(sol::environment& env)
{
    static const sol::state& global_vm = get_lua_vm();
    for (auto& field : unsafe_fields)
    {
        env[field] = global_vm["_G"][field];
    }
}
