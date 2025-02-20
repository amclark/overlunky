---@diagnostic disable: unused-function,lowercase-global
---@class Meta
---@field name string
---@field version string
---@field description string
---@field author string

---@type Meta
meta = nil

---@type StateMemory
state = nil
---@type GameManager
game_manager = nil
---@type Online
online = nil
---@type Player[]
players = nil
---@type SaveData
savegame = nil
---@type any
options = nil
---@type PRNG
prng = nil

-- Functions

---Returns Player (or PlayerGhost if `get_player(1, true)`) with this player slot
---@param slot integer
---@param or_ghost boolean
---@return Player
function get_player(slot, or_ghost) end
---Returns PlayerGhost with this player slot 1..4
---@param slot integer
---@return PlayerGhost
function get_playerghost(slot) end
---Standard lua print function, prints directly to the console but not to the game
---@return nil
function lua_print() end
---Print a log message on screen.
---@param message string
---@return nil
function print(message) end
---Same as `print`
---@param message string
---@return nil
function message(message) end
---Prints any type of object by first funneling it through `inspect`, no need for a manual `tostring` or `inspect`.
---@vararg any
---@return nil
function prinspect(...) end
---Same as `prinspect`
---@vararg any
---@return nil
function messpect(...) end
---Adds a command that can be used in the console.
---@param name string
---@param cmd fun(): any
---@return nil
function register_console_command(name, cmd) end
---Returns unique id for the callback to be used in [clear_callback](#clear_callback). You can also return `false` from your function to clear the callback.
---Add per level callback function to be called every `frames` engine frames. Timer is paused on pause and cleared on level transition.
---@param cb fun(): any
---@param frames integer
---@return CallbackId
function set_interval(cb, frames) end
---Returns unique id for the callback to be used in [clear_callback](#clear_callback).
---Add per level callback function to be called after `frames` engine frames. Timer is paused on pause and cleared on level transition.
---@param cb fun(): any
---@param frames integer
---@return CallbackId
function set_timeout(cb, frames) end
---Returns unique id for the callback to be used in [clear_callback](#clear_callback). You can also return `false` from your function to clear the callback.
---Add global callback function to be called every `frames` engine frames. This timer is never paused or cleared.
---@param cb fun(): any
---@param frames integer
---@return CallbackId
function set_global_interval(cb, frames) end
---Returns unique id for the callback to be used in [clear_callback](#clear_callback).
---Add global callback function to be called after `frames` engine frames. This timer is never paused or cleared.
---@param cb fun(): any
---@param frames integer
---@return CallbackId
function set_global_timeout(cb, frames) end
---Returns unique id for the callback to be used in [clear_callback](#clear_callback).
---Add global callback function to be called on an [event](#ON).
---@param cb fun(): any
---@param screen integer
---@return CallbackId
function set_callback(cb, screen) end
---Clear previously added callback `id` or call without arguments inside any callback to clear that callback after it returns.
---@param id CallbackId?
---@return nil
function clear_callback(id) end
---Load another script by id "author/name" and import its `exports` table
---@param id string
---@param version string?
---@return table
function import(id, version) end
---Get your sanitized script id to be used in import.
---@return string
function get_id() end
---Show a message that looks like a level feeling.
---@param message string
---@return nil
function toast(message) end
---Show a message coming from an entity
---@param entity_uid integer
---@param message string
---@param unk_type integer
---@param top boolean
---@return nil
function say(entity_uid, message, unk_type, top) end
---Add an integer option that the user can change in the UI. Read with `options.name`, `value` is the default. Keep in mind these are just soft
---limits, you can override them in the UI with double click.
---@param name string
---@param desc string
---@param long_desc string
---@param value integer
---@param min integer
---@param max integer
---@return nil
function register_option_int(name, desc, long_desc, value, min, max) end
---Add a float option that the user can change in the UI. Read with `options.name`, `value` is the default. Keep in mind these are just soft
---limits, you can override them in the UI with double click.
---@param name string
---@param desc string
---@param long_desc string
---@param value number
---@param min number
---@param max number
---@return nil
function register_option_float(name, desc, long_desc, value, min, max) end
---Add a boolean option that the user can change in the UI. Read with `options.name`, `value` is the default.
---@param name string
---@param desc string
---@param long_desc string
---@param value boolean
---@return nil
function register_option_bool(name, desc, long_desc, value) end
---Add a string option that the user can change in the UI. Read with `options.name`, `value` is the default.
---@param name string
---@param desc string
---@param long_desc string
---@param value string
---@return nil
function register_option_string(name, desc, long_desc, value) end
---Add a combobox option that the user can change in the UI. Read the int index of the selection with `options.name`. Separate `opts` with `\0`,
---with a double `\0\0` at the end.
---@param name string
---@param desc string
---@param long_desc string
---@param opts string
---@return nil
function register_option_combo(name, desc, long_desc, opts) end
---Add a button that the user can click in the UI. Sets the timestamp of last click on value and runs the callback function.
---@param name string
---@param desc string
---@param long_desc string
---@param on_click fun(): any
---@return nil
function register_option_button(name, desc, long_desc, on_click) end
---Spawn liquids, always spawns in the front layer, will have fun effects if `entity_type` is not a liquid (only the short version, without velocity etc.).
---Don't overuse this, you are still restricted by the liquid pool sizes and thus might crash the game.
---`liquid_flags` - not much known about, 2 - will probably crash the game, 3 - pause_physics, 6-12 is probably agitation, surface_tension etc. set to 0 to ignore
---`amount` - it will spawn amount x amount (so 1 = 1, 2 = 4, 3 = 6 etc.), `blobs_separation` is optional
---@param entity_type ENT_TYPE
---@param x number
---@param y number
---@return nil
function spawn_liquid(entity_type, x, y) end
---Spawn liquids, always spawns in the front layer, will have fun effects if `entity_type` is not a liquid (only the short version, without velocity etc.).
---Don't overuse this, you are still restricted by the liquid pool sizes and thus might crash the game.
---`liquid_flags` - not much known about, 2 - will probably crash the game, 3 - pause_physics, 6-12 is probably agitation, surface_tension etc. set to 0 to ignore
---`amount` - it will spawn amount x amount (so 1 = 1, 2 = 4, 3 = 6 etc.), `blobs_separation` is optional
---@param entity_type ENT_TYPE
---@param x number
---@param y number
---@param velocityx number
---@param velocityy number
---@param liquid_flags integer
---@param amount integer
---@param blobs_separation number
---@return nil
function spawn_liquid(entity_type, x, y, velocityx, velocityy, liquid_flags, amount, blobs_separation) end
---Spawn an entity in position with some velocity and return the uid of spawned entity.
---Uses level coordinates with [LAYER.FRONT](#LAYER) and LAYER.BACK, but player-relative coordinates with LAYER.PLAYERn.
---@param entity_type ENT_TYPE
---@param x number
---@param y number
---@param layer LAYER
---@param vx number
---@param vy number
---@return integer
function spawn_entity(entity_type, x, y, layer, vx, vy) end
---Short for [spawn_entity](#spawn_entity).
---@param entity_type ENT_TYPE
---@param x number
---@param y number
---@param layer LAYER
---@param vx number
---@param vy number
---@return integer
function spawn(entity_type, x, y, layer, vx, vy) end
---Spawns an entity directly on the floor below the tile at the given position.
---Use this to avoid the little fall that some entities do when spawned during level gen callbacks.
---@param entity_type ENT_TYPE
---@param x number
---@param y number
---@param layer LAYER
---@return integer
function spawn_entity_snapped_to_floor(entity_type, x, y, layer) end
---Short for [spawn_entity_snapped_to_floor](#spawn_entity_snapped_to_floor).
---@param entity_type ENT_TYPE
---@param x number
---@param y number
---@param layer LAYER
---@return integer
function spawn_on_floor(entity_type, x, y, layer) end
---Spawn a grid entity, such as floor or traps, that snaps to the grid.
---@param entity_type ENT_TYPE
---@param x number
---@param y number
---@param layer LAYER
---@return integer
function spawn_grid_entity(entity_type, x, y, layer) end
---Same as `spawn_entity` but does not trigger any pre-entity-spawn callbacks, so it will not be replaced by another script
---@param entity_type ENT_TYPE
---@param x number
---@param y number
---@param layer LAYER
---@param vx number
---@param vy number
---@return integer
function spawn_entity_nonreplaceable(entity_type, x, y, layer, vx, vy) end
---Short for [spawn_entity_nonreplaceable](#spawn_entity_nonreplaceable).
---@param entity_type ENT_TYPE
---@param x number
---@param y number
---@param layer LAYER
---@param vx number
---@param vy number
---@return integer
function spawn_critical(entity_type, x, y, layer, vx, vy) end
---Spawn a door to another world, level and theme and return the uid of spawned entity.
---Uses level coordinates with LAYER.FRONT and LAYER.BACK, but player-relative coordinates with LAYER.PLAYERn
---@param x number
---@param y number
---@param layer LAYER
---@param w integer
---@param l integer
---@param t integer
---@return integer
function spawn_door(x, y, layer, w, l, t) end
---Short for [spawn_door](#spawn_door).
---@param x number
---@param y number
---@param layer LAYER
---@param w integer
---@param l integer
---@param t integer
---@return integer
function door(x, y, layer, w, l, t) end
---Spawn a door to backlayer.
---@param x number
---@param y number
---@return nil
function spawn_layer_door(x, y) end
---Short for [spawn_layer_door](#spawn_layer_door).
---@param x number
---@param y number
---@return nil
function layer_door(x, y) end
---Spawns apep with the choice if it going left or right, if you want the game to choose use regular spawn functions with `ENT_TYPE.MONS_APEP_HEAD`
---@param x number
---@param y number
---@param layer LAYER
---@param right boolean
---@return integer
function spawn_apep(x, y, layer, right) end
---Spawns and grows a tree
---@param x number
---@param y number
---@param layer LAYER
---@return nil
function spawn_tree(x, y, layer) end
---Spawns and grows a tree
---@param x number
---@param y number
---@param layer LAYER
---@param height integer
---@return nil
function spawn_tree(x, y, layer, height) end
---Spawns and grows mushroom, height relates to the trunk, without it, it will roll the game default 3-5 height
---Regardless, if there is not enough space, it will spawn shorter one or if there is no space even for the smallest one, it will just not spawn at all
---Returns uid of the base or -1 if it wasn't able to spawn
---@param x number
---@param y number
---@param l LAYER
---@return integer
function spawn_mushroom(x, y, l) end
---Spawns and grows mushroom, height relates to the trunk, without it, it will roll the game default 3-5 height
---Regardless, if there is not enough space, it will spawn shorter one or if there is no space even for the smallest one, it will just not spawn at all
---Returns uid of the base or -1 if it wasn't able to spawn
---@param x number
---@param y number
---@param l LAYER
---@param height integer
---@return integer
function spawn_mushroom(x, y, l, height) end
---Spawn a player in given location, if player of that slot already exist it will spawn clone, the game may crash as this is very unexpected situation
---If you want to respawn a player that is a ghost, set in his inventory `health` to above 0, and `time_of_death` to 0 and call this function, the ghost entity will be removed automatically
---@param player_slot integer
---@param x number
---@param y number
---@return nil
function spawn_player(player_slot, x, y) end
---Add a callback for a spawn of specific entity types or mask. Set `mask` to `MASK.ANY` to ignore that.
---This is run before the entity is spawned, spawn your own entity and return its uid to replace the intended spawn.
---In many cases replacing the intended entity won't have the indended effect or will even break the game, so use only if you really know what you're doing.
---The callback signature is `optional<int> pre_entity_spawn(entity_type, x, y, layer, overlay_entity, spawn_flags)`
---@param cb fun(): any
---@param flags SPAWN_TYPE
---@param mask integer
---@vararg any
---@return CallbackId
function set_pre_entity_spawn(cb, flags, mask, ...) end
---Add a callback for a spawn of specific entity types or mask. Set `mask` to `MASK.ANY` to ignore that.
---This is run right after the entity is spawned but before and particular properties are changed, e.g. owner or velocity.
---The callback signature is `nil post_entity_spawn(entity, spawn_flags)`
---@param cb fun(): any
---@param flags SPAWN_TYPE
---@param mask integer
---@vararg any
---@return CallbackId
function set_post_entity_spawn(cb, flags, mask, ...) end
---Warp to a level immediately.
---@param w integer
---@param l integer
---@param t integer
---@return nil
function warp(w, l, t) end
---Set seed and reset run.
---@param seed integer
---@return nil
function set_seed(seed) end
---Enable/disable godmode for players.
---@param g boolean
---@return nil
function god(g) end
---Enable/disable godmode for companions.
---@param g boolean
---@return nil
function god_companions(g) end
---Set the zoom level used in levels and shops. 13.5 is the default.
---@param level number
---@return nil
function zoom(level) end
---Enable/disable game engine pause.
---This is just short for `state.pause == 32`, but that produces an audio bug
---I suggest `state.pause == 2`, but that won't run any callback, `state.pause == 16` will do the same but `set_global_interval` will still work
---@param p boolean
---@return nil
function pause(p) end
---Teleport entity to coordinates with optional velocity
---@param uid integer
---@param x number
---@param y number
---@param vx number
---@param vy number
---@return nil
function move_entity(uid, x, y, vx, vy) end
---Teleport entity to coordinates with optional velocity
---@param uid integer
---@param x number
---@param y number
---@param vx number
---@param vy number
---@param layer LAYER
---@return nil
function move_entity(uid, x, y, vx, vy, layer) end
---Teleport grid entity, the destination should be whole number, this ensures that the collisions will work properly
---@param uid integer
---@param x number
---@param y number
---@param layer LAYER
---@return nil
function move_grid_entity(uid, x, y, layer) end
---Make an ENT_TYPE.FLOOR_DOOR_EXIT go to world `w`, level `l`, theme `t`
---@param uid integer
---@param w integer
---@param l integer
---@param t integer
---@return nil
function set_door_target(uid, w, l, t) end
---Short for [set_door_target](#set_door_target).
---@param uid integer
---@param w integer
---@param l integer
---@param t integer
---@return nil
function set_door(uid, w, l, t) end
---Get door target `world`, `level`, `theme`
---@param uid integer
---@return integer, integer, integer
function get_door_target(uid) end
---Set the contents of ENT_TYPE.ITEM_POT, ENT_TYPE.ITEM_CRATE or ENT_TYPE.ITEM_COFFIN `uid` to ENT_TYPE... `item_entity_type`
---@param uid integer
---@param item_entity_type ENT_TYPE
---@return nil
function set_contents(uid, item_entity_type) end
---Get the Entity behind an uid, converted to the correct type. To see what type you will get, consult the [entity hierarchy list](https://github.com/spelunky-fyi/overlunky/blob/main/docs/entities-hierarchy.md)
---@param uid integer
---@return Entity
function get_entity(uid) end
---Get the [EntityDB](#EntityDB) behind an ENT_TYPE...
---@param id integer
---@return EntityDB
function get_type(id) end
---Gets a grid entity, such as floor or spikes, at the given position and layer.
---@param x number
---@param y number
---@param layer LAYER
---@return integer
function get_grid_entity_at(x, y, layer) end
---Returns a list of all uids in `entities` for which `predicate(get_entity(uid))` returns true
---@param entities integer[]
---@param predicate fun(): any
---@return integer[]
function filter_entities(entities, predicate) end
---Get uids of entities by some conditions. Set `entity_type` or `mask` to `0` to ignore that, can also use table of entity_types
---@param entity_types ENT_TYPE[]
---@param mask integer
---@param layer LAYER
---@return integer[]
function get_entities_by(entity_types, mask, layer) end
---Get uids of entities by some conditions. Set `entity_type` or `mask` to `0` to ignore that, can also use table of entity_types
---@param entity_type ENT_TYPE
---@param mask integer
---@param layer LAYER
---@return integer[]
function get_entities_by(entity_type, mask, layer) end
---Get uids of entities matching id. This function is variadic, meaning it accepts any number of id's.
---You can even pass a table!
---@vararg any
---@return integer[]
function get_entities_by_type(...) end
---Get uids of matching entities inside some radius. Set `entity_type` or `mask` to `0` to ignore that, can also use table of entity_types
---@param entity_types ENT_TYPE[]
---@param mask integer
---@param x number
---@param y number
---@param layer LAYER
---@param radius number
---@return integer[]
function get_entities_at(entity_types, mask, x, y, layer, radius) end
---Get uids of matching entities inside some radius. Set `entity_type` or `mask` to `0` to ignore that, can also use table of entity_types
---@param entity_type ENT_TYPE
---@param mask integer
---@param x number
---@param y number
---@param layer LAYER
---@param radius number
---@return integer[]
function get_entities_at(entity_type, mask, x, y, layer, radius) end
---Get uids of matching entities overlapping with the given hitbox. Set `entity_type` or `mask` to `0` to ignore that, can also use table of entity_types
---@param entity_types ENT_TYPE[]
---@param mask integer
---@param hitbox AABB
---@param layer LAYER
---@return integer[]
function get_entities_overlapping_hitbox(entity_types, mask, hitbox, layer) end
---Get uids of matching entities overlapping with the given hitbox. Set `entity_type` or `mask` to `0` to ignore that, can also use table of entity_types
---@param entity_type ENT_TYPE
---@param mask integer
---@param hitbox AABB
---@param layer LAYER
---@return integer[]
function get_entities_overlapping_hitbox(entity_type, mask, hitbox, layer) end
---Attaches `attachee` to `overlay`, similar to setting `get_entity(attachee).overlay = get_entity(overlay)`.
---However this function offsets `attachee` (so you don't have to) and inserts it into `overlay`'s inventory.
---@param overlay_uid integer
---@param attachee_uid integer
---@return nil
function attach_entity(overlay_uid, attachee_uid) end
---Get the `flags` field from entity by uid
---@param uid integer
---@return integer
function get_entity_flags(uid) end
---Set the `flags` field from entity by uid
---@param uid integer
---@param flags integer
---@return nil
function set_entity_flags(uid, flags) end
---Get the `more_flags` field from entity by uid
---@param uid integer
---@return integer
function get_entity_flags2(uid) end
---Set the `more_flags` field from entity by uid
---@param uid integer
---@param flags integer
---@return nil
function set_entity_flags2(uid, flags) end
---Get `state.level_flags`
---@return integer
function get_level_flags() end
---Set `state.level_flags`
---@param flags integer
---@return nil
function set_level_flags(flags) end
---Get the ENT_TYPE... of the entity by uid
---@param uid integer
---@return ENT_TYPE
function get_entity_type(uid) end
---Get the current set zoom level
---@return number
function get_zoom_level() end
---Get the game coordinates at the screen position (`x`, `y`)
---@param x number
---@param y number
---@return number, number
function game_position(x, y) end
---Translate an entity position to screen position to be used in drawing functions
---@param x number
---@param y number
---@return number, number
function screen_position(x, y) end
---Translate a distance of `x` tiles to screen distance to be be used in drawing functions
---@param x number
---@return number
function screen_distance(x) end
---Get position `x, y, layer` of entity by uid. Use this, don't use `Entity.x/y` because those are sometimes just the offset to the entity
---you're standing on, not real level coordinates.
---@param uid integer
---@return number, number, integer
function get_position(uid) end
---Get interpolated render position `x, y, layer` of entity by uid. This gives smooth hitboxes for 144Hz master race etc...
---@param uid integer
---@return number, number, integer
function get_render_position(uid) end
---Get velocity `vx, vy` of an entity by uid. Use this, don't use `Entity.velocityx/velocityy` because those are relative to `Entity.overlay`.
---@param uid integer
---@return number, number
function get_velocity(uid) end
---Remove item by uid from entity
---@param uid integer
---@param item_uid integer
---@return nil
function entity_remove_item(uid, item_uid) end
---Spawns and attaches ball and chain to `uid`, the initial position of the ball is at the entity position plus `off_x`, `off_y`
---@param uid integer
---@param off_x number
---@param off_y number
---@return integer
function attach_ball_and_chain(uid, off_x, off_y) end
---Spawn an entity of `entity_type` attached to some other entity `over_uid`, in offset `x`, `y`
---@param entity_type ENT_TYPE
---@param over_uid integer
---@param x number
---@param y number
---@return integer
function spawn_entity_over(entity_type, over_uid, x, y) end
---Short for [spawn_entity_over](#spawn_entity_over)
---@param entity_type ENT_TYPE
---@param over_uid integer
---@param x number
---@param y number
---@return integer
function spawn_over(entity_type, over_uid, x, y) end
---Check if the entity `uid` has some specific `item_uid` by uid in their inventory
---@param uid integer
---@param item_uid integer
---@return boolean
function entity_has_item_uid(uid, item_uid) end
---Check if the entity `uid` has some ENT_TYPE `entity_type` in their inventory, can also use table of entity_types
---@param uid integer
---@param entity_types ENT_TYPE[]
---@return boolean
function entity_has_item_type(uid, entity_types) end
---Check if the entity `uid` has some ENT_TYPE `entity_type` in their inventory, can also use table of entity_types
---@param uid integer
---@param entity_type ENT_TYPE
---@return boolean
function entity_has_item_type(uid, entity_type) end
---Gets uids of entities attached to given entity uid. Use `entity_type` and `mask` to filter, set them to 0 to return all attached entities.
---@param uid integer
---@param entity_types ENT_TYPE[]
---@param mask integer
---@return integer[]
function entity_get_items_by(uid, entity_types, mask) end
---Gets uids of entities attached to given entity uid. Use `entity_type` and `mask` to filter, set them to 0 to return all attached entities.
---@param uid integer
---@param entity_type ENT_TYPE
---@param mask integer
---@return integer[]
function entity_get_items_by(uid, entity_type, mask) end
---Kills an entity by uid. `destroy_corpse` defaults to `true`, if you are killing for example a caveman and want the corpse to stay make sure to pass `false`.
---@param uid integer
---@param destroy_corpse boolean?
---@return nil
function kill_entity(uid, destroy_corpse) end
---Pick up another entity by uid. Make sure you're not already holding something, or weird stuff will happen.
---@param who_uid integer
---@param what_uid integer
---@return nil
function pick_up(who_uid, what_uid) end
---Drop an entity by uid
---@param who_uid integer
---@param what_uid integer
---@return nil
function drop(who_uid, what_uid) end
---Unequips the currently worn backitem
---@param who_uid integer
---@return nil
function unequip_backitem(who_uid) end
---Returns the uid of the currently worn backitem, or -1 if wearing nothing
---@param who_uid integer
---@return integer
function worn_backitem(who_uid) end
---Apply changes made in [get_type](#get_type)() to entity instance by uid.
---@param uid integer
---@return nil
function apply_entity_db(uid) end
---Try to lock the exit at coordinates
---@param x number
---@param y number
---@return nil
function lock_door_at(x, y) end
---Try to unlock the exit at coordinates
---@param x number
---@param y number
---@return nil
function unlock_door_at(x, y) end
---Get the current global frame count since the game was started. You can use this to make some timers yourself, the engine runs at 60fps.
---@return integer
function get_frame() end
---Get the current timestamp in milliseconds since the Unix Epoch.
---@return nil
function get_ms() end
---Make `mount_uid` carry `rider_uid` on their back. Only use this with actual mounts and living things.
---@param mount_uid integer
---@param rider_uid integer
---@return nil
function carry(mount_uid, rider_uid) end
---Sets the amount of blood drops in the Kapala needed to trigger a health increase (default = 7).
---@param threshold integer
---@return nil
function set_kapala_blood_threshold(threshold) end
---Sets the hud icon for the Kapala (0-6 ; -1 for default behaviour).
---If you set a Kapala treshold greater than 7, make sure to set the hud icon in the range 0-6, or other icons will appear in the hud!
---@param icon_index integer
---@return nil
function set_kapala_hud_icon(icon_index) end
---Changes characteristics of (all) sparktraps: speed, rotation direction and distance from center
---Speed: expressed as the amount that should be added to the angle every frame (use a negative number to go in the other direction)
---Distance from center: if you go above 3.0 the game might crash because a spark may go out of bounds!
---@param angle_increment number
---@param distance number
---@return nil
function modify_sparktraps(angle_increment, distance) end
---Activate custom variables for speed and distance in the `ITEM_SPARK`
---note: because those the variables are custom and game does not initiate then, you need to do it yourself for each spark, recommending `set_post_entity_spawn`
---default game values are: speed = -0.015, distance = 3.0
---@param activate boolean
---@return nil
function activate_sparktraps_hack(activate) end
---Set layer to search for storage items on
---@param layer LAYER
---@return nil
function set_storage_layer(layer) end
---Sets the multiplication factor for blood droplets upon death (default/no Vlad's cape = 1, with Vlad's cape = 2)
---Due to changes in 1.23.x only the Vlad's cape value you provide will be used. The default is automatically Vlad's cape value - 1
---@param default_multiplier integer
---@param vladscape_multiplier integer
---@return nil
function set_blood_multiplication(default_multiplier, vladscape_multiplier) end
---Flip entity around by uid. All new entities face right by default.
---@param uid integer
---@return nil
function flip_entity(uid) end
---Sets the Y-level at which Olmec changes phases
---@param phase integer
---@param y number
---@return nil
function set_olmec_phase_y_level(phase, y) end
---Forces Olmec to stay on phase 0 (stomping)
---@param b boolean
---@return nil
function force_olmec_phase_0(b) end
---Determines when the ghost appears, either when the player is cursed or not
---@param normal integer
---@param cursed integer
---@return nil
function set_ghost_spawn_times(normal, cursed) end
---Determines whether the time ghost appears, including the showing of the ghost toast
---@param b boolean
---@return nil
function set_time_ghost_enabled(b) end
---Determines whether the time jelly appears in cosmic ocean
---@param b boolean
---@return nil
function set_time_jelly_enabled(b) end
---Enables or disables the journal
---@param b boolean
---@return nil
function set_journal_enabled(b) end
---Enables or disables the default position based camp camera bounds, to set them manually yourself
---@param b boolean
---@return nil
function set_camp_camera_bounds_enabled(b) end
---Sets which entities are affected by a bomb explosion. Default = MASK.PLAYER | MASK.MOUNT | MASK.MONSTER | MASK.ITEM | MASK.ACTIVEFLOOR | MASK.FLOOR
---@param mask integer
---@return nil
function set_explosion_mask(mask) end
---Sets the maximum length of a thrown rope (anchor segment not included). Unfortunately, setting this higher than default (6) creates visual glitches in the rope, even though it is fully functional.
---@param length integer
---@return nil
function set_max_rope_length(length) end
---Checks whether a coordinate is inside a room containing an active shop. This function checks whether the shopkeeper is still alive.
---@param x number
---@param y number
---@param layer LAYER
---@return boolean
function is_inside_active_shop_room(x, y, layer) end
---Checks whether a coordinate is inside a shop zone, the rectangle where the camera zooms in a bit. Does not check if the shop is still active!
---@param x number
---@param y number
---@param layer LAYER
---@return boolean
function is_inside_shop_zone(x, y, layer) end
---Returns how many of a specific entity type Waddler has stored
---@param entity_type ENT_TYPE
---@return integer
function waddler_count_entity(entity_type) end
---Store an entity type in Waddler's storage. Returns the slot number the item was stored in or -1 when storage is full and the item couldn't be stored.
---@param entity_type ENT_TYPE
---@return integer
function waddler_store_entity(entity_type) end
---Removes an entity type from Waddler's storage. Second param determines how many of the item to remove (default = remove all)
---@param entity_type ENT_TYPE
---@param amount_to_remove integer
---@return nil
function waddler_remove_entity(entity_type, amount_to_remove) end
---Gets the 16-bit meta-value associated with the entity type in the associated slot
---@param slot integer
---@return integer
function waddler_get_entity_meta(slot) end
---Sets the 16-bit meta-value associated with the entity type in the associated slot
---@param slot integer
---@param meta integer
---@return nil
function waddler_set_entity_meta(slot, meta) end
---Gets the entity type of the item in the provided slot
---@param slot integer
---@return integer
function waddler_entity_type_in_slot(slot) end
---Spawn a companion (hired hand, player character, eggplant child)
---@param companion_type ENT_TYPE
---@param x number
---@param y number
---@param layer LAYER
---@return integer
function spawn_companion(companion_type, x, y, layer) end
---Calculate the tile distance of two entities by uid
---@param uid_a integer
---@param uid_b integer
---@return number
function distance(uid_a, uid_b) end
---Basically gets the absolute coordinates of the area inside the unbreakable bedrock walls, from wall to wall. Every solid entity should be
---inside these boundaries. The order is: top left x, top left y, bottom right x, bottom right y
---@return number, number, number, number
function get_bounds() end
---Gets the current camera position in the level
---@return number, number
function get_camera_position() end
---Set a bit in a number. This doesn't actually change the bit in the entity you pass it, it just returns the new value you can use.
---@param flags Flags
---@param bit integer
---@return Flags
function set_flag(flags, bit) end
---Clears a bit in a number. This doesn't actually change the bit in the entity you pass it, it just returns the new value you can use.
---@param flags Flags
---@param bit integer
---@return Flags
function clr_flag(flags, bit) end
---Returns true if a bit is set in the flags
---@param flags Flags
---@param bit integer
---@return boolean
function test_flag(flags, bit) end
---Gets the resolution (width and height) of the screen
---@return integer, integer
function get_window_size() end
---Steal input from a Player or HH.
---@param uid integer
---@return nil
function steal_input(uid) end
---Return input
---@param uid integer
---@return nil
function return_input(uid) end
---Send input
---@param uid integer
---@param buttons INPUTS
---@return nil
function send_input(uid, buttons) end
---Read input
---@param uid integer
---@return INPUTS
function read_input(uid) end
---Read input that has been previously stolen with steal_input
---@param uid integer
---@return INPUTS
function read_stolen_input(uid) end
---Clears a callback that is specific to a screen.
---@param screen_id integer
---@param cb_id CallbackId
---@return nil
function clear_screen_callback(screen_id, cb_id) end
---Returns unique id for the callback to be used in [clear_screen_callback](#clear_screen_callback) or `nil` if screen_id is not valid.
---Sets a callback that is called right before the screen is drawn, return `true` to skip the default rendering.
---@param screen_id integer
---@param fun fun(): any
---@return CallbackId?
function set_pre_render_screen(screen_id, fun) end
---Returns unique id for the callback to be used in [clear_screen_callback](#clear_screen_callback) or `nil` if screen_id is not valid.
---Sets a callback that is called right after the screen is drawn.
---@param screen_id integer
---@param fun fun(): any
---@return CallbackId?
function set_post_render_screen(screen_id, fun) end
---Clears a callback that is specific to an entity.
---@param uid integer
---@param cb_id CallbackId
---@return nil
function clear_entity_callback(uid, cb_id) end
---Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
---`uid` has to be the uid of a `Movable` or else stuff will break.
---Sets a callback that is called right before the statemachine, return `true` to skip the statemachine update.
---Use this only when no other approach works, this call can be expensive if overused.
---Check [here](https://github.com/spelunky-fyi/overlunky/blob/main/docs/virtual-availability.md) to see whether you can use this callback on the entity type you intend to.
---@param uid integer
---@param fun fun(): any
---@return CallbackId?
function set_pre_statemachine(uid, fun) end
---Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
---`uid` has to be the uid of a `Movable` or else stuff will break.
---Sets a callback that is called right after the statemachine, so you can override any values the satemachine might have set (e.g. `animation_frame`).
---Use this only when no other approach works, this call can be expensive if overused.
---Check [here](https://github.com/spelunky-fyi/overlunky/blob/main/docs/virtual-availability.md) to see whether you can use this callback on the entity type you intend to.
---@param uid integer
---@param fun fun(): any
---@return CallbackId?
function set_post_statemachine(uid, fun) end
---Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
---Sets a callback that is called right when an entity is destroyed, e.g. as if by `Entity.destroy()` before the game applies any side effects.
---The callback signature is `nil on_destroy(Entity self)`
---Use this only when no other approach works, this call can be expensive if overused.
---@param uid integer
---@param fun fun(): any
---@return CallbackId?
function set_on_destroy(uid, fun) end
---Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
---Sets a callback that is called right when an entity is eradicated (killing monsters that leave a body behind will not trigger this), before the game applies any side effects.
---The callback signature is `nil on_kill(Entity self, Entity killer)`
---Use this only when no other approach works, this call can be expensive if overused.
---@param uid integer
---@param fun fun(): any
---@return CallbackId?
function set_on_kill(uid, fun) end
---Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
---Sets a callback that is called right when an player/hired hand is crushed/insta-gibbed, return `true` to skip the game's crush handling.
---The callback signature is `bool on_player_instagib(Entity self)`
---The game's instagib function will be forcibly executed (regardless of whatever you return in the callback) when the entity's health is zero.
---This is so that when the entity dies (from other causes), the death screen still gets shown.
---Use this only when no other approach works, this call can be expensive if overused.
---@param uid integer
---@param fun fun(): any
---@return CallbackId?
function set_on_player_instagib(uid, fun) end
---Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
---Sets a callback that is called right before an entity is damaged, return `true` to skip the game's damage handling.
---The callback signature is `bool on_damage(Entity self, Entity damage_dealer, int damage_amount, float velocity_x, float velocity_y, int stun_amount, int iframes)`
---Note that damage_dealer can be nil ! (long fall, ...)
---DO NOT CALL `self:damage()` in the callback !
---Use this only when no other approach works, this call can be expensive if overused.
---Check [here](https://github.com/spelunky-fyi/overlunky/blob/main/docs/virtual-availability.md) to see whether you can use this callback on the entity type you intend to.
---@param uid integer
---@param fun fun(): any
---@return CallbackId?
function set_on_damage(uid, fun) end
---Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
---Sets a callback that is called right when a container is opened via up+door, or weapon is shot.
---The callback signature is `nil on_open(Entity entity_self, Entity opener)`
---Use this only when no other approach works, this call can be expensive if overused.
---Check [here](https://github.com/spelunky-fyi/overlunky/blob/main/docs/virtual-availability.md) to see whether you can use this callback on the entity type you intend to.
---@param uid integer
---@param fun fun(): any
---@return CallbackId?
function set_on_open(uid, fun) end
---Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
---Sets a callback that is called right before the collision 1 event, return `true` to skip the game's collision handling.
---Use this only when no other approach works, this call can be expensive if overused.
---Check [here](https://github.com/spelunky-fyi/overlunky/blob/main/docs/virtual-availability.md) to see whether you can use this callback on the entity type you intend to.
---@param uid integer
---@param fun fun(): any
---@return CallbackId?
function set_pre_collision1(uid, fun) end
---Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
---Sets a callback that is called right before the collision 2 event, return `true` to skip the game's collision handling.
---Use this only when no other approach works, this call can be expensive if overused.
---Check [here](https://github.com/spelunky-fyi/overlunky/blob/main/docs/virtual-availability.md) to see whether you can use this callback on the entity type you intend to.
---@param uid integer
---@param fun fun(): any
---@return CallbackId?
function set_pre_collision2(uid, fun) end
---Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
---Sets a callback that is called right after the entity is rendered. The signature of the callback is `bool pre_render(render_ctx, entity)`
---where `render_ctx` is a `VanillaRenderContext`. Return `true` to skip the original rendering function and all later pre_render callbacks.
---Use this only when no other approach works, this call can be expensive if overused.
---@param uid integer
---@param fun fun(): any
---@return CallbackId?
function set_pre_render(uid, fun) end
---Returns unique id for the callback to be used in [clear_entity_callback](#clear_entity_callback) or `nil` if uid is not valid.
---Sets a callback that is called right after the entity is rendered. The signature of the callback is `nil post_render(render_ctx, entity)`
---where `render_ctx` is a `VanillaRenderContext`.
---Use this only when no other approach works, this call can be expensive if overused.
---@param uid integer
---@param fun fun(): any
---@return CallbackId?
function set_post_render(uid, fun) end
---Raise a signal and probably crash the game
---@return nil
function raise() end
---Convert the hash to stringid
---Check [strings00_hashed.str](game_data/strings00_hashed.str) for the hash values, or extract assets with modlunky and check those.
---@param hash integer
---@return STRINGID
function hash_to_stringid(hash) end
---Get string behind STRINGID (don't use stringid diretcly for vanilla string, use `hash_to_stringid` first)
---Will return the string of currently choosen language
---@param string_id STRINGID
---@return string
function get_string(string_id) end
---Change string at the given id (don't use stringid diretcly for vanilla string, use `hash_to_stringid` first)
---This edits custom string and in game strings but changing the language in settings will reset game strings
---@param id STRINGID
---@param str string
---@return nil
function change_string(id, str) end
---Add custom string, currently can only be used for names of shop items (Entitydb->description)
---Returns STRINGID of the new string
---@param str string
---@return STRINGID
function add_string(str) end
---Adds custom name to the item by uid used in the shops
---This is better alternative to `add_string` but instead of changing the name for entity type, it changes it for this particular entity
---@param uid integer
---@param name string
---@return nil
function add_custom_name(uid, name) end
---Clears the name set with `add_custom_name`
---@param uid integer
---@return nil
function clear_custom_name(uid) end
---Calls the enter door function, position doesn't matter, can also enter closed doors (like COG, EW) without unlocking them
---@param player_uid integer
---@param door_uid integer
---@return nil
function enter_door(player_uid, door_uid) end
---Change ENT_TYPE's spawned by `FLOOR_SUNCHALLENGE_GENERATOR`, by default there are 4:
---{MONS_WITCHDOCTOR, MONS_VAMPIRE, MONS_SORCERESS, MONS_NECROMANCER}
---Because of the game logic number of entity types has to be a power of 2: (1, 2, 4, 8, 16, 32), if you want say 30 types, you need to write two entities two times (they will have higher "spawn chance")
---Use empty table as argument to reset to the game default
---@param ent_types ENT_TYPE[]
---@return nil
function change_sunchallenge_spawns(ent_types) end
---Change ENT_TYPE's spawned in dice shops (Madame Tusk as well), by default there are 25:
---{ITEM_PICKUP_BOMBBAG, ITEM_PICKUP_BOMBBOX, ITEM_PICKUP_ROPEPILE, ITEM_PICKUP_COMPASS, ITEM_PICKUP_PASTE, ITEM_PICKUP_PARACHUTE, ITEM_PURCHASABLE_CAPE, ITEM_PICKUP_SPECTACLES, ITEM_PICKUP_CLIMBINGGLOVES, ITEM_PICKUP_PITCHERSMITT,
---ENT_TYPE_ITEM_PICKUP_SPIKESHOES, ENT_TYPE_ITEM_PICKUP_SPRINGSHOES, ITEM_MACHETE, ITEM_BOOMERANG, ITEM_CROSSBOW, ITEM_SHOTGUN, ITEM_FREEZERAY, ITEM_WEBGUN, ITEM_CAMERA, ITEM_MATTOCK, ITEM_PURCHASABLE_JETPACK, ITEM_PURCHASABLE_HOVERPACK,
---ITEM_TELEPORTER, ITEM_PURCHASABLE_TELEPORTER_BACKPACK, ITEM_PURCHASABLE_POWERPACK}
---Min 6, Max 255, if you want less then 6 you need to write some of them more then once (they will have higher "spawn chance")
---If you use this function in the level with diceshop in it, you have to update `item_ids` in the [ITEM_DICE_PRIZE_DISPENSER](#PrizeDispenser)
---Use empty table as argument to reset to the game default
---@param ent_types ENT_TYPE[]
---@return nil
function change_diceshop_prizes(ent_types) end
---Change ENT_TYPE's spawned when you damage the altar, by default there are 6:
---{MONS_BAT, MONS_BEE, MONS_SPIDER, MONS_JIANGSHI, MONS_FEMALE_JIANGSHI, MONS_VAMPIRE}
---Max 255 types
---Use empty table as argument to reset to the game default
---@param ent_types ENT_TYPE[]
---@return nil
function change_altar_damage_spawns(ent_types) end
---Change ENT_TYPE's spawned when Waddler dies, by default there are 3:
---{ITEM_PICKUP_COMPASS, ITEM_CHEST, ITEM_KEY}
---Max 255 types
---Use empty table as argument to reset to the game default
---@param ent_types ENT_TYPE[]
---@return nil
function change_waddler_drop(ent_types) end
---Poisons entity, to cure poison set `poison_tick_timer` to -1
---@param entity_uid integer
---@return nil
function poison_entity(entity_uid) end
---Change how much health the ankh gives you after death, with every beat (the heart beat effect) it will add `beat_add_health` to your health,
---`beat_add_health` has to be divisor of `health` and can't be 0, otherwise the function does nothing, Set `health` to 0 return to game default values,
---If you set `health` above the game max health it will be forced down to the game max
---@param max_health integer
---@param beat_add_health integer
---@return nil
function modify_ankh_health_gain(max_health, beat_add_health) end
---Adds entity as shop item, has to be movable (haven't tested many)
---@param item_uid integer
---@param shop_owner integer
---@return nil
function add_item_to_shop(item_uid, shop_owner) end
---Change the amount of frames after the damage from poison is applied
---@param frames integer
---@return nil
function change_poison_timer(frames) end
---Creates a new Illumination. Don't forget to continuously call `refresh_illumination`, otherwise your light emitter fades out! Check out the illumination.lua script for an example
---@param color Color
---@param size number
---@param x number
---@param y number
---@return Illumination
function create_illumination(color, size, x, y) end
---Creates a new Illumination. Don't forget to continuously call `refresh_illumination`, otherwise your light emitter fades out! Check out the illumination.lua script for an example
---@param color Color
---@param size number
---@param uid integer
---@return Illumination
function create_illumination(color, size, uid) end
---Refreshes an Illumination, keeps it from fading out
---@param illumination Illumination
---@return nil
function refresh_illumination(illumination) end
---Removes all liquid that is about to go out of bounds, which crashes the game.
---@return nil
function fix_liquid_out_of_bounds() end
---Gets the specified setting, values might need to be interpreted differently per setting
---@param setting GAME_SETTING
---@return integer?
function get_setting(setting) end
---Return the name of an unknown number in an enum table
---@param enum table
---@param value integer
---@return string
function enum_get_name(enum, value) end
---Spawn a Shopkeeper in the coordinates and make the room their shop. Returns the Shopkeeper uid. Also see spawn_roomowner.
---@param x number
---@param y number,
---@param layer LAYER
---@param room_template ROOM_TEMPLATE
---@return integer
function spawn_shopkeeper(x, y, layer, room_template) end
---Spawn a RoomOwner (or a few other like CavemanShopkeeper) in the coordinates and make them own the room, optionally changing the room template. Returns the RoomOwner uid.
---@param owner_type ENT_TYPE
---@param x number
---@param y number,
---@param layer LAYER
---@param room_template ROOM_TEMPLATE
---@return integer
function spawn_roomowner(owner_type, x, y, layer, room_template) end
---@return boolean
function toast_visible() end
---@return boolean
function speechbubble_visible() end
---@return nil
function cancel_toast() end
---@return nil
function cancel_speechbubble() end
---Seed the game prng.
---@param seed integer
---@return nil
function seed_prng(seed) end
---Same as `Player.get_name`
---@param type_id ENT_TYPE
---@return string
function get_character_name(type_id) end
---Same as `Player.get_short_name`
---@param type_id ENT_TYPE
---@return string
function get_character_short_name(type_id) end
---Same as `Player.get_heart_color`
---@param type_id ENT_TYPE
---@return Color
function get_character_heart_color(type_id) end
---Same as `Player.is_female`
---@param type_id ENT_TYPE
---@return boolean
function is_character_female(type_id) end
---Same as `Player.set_heart_color`
---@param type_id ENT_TYPE
---@param color Color
---@return nil
function set_character_heart_color(type_id, color) end
---Get the [ParticleDB](#ParticleDB) details of the specified ID
---@param id integer
---@return ParticleDB
function get_particle_type(id) end
---Generate particles of the specified type around the specified entity uid (use e.g. `local emitter = generate_world_particles(PARTICLEEMITTER.PETTING_PET, players[1].uid)`). You can then decouple the emitter from the entity with `emitter.entity_uid = -1` and freely move it around. See the `particles.lua` example script for more details.
---@param particle_emitter_id integer
---@param uid integer
---@return ParticleEmitterInfo
function generate_world_particles(particle_emitter_id, uid) end
---Generate particles of the specified type at a certain screen coordinate (use e.g. `local emitter = generate_screen_particles(PARTICLEEMITTER.CHARSELECTOR_TORCHFLAME_FLAMES, 0.0, 0.0)`). See the `particles.lua` example script for more details.
---@param particle_emitter_id integer
---@param x number
---@param y number
---@return ParticleEmitterInfo
function generate_screen_particles(particle_emitter_id, x, y) end
---Advances the state of the screen particle emitter (simulates the next positions, ... of all the particles in the emitter). Only used with screen particle emitters. See the `particles.lua` example script for more details.
---@param particle_emitter ParticleEmitterInfo
---@return nil
function advance_screen_particles(particle_emitter) end
---Renders the particles to the screen. Only used with screen particle emitters. See the `particles.lua` example script for more details.
---@param particle_emitter ParticleEmitterInfo
---@return nil
function render_screen_particles(particle_emitter) end
---Extinguish a particle emitter (use the return value of `generate_world_particles` or `generate_screen_particles` as the parameter in this function)
---@param particle_emitter ParticleEmitterInfo
---@return nil
function extinguish_particles(particle_emitter) end
---Level file to load. Probably doesn't do much in custom themes, especially if you're forcing them in PRE_LOAD_LEVEL_FILES.
---Theme index. Probably shouldn't collide with the vanilla ones. Purpose unknown.
---Base THEME to load enabled functions from, when no other theme is specified.
---Add TEXTUREs here to override different dynamic textures.
---Set a callback to be called before this theme function.
---Set a callback to be called after this theme function, to fix some changes it did for example.
---Create a new theme with an id and base theme, overriding defaults. Check [theme functions that are default enabled here](https://github.com/spelunky-fyi/overlunky/blob/main/src/game_api/script/usertypes/level_lua.cpp).
---Create a new theme with defaults.
---Create a new theme with base dwelling and id 100.
---Add TEXTUREs to `textures` to override different dynamic textures easily.
---Default function in spawn definitions to check whether a spawn is valid or not
---@param x number
---@param y number
---@param layer integer
---@return boolean
function default_spawn_is_valid(x, y, layer) end
---Add a callback for a specific tile code that is called before the game handles the tile code.
---The callback signature is `bool pre_tile_code(x, y, layer, room_template)`
---Return true in order to stop the game or scripts loaded after this script from handling this tile code.
---For example, when returning true in this callback set for `"floor"` then no floor will spawn in the game (unless you spawn it yourself)
---@param cb fun(): any
---@param tile_code string
---@return CallbackId
function set_pre_tile_code_callback(cb, tile_code) end
---Add a callback for a specific tile code that is called after the game handles the tile code.
---The callback signature is `nil post_tile_code(x, y, layer, room_template)`
---Use this to affect what the game or other scripts spawned in this position.
---This is received even if a previous pre-tile-code-callback has returned true
---@param cb fun(): any
---@param tile_code string
---@return CallbackId
function set_post_tile_code_callback(cb, tile_code) end
---Define a new tile code, to make this tile code do anything you have to use either `set_pre_tile_code_callback` or `set_post_tile_code_callback`.
---If a user disables your script but still uses your level mod nothing will be spawned in place of your tile code.
---@param tile_code string
---@return TILE_CODE
function define_tile_code(tile_code) end
---Gets a short tile code based on definition, returns `nil` if it can't be found
---@param short_tile_code_def ShortTileCodeDef
---@return integer?
function get_short_tile_code(short_tile_code_def) end
---Gets the definition of a short tile code (if available), will vary depending on which file is loaded
---@param short_tile_code SHORT_TILE_CODE
---@return ShortTileCodeDef?
function get_short_tile_code_definition(short_tile_code) end
---Define a new procedural spawn, the function `nil do_spawn(x, y, layer)` contains your code to spawn the thing, whatever it is.
---The function `bool is_valid(x, y, layer)` determines whether the spawn is legal in the given position and layer.
---Use for example when you can spawn only on the ceiling, under water or inside a shop.
---Set `is_valid` to `nil` in order to use the default rule (aka. on top of floor and not obstructed).
---If a user disables your script but still uses your level mod nothing will be spawned in place of your procedural spawn.
---@param procedural_spawn string
---@param do_spawn fun(): any
---@param is_valid fun(): any
---@return PROCEDURAL_CHANCE
function define_procedural_spawn(procedural_spawn, do_spawn, is_valid) end
---Define a new extra spawn, these are semi-guaranteed level gen spawns with a fixed upper bound.
---The function `nil do_spawn(x, y, layer)` contains your code to spawn the thing, whatever it is.
---The function `bool is_valid(x, y, layer)` determines whether the spawn is legal in the given position and layer.
---Use for example when you can spawn only on the ceiling, under water or inside a shop.
---Set `is_valid` to `nil` in order to use the default rule (aka. on top of floor and not obstructed).
---To change the number of spawns use `PostRoomGenerationContext::set_num_extra_spawns` during `ON.POST_ROOM_GENERATION`
---No name is attached to the extra spawn since it is not modified from level files, instead every call to this function will return a new uniqe id.
---@param do_spawn fun(): any
---@param is_valid fun(): any
---@param num_spawns_frontlayer integer
---@param num_spawns_backlayer integer
---@return integer
function define_extra_spawn(do_spawn, is_valid, num_spawns_frontlayer, num_spawns_backlayer) end
---Use to query whether any of the requested spawns could not be made, usually because there were not enough valid spaces in the level.
---Returns missing spawns in the front layer and missing spawns in the back layer in that order.
---The value only makes sense after level generation is complete, aka after `ON.POST_LEVEL_GENERATION` has run.
---@param extra_spawn_chance_id integer
---@return integer, integer
function get_missing_extra_spawns(extra_spawn_chance_id) end
---Transform a position to a room index to be used in `get_room_template` and `PostRoomGenerationContext.set_room_template`
---@param x number
---@param y number
---@return integer, integer
function get_room_index(x, y) end
---Transform a room index into the top left corner position in the room
---@param x integer
---@param y integer
---@return number, number
function get_room_pos(x, y) end
---Get the room template given a certain index, returns `nil` if coordinates are out of bounds
---@param x integer
---@param y integer
---@param layer LAYER
---@return integer?
function get_room_template(x, y, layer) end
---Get whether a room is flipped at the given index, returns `false` if coordinates are out of bounds
---@param x integer
---@param y integer
---@return boolean
function is_room_flipped(x, y) end
---For debugging only, get the name of a room template, returns `'invalid'` if room template is not defined
---@param room_template integer
---@return string
function get_room_template_name(room_template) end
---Define a new room remplate to use with `set_room_template`
---@param room_template string
---@param type ROOM_TEMPLATE_TYPE
---@return integer
function define_room_template(room_template, type) end
---Set the size of room template in tiles, the template must be of type `ROOM_TEMPLATE_TYPE.MACHINE_ROOM`.
---@param room_template integer
---@param width integer
---@param height integer
---@return boolean
function set_room_template_size(room_template, width, height) end
---Get the inverse chance of a procedural spawn for the current level.
---A return value of 0 does not mean the chance is infinite, it means the chance is zero.
---@param chance_id PROCEDURAL_CHANCE
---@return integer
function get_procedural_spawn_chance(chance_id) end
---Gets the sub theme of the current cosmic ocean level, returns `COSUBTHEME.NONE` if the current level is not a CO level.
---@return integer
function get_co_subtheme() end
---Forces the theme of the next cosmic ocean level(s) (use e.g. `force_co_subtheme(COSUBTHEME.JUNGLE)`. Use `COSUBTHEME.RESET` to reset to default random behaviour)
---@param subtheme integer
---@return nil
function force_co_subtheme(subtheme) end
---Gets the value for the specified config
---@param config LEVEL_CONFIG
---@return integer
function get_level_config(config) end
---Grow vines from `GROWABLE_VINE` and `VINE_TREE_TOP` entities in a level, `area` default is whole level, `destroy_broken` default is false
---@param l LAYER
---@param max_lengh integer
---@return nil
function grow_vines(l, max_lengh) end
---Grow vines from `GROWABLE_VINE` and `VINE_TREE_TOP` entities in a level, `area` default is whole level, `destroy_broken` default is false
---@param l LAYER
---@param max_lengh integer
---@param area AABB
---@param destroy_broken boolean
---@return nil
function grow_vines(l, max_lengh, area, destroy_broken) end
---Grow pole from `GROWABLE_CLIMBING_POLE` entities in a level, `area` default is whole level, `destroy_broken` default is false
---@param l LAYER
---@param max_lengh integer
---@return nil
function grow_poles(l, max_lengh) end
---Grow pole from `GROWABLE_CLIMBING_POLE` entities in a level, `area` default is whole level, `destroy_broken` default is false
---@param l LAYER
---@param max_lengh integer
---@param area AABB
---@param destroy_broken boolean
---@return nil
function grow_poles(l, max_lengh, area, destroy_broken) end
---Grow chains from `CHAIN_CEILING` and chain with blocks on it from `CHAINANDBLOCKS_CEILING`, it starts looking for the ceilings from the top left corner of a level
---To limit it use the parameters, so if you set x to 10, it will only grow chains from ceilings with x < 10, with y = 10 it's ceilings that have y > (level bound top - 10)
---@return boolean
function grow_chainandblocks() end
---Grow chains from `CHAIN_CEILING` and chain with blocks on it from `CHAINANDBLOCKS_CEILING`, it starts looking for the ceilings from the top left corner of a level
---To limit it use the parameters, so if you set x to 10, it will only grow chains from ceilings with x < 10, with y = 10 it's ceilings that have y > (level bound top - 10)
---@param x integer
---@param y integer
---@return boolean
function grow_chainandblocks(x, y) end
---Customizable ThemeInfo with ability to override certain theming functions from different themes or write custom functions. Check ThemeInfo for some notes on the vanilla theme functions. Warning: We WILL change these function names, especially the unknown ones, when you figure out what they do.
---Overrides for different CustomTheme functions. Warning: We WILL change these, especially the unknown ones, and even the known ones if they turn out wrong in testing.
---Force a theme in PRE_LOAD_LEVEL_FILES, POST_ROOM_GENERATION or PRE_LEVEL_GENERATION to change different aspects of the levelgen. You can pass a CustomTheme, ThemeInfo or THEME.
---@return nil
function force_custom_theme() end
---Force current subtheme used in the CO theme. You can pass a CustomTheme, ThemeInfo or THEME. Not to be confused with force_co_subtheme.
---@return nil
function force_custom_subtheme() end
---Loads a sound from disk relative to this script, ownership might be shared with other code that loads the same file. Returns nil if file can't be found
---@param path string
---@return CustomSound?
function create_sound(path) end
---Gets an existing sound, either if a file at the same path was already loaded or if it is already loaded by the game
---@param path_or_vanilla_sound string
---@return CustomSound?
function get_sound(path_or_vanilla_sound) end
---Returns unique id for the callback to be used in [clear_vanilla_sound_callback](#clear_vanilla_sound_callback).
---Sets a callback for a vanilla sound which lets you hook creation or playing events of that sound
---Callbacks are executed on another thread, so avoid touching any global state, only the local Lua state is protected
---If you set such a callback and then play the same sound yourself you have to wait until receiving the STARTED event before changing any
---properties on the sound. Otherwise you may cause a deadlock. The callback signature is `nil on_vanilla_sound(PlayingSound sound)`
---@param name VANILLA_SOUND
---@param types VANILLA_SOUND_CALLBACK_TYPE
---@param cb fun(): any
---@return CallbackId
function set_vanilla_sound_callback(name, types, cb) end
---Clears a previously set callback
---@param id CallbackId
---@return nil
function clear_vanilla_sound_callback(id) end
---Converts a color to int to be used in drawing functions. Use values from `0..255`.
---@param r integer
---@param g integer
---@param b integer
---@param a integer
---@return uColor
function rgba(r, g, b, a) end
---Calculate the bounding box of text, so you can center it etc. Returns `width`, `height` in screen distance.
---@param size number
---@param text string
---@return number, number
function draw_text_size(size, text) end
---Create image from file. Returns a tuple containing id, width and height.
---@param path string
---@return IMAGE, integer, integer
function create_image(path) end
---Current mouse cursor position in screen coordinates.
---@return number, number
function mouse_position() end
---Returns: [ImGuiIO](#ImGuiIO) for raw keyboard, mouse and xinput gamepad stuff. This is kinda bare and might change.
---- Note: The clicked/pressed actions only make sense in `ON.GUIFRAME`.
---- Note: Lua starts indexing at 1, you need `keysdown[string.byte('A') + 1]` to find the A key.
---- Note: Overlunky/etc will eat all keys it is currently configured to use, your script will only get leftovers.
---- Note: `gamepad` is basically [XINPUT_GAMEPAD](https://docs.microsoft.com/en-us/windows/win32/api/xinput/ns-xinput-xinput_gamepad) but variables are renamed and values are normalized to -1.0..1.0 range.
---@return ImGuiIO
function get_io() end
---@param texture_id TEXTURE?
---@param layer LAYER
---@return nil
function set_lut(texture_id, layer) end
---@param layer LAYER
---@return nil
function reset_lut(layer) end
---Alters the drop chance for the provided monster-item combination (use e.g. set_drop_chance(DROPCHANCE.MOLE_MATTOCK, 10) for a 1 in 10 chance)
---Use `-1` as dropchance_id to reset all to default
---@param dropchance_id integer
---@param new_drop_chance integer
---@return nil
function set_drop_chance(dropchance_id, new_drop_chance) end
---Changes a particular drop, e.g. what Van Horsing throws at you (use e.g. replace_drop(DROP.VAN_HORSING_DIAMOND, ENT_TYPE.ITEM_PLASMACANNON))
---Use `0` as type to reset this drop to default, use `-1` as drop_id to reset all to default
---@param drop_id integer
---@param new_drop_entity_type ENT_TYPE
---@return nil
function replace_drop(drop_id, new_drop_entity_type) end
---Gets a `TextureDefinition` for equivalent to the one used to define the texture with `id`
---@param texture_id TEXTURE
---@return TextureDefinition
function get_texture_definition(texture_id) end
---Defines a new texture that can be used in Entity::set_texture
---If a texture with the same definition already exists the texture will be reloaded from disk.
---@param texture_data TextureDefinition
---@return TEXTURE
function define_texture(texture_data) end
---Gets a texture with the same definition as the given, if none exists returns `nil`
---@param texture_data TextureDefinition
---@return TEXTURE?
function get_texture(texture_data) end
---Reloads a texture from disk, use this only as a development tool for example in the console
---Note that `define_texture` will also reload the texture if it already exists
---@param texture_path string
---@return nil
function reload_texture(texture_path) end
---Gets the hitbox of an entity, use `extrude` to make the hitbox bigger/smaller in all directions and `offset` to offset the hitbox in a given direction
---@param uid integer
---@param extrude number?
---@param offsetx number?
---@param offsety number?
---@return AABB
function get_hitbox(uid, extrude, offsetx, offsety) end
---Same as `get_hitbox` but based on `get_render_position`
---@param uid integer
---@param extrude number?
---@param offsetx number?
---@param offsety number?
---@return AABB
function get_render_hitbox(uid, extrude, offsetx, offsety) end
---Convert an `AABB` to a screen `AABB` that can be directly passed to draw functions
---@param box AABB
---@return AABB
function screen_aabb(box) end
---Start an UDP server on specified address and run callback when data arrives. Return a string from the callback to reply. Requires unsafe mode.
---@param host string
---@param port in_port_t
---@param cb fun(): any
---@return UdpServer
function udp_listen(host, port, cb) end
---Send data to specified UDP address. Requires unsafe mode.
---@param host string
---@param port in_port_t
---@param msg string
---@return nil
function udp_send(host, port, msg) end

--## Types

---@class SaveContext
    ---@field save fun(self, data: string): boolean

---@class LoadContext
    ---@field load fun(self, ): string

---@class ArenaConfigArenas
    ---@field dwelling_1 boolean
    ---@field dwelling_2 boolean
    ---@field dwelling_3 boolean
    ---@field dwelling_4 boolean
    ---@field dwelling_5 boolean
    ---@field jungle_1 boolean
    ---@field jungle_2 boolean
    ---@field jungle_3 boolean
    ---@field jungle_4 boolean
    ---@field jungle_5 boolean
    ---@field volcana_1 boolean
    ---@field volcana_2 boolean
    ---@field volcana_3 boolean
    ---@field volcana_4 boolean
    ---@field volcana_5 boolean
    ---@field tidepool_1 boolean
    ---@field tidepool_2 boolean
    ---@field tidepool_3 boolean
    ---@field tidepool_4 boolean
    ---@field tidepool_5 boolean
    ---@field temple_1 boolean
    ---@field temple_2 boolean
    ---@field temple_3 boolean
    ---@field temple_4 boolean
    ---@field temple_5 boolean
    ---@field icecaves_1 boolean
    ---@field icecaves_2 boolean
    ---@field icecaves_3 boolean
    ---@field icecaves_4 boolean
    ---@field icecaves_5 boolean
    ---@field neobabylon_1 boolean
    ---@field neobabylon_2 boolean
    ---@field neobabylon_3 boolean
    ---@field neobabylon_4 boolean
    ---@field neobabylon_5 boolean
    ---@field sunkencity_1 boolean
    ---@field sunkencity_2 boolean
    ---@field sunkencity_3 boolean
    ---@field sunkencity_4 boolean
    ---@field sunkencity_5 boolean

---@class ArenaConfigItems
    ---@field rock boolean
    ---@field pot boolean
    ---@field bombbag boolean
    ---@field bombbox boolean
    ---@field ropepile boolean
    ---@field pickup_12bag boolean
    ---@field pickup_24bag boolean
    ---@field cooked_turkey boolean
    ---@field royal_jelly boolean
    ---@field torch boolean
    ---@field boomerang boolean
    ---@field machete boolean
    ---@field mattock boolean
    ---@field crossbow boolean
    ---@field webgun boolean
    ---@field freezeray boolean
    ---@field shotgun boolean
    ---@field camera boolean
    ---@field plasma_cannon boolean
    ---@field wooden_shield boolean
    ---@field metal_shield boolean
    ---@field teleporter boolean
    ---@field mine boolean
    ---@field snaptrap boolean
    ---@field paste boolean
    ---@field climbing_gloves boolean
    ---@field pitchers_mitt boolean
    ---@field spike_shoes boolean
    ---@field spring_shoes boolean
    ---@field parachute boolean
    ---@field cape boolean
    ---@field vlads_cape boolean
    ---@field jetpack boolean
    ---@field hoverpack boolean
    ---@field telepack boolean
    ---@field powerpack boolean
    ---@field excalibur boolean
    ---@field scepter boolean
    ---@field kapala boolean
    ---@field true_crown boolean

---@class ArenaConfigEquippedItems
    ---@field paste boolean
    ---@field climbing_gloves boolean
    ---@field pitchers_mitt boolean
    ---@field spike_shoes boolean
    ---@field spring_shoes boolean
    ---@field parachute boolean
    ---@field kapala boolean
    ---@field scepter boolean

---@class ArenaState
    ---@field current_arena integer
    ---@field player_teams integer[]
    ---@field format integer
    ---@field ruleset integer
    ---@field player_lives integer[]
    ---@field player_totalwins integer[]
    ---@field player_won boolean[]
    ---@field timer integer
    ---@field timer_ending integer
    ---@field wins integer
    ---@field lives integer
    ---@field player_idolheld_countdown integer[]
    ---@field health integer
    ---@field bombs integer
    ---@field ropes integer
    ---@field stun_time integer
    ---@field mount integer
    ---@field arena_select integer
    ---@field arenas ArenaConfigArenas
    ---@field dark_level_chance integer
    ---@field crate_frequency integer
    ---@field items_enabled ArenaConfigItems
    ---@field items_in_crate ArenaConfigItems
    ---@field held_item integer
    ---@field equipped_backitem integer
    ---@field equipped_items ArenaConfigEquippedItems
    ---@field whip_damage integer
    ---@field final_ghost boolean
    ---@field breath_cooldown integer
    ---@field punish_ball boolean

---@class SelectPlayerSlot
    ---@field activated boolean
    ---@field character ENT_TYPE
    ---@field texture integer

---@class Items
    ---@field player_count integer
    ---@field saved_pets_count integer
    ---@field saved_pets ENT_TYPE[]
    ---@field is_pet_cursed boolean[]
    ---@field is_pet_poisoned boolean[]
    ---@field player_inventory Inventory[]
    ---@field player_select SelectPlayerSlot[]

---@class LiquidPhysicsEngine
    ---@field pause boolean
    ---@field gravity number
    ---@field cohesion number
    ---@field elasticity number
    ---@field size number
    ---@field weight number
    ---@field count integer

---@class LiquidPhysicsParams
    ---@field gravity number
    ---@field cohesion number
    ---@field elasticity number

---@class LiquidPool
    ---@field default LiquidPhysicsParams
    ---@field engine LiquidPhysicsEngine

---@class LiquidPhysics
    ---@field pools LiquidPool[] @size: 5

---@class StateMemory
    ---@field screen_last integer
    ---@field screen integer
    ---@field screen_next integer
    ---@field ingame integer
    ---@field playing integer
    ---@field pause integer
    ---@field width integer
    ---@field height integer
    ---@field kali_favor integer
    ---@field kali_status integer
    ---@field kali_altars_destroyed integer
    ---@field kali_gifts integer
    ---@field seed integer
    ---@field time_total integer
    ---@field world integer
    ---@field world_next integer
    ---@field world_start integer
    ---@field level integer
    ---@field level_next integer
    ---@field level_start integer
    ---@field theme integer
    ---@field theme_next integer
    ---@field theme_start integer
    ---@field force_current_theme fun(self, t: integer): nil
    ---@field shoppie_aggro integer
    ---@field shoppie_aggro_next integer
    ---@field merchant_aggro integer
    ---@field kills_npc integer
    ---@field level_count integer
    ---@field damage_taken integer
    ---@field journal_flags integer
    ---@field time_last_level integer
    ---@field time_level integer
    ---@field level_flags integer
    ---@field loading integer
    ---@field quest_flags integer
    ---@field presence_flags integer
    ---@field fadevalue number
    ---@field fadeout integer
    ---@field fadein integer
    ---@field loading_black_screen_timer integer
    ---@field saved_dogs integer
    ---@field saved_cats integer
    ---@field saved_hamsters integer
    ---@field win_state integer
    ---@field illumination Illumination
    ---@field money_last_levels integer
    ---@field money_shop_total integer
    ---@field player_inputs PlayerInputs
    ---@field quests QuestsInfo
    ---@field camera Camera
    ---@field special_visibility_flags integer
    ---@field cause_of_death integer
    ---@field cause_of_death_entity_type ENT_TYPE
    ---@field toast_timer integer
    ---@field speechbubble_timer integer
    ---@field speechbubble_owner integer
    ---@field level_gen LevelGenSystem
    ---@field correct_ushabti integer
    ---@field items Items
    ---@field camera_layer integer
    ---@field screen_team_select ScreenTeamSelect
    ---@field screen_character_select ScreenCharacterSelect
    ---@field screen_transition ScreenTransition
    ---@field screen_death ScreenDeath
    ---@field screen_win ScreenWin
    ---@field screen_credits ScreenCredits
    ---@field screen_scores ScreenScores
    ---@field screen_constellation ScreenConstellation
    ---@field screen_recap ScreenRecap
    ---@field screen_arena_stages_select ScreenArenaStagesSelect
    ---@field screen_arena_intro ScreenArenaIntro
    ---@field screen_arena_level ScreenArenaLevel
    ---@field screen_arena_score ScreenArenaScore
    ---@field screen_arena_menu ScreenArenaMenu
    ---@field screen_arena_items ScreenArenaItems
    ---@field get_correct_ushabti fun(self, ): integer
    ---@field set_correct_ushabti fun(self, animation_frame: integer): nil
    ---@field arena ArenaState
    ---@field speedrun_character ENT_TYPE
    ---@field speedrun_activation_trigger integer
    ---@field end_spaceship_character ENT_TYPE
    ---@field world2_coffin_spawned boolean
    ---@field world4_coffin_spawned boolean
    ---@field world6_coffin_spawned boolean
    ---@field first_damage_cause ENT_TYPE
    ---@field first_damage_world integer
    ---@field first_damage_level integer
    ---@field time_speedrun integer
    ---@field coffin_contents ENT_TYPE
    ---@field screen_change_counter integer
    ---@field time_startup integer
    ---@field storage_uid integer
    ---@field waddler_storage ENT_TYPE[]
    ---@field waddler_metadata integer[]
    ---@field logic LogicList
    ---@field liquid LiquidPhysics

---@class LightParams
    ---@field red number
    ---@field green number
    ---@field blue number
    ---@field size number

---@class Illumination
    ---@field lights LightParams[]
    ---@field light1 LightParams
    ---@field light2 LightParams
    ---@field light3 LightParams
    ---@field light4 LightParams
    ---@field brightness number
    ---@field brightness_multiplier number
    ---@field light_pos_x number
    ---@field light_pos_y number
    ---@field offset_x number
    ---@field offset_y number
    ---@field distortion number
    ---@field entity_uid integer
    ---@field flags integer
    ---@field type_flags integer
    ---@field enabled boolean
    ---@field layer integer

---@class Camera
    ---@field bounds_left number
    ---@field bounds_right number
    ---@field bounds_bottom number
    ---@field bounds_top number
    ---@field adjusted_focus_x number
    ---@field adjusted_focus_y number
    ---@field focus_offset_x number
    ---@field focus_offset_y number
    ---@field focus_x number
    ---@field focus_y number
    ---@field vertical_pan number
    ---@field shake_countdown_start integer
    ---@field shake_countdown integer
    ---@field shake_amplitude number
    ---@field shake_multiplier_x number
    ---@field shake_multiplier_y number
    ---@field uniform_shake boolean
    ---@field focused_entity_uid integer
    ---@field inertia number

---@class Online
    ---@field online_players OnlinePlayer[]
    ---@field local_player OnlinePlayerShort
    ---@field lobby OnlineLobby

---@class OnlinePlayer
    ---@field ready_state integer
    ---@field character integer
    ---@field player_name string

---@class OnlineLobby
    ---@field code integer
    ---@field get_code fun(self, ): string

---@class LogicList
    ---@field olmec_cutscene LogicOlmecCutscene
    ---@field tiamat_cutscene LogicTiamatCutscene
    ---@field diceshop LogicDiceShop

---@class LogicOlmecCutscene : Logic
    ---@field olmec Entity
    ---@field player Entity
    ---@field cinematic_anchor Entity
    ---@field timer integer

---@class LogicTiamatCutscene : Logic
    ---@field tiamat Entity
    ---@field player Entity
    ---@field cinematic_anchor Entity
    ---@field timer integer

---@class LogicDiceShop : Logic
    ---@field bet_machine integer
    ---@field die1 integer
    ---@field die2 integer
    ---@field die_1_value integer
    ---@field die_2_value integer
    ---@field prize_dispenser integer
    ---@field prize integer
    ---@field forcefield integer
    ---@field bet_active boolean
    ---@field forcefield_deactivated boolean
    ---@field boss_angry boolean
    ---@field result_announcement_timer integer
    ---@field won_prizes_count integer
    ---@field balance integer

---@class GameManager
    ---@field game_props GameProps
    ---@field screen_logo ScreenLogo
    ---@field screen_intro ScreenIntro
    ---@field screen_prologue ScreenPrologue
    ---@field screen_title ScreenTitle
    ---@field screen_menu ScreenMenu
    ---@field screen_options ScreenOptions
    ---@field screen_player_profile ScreenPlayerProfile
    ---@field screen_leaderboards ScreenLeaderboards
    ---@field screen_seed_input ScreenSeedInput
    ---@field screen_camp ScreenCamp
    ---@field screen_level ScreenLevel
    ---@field screen_online_loading ScreenOnlineLoading
    ---@field screen_online_lobby ScreenOnlineLobby
    ---@field pause_ui PauseUI
    ---@field journal_ui JournalUI
    ---@field save_related SaveRelated

---@class SaveRelated
    ---@field journal_popup_ui JournalPopupUI

---@class JournalPopupUI
    ---@field wiggling_page_icon TextureRenderingInfo
    ---@field black_background TextureRenderingInfo
    ---@field button_icon TextureRenderingInfo
    ---@field wiggling_page_angle number
    ---@field chapter_to_show integer
    ---@field entry_to_show integer
    ---@field timer integer
    ---@field slide_position number

---@class GameProps
    ---@field buttons integer
    ---@field game_has_focus boolean

---@class PRNG
    ---@field seed fun(self, seed: integer): nil
    ---@field random_float fun(self, type: PRNG_CLASS): number
    ---@field random_chance fun(self, inverse_chance: integer, type: PRNG_CLASS): boolean
    ---@field random_index fun(self, i: integer, type: PRNG_CLASS): integer?
    ---@field random_int fun(self, min: integer, max: integer, type: PRNG_CLASS): integer?
    ---@field random PRNG_random
    ---@field get_pair any @&PRNG::get_pair
    ---@field set_pair any @&PRNG::set_pair

---@class PRNG_random
---@param min integer
---@param max integer
---@overload fun(self): number
---@overload fun(self, i: integer): integer?
local function PRNG_random(self, min, max) end

---@class Color
    ---@field r number
    ---@field g number
    ---@field b number
    ---@field a number
    ---@field get_rgba fun(self, ): integer, integer, integer, integer
    ---@field set_rgba fun(self, red: integer, green: integer, blue: integer, alpha: integer): Color
    ---@field get_ucolor fun(self, ): uColor
    ---@field set_ucolor fun(self, color: uColor): Color

---@class Animation
    ---@field first_tile integer
    ---@field num_tiles integer
    ---@field interval integer
    ---@field repeat_mode REPEAT_TYPE

---@class EntityDB
    ---@field id ENT_TYPE
    ---@field search_flags integer
    ---@field width number
    ---@field height number
    ---@field offsetx number
    ---@field offsety number
    ---@field hitboxx number
    ---@field hitboxy number
    ---@field draw_depth integer
    ---@field friction number
    ---@field elasticity number
    ---@field weight number
    ---@field acceleration number
    ---@field max_speed number
    ---@field sprint_factor number
    ---@field jump number
    ---@field glow_red number
    ---@field glow_green number
    ---@field glow_blue number
    ---@field glow_alpha number
    ---@field damage integer
    ---@field life integer
    ---@field blood_content integer
    ---@field texture integer
    ---@field animations table<integer, Animation>
    ---@field properties_flags integer
    ---@field default_flags integer
    ---@field default_more_flags integer
    ---@field leaves_corpse_behind boolean
    ---@field sound_killed_by_player integer
    ---@field sound_killed_by_other integer
    ---@field description STRINGID
    ---@field tilex integer
    ---@field tiley integer

---@class RenderInfo
    ---@field x number
    ---@field y number
    ---@field shader integer
    ---@field source Quad
    ---@field destination Quad
    ---@field tilew number
    ---@field tileh number
    ---@field facing_left boolean
    ---@field render_inactive boolean

---@class Entity
    ---@field type EntityDB
    ---@field overlay Entity
    ---@field flags integer
    ---@field more_flags integer
    ---@field uid integer
    ---@field animation_frame integer
    ---@field draw_depth integer
    ---@field x number
    ---@field y number
    ---@field layer integer
    ---@field width number
    ---@field height number
    ---@field special_offsetx number
    ---@field special_offsety number
    ---@field tile_width number
    ---@field tile_height number
    ---@field angle number
    ---@field color Color
    ---@field hitboxx number
    ---@field hitboxy number
    ---@field shape SHAPE
    ---@field hitbox_enabled boolean
    ---@field offsetx number
    ---@field offsety number
    ---@field rendering_info RenderInfo
    ---@field topmost fun(self, ): Entity
    ---@field topmost_mount fun(self, ): Entity
    ---@field overlaps_with Entity_overlaps_with
    ---@field get_texture fun(self, ): TEXTURE
    ---@field set_texture fun(self, texture_id: TEXTURE): boolean
    ---@field set_draw_depth fun(self, draw_depth: integer): nil
    ---@field liberate_from_shop any @&Entity::liberate_from_shop
    ---@field get_held_entity fun(self, ): Entity
    ---@field set_layer fun(self, layer: LAYER): nil
    ---@field remove fun(self, ): nil
    ---@field respawn fun(self, layer: LAYER): nil
    ---@field kill fun(self, destroy_corpse: boolean, responsible: Entity): nil
    ---@field destroy fun(self, ): nil
    ---@field activate fun(self, activator: Entity): nil
    ---@field perform_teleport fun(self, delta_x: integer, delta_y: integer): nil
    ---@field trigger_action fun(self, user: Entity): boolean
    ---@field get_metadata any @&Entity::get_metadata
    ---@field apply_metadata fun(self, metadata: integer): nil
    ---@field set_invisible fun(self, value: boolean): nil
    ---@field get_items fun(self, ): span<integer>
    ---@field is_in_liquid fun(self, ): boolean

---@class Entity_overlaps_with
---@param other Entity
---@overload fun(self, hitbox: AABB): boolean
---@overload fun(self, rect_left: number, rect_bottom: number, rect_right: number, rect_top: number): boolean
local function Entity_overlaps_with(self, other) end

---@class Movable : Entity
    ---@field movex number
    ---@field movey number
    ---@field buttons BUTTON
    ---@field buttons_previous BUTTON
    ---@field stand_counter integer
    ---@field jump_height_multiplier number
    ---@field owner_uid integer
    ---@field last_owner_uid integer
    ---@field idle_counter integer
    ---@field standing_on_uid integer
    ---@field velocityx number
    ---@field velocityy number
    ---@field holding_uid integer
    ---@field state integer
    ---@field last_state integer
    ---@field move_state integer
    ---@field health integer
    ---@field stun_timer integer
    ---@field stun_state integer
    ---@field lock_input_timer integer
    ---@field some_state integer
    ---@field wet_effect_timer integer
    ---@field poison_tick_timer integer
    ---@field airtime integer
    ---@field falling_timer integer
    ---@field is_poisoned fun(self, ): boolean
    ---@field poison fun(self, frames: integer): nil
    ---@field dark_shadow_timer integer
    ---@field onfire_effect_timer integer
    ---@field exit_invincibility_timer integer
    ---@field invincibility_frames_timer integer
    ---@field frozen_timer integer
    ---@field is_button_pressed fun(self, button: BUTTON): boolean
    ---@field is_button_held fun(self, button: BUTTON): boolean
    ---@field is_button_released fun(self, button: BUTTON): boolean
    ---@field price integer
    ---@field stun fun(self, framecount: integer): nil
    ---@field freeze fun(self, framecount: integer): nil
    ---@field light_on_fire fun(self, time: integer): nil
    ---@field set_cursed fun(self, b: boolean): nil
    ---@field drop fun(self, entity_to_drop: Entity): nil
    ---@field pick_up fun(self, entity_to_pick_up: Entity): nil
    ---@field can_jump fun(self, ): boolean
    ---@field standing_on fun(self, ): Entity
    ---@field add_money fun(self, money: integer): nil
    ---@field is_on_fire fun(self, ): boolean
    ---@field damage fun(self, damage_dealer_uid: integer, damage_amount: integer, stun_time: integer, velocity_x: number, velocity_y: number, iframes: integer): nil
    ---@field get_all_behaviors fun(self, ): integer[]
    ---@field set_behavior fun(self, behavior_id: integer): boolean
    ---@field get_behavior fun(self, ): integer

---@class PowerupCapable : Movable
    ---@field remove_powerup fun(self, powerup_type: ENT_TYPE): nil
    ---@field give_powerup fun(self, powerup_type: ENT_TYPE): nil
    ---@field has_powerup fun(self, powerup_type: ENT_TYPE): boolean
    ---@field get_powerups fun(self, ): ENT_TYPE[]
    ---@field unequip_backitem fun(self, ): nil
    ---@field worn_backitem fun(self, ): integer

---@class Inventory
    ---@field money integer
    ---@field bombs integer
    ---@field ropes integer
    ---@field player_slot integer
    ---@field poison_tick_timer integer
    ---@field cursed boolean
    ---@field elixir_buff boolean
    ---@field health integer
    ---@field kapala_blood_amount integer
    ---@field time_of_death integer
    ---@field held_item ENT_TYPE
    ---@field held_item_metadata integer
    ---@field mount_type ENT_TYPE
    ---@field mount_metadata integer
    ---@field kills_level integer
    ---@field kills_total integer
    ---@field collected_money_total integer
    ---@field collected_money_count integer
    ---@field collected_money ENT_TYPE[]
    ---@field collected_money_values integer[]
    ---@field killed_enemies ENT_TYPE[]
    ---@field companion_count integer
    ---@field companions ENT_TYPE[]
    ---@field companion_held_items ENT_TYPE[]
    ---@field companion_held_item_metadatas integer[]
    ---@field companion_trust integer[]
    ---@field companion_health integer[]
    ---@field companion_poison_tick_timers integer[]
    ---@field is_companion_cursed boolean[]
    ---@field acquired_powerups ENT_TYPE[]

---@class Ai
    ---@field target Entity
    ---@field target_uid integer
    ---@field timer integer
    ---@field state integer
    ---@field trust integer
    ---@field whipped integer

---@class Player : PowerupCapable
    ---@field inventory Inventory
    ---@field emitted_light Illumination
    ---@field linked_companion_parent integer
    ---@field linked_companion_child integer
    ---@field ai Ai
    ---@field set_jetpack_fuel fun(self, fuel: integer): nil
    ---@field kapala_blood_amount fun(self, ): integer
    ---@field get_name fun(self, ): string
    ---@field get_short_name fun(self, ): string
    ---@field get_heart_color fun(self, ): Color
    ---@field is_female fun(self, ): boolean
    ---@field set_heart_color fun(self, hcolor: Color): nil
    ---@field let_go fun(self, ): nil

---@class Floor : Entity
    ---@field deco_top integer
    ---@field deco_bottom integer
    ---@field deco_left integer
    ---@field deco_right integer
    ---@field fix_border_tile_animation fun(self, ): nil
    ---@field fix_decorations fun(self, fix_also_neighbors: boolean, fix_styled_floor: boolean): nil
    ---@field add_decoration fun(self, side: FLOOR_SIDE): nil
    ---@field remove_decoration fun(self, side: FLOOR_SIDE): nil
    ---@field decorate_internal fun(self, ): nil
    ---@field get_floor_type fun(self, ): ENT_TYPE

---@class Door : Floor
    ---@field counter integer
    ---@field fx_button Entity
    ---@field enter fun(self, who: Entity): integer
    ---@field is_unlocked fun(self, ): boolean
    ---@field unlock fun(self, unlock: boolean): nil

---@class ExitDoor : Door
    ---@field entered boolean
    ---@field special_door boolean
    ---@field level integer
    ---@field timer integer
    ---@field world integer
    ---@field theme integer

---@class DecoratedDoor : ExitDoor
    ---@field special_bg Entity

---@class LockedDoor : Door
    ---@field unlocked boolean

---@class CityOfGoldDoor : DecoratedDoor
    ---@field unlocked boolean

---@class MainExit : ExitDoor

---@class EggShipDoor : Door
    ---@field timer integer

---@class EggShipDoorS : EggShipDoor
    ---@field entered boolean

---@class Arrowtrap : Floor
    ---@field arrow_shot boolean
    ---@field rearm fun(self, ): nil
    ---@field trigger fun(self, who_uid: integer): nil

---@class TotemTrap : Floor
    ---@field spawn_entity_type ENT_TYPE
    ---@field first_sound_id integer
    ---@field trigger fun(self, who_uid: integer, left: boolean): nil

---@class LaserTrap : Floor
    ---@field emitted_light Illumination
    ---@field reset_timer integer
    ---@field phase_2 boolean
    ---@field trigger fun(self, who_uid: integer): nil

---@class SparkTrap : Floor
    ---@field emitted_light Illumination
    ---@field spark_uid integer

---@class Altar : Floor
    ---@field timer integer

---@class SpikeballTrap : Floor
    ---@field chain Entity
    ---@field end_piece Entity
    ---@field state integer
    ---@field timer integer

---@class TransferFloor : Floor
    ---@field transferred_entities table<integer, integer>

---@class ConveyorBelt : TransferFloor
    ---@field timer integer

---@class Pipe : Floor
    ---@field direction_type integer
    ---@field end_pipe boolean

---@class Generator : Floor
    ---@field spawned_uid integer
    ---@field set_timer integer
    ---@field timer integer
    ---@field start_counter integer
    ---@field on_off boolean

---@class SlidingWallCeiling : Floor
    ---@field attached_piece Entity
    ---@field active_floor_part_uid integer
    ---@field state integer

---@class QuickSand : Floor

---@class BigSpearTrap : Floor
    ---@field spear_uid integer
    ---@field left_part boolean
    ---@field trigger fun(self, who_uid: integer, left: boolean): nil

---@class StickyTrap : Floor
    ---@field attached_piece_uid integer
    ---@field ball_uid integer
    ---@field state integer
    ---@field timer integer

---@class MotherStatue : Floor
    ---@field players_standing boolean[]
    ---@field player1_standing boolean
    ---@field player2_standing boolean
    ---@field player3_standing boolean
    ---@field player4_standing boolean
    ---@field players_health_received boolean[]
    ---@field player1_health_received boolean
    ---@field player2_health_received boolean
    ---@field player3_health_received boolean
    ---@field player4_health_received boolean
    ---@field players_health_timer integer[]
    ---@field player1_health_timer integer
    ---@field player2_health_timer integer
    ---@field player3_health_timer integer
    ---@field player4_health_timer integer
    ---@field eggplantchild_timer integer
    ---@field eggplantchild_detected boolean

---@class TeleportingBorder : Floor
    ---@field direction integer

---@class ForceField : Floor
    ---@field first_item_beam Entity
    ---@field fx Entity
    ---@field emitted_light Illumination
    ---@field is_on boolean
    ---@field activate_laserbeam fun(self, turn_on: boolean): nil

---@class TimedForceField : ForceField
    ---@field timer integer
    ---@field pause boolean

---@class HorizontalForceField : Floor
    ---@field first_item_beam Entity
    ---@field fx Entity
    ---@field timer integer
    ---@field is_on boolean

---@class TentacleBottom : Floor
    ---@field attached_piece_uid integer
    ---@field tentacle_uid integer
    ---@field state integer

---@class PoleDeco : Floor
    ---@field deco_up integer
    ---@field deco_down integer

---@class JungleSpearTrap : Floor
    ---@field trigger fun(self, who_uid: integer, direction: integer): nil

---@class Crushtrap : Movable
    ---@field dirx number
    ---@field diry number
    ---@field timer integer
    ---@field bounce_back_timer integer

---@class Olmec : Movable
    ---@field target_uid integer
    ---@field attack_phase integer
    ---@field attack_timer integer
    ---@field ai_timer integer
    ---@field move_direction integer
    ---@field jump_timer integer
    ---@field phase1_amount_of_bomb_salvos integer
    ---@field unknown_attack_state integer
    ---@field broken_floaters fun(self, ): integer

---@class WoodenlogTrap : Movable
    ---@field ceiling_1_uid integer
    ---@field ceiling_2_uid integer
    ---@field falling_speed number

---@class Boulder : Movable
    ---@field is_rolling integer

---@class PushBlock : Movable
    ---@field dust_particle ParticleEmitterInfo
    ---@field dest_pos_x number

---@class BoneBlock : Movable

---@class ChainedPushBlock : PushBlock
    ---@field is_chained boolean

---@class LightArrowPlatform : Movable
    ---@field emitted_light Illumination

---@class FallingPlatform : Movable
    ---@field timer integer
    ---@field shaking_factor number
    ---@field y_pos number

---@class UnchainedSpikeBall : Movable
    ---@field bounce boolean

---@class Drill : Movable
    ---@field top_chain_piece Entity
    ---@field trigger fun(self, ): nil

---@class ThinIce : Movable
    ---@field strength integer

---@class Elevator : Movable
    ---@field emitted_light Illumination
    ---@field timer integer
    ---@field moving_up boolean

---@class ClamBase : Movable
    ---@field treasure_type ENT_TYPE
    ---@field treasure_uid integer
    ---@field treasure_x_pos number
    ---@field treasure_y_pos number
    ---@field top_part_uid integer

---@class RegenBlock : Movable
    ---@field on_breaking boolean

---@class TimedPowderkeg : PushBlock
    ---@field timer integer

---@class Mount : PowerupCapable
    ---@field carry fun(self, rider: Movable): nil
    ---@field tame fun(self, value: boolean): nil
    ---@field rider_uid integer
    ---@field can_doublejump boolean
    ---@field tamed boolean
    ---@field walk_pause_timer integer
    ---@field taming_timer integer
    ---@field used_double_jump fun(self, ): boolean
    ---@field remove_rider fun(self, ): nil

---@class Rockdog : Mount
    ---@field attack_cooldown integer

---@class Axolotl : Mount
    ---@field attack_cooldown integer
    ---@field can_teleport boolean

---@class Mech : Mount
    ---@field gun_cooldown integer
    ---@field walking boolean
    ---@field breaking_wall boolean

---@class Qilin : Mount
    ---@field attack_cooldown integer

---@class Monster : PowerupCapable
    ---@field chased_target_uid integer
    ---@field target_selection_timer integer

---@class RoomOwner : Monster
    ---@field room_index integer
    ---@field climb_y_direction number
    ---@field ai_state integer
    ---@field patrol_timer integer
    ---@field lose_interest_timer integer
    ---@field countdown_timer integer
    ---@field is_patrolling boolean
    ---@field aggro_trigger boolean
    ---@field was_hurt boolean

---@class WalkingMonster : Monster
    ---@field chatting_to_uid integer
    ---@field walk_pause_timer integer
    ---@field cooldown_timer integer

---@class NPC : Monster
    ---@field climb_direction number
    ---@field target_in_sight_timer integer
    ---@field ai_state integer
    ---@field aggro boolean

---@class Ghost : Monster
    ---@field split_timer integer
    ---@field velocity_multiplier number
    ---@field ghost_behaviour GHOST_BEHAVIOR
    ---@field emitted_light Illumination
    ---@field linked_ghost Entity

---@class Bat : Monster
    ---@field spawn_x number
    ---@field spawn_y number

---@class Jiangshi : Monster
    ---@field wait_timer integer
    ---@field jump_counter integer
    ---@field on_ceiling boolean

---@class Monkey : Monster
    ---@field jump_timer integer
    ---@field on_vine boolean

---@class GoldMonkey : Monster
    ---@field jump_timer integer
    ---@field poop_timer integer
    ---@field poop_count integer

---@class Mole : Monster
    ---@field burrowing_particle ParticleEmitterInfo
    ---@field burrow_dir_x number
    ---@field burrow_dir_y number
    ---@field burrowing_in_uid integer
    ---@field counter_burrowing integer
    ---@field counter_nonburrowing integer
    ---@field countdown_for_appearing integer
    ---@field digging_state integer

---@class Spider : Monster
    ---@field ceiling_pos_x number
    ---@field ceiling_pos_y number
    ---@field jump_timer integer
    ---@field trigger_distance number

---@class HangSpider : Monster
    ---@field dangle_jump_timer integer
    ---@field ceiling_pos_x number
    ---@field ceiling_pos_y number

---@class Shopkeeper : RoomOwner
    ---@field name integer
    ---@field shotgun_attack_delay integer
    ---@field has_key boolean
    ---@field shop_owner boolean

---@class Yang : RoomOwner
    ---@field turkeys_in_den integer[]
    ---@field first_message_shown boolean
    ---@field quest_incomplete boolean
    ---@field special_message_shown boolean

---@class Tun : RoomOwner
    ---@field arrows_left integer
    ---@field reload_timer integer
    ---@field challenge_fee_paid boolean
    ---@field congrats_challenge boolean
    ---@field murdered boolean
    ---@field shop_entered boolean
    ---@field tiamat_encounter boolean

---@class Pet : Monster
    ---@field fx_button Entity
    ---@field petting_by_uid integer
    ---@field yell_counter integer
    ---@field func_timer integer
    ---@field active_state integer

---@class Caveman : WalkingMonster
    ---@field wake_up_timer integer
    ---@field can_pick_up_timer integer
    ---@field aggro_timer integer

---@class CavemanShopkeeper : WalkingMonster
    ---@field tripping boolean
    ---@field shop_entered boolean

---@class HornedLizard : Monster
    ---@field eaten_uid integer
    ---@field walk_pause_timer integer
    ---@field attack_cooldown_timer integer
    ---@field blood_squirt_timer integer
    ---@field particle ParticleEmitterInfo

---@class Mosquito : Monster
    ---@field direction_x number
    ---@field direction_y number
    ---@field stuck_rel_pos_x number
    ---@field stuck_rel_pos_y number
    ---@field timer integer

---@class Mantrap : Monster
    ---@field walk_pause_timer integer
    ---@field eaten_uid integer

---@class Skeleton : Monster
    ---@field explosion_timer integer

---@class Scarab : Monster
    ---@field emitted_light Illumination
    ---@field timer integer

---@class Imp : Monster
    ---@field carrying_uid integer
    ---@field patrol_y_level number

---@class Lavamander : Monster
    ---@field emitted_light Illumination
    ---@field shoot_lava_timer integer
    ---@field jump_pause_timer integer
    ---@field lava_detection_timer integer
    ---@field is_hot boolean
    ---@field player_detect_state integer

---@class Firebug : Monster
    ---@field fire_timer integer
    ---@field going_up boolean
    ---@field detached_from_chain boolean

---@class FirebugUnchained : Monster
    ---@field max_flight_height number
    ---@field ai_timer integer
    ---@field walking_timer integer

---@class Robot : WalkingMonster
    ---@field emitted_light_explosion Illumination

---@class Quillback : WalkingMonster
    ---@field particle ParticleEmitterInfo
    ---@field seen_player boolean

---@class Leprechaun : WalkingMonster
    ---@field hump_timer integer
    ---@field target_in_sight_timer integer
    ---@field gold integer
    ---@field timer_after_humping integer

---@class Crocman : WalkingMonster
    ---@field teleport_cooldown integer

---@class Mummy : Monster
    ---@field walk_pause_timer integer

---@class VanHorsing : NPC
    ---@field show_text boolean

---@class WitchDoctor : WalkingMonster
    ---@field skull_regen_timer integer

---@class WitchDoctorSkull : Monster
    ---@field witch_doctor_uid integer
    ---@field emitted_light Illumination
    ---@field rotation_angle number

---@class ForestSister : NPC
    ---@field walk_pause_timer integer

---@class Vampire : Monster
    ---@field jump_trigger_distance_x number
    ---@field jump_trigger_distance_y number
    ---@field sleep_pos_x number
    ---@field sleep_pos_y number
    ---@field walk_pause_timer integer

---@class Vlad : Vampire
    ---@field teleport_timer integer
    ---@field aggro boolean

---@class Waddler : RoomOwner
    ---@field player_detected boolean
    ---@field on_the_ground boolean
    ---@field air_timer integer

---@class Octopus : WalkingMonster

---@class Bodyguard : NPC
    ---@field position_state integer
    ---@field message_shown boolean

---@class Fish : Monster
    ---@field change_direction_timer integer

---@class GiantFish : Monster
    ---@field change_direction_timer integer
    ---@field lose_interest_timer integer

---@class Crabman : Monster
    ---@field walk_pause_timer integer
    ---@field invincibility_timer integer
    ---@field poison_attack_timer integer
    ---@field attacking_claw_uid integer
    ---@field at_maximum_attack boolean

---@class Kingu : Monster
    ---@field climb_direction_x number
    ---@field climb_direction_y number
    ---@field climb_pause_timer integer
    ---@field shell_invincibility_timer integer
    ---@field monster_spawn_timer integer
    ---@field initial_shell_health integer
    ---@field player_seen_by_kingu boolean

---@class Anubis : Monster
    ---@field spawn_x number
    ---@field spawn_y number
    ---@field attack_proximity_y number
    ---@field attack_proximity_x number
    ---@field ai_timer integer
    ---@field next_attack_timer integer
    ---@field psychic_orbs_counter integer
    ---@field awake boolean

---@class Cobra : Monster
    ---@field spit_timer integer

---@class CatMummy : Monster
    ---@field ai_state integer
    ---@field attack_timer integer

---@class Sorceress : WalkingMonster
    ---@field inbetween_attack_timer integer
    ---@field in_air_timer number
    ---@field halo_emitted_light Illumination
    ---@field fx_entity Entity
    ---@field hover_timer integer

---@class MagmaMan : Monster
    ---@field emitted_light Illumination
    ---@field particle ParticleEmitterInfo
    ---@field jump_timer integer
    ---@field alive_timer integer

---@class Bee : Monster
    ---@field can_rest boolean
    ---@field fly_hang_timer integer
    ---@field targeting_timer integer
    ---@field wobble_x number
    ---@field wobble_y number

---@class Ammit : Monster
    ---@field walk_pause_timer integer
    ---@field particle ParticleEmitterInfo

---@class ApepPart : Monster
    ---@field y_pos number
    ---@field sine_angle number
    ---@field sync_timer integer

---@class ApepHead : ApepPart
    ---@field distance_traveled number
    ---@field tail_uid integer
    ---@field fx_mouthpiece1_uid integer
    ---@field fx_mouthpiece2_uid integer

---@class OsirisHead : Monster
    ---@field right_hand_uid integer
    ---@field left_hand_uid integer
    ---@field moving_left boolean
    ---@field targeting_timer integer
    ---@field invincibility_timer integer

---@class OsirisHand : Monster
    ---@field attack_cooldown_timer integer

---@class Alien : Monster
    ---@field jump_timer integer

---@class UFO : Monster
    ---@field patrol_distance integer
    ---@field attack_cooldown_timer integer
    ---@field is_falling boolean

---@class Lahamu : Monster
    ---@field attack_cooldown_timer integer

---@class YetiQueen : Monster
    ---@field walk_pause_timer integer

---@class YetiKing : Monster
    ---@field walk_pause_timer integer
    ---@field emitted_light Illumination
    ---@field particle_fog ParticleEmitterInfo
    ---@field particle_dust ParticleEmitterInfo
    ---@field particle_sparkles ParticleEmitterInfo

---@class Lamassu : Monster
    ---@field attack_effect_entity Entity
    ---@field particle ParticleEmitterInfo
    ---@field emitted_light Illumination
    ---@field walk_pause_timer integer
    ---@field flight_timer integer
    ---@field attack_timer integer
    ---@field attack_angle number

---@class Olmite : WalkingMonster
    ---@field armor_on boolean
    ---@field in_stack boolean
    ---@field in_stack2 boolean
    ---@field on_top_uid integer
    ---@field y_offset number
    ---@field attack_cooldown_timer integer

---@class Tiamat : Monster
    ---@field fx_tiamat_head integer
    ---@field fx_tiamat_arm_right1 integer
    ---@field fx_tiamat_arm_right2 integer
    ---@field frown_timer integer
    ---@field damage_timer integer
    ---@field attack_timer integer
    ---@field tail_angle number
    ---@field tail_radian number
    ---@field tail_move_speed number
    ---@field right_arm_angle number

---@class GiantFrog : Monster
    ---@field door_front_layer Entity
    ---@field door_back_layer Entity
    ---@field platform Entity
    ---@field attack_timer integer
    ---@field frogs_ejected_in_cycle integer
    ---@field invincibility_timer integer
    ---@field mouth_close_timer integer
    ---@field mouth_open_trigger boolean

---@class Frog : Monster
    ---@field grub_being_eaten_uid integer
    ---@field jump_timer integer
    ---@field pause boolean

---@class FireFrog : Frog

---@class Grub : Monster
    ---@field rotation_delta number
    ---@field drop boolean
    ---@field looking_for_new_direction_timer integer
    ---@field walk_pause_timer integer
    ---@field turn_into_fly_timer integer
    ---@field particle ParticleEmitterInfo

---@class Tadpole : Monster
    ---@field acceleration_timer integer
    ---@field player_spotted boolean

---@class GiantFly : Monster
    ---@field head_entity Entity
    ---@field particle ParticleEmitterInfo
    ---@field sine_amplitude number
    ---@field sine_frequency number
    ---@field delta_y_angle number
    ---@field sine_counter integer

---@class Ghist : Monster
    ---@field body_uid integer
    ---@field idle_timer integer
    ---@field transparency integer
    ---@field fadeout integer

---@class JumpDog : Monster
    ---@field walk_pause_timer integer
    ---@field squish_timer integer

---@class EggplantMinister : Monster
    ---@field walk_pause_timer integer
    ---@field squish_timer integer

---@class Yama : Monster
    ---@field message_shown boolean

---@class Hundun : Monster
    ---@field applied_hor_velocity number
    ---@field applied_ver_velocity number
    ---@field birdhead_entity_uid integer
    ---@field snakehead_entity_uid integer
    ---@field y_level number
    ---@field bounce_timer integer
    ---@field fireball_timer integer
    ---@field birdhead_defeated boolean
    ---@field snakehead_defeated boolean
    ---@field hundun_flags integer

---@class HundunHead : Monster
    ---@field attack_position_x number
    ---@field attack_position_y number
    ---@field egg_crack_effect_uid integer
    ---@field targeted_player_uid integer
    ---@field looking_for_target_timer integer
    ---@field invincibility_timer integer

---@class MegaJellyfish : Monster
    ---@field flipper1 Entity
    ---@field flipper2 Entity
    ---@field orb_uid integer
    ---@field tail_bg_uid integer
    ---@field applied_velocity number
    ---@field wagging_tail_counter number
    ---@field flipper_distance integer
    ---@field velocity_application_timer integer

---@class Scorpion : Monster
    ---@field walk_pause_timer integer
    ---@field jump_cooldown_timer integer

---@class Hermitcrab : Monster
    ---@field carried_entity_type ENT_TYPE
    ---@field carried_entity_uid integer
    ---@field walk_spit_timer integer
    ---@field is_active boolean
    ---@field is_inactive boolean
    ---@field spawn_new_carried_item boolean

---@class Necromancer : WalkingMonster
    ---@field red_skeleton_spawn_x number
    ---@field red_skeleton_spawn_y number
    ---@field resurrection_uid integer
    ---@field resurrection_timer integer

---@class ProtoShopkeeper : Monster
    ---@field movement_state integer
    ---@field walk_pause_explode_timer integer
    ---@field walking_speed integer

---@class Beg : NPC
    ---@field walk_pause_timer integer
    ---@field disappear_timer integer

---@class Terra : Monster
    ---@field fx_button Entity
    ---@field x_pos number
    ---@field abuse_speechbubble_timer integer

---@class Critter : Monster
    ---@field last_picked_up_by_uid integer
    ---@field holding_state integer

---@class CritterBeetle : Critter
    ---@field pause boolean

---@class CritterCrab : Critter
    ---@field walk_pause_timer integer
    ---@field walking_left boolean

---@class CritterButterfly : Critter
    ---@field change_direction_timer integer
    ---@field vertical_flight_direction integer

---@class CritterLocust : Critter
    ---@field jump_timer integer

---@class CritterSnail : Critter
    ---@field x_direction number
    ---@field y_direction number
    ---@field pos_x number
    ---@field pos_y number
    ---@field rotation_center_x number
    ---@field rotation_center_y number
    ---@field rotation_angle number
    ---@field rotation_speed number

---@class CritterFish : Critter
    ---@field swim_pause_timer integer
    ---@field player_in_proximity boolean

---@class CritterPenguin : Critter
    ---@field walk_pause_timer integer
    ---@field jump_timer integer

---@class CritterFirefly : Critter
    ---@field sine_amplitude number
    ---@field sine_frequency number
    ---@field sine_angle number
    ---@field change_direction_timer integer
    ---@field sit_timer integer
    ---@field sit_cooldown_timer integer

---@class CritterDrone : Critter
    ---@field emitted_light Illumination
    ---@field applied_hor_momentum number
    ---@field applied_ver_momentum number
    ---@field move_timer integer

---@class CritterSlime : Critter
    ---@field x_direction number
    ---@field y_direction number
    ---@field pos_x number
    ---@field pos_y number
    ---@field rotation_center_x number
    ---@field rotation_center_y number
    ---@field rotation_angle number
    ---@field rotation_speed number
    ---@field walk_pause_timer integer

---@class Bomb : Movable
    ---@field scale_hor number
    ---@field scale_ver number
    ---@field is_big_bomb boolean

---@class Backpack : Movable
    ---@field explosion_trigger boolean
    ---@field explosion_timer integer

---@class Projectile : Movable

---@class Purchasable : Movable

---@class DummyPurchasableEntity : Purchasable

---@class Bow : Purchasable

---@class Present : Purchasable
    ---@field inside ENT_TYPE

---@class Jetpack : Backpack
    ---@field flame_on boolean
    ---@field fuel integer

---@class TeleporterBackpack : Backpack
    ---@field teleport_number integer

---@class Hoverpack : Backpack
    ---@field is_on boolean

---@class Cape : Backpack
    ---@field floating_down boolean

---@class VladsCape : Cape
    ---@field can_double_jump boolean

---@class Mattock : Purchasable
    ---@field remaining integer

---@class Gun : Purchasable
    ---@field cooldown integer
    ---@field shots integer
    ---@field shots2 integer
    ---@field in_chamber integer

---@class Flame : Movable
    ---@field emitted_light Illumination

---@class FlameSize : Flame
    ---@field flame_size number

---@class ClimbableRope : Movable
    ---@field segment_nr_inverse integer
    ---@field burn_timer integer
    ---@field above_part Entity
    ---@field below_part Entity
    ---@field segment_nr integer

---@class Idol : Movable
    ---@field trap_triggered boolean
    ---@field touch integer
    ---@field spawn_x number
    ---@field spawn_y number

---@class Spear : Movable
    ---@field sound_id integer

---@class JungleSpearCosmetic : Movable
    ---@field move_x number
    ---@field move_y number

---@class WebShot : Projectile
    ---@field shot boolean

---@class HangStrand : Movable
    ---@field start_pos_y number

---@class HangAnchor : Movable
    ---@field spider_uid integer

---@class Arrow : Purchasable
    ---@field flame_uid integer
    ---@field is_on_fire boolean
    ---@field is_poisoned boolean
    ---@field shot_from_trap boolean
    ---@field poison_arrow fun(self, poisoned: boolean): nil
    ---@field light_up fun(self, lit: boolean): nil

---@class LightArrow : Arrow
    ---@field emitted_light Illumination

---@class LightShot : Projectile
    ---@field emitted_light Illumination

---@class LightEmitter : Movable
    ---@field emitted_light Illumination

---@class ScepterShot : LightEmitter
    ---@field speed number
    ---@field idle_timer integer

---@class SpecialShot : LightEmitter
    ---@field target_x number
    ---@field target_y number

---@class SoundShot : LightShot

---@class Spark : Flame
    ---@field particle ParticleEmitterInfo
    ---@field fx_entity Entity
    ---@field rotation_center_x number
    ---@field rotation_center_y number
    ---@field rotation_angle number
    ---@field size number
    ---@field size_multiply number
    ---@field next_size number
    ---@field size_change_timer integer
    ---@field speed number
    ---@field distance number

---@class TiamatShot : LightEmitter

---@class Fireball : SoundShot
    ---@field particle ParticleEmitterInfo

---@class Leaf : Movable
    ---@field fade_away_counter number
    ---@field swing_direction integer
    ---@field fade_away_trigger boolean

---@class AcidBubble : Movable
    ---@field speed_x number
    ---@field speed_y number
    ---@field float_counter number

---@class Claw : Movable
    ---@field crabman_uid integer
    ---@field spawn_x number
    ---@field spawn_y number

---@class StretchChain : Movable
    ---@field at_end_of_chain_uid integer
    ---@field dot_offset number
    ---@field position_in_chain integer
    ---@field inverse_doubled_position_in_chain integer
    ---@field is_dot_hidden boolean

---@class Chest : Movable
    ---@field leprechaun boolean
    ---@field bomb boolean

---@class Treasure : Movable
    ---@field cashed boolean

---@class HundunChest : Treasure
    ---@field timer integer

---@class Boombox : Movable
    ---@field fx_button Entity
    ---@field music_note1 ParticleEmitterInfo
    ---@field music_note2 ParticleEmitterInfo
    ---@field spawn_y number
    ---@field station integer
    ---@field station_change_delay integer
    ---@field jump_timer integer
    ---@field jump_state integer

---@class TV : Movable
    ---@field fx_button Entity
    ---@field emitted_light Illumination
    ---@field station integer

---@class Telescope : Movable
    ---@field fx_button Entity
    ---@field camera_anchor Entity
    ---@field looked_through_by_uid integer

---@class Torch : Movable
    ---@field flame_uid integer
    ---@field is_lit boolean
    ---@field light_up fun(self, lit: boolean): nil
    ---@field get_flame_type fun(self, ): ENT_TYPE

---@class WallTorch : Torch
    ---@field dropped_gold boolean

---@class TorchFlame : Flame
    ---@field smoke_particle ParticleEmitterInfo
    ---@field flame_particle ParticleEmitterInfo
    ---@field warp_particle ParticleEmitterInfo
    ---@field flame_size number

---@class LampFlame : Flame
    ---@field flame_particle ParticleEmitterInfo

---@class Bullet : Projectile

---@class TimedShot : LightShot
    ---@field timer integer

---@class CloneGunShot : LightShot
    ---@field timer integer
    ---@field spawn_y number

---@class PunishBall : Movable
    ---@field attached_to_uid integer
    ---@field x_pos number
    ---@field y_pos number

---@class Chain : Movable
    ---@field attached_to_uid integer
    ---@field timer integer

---@class Container : Movable
    ---@field inside ENT_TYPE

---@class Coffin : Movable
    ---@field inside ENT_TYPE
    ---@field timer integer
    ---@field player_respawn boolean

---@class Fly : Movable
    ---@field timer integer

---@class OlmecCannon : Movable
    ---@field timer integer
    ---@field bombs_left integer

---@class Landmine : LightEmitter
    ---@field timer integer

---@class UdjatSocket : Movable
    ---@field fx_button Entity

---@class Ushabti : Movable
    ---@field wiggle_timer integer
    ---@field shine_timer integer

---@class Honey : Movable
    ---@field wiggle_timer integer

---@class GiantClamTop : Movable
    ---@field close_timer integer
    ---@field open_timer integer

---@class PlayerGhost : LightEmitter
    ---@field sparkles_particle ParticleEmitterInfo
    ---@field player_inputs PlayerInputs
    ---@field inventory Inventory
    ---@field body_uid integer
    ---@field shake_timer integer
    ---@field boost_timer integer

---@class GhostBreath : Projectile
    ---@field timer integer
    ---@field big_cloud boolean

---@class LaserBeam : Movable
    ---@field sparks ParticleEmitterInfo
    ---@field emitted_light Illumination

---@class TreasureHook : Movable

---@class AxolotlShot : Projectile
    ---@field trapped_uid integer
    ---@field size number
    ---@field swing number
    ---@field swing_periodicity number
    ---@field distance_after_capture number

---@class TrapPart : Movable
    ---@field ceiling Entity

---@class SkullDropTrap : Movable
    ---@field left_skull_uid integer
    ---@field middle_skull_uid integer
    ---@field right_skull_uid integer
    ---@field left_skull_drop_time integer
    ---@field middle_skull_drop_time integer
    ---@field right_skull_drop_time integer
    ---@field timer integer

---@class FrozenLiquid : Movable

---@class Switch : Movable
    ---@field timer integer

---@class FlyHead : Movable
    ---@field vored_entity_uid integer

---@class SnapTrap : Movable
    ---@field bait_uid integer
    ---@field reload_timer integer

---@class EmpressGrave : Movable
    ---@field fx_button Entity
    ---@field ghost Entity

---@class Tentacle : Chain
    ---@field bottom Entity

---@class MiniGameShip : Movable
    ---@field velocity_x number
    ---@field velocity_y number
    ---@field swing number
    ---@field up_down_normal number

---@class MiniGameAsteroid : Movable
    ---@field spin_speed number

---@class Pot : Purchasable
    ---@field inside ENT_TYPE
    ---@field dont_transfer_dmg boolean

---@class CursedPot : Movable
    ---@field smoke ParticleEmitterInfo
    ---@field smoke2 ParticleEmitterInfo

---@class CookFire : Torch
    ---@field emitted_light Illumination
    ---@field particles_smoke ParticleEmitterInfo
    ---@field particles_flames ParticleEmitterInfo
    ---@field particles_warp ParticleEmitterInfo

---@class Orb : Movable
    ---@field timer integer

---@class EggSac : Movable
    ---@field timer integer

---@class Goldbar : Movable

---@class Coin : Movable
    ---@field nominal_price integer

---@class RollingItem : Purchasable
    ---@field roll_speed number

---@class PlayerBag : Movable
    ---@field bombs integer
    ---@field ropes integer

---@class Powerup : Movable

---@class KapalaPowerup : Powerup
    ---@field amount_of_blood integer

---@class ParachutePowerup : Powerup
    ---@field falltime_deploy integer
    ---@field deployed boolean
    ---@field deploy fun(self, ): nil

---@class TrueCrownPowerup : Powerup
    ---@field timer integer

---@class AnkhPowerup : Powerup
    ---@field player Entity
    ---@field fx_glow Entity
    ---@field timer1 integer
    ---@field timer2 integer
    ---@field timer3 integer
    ---@field music_on_off boolean

---@class YellowCape : Cape

---@class Teleporter : Purchasable
    ---@field teleport_number integer

---@class Boomerang : Purchasable
    ---@field trail ParticleEmitterInfo
    ---@field distance number
    ---@field rotation number
    ---@field returns_to_uid integer

---@class Excalibur : Movable
    ---@field in_stone boolean

---@class Shield : Purchasable
    ---@field shake number

---@class PrizeDispenser : Movable
    ---@field item_ids integer[]
    ---@field prizes_spawned integer

---@class LiquidSurface : Movable
    ---@field glow_radius number
    ---@field sine_pos number
    ---@field sine_pos_increment number

---@class OlmecFloater : Movable
    ---@field both_floaters_intact boolean
    ---@field on_breaking boolean

---@class EggshipCenterJetFlame : Movable
    ---@field emitted_light Illumination
    ---@field particle ParticleEmitterInfo
    ---@field smoke_on boolean

---@class MiniGameShipOffset : Movable
    ---@field offset_x number
    ---@field offset_y number
    ---@field normal_y_offset number

---@class Button : Movable
    ---@field button_sprite integer
    ---@field visibility number
    ---@field is_visible boolean
    ---@field player_trigger boolean
    ---@field seen integer

---@class FxTornJournalPage : Movable
    ---@field page_number integer

---@class FxMainExitDoor : Movable
    ---@field emitted_light Illumination
    ---@field timer integer

---@class Birdies : Movable

---@class Explosion : Movable
    ---@field emitted_light Illumination

---@class FxOuroboroOccluder : Movable

---@class FxOuroboroDragonPart : Movable
    ---@field speed number
    ---@field timer integer
    ---@field particle ParticleEmitterInfo

---@class Rubble : Movable

---@class FxCompass : Movable
    ---@field sine_angle number
    ---@field visibility number
    ---@field is_active boolean

---@class SleepBubble : Movable
    ---@field show_hide_timer integer

---@class MovingIcon : Movable
    ---@field movement_timer integer

---@class FxSaleContainer : Movable
    ---@field fx_value Entity
    ---@field fx_icon Entity
    ---@field fx_button Entity
    ---@field shake_amplitude number
    ---@field sound_trigger boolean
    ---@field pop_in_out_procentage integer

---@class FxPickupEffect : Movable
    ---@field spawn_y number
    ---@field visibility number

---@class FxShotgunBlast : Movable
    ---@field illumination Illumination

---@class FxJetpackFlame : Movable
    ---@field particle_smoke ParticleEmitterInfo
    ---@field particle_flame ParticleEmitterInfo
    ---@field illumination Illumination

---@class FxPlayerIndicator : Movable
    ---@field attached_to integer
    ---@field pos_x number
    ---@field pos_y number

---@class FxSpringtrapRing : Movable
    ---@field timer integer
    ---@field illumination Illumination

---@class FxWitchdoctorHint : Movable

---@class FxNecromancerANKH : Movable

---@class FxWebbedEffect : Movable
    ---@field visible boolean

---@class FxUnderwaterBubble : Movable
    ---@field bubble_source_uid integer
    ---@field direction integer
    ---@field pop boolean
    ---@field inverted boolean

---@class FxWaterDrop : Movable
    ---@field inverted boolean
    ---@field droplet_source_uid integer

---@class FxKinguSliding : Movable
    ---@field particle ParticleEmitterInfo

---@class FxAlienBlast : Movable

---@class FxSparkSmall : Movable
    ---@field timer integer

---@class FxTiamatHead : Movable
    ---@field timer integer

---@class FxTiamatTorso : Movable
    ---@field timer integer
    ---@field torso_target_size number

---@class FxTiamatTail : Movable
    ---@field angle_two number
    ---@field x_pos number
    ---@field y_pos number

---@class FxVatBubble : Movable
    ---@field max_y number

---@class FxHundunNeckPiece : Movable
    ---@field kill_timer integer

---@class FxJellyfishStar : Movable
    ---@field rotation_angle number
    ---@field radius number
    ---@field speed number

---@class FxQuickSand : Movable

---@class FxSorceressAttack : Movable
    ---@field size number

---@class FxLamassuAttack : Movable
    ---@field attack_angle number

---@class FxFireflyLight : Movable
    ---@field illumination Illumination
    ---@field light_timer integer
    ---@field cooldown_timer integer

---@class FxEmpress : Movable
    ---@field sine_angle number

---@class FxAnkhRotatingSpark : Movable
    ---@field radius number
    ---@field inclination number
    ---@field speed number
    ---@field sine_angle number
    ---@field size number

---@class FxAnkhBrokenPiece : Movable

---@class MegaJellyfishEye : Movable
    ---@field timer integer

---@class Liquid : Entity
    ---@field fx_surface Entity
    ---@field get_liquid_flags fun(self, ): integer
    ---@field set_liquid_flags fun(self, flags: integer): nil

---@class Lava : Liquid
    ---@field emitted_light Illumination

---@class BGBackLayerDoor : Entity
    ---@field illumination1 Illumination
    ---@field illumination2 Illumination

---@class BGSurfaceStar : Entity
    ---@field blink_timer integer
    ---@field relative_x number
    ---@field relative_y number

---@class BGRelativeElement : Entity
    ---@field relative_x number
    ---@field relative_y number

---@class BGSurfaceLayer : BGRelativeElement
    ---@field relative_offset_x number
    ---@field relative_offset_y number

---@class BGEggshipRoom : Entity
    ---@field fx_shell Entity
    ---@field fx_door Entity
    ---@field platform_left Entity
    ---@field platform_middle Entity
    ---@field platform_right Entity
    ---@field player_in boolean

---@class BGMovingStar : BGSurfaceStar
    ---@field falling_speed number

---@class BGTutorialSign : Entity
    ---@field is_shown boolean

---@class BGShootingStar : BGRelativeElement
    ---@field x_increment number
    ---@field y_increment number
    ---@field timer integer
    ---@field max_timer integer
    ---@field size number

---@class BGShopEntrence : Entity
    ---@field on_entering boolean

---@class BGFloatingDebris : BGSurfaceLayer
    ---@field distance number
    ---@field speed number
    ---@field sine_angle number

---@class BGShopKeeperPrime : Entity
    ---@field normal_y number
    ---@field sine_pos number
    ---@field bubbles_timer integer
    ---@field bubble_spawn_trigger boolean
    ---@field bubble_spawn_delay integer

---@class CrossBeam : Entity
    ---@field attached_to_side_uid integer
    ---@field attached_to_top_uid integer

---@class DestructibleBG : Entity

---@class PalaceSign : Entity
    ---@field illumination Illumination
    ---@field arrow_illumination Illumination
    ---@field arrow_change_timer integer

---@class DecoRegeneratingBlock : Entity

---@class Portal : Entity
    ---@field emitted_light Illumination
    ---@field transition_timer integer
    ---@field level integer
    ---@field world integer
    ---@field theme integer
    ---@field timer integer

---@class ShootingStarSpawner : Entity
    ---@field timer integer

---@class LogicalDoor : Entity
    ---@field door_type ENT_TYPE
    ---@field platform_type ENT_TYPE
    ---@field visible boolean
    ---@field platform_spawned boolean

---@class LogicalSound : Entity

---@class LogicalStaticSound : LogicalSound

---@class LogicalLiquidStreamSound : LogicalStaticSound

---@class LogicalTrapTrigger : Entity
    ---@field min_empty_distance integer
    ---@field trigger_distance integer
    ---@field vertical boolean

---@class JungleTrapTrigger : LogicalTrapTrigger

---@class WetEffect : Entity
    ---@field particle ParticleEmitterInfo

---@class OnFireEffect : Entity
    ---@field particle_smoke ParticleEmitterInfo
    ---@field particle_flame ParticleEmitterInfo
    ---@field illumination Illumination

---@class PoisonedEffect : Entity
    ---@field particle_burst ParticleEmitterInfo
    ---@field particle_base ParticleEmitterInfo
    ---@field burst_timer integer
    ---@field burst_active boolean

---@class CursedEffect : Entity
    ---@field particle ParticleEmitterInfo

---@class OuroboroCameraAnchor : Entity
    ---@field target_x number
    ---@field target_y number
    ---@field velocity_x number
    ---@field velocity_y number

---@class OuroboroCameraZoomin : Entity
    ---@field zoomin_level number

---@class CinematicAnchor : Entity
    ---@field blackbar_top Entity
    ---@field blackbar_bottom Entity
    ---@field roll_in number

---@class BurningRopeEffect : Entity
    ---@field illumination Illumination

---@class DustWallApep : Entity
    ---@field particle ParticleEmitterInfo

---@class CameraFlash : Entity
    ---@field illumination1 Illumination
    ---@field illumination2 Illumination
    ---@field timer integer

---@class RoomLight : Entity
    ---@field illumination Illumination

---@class LimbAnchor : Entity
    ---@field move_timer integer
    ---@field flip_vertical boolean

---@class LogicalConveyorbeltSound : LogicalSound

---@class LogicalAnchovyFlock : Entity
    ---@field current_speed number
    ---@field max_speed number
    ---@field timer integer

---@class MummyFliesSound : LogicalSound
    ---@field mummy_uid integer
    ---@field flies integer

---@class QuickSandSound : LogicalSound

---@class IceSlidingSound : LogicalSound

---@class FrostBreathEffect : Entity
    ---@field timer integer

---@class BoulderSpawner : Entity
    ---@field timer integer

---@class PipeTravelerSound : LogicalSound
    ---@field enter_exit boolean

---@class LogicalDrain : Entity
    ---@field timer integer

---@class LogicalRegeneratingBlock : Entity
    ---@field timer integer

---@class SplashBubbleGenerator : Entity
    ---@field timer integer

---@class EggplantThrower : Entity

---@class LogicalMiniGame : Entity
    ---@field timer integer

---@class DMSpawning : Entity
    ---@field spawn_x number
    ---@field spawn_y number
    ---@field sine_pos number
    ---@field timer integer

---@class DMAlienBlast : Entity

---@class ParticleDB
    ---@field id integer
    ---@field spawn_count_min integer
    ---@field spawn_count integer
    ---@field lifespan_min integer
    ---@field lifespan integer
    ---@field sheet_id integer
    ---@field animation_sequence_length integer
    ---@field spawn_interval number
    ---@field shrink_growth_factor number
    ---@field rotation_speed number
    ---@field opacity number
    ---@field hor_scattering number
    ---@field ver_scattering number
    ---@field scale_x_min number
    ---@field scale_x number
    ---@field scale_y_min number
    ---@field scale_y number
    ---@field hor_deflection_1 number
    ---@field ver_deflection_1 number
    ---@field hor_deflection_2 number
    ---@field ver_deflection_2 number
    ---@field hor_velocity number
    ---@field ver_velocity number
    ---@field red integer
    ---@field green integer
    ---@field blue integer
    ---@field permanent boolean
    ---@field invisible boolean
    ---@field get_texture fun(self, ): integer
    ---@field set_texture fun(self, texture_id: integer): boolean

---@class ParticleEmitterInfo
    ---@field particle_type ParticleDB
    ---@field particle_count integer
    ---@field entity_uid integer
    ---@field x number
    ---@field y number
    ---@field offset_x number
    ---@field offset_y number

---@class ThemeInfo
    ---@field sub_theme ThemeInfo
    ---@field get_unknown1 fun(self, ): boolean
    ---@field init_flags fun(self, ): nil
    ---@field init_level fun(self, ): nil
    ---@field unknown_v4 fun(self, ): nil
    ---@field unknown_v5 fun(self, ): nil
    ---@field add_special_rooms fun(self, ): nil
    ---@field unknown_v7 fun(self, ): nil
    ---@field unknown_v8 fun(self, ): nil
    ---@field add_vault fun(self, ): nil
    ---@field add_coffin fun(self, ): nil
    ---@field add_special_feeling fun(self, ): nil
    ---@field unknown_v12 fun(self, ): boolean
    ---@field spawn_level fun(self, ): nil
    ---@field spawn_border fun(self, ): nil
    ---@field post_process_level fun(self, ): nil
    ---@field spawn_traps fun(self, ): nil
    ---@field post_process_entities fun(self, ): nil
    ---@field spawn_procedural fun(self, ): nil
    ---@field spawn_background fun(self, ): nil
    ---@field spawn_lights fun(self, ): nil
    ---@field spawn_transition fun(self, ): nil
    ---@field post_transition fun(self, ): nil
    ---@field spawn_players fun(self, ): nil
    ---@field spawn_effects fun(self, ): nil
    ---@field get_level_file fun(self, ): string
    ---@field get_theme_id fun(self, ): integer
    ---@field get_base_id fun(self, ): integer
    ---@field get_floor_spreading_type fun(self, ): integer
    ---@field get_floor_spreading_type2 fun(self, ): integer
    ---@field unknown_v30 fun(self, ): boolean
    ---@field get_transition_block_modifier fun(self, ): integer
    ---@field unknown_v32 fun(self, ): integer
    ---@field get_backwall_type fun(self, ): integer
    ---@field get_border_type fun(self, ): integer
    ---@field get_critter_type fun(self, ): integer
    ---@field get_liquid_gravity fun(self, ): number
    ---@field get_player_damage fun(self, ): boolean
    ---@field unknown_v38 fun(self, ): boolean
    ---@field get_backlayer_lut fun(self, ): integer
    ---@field get_backlayer_light_level fun(self, ): number
    ---@field get_loop fun(self, ): boolean
    ---@field get_vault_level fun(self, ): integer
    ---@field get_unknown_1_or_2 fun(self, index: integer): boolean
    ---@field get_dynamic_texture fun(self, texture_id: integer): integer
    ---@field pre_transition fun(self, ): nil
    ---@field get_level_height fun(self, ): integer
    ---@field unknown_v47 fun(self, ): integer
    ---@field spawn_decoration fun(self, ): nil
    ---@field spawn_decoration2 fun(self, ): nil
    ---@field spawn_extra fun(self, ): nil
    ---@field unknown_v51 fun(self, ): nil

---@class CustomTheme
    ---@field level_file string
    ---@field theme integer
    ---@field base_theme integer
    ---@field sub_theme any @&CustomTheme::sub_theme
    ---@field textures table<DYNAMIC_TEXTURE, integer>
    ---@field override any @theme_override
    ---@field pre any @&CustomTheme::pre
    ---@field post any @&CustomTheme::post
    ---@field unknown1 any @&CustomTheme::unknown1
    ---@field unknown2 any @&CustomTheme::unknown2
    ---@field unknown3 any @&CustomTheme::unknown3
    ---@field unknown4 any @&CustomTheme::unknown4
    ---@field get_unknown1 fun(self, ): boolean
    ---@field init_flags fun(self, ): nil
    ---@field init_level fun(self, ): nil
    ---@field unknown_v4 fun(self, ): nil
    ---@field unknown_v5 fun(self, ): nil
    ---@field add_special_rooms fun(self, ): nil
    ---@field unknown_v7 fun(self, ): nil
    ---@field unknown_v8 fun(self, ): nil
    ---@field add_vault fun(self, ): nil
    ---@field add_coffin fun(self, ): nil
    ---@field add_special_feeling fun(self, ): nil
    ---@field unknown_v12 fun(self, ): boolean
    ---@field spawn_level fun(self, ): nil
    ---@field spawn_border fun(self, ): nil
    ---@field post_process_level fun(self, ): nil
    ---@field spawn_traps fun(self, ): nil
    ---@field post_process_entities fun(self, ): nil
    ---@field spawn_procedural fun(self, ): nil
    ---@field spawn_background fun(self, ): nil
    ---@field spawn_lights fun(self, ): nil
    ---@field spawn_transition fun(self, ): nil
    ---@field post_transition fun(self, ): nil
    ---@field spawn_players fun(self, ): nil
    ---@field spawn_effects fun(self, ): nil
    ---@field get_level_file fun(self, ): string
    ---@field get_theme_id fun(self, ): integer
    ---@field get_base_id fun(self, ): integer
    ---@field get_floor_spreading_type fun(self, ): integer
    ---@field get_floor_spreading_type2 fun(self, ): integer
    ---@field unknown_v30 fun(self, ): boolean
    ---@field get_transition_block_modifier fun(self, ): integer
    ---@field unknown_v32 fun(self, ): integer
    ---@field get_backwall_type fun(self, ): integer
    ---@field get_border_type fun(self, ): integer
    ---@field get_critter_type fun(self, ): integer
    ---@field get_liquid_gravity fun(self, ): number
    ---@field get_player_damage fun(self, ): boolean
    ---@field unknown_v38 fun(self, ): boolean
    ---@field get_backlayer_lut fun(self, ): integer
    ---@field get_backlayer_light_level fun(self, ): number
    ---@field get_loop fun(self, ): boolean
    ---@field get_vault_level fun(self, ): integer
    ---@field get_unknown_1_or_2 fun(self, index: integer): boolean
    ---@field get_dynamic_texture fun(self, texture_id: integer): integer
    ---@field pre_transition fun(self, ): nil
    ---@field get_level_height fun(self, ): integer
    ---@field unknown_v47 fun(self, ): integer
    ---@field spawn_decoration fun(self, ): nil
    ---@field spawn_decoration2 fun(self, ): nil
    ---@field spawn_extra fun(self, ): nil
    ---@field unknown_v51 fun(self, ): nil

---@class PreLoadLevelFilesContext
    ---@field override_level_files fun(self, levels: string[]): nil
    ---@field add_level_files fun(self, levels: string[]): nil

---@class DoorCoords
    ---@field door1_x number
    ---@field door1_y number
    ---@field door2_x number
    ---@field door2_y number

---@class LevelGenSystem
    ---@field shop_type SHOP_TYPE
    ---@field backlayer_shop_type SHOP_TYPE
    ---@field spawn_x number
    ---@field spawn_y number
    ---@field spawn_room_x integer
    ---@field spawn_room_y integer
    ---@field exits DoorCoords
    ---@field exit_doors Vec2[]
    ---@field themes ThemeInfo[] @size: 18

---@class PostRoomGenerationContext
    ---@field set_room_template fun(self, x: integer, y: integer, layer: LAYER, room_template: ROOM_TEMPLATE): boolean
    ---@field mark_as_machine_room_origin fun(self, x: integer, y: integer, layer: LAYER): boolean
    ---@field mark_as_set_room fun(self, x: integer, y: integer, layer: LAYER): boolean
    ---@field unmark_as_set_room fun(self, x: integer, y: integer, layer: LAYER): boolean
    ---@field set_shop_type fun(self, x: integer, y: integer, layer: LAYER, shop_type: integer): boolean
    ---@field set_procedural_spawn_chance fun(self, chance_id: PROCEDURAL_CHANCE, inverse_chance: integer): boolean
    ---@field set_num_extra_spawns fun(self, extra_spawn_id: integer, num_spawns_front_layer: integer, num_spawns_back_layer: integer): nil
    ---@field define_short_tile_code fun(self, short_tile_code_def: ShortTileCodeDef): SHORT_TILE_CODE?
    ---@field change_short_tile_code fun(self, short_tile_code: SHORT_TILE_CODE, short_tile_code_def: ShortTileCodeDef): nil

---@class PreHandleRoomTilesContext
    ---@field get_short_tile_code fun(self, tx: integer, ty: integer, layer: LAYER): SHORT_TILE_CODE?
    ---@field set_short_tile_code fun(self, tx: integer, ty: integer, layer: LAYER, short_tile_code: SHORT_TILE_CODE): boolean
    ---@field find_all_short_tile_codes fun(self, layer: LAYER, short_tile_code: SHORT_TILE_CODE): integer[][]
    ---@field replace_short_tile_code fun(self, layer: LAYER, short_tile_code: SHORT_TILE_CODE, replacement_short_tile_code: SHORT_TILE_CODE): boolean
    ---@field has_back_layer fun(self, ): boolean
    ---@field add_empty_back_layer fun(self, ): nil
    ---@field add_copied_back_layer fun(self, ): nil

---@class ShortTileCodeDef
    ---@field tile_code TILE_CODE
    ---@field chance integer
    ---@field alt_tile_code TILE_CODE

---@class QuestsInfo
    ---@field yang_state integer
    ---@field jungle_sisters_flags integer
    ---@field van_horsing_state integer
    ---@field sparrow_state integer
    ---@field madame_tusk_state integer
    ---@field beg_state integer

---@class SaveData
    ---@field places boolean[]
    ---@field bestiary boolean[]
    ---@field people boolean[]
    ---@field items boolean[]
    ---@field traps boolean[]
    ---@field last_daily string
    ---@field characters integer
    ---@field shortcuts integer
    ---@field bestiary_killed integer[]
    ---@field bestiary_killed_by integer[]
    ---@field people_killed integer[]
    ---@field people_killed_by integer[]
    ---@field plays integer
    ---@field deaths integer
    ---@field wins_normal integer
    ---@field wins_hard integer
    ---@field wins_special integer
    ---@field score_total integer
    ---@field score_top integer
    ---@field deepest_area integer
    ---@field deepest_level integer
    ---@field time_best integer
    ---@field time_total integer
    ---@field time_tutorial integer
    ---@field character_deaths integer[]
    ---@field pets_rescued integer[]
    ---@field completed_normal boolean
    ---@field completed_ironman boolean
    ---@field completed_hard boolean
    ---@field profile_seen boolean
    ---@field seeded_unlocked boolean
    ---@field world_last integer
    ---@field level_last integer
    ---@field score_last integer
    ---@field time_last integer
    ---@field stickers integer[]
    ---@field players integer[]
    ---@field constellation Constellation

---@class Constellation
    ---@field star_count integer
    ---@field stars ConstellationStar[]
    ---@field scale number
    ---@field line_count integer
    ---@field lines ConstellationLine[]
    ---@field line_red_intensity number

---@class ConstellationStar
    ---@field type integer
    ---@field x number
    ---@field y number
    ---@field size number
    ---@field red number
    ---@field green number
    ---@field blue number
    ---@field alpha number
    ---@field halo_red number
    ---@field halo_green number
    ---@field halo_blue number
    ---@field halo_alpha number
    ---@field canis_ring boolean
    ---@field fidelis_ring boolean

---@class ConstellationLine
    ---@field from integer
    ---@field to integer

---@class CustomSound
    ---@field play CustomSound_play
    ---@field get_parameters fun(self, ): table<VANILLA_SOUND_PARAM, string>

---@class CustomSound_play
---@param paused boolean
---@param sound_type SOUND_TYPE
---@overload fun(self): PlayingSound
---@overload fun(self, paused: boolean): PlayingSound
local function CustomSound_play(self, paused, sound_type) end

---@class PlayingSound
    ---@field is_playing fun(self, ): boolean
    ---@field stop fun(self, ): boolean
    ---@field set_pause fun(self, pause: boolean): boolean
    ---@field set_mute fun(self, mute: boolean): boolean
    ---@field set_pitch fun(self, pitch: number): boolean
    ---@field set_pan fun(self, pan: number): boolean
    ---@field set_volume fun(self, volume: number): boolean
    ---@field set_looping fun(self, loop_mode: SOUND_LOOP_MODE): boolean
    ---@field set_callback fun(self, callback: SoundCallbackFunction): boolean
    ---@field get_parameters fun(self, ): table<VANILLA_SOUND_PARAM, string>
    ---@field get_parameter fun(self, parameter_index: VANILLA_SOUND_PARAM): number?
    ---@field set_parameter fun(self, parameter_index: VANILLA_SOUND_PARAM, value: number): boolean

---@class PlayerSlotSettings
    ---@field controller_vibration boolean
    ---@field auto_run_enabled boolean
    ---@field controller_right_stick boolean

---@class PlayerSlot
    ---@field buttons_gameplay INPUTS
    ---@field buttons INPUTS
    ---@field input_mapping_keyboard InputMapping
    ---@field input_mapping_controller InputMapping
    ---@field player_id integer
    ---@field is_participating boolean

---@class InputMapping
    ---@field jump integer
    ---@field attack integer
    ---@field bomb integer
    ---@field rope integer
    ---@field walk_run integer
    ---@field use_door_buy integer
    ---@field pause_menu integer
    ---@field journal integer
    ---@field left integer
    ---@field right integer
    ---@field up integer
    ---@field down integer

---@class PlayerInputs
    ---@field player_slots PlayerSlot[]
    ---@field player_slot_1 PlayerSlot
    ---@field player_slot_2 PlayerSlot
    ---@field player_slot_3 PlayerSlot
    ---@field player_slot_4 PlayerSlot
    ---@field player_settings PlayerSlotSettings[]
    ---@field player_slot_1_settings PlayerSlotSettings
    ---@field player_slot_2_settings PlayerSlotSettings
    ---@field player_slot_3_settings PlayerSlotSettings
    ---@field player_slot_4_settings PlayerSlotSettings

---@class GuiDrawContext
    ---@field draw_line fun(self, x1: number, y1: number, x2: number, y2: number, thickness: number, color: uColor): nil
    ---@field draw_rect GuiDrawContext_draw_rect
    ---@field draw_rect_filled GuiDrawContext_draw_rect_filled
    ---@field draw_triangle fun(self, p1: Vec2, p2: Vec2, p3: Vec2, thickness: number, color: uColor): nil
    ---@field draw_triangle_filled fun(self, p1: Vec2, p2: Vec2, p3: Vec2, color: uColor): nil
    ---@field draw_poly fun(self, points: Vec2[], thickness: number, color: uColor): nil
    ---@field draw_poly_filled fun(self, points: Vec2[], color: uColor): nil
    ---@field draw_bezier_cubic fun(self, p1: Vec2, p2: Vec2, p3: Vec2, p4: Vec2, thickness: number, color: uColor): nil
    ---@field draw_bezier_quadratic fun(self, p1: Vec2, p2: Vec2, p3: Vec2, thickness: number, color: uColor): nil
    ---@field draw_circle fun(self, x: number, y: number, radius: number, thickness: number, color: uColor): nil
    ---@field draw_circle_filled fun(self, x: number, y: number, radius: number, color: uColor): nil
    ---@field draw_text fun(self, x: number, y: number, size: number, text: string, color: uColor): nil
    ---@field draw_image GuiDrawContext_draw_image
    ---@field draw_image_rotated GuiDrawContext_draw_image_rotated
    ---@field window any @&GuiDrawContext::window
    ---@field win_text fun(self, text: string): nil
    ---@field win_separator fun(self, ): nil
    ---@field win_inline fun(self, ): nil
    ---@field win_sameline fun(self, offset: number, spacing: number): nil
    ---@field win_button fun(self, text: string): boolean
    ---@field win_input_text fun(self, label: string, value: string): string
    ---@field win_input_int fun(self, label: string, value: integer): integer
    ---@field win_input_float fun(self, label: string, value: number): number
    ---@field win_slider_int fun(self, label: string, value: integer, min: integer, max: integer): integer
    ---@field win_drag_int fun(self, label: string, value: integer, min: integer, max: integer): integer
    ---@field win_slider_float fun(self, label: string, value: number, min: number, max: number): number
    ---@field win_drag_float fun(self, label: string, value: number, min: number, max: number): number
    ---@field win_check fun(self, label: string, value: boolean): boolean
    ---@field win_combo fun(self, label: string, selected: integer, opts: string): integer
    ---@field win_pushid fun(self, id: integer): nil
    ---@field win_popid fun(self, ): nil
    ---@field win_image fun(self, image: IMAGE, width: integer, height: integer): nil

---@class GuiDrawContext_draw_rect
---@param rect AABB
---@param thickness number
---@param rounding number
---@param color uColor
---@overload fun(self, left: number, top: number, right: number, bottom: number, thickness: number, rounding: number, color: uColor): nil
local function GuiDrawContext_draw_rect(self, rect, thickness, rounding, color) end

---@class GuiDrawContext_draw_rect_filled
---@param rect AABB
---@param rounding number
---@param color uColor
---@overload fun(self, left: number, top: number, right: number, bottom: number, rounding: number, color: uColor): nil
local function GuiDrawContext_draw_rect_filled(self, rect, rounding, color) end

---@class GuiDrawContext_draw_image
---@param image IMAGE
---@param rect AABB
---@param uv_rect AABB
---@param color uColor
---@overload fun(self, image: IMAGE, left: number, top: number, right: number, bottom: number, uvx1: number, uvy1: number, uvx2: number, uvy2: number, color: uColor): nil
local function GuiDrawContext_draw_image(self, image, rect, uv_rect, color) end

---@class GuiDrawContext_draw_image_rotated
---@param image IMAGE
---@param rect AABB
---@param uv_rect AABB
---@param color uColor
---@param angle number
---@param px number
---@param py number
---@overload fun(self, image: IMAGE, left: number, top: number, right: number, bottom: number, uvx1: number, uvy1: number, uvx2: number, uvy2: number, color: uColor, angle: number, px: number, py: number): nil
local function GuiDrawContext_draw_image_rotated(self, image, rect, uv_rect, color, angle, px, py) end

---@class ImVec2
    ---@field x number
    ---@field y number

---@class Gamepad
    ---@field enabled boolean
    ---@field buttons any @&Gamepad::wButtons
    ---@field lt number
    ---@field rt number
    ---@field lx number
    ---@field ly number
    ---@field rx number
    ---@field ry number

---@class ImGuiIO
    ---@field displaysize ImVec2
    ---@field framerate number
    ---@field wantkeyboard boolean
    ---@field keysdown boolean       [] @size: 512. Note: lua starts indexing at 1, you need `keysdown[string.byte('A') + 1]` to find the A key.
    ---@field keydown fun(key: number | string): boolean
    ---@field keypressed fun(key: number | string, repeat?: boolean ): boolean
    ---@field keyreleased fun(key: number | string): boolean
    ---@field keyctrl boolean
    ---@field keyshift boolean
    ---@field keyalt boolean
    ---@field keysuper boolean
    ---@field wantmouse boolean
    ---@field mousepos ImVec2
    ---@field mousedown boolean       [] @size: 5
    ---@field mouseclicked boolean       [] @size: 5
    ---@field mousedoubleclicked boolean       [] @size: 5
    ---@field mousewheel number
    ---@field gamepad Gamepad

---@class VanillaRenderContext
    ---@field draw_text fun(self, text: string, x: number, y: number, scale_x: number, scale_y: number, color: Color, alignment: integer, fontstyle: integer): nil
    ---@field draw_text_size fun(self, text: string, scale_x: number, scale_y: number, fontstyle: integer): number, number
    ---@field draw_screen_texture VanillaRenderContext_draw_screen_texture
    ---@field draw_world_texture VanillaRenderContext_draw_world_texture

---@class VanillaRenderContext_draw_screen_texture
---@param texture_id TEXTURE
---@param source Quad
---@param dest Quad
---@param color Color
---@overload fun(self, texture_id: TEXTURE, row: integer, column: integer, left: number, top: number, right: number, bottom: number, color: Color): nil
---@overload fun(self, texture_id: TEXTURE, row: integer, column: integer, rect: AABB, color: Color): nil
---@overload fun(self, texture_id: TEXTURE, row: integer, column: integer, rect: AABB, color: Color, angle: number, px: number, py: number): nil
---@overload fun(self, texture_id: TEXTURE, row: integer, column: integer, dest: Quad, color: Color): nil
local function VanillaRenderContext_draw_screen_texture(self, texture_id, source, dest, color) end

---@class VanillaRenderContext_draw_world_texture
---@param texture_id TEXTURE
---@param source Quad
---@param dest Quad
---@param color Color
---@overload fun(self, texture_id: TEXTURE, row: integer, column: integer, left: number, top: number, right: number, bottom: number, color: Color): nil
---@overload fun(self, texture_id: TEXTURE, row: integer, column: integer, dest: AABB, color: Color): nil
---@overload fun(self, texture_id: TEXTURE, row: integer, column: integer, dest: AABB, color: Color, angle: number, px: number, py: number): nil
---@overload fun(self, texture_id: TEXTURE, row: integer, column: integer, dest: Quad, color: Color, shader: WORLD_SHADER): nil
---@overload fun(self, texture_id: TEXTURE, row: integer, column: integer, dest: Quad, color: Color): nil
---@overload fun(self, texture_id: TEXTURE, source: Quad, dest: Quad, color: Color, shader: WORLD_SHADER): nil
local function VanillaRenderContext_draw_world_texture(self, texture_id, source, dest, color) end

---@class TextureRenderingInfo
    ---@field x number
    ---@field y number
    ---@field destination_bottom_left_x number
    ---@field destination_bottom_left_y number
    ---@field destination_bottom_right_x number
    ---@field destination_bottom_right_y number
    ---@field destination_top_left_x number
    ---@field destination_top_left_y number
    ---@field destination_top_right_x number
    ---@field destination_top_right_y number
    ---@field set_destination fun(self, bbox: AABB): nil
    ---@field dest_get_quad fun(self, ): Quad
    ---@field dest_set_quad fun(self, quad: Quad): nil
    ---@field source_bottom_left_x number
    ---@field source_bottom_left_y number
    ---@field source_bottom_right_x number
    ---@field source_bottom_right_y number
    ---@field source_top_left_x number
    ---@field source_top_left_y number
    ---@field source_top_right_x number
    ---@field source_top_right_y number
    ---@field source_get_quad fun(self, ): Quad
    ---@field source_set_quad fun(self, quad: Quad): nil

---@class TextRenderingInfo
    ---@field x number
    ---@field y number
    ---@field text_length integer
    ---@field width number
    ---@field height number
    ---@field font Texture

---@class TextureDefinition
    ---@field texture_path string
    ---@field width integer
    ---@field height integer
    ---@field tile_width integer
    ---@field tile_height integer
    ---@field sub_image_offset_x integer
    ---@field sub_image_offset_y integer
    ---@field sub_image_width integer
    ---@field sub_image_height integer

---@class Vec2
    ---@field x number
    ---@field y number
    ---@field rotate fun(self, angle: number, px: number, py: number): Vec2
    ---@field split any @&Vec2::operatorstd::pair<float

---@class AABB
    ---@field left number
    ---@field bottom number
    ---@field right number
    ---@field top number
    ---@field overlaps_with fun(self, other: AABB): boolean
    ---@field abs fun(self, ): AABB
    ---@field extrude fun(self, amount: number): AABB
    ---@field offset fun(self, off_x: number, off_y: number): AABB
    ---@field area fun(self, ): number
    ---@field center fun(self, ): number, number
    ---@field width fun(self, ): number
    ---@field height fun(self, ): number

---@class Quad
    ---@field bottom_left_x number
    ---@field bottom_left_y number
    ---@field bottom_right_x number
    ---@field bottom_right_y number
    ---@field top_right_x number
    ---@field top_right_y number
    ---@field top_left_x number
    ---@field top_left_y number
    ---@field get_AABB fun(self, ): AABB
    ---@field offset fun(self, off_x: number, off_y: number): Quad
    ---@field rotate fun(self, angle: number, px: number, py: number): Quad
    ---@field flip_horizontally fun(self, ): Quad
    ---@field flip_vertically fun(self, ): Quad
    ---@field split fun(self, ): Vec2, Vec2, Vec2, Vec2

---@class Screen
    ---@field render_timer number

---@class ScreenLogo : Screen
    ---@field logo_mossmouth TextureRenderingInfo
    ---@field logo_blitworks TextureRenderingInfo
    ---@field logo_fmod TextureRenderingInfo

---@class ScreenIntro : Screen
    ---@field unknown4 TextureRenderingInfo

---@class ScreenPrologue : Screen
    ---@field line1 STRINGID
    ---@field line2 STRINGID
    ---@field line3 STRINGID

---@class ScreenTitle : Screen
    ---@field logo_spelunky2 TextureRenderingInfo
    ---@field ana TextureRenderingInfo
    ---@field ana_right_eyeball_torch_reflection TextureRenderingInfo
    ---@field ana_left_eyeball_torch_reflection TextureRenderingInfo
    ---@field particle_torchflame_smoke ParticleEmitterInfo
    ---@field particle_torchflame_backflames ParticleEmitterInfo
    ---@field particle_torchflame_flames ParticleEmitterInfo
    ---@field particle_torchflame_backflames_animated ParticleEmitterInfo
    ---@field particle_torchflame_flames_animated ParticleEmitterInfo
    ---@field particle_torchflame_ash ParticleEmitterInfo

---@class ScreenMenu : Screen
    ---@field tunnel_background TextureRenderingInfo
    ---@field cthulhu_disc TextureRenderingInfo
    ---@field tunnel_ring_darkbrown TextureRenderingInfo
    ---@field cthulhu_body TextureRenderingInfo
    ---@field tunnel_ring_lightbrown TextureRenderingInfo
    ---@field vine_left TextureRenderingInfo
    ---@field vine_right TextureRenderingInfo
    ---@field skull_left TextureRenderingInfo
    ---@field salamander_right TextureRenderingInfo
    ---@field left_spear TextureRenderingInfo
    ---@field right_spear TextureRenderingInfo
    ---@field spear_dangler_related TextureRenderingInfo
    ---@field play_scroll TextureRenderingInfo
    ---@field info_toast TextureRenderingInfo
    ---@field cthulhu_disc_ring_angle number
    ---@field cthulhu_disc_split_progress number
    ---@field cthulhu_disc_y number
    ---@field cthulhu_timer number
    ---@field selected_menu_index integer
---@field menu_text_opacity number
    ---@field spear_position number[]
    ---@field spear_dangler SpearDanglerAnimFrames[]
    ---@field play_scroll_descend_timer number
    ---@field scroll_text STRINGID

---@class ScreenOptions : Screen
    ---@field selected_menu_index integer
    ---@field brick_border TextureRenderingInfo
    ---@field top_bottom_woodpanels_velocity number
    ---@field top_bottom_woodpanels_progress number
    ---@field scroll_unfurl_progress number
    ---@field bottom_woodpanel_y number
    ---@field top_bottom_woodpanels_slide_in_related number
    ---@field bottom_woodpanel TextureRenderingInfo
    ---@field top_woodpanel TextureRenderingInfo
    ---@field top_woodpanel_left_scrollhandle TextureRenderingInfo
    ---@field top_woodpanel_right_scrollhandle TextureRenderingInfo
    ---@field button_right_caption STRINGID
    ---@field button_middle_caption STRINGID
    ---@field top_woodpanel_visible boolean
    ---@field bottom_woodpanel_visible boolean
    ---@field toggle_woodpanel_slidein_animation boolean
    ---@field capitalize_top_woodpanel boolean
    ---@field current_menu_1 integer
    ---@field current_menu_2 integer
    ---@field topleft_woodpanel_esc TextureRenderingInfo
    ---@field brick_background TextureRenderingInfo
    ---@field brick_middlelayer TextureRenderingInfo
    ---@field brick_foreground TextureRenderingInfo
    ---@field selected_item_rounded_rect TextureRenderingInfo
    ---@field selected_item_scarab TextureRenderingInfo
    ---@field item_option_arrow_left TextureRenderingInfo
    ---@field item_option_arrow_right TextureRenderingInfo
    ---@field tooltip_background TextureRenderingInfo
    ---@field progressbar_background TextureRenderingInfo
    ---@field progressbar_foreground TextureRenderingInfo
    ---@field progressbar_position_indicator TextureRenderingInfo
    ---@field sectionheader_background TextureRenderingInfo
    ---@field topleft_woodpanel_esc_slidein_timer number
    ---@field text_fadein_timer number
    ---@field vertical_scroll_effect_timer number

---@class ScreenPlayerProfile : Screen

---@class ScreenLeaderboards : Screen

---@class ScreenSeedInput : Screen
    ---@field bottom_woodpanel_slideup_timer number
    ---@field bottom_woodpanel_y number
    ---@field bottom_woodpanel TextureRenderingInfo
    ---@field buttons_text_id STRINGID
    ---@field topleft_woodpanel_esc_slidein_timer number
    ---@field scroll_text_id STRINGID
    ---@field start_text_id STRINGID
    ---@field main_woodpanel_left_border TextureRenderingInfo
    ---@field main_woodpanel_center TextureRenderingInfo
    ---@field main_woodpanel_right_border TextureRenderingInfo
    ---@field seed_letter_cutouts TextureRenderingInfo
    ---@field topleft_woodpanel_esc TextureRenderingInfo
    ---@field start_sidepanel TextureRenderingInfo
    ---@field start_sidepanel_slidein_timer number

---@class ScreenCharacterSelect : Screen
    ---@field main_background_zoom_target number
    ---@field blurred_border_zoom_target number
    ---@field top_bottom_woodpanel_slidein_timer number
    ---@field top_scroll_unfurl_timer number
    ---@field bottom_woodpanel TextureRenderingInfo
    ---@field top_woodpanel TextureRenderingInfo
    ---@field left_scroll_handle TextureRenderingInfo
    ---@field right_scroll_handle TextureRenderingInfo
    ---@field left_button_text_id STRINGID
    ---@field right_button_text_id STRINGID
    ---@field middle_button_text_id STRINGID
    ---@field top_woodpanel_visible boolean
    ---@field bottom_woodpanel_visible boolean
    ---@field toggle_woodpanel_slidein_animation boolean
    ---@field mine_entrance_background TextureRenderingInfo
    ---@field character TextureRenderingInfo
    ---@field character_shadow TextureRenderingInfo
    ---@field character_flag TextureRenderingInfo
    ---@field character_left_arrow TextureRenderingInfo
    ---@field character_right_arrow TextureRenderingInfo
    ---@field mine_entrance_border TextureRenderingInfo
    ---@field mine_entrance_shutter TextureRenderingInfo
    ---@field background TextureRenderingInfo
    ---@field blurred_border TextureRenderingInfo
    ---@field blurred_border2 TextureRenderingInfo
    ---@field topleft_woodpanel_esc TextureRenderingInfo
    ---@field start_sidepanel TextureRenderingInfo
    ---@field quick_select_panel TextureRenderingInfo
    ---@field quick_select_selected_char_background TextureRenderingInfo
    ---@field quick_select_panel_related TextureRenderingInfo
    ---@field player_shutter_timer number[]
    ---@field player_x number[]
    ---@field player_y number[]
    ---@field player_arrow_slidein_timer number[][]
    ---@field player_facing_left boolean[]
    ---@field player_quickselect_shown boolean[]
    ---@field player_quickselect_fadein_timer number[]
    ---@field player_quickselect_coords number[][]
    ---@field player_quickselect_wiggle_angle number[]
    ---@field topleft_woodpanel_esc_slidein_timer number
    ---@field start_panel_slidein_timer number
    ---@field action_buttons_keycap_size number
    ---@field not_ready_to_start_yet boolean
    ---@field available_mine_entrances integer
    ---@field amount_of_mine_entrances_activated integer
    ---@field buttons integer
    ---@field opacity number
    ---@field start_pressed boolean
    ---@field transition_to_game_started boolean
    ---@field flying_things FlyingThing[]
    ---@field flying_thing_countdown integer
    ---@field particle_ceilingdust_smoke ParticleEmitterInfo
    ---@field particle_ceilingdust_rubble ParticleEmitterInfo
    ---@field particle_mist ParticleEmitterInfo
    ---@field particle_torchflame_smoke1 ParticleEmitterInfo
    ---@field particle_torchflame_flames1 ParticleEmitterInfo
    ---@field particle_torchflame_smoke2 ParticleEmitterInfo
    ---@field particle_torchflame_flames2 ParticleEmitterInfo
    ---@field particle_torchflame_smoke3 ParticleEmitterInfo
    ---@field particle_torchflame_flames3 ParticleEmitterInfo
    ---@field particle_torchflame_smoke4 ParticleEmitterInfo
    ---@field particle_torchflame_flames4 ParticleEmitterInfo

---@class FlyingThing
    ---@field texture_info TextureRenderingInfo
    ---@field entity_type integer
    ---@field spritesheet_column number
    ---@field spritesheet_row number
    ---@field spritesheet_animation_length number
    ---@field velocity_x number
    ---@field amplitude number
    ---@field frequency number
    ---@field sinewave_angle number

---@class ScreenTeamSelect : Screen
    ---@field ana_carrying_torch TextureRenderingInfo
    ---@field scroll_bottom_left TextureRenderingInfo
    ---@field scrollend_bottom_left TextureRenderingInfo
    ---@field four_ropes TextureRenderingInfo
    ---@field unknown4 TextureRenderingInfo
    ---@field four_characters TextureRenderingInfo
    ---@field left_arrow TextureRenderingInfo
    ---@field right_arrow TextureRenderingInfo
    ---@field start_panel TextureRenderingInfo
    ---@field start_panel_slide_timer number
    ---@field pulsating_arrows_timer number
    ---@field selected_player integer
    ---@field buttons integer
    ---@field ready boolean

---@class ScreenCamp : Screen
    ---@field buttons integer

---@class ScreenLevel : Screen
    ---@field buttons integer

---@class ScreenTransition : Screen
    ---@field woodpanel_pos number
    ---@field stats_scroll_horizontal_posaa number
    ---@field stats_scroll_vertical_pos number
    ---@field level_completed_pos number
    ---@field stats_scroll_unfurl_targetvalue number
    ---@field woodpanel1 TextureRenderingInfo
    ---@field woodpanel2 TextureRenderingInfo
    ---@field woodpanel3 TextureRenderingInfo
    ---@field woodpanel_cutout1 TextureRenderingInfo
    ---@field woodpanel_cutout2 TextureRenderingInfo
    ---@field woodpanel_cutout3 TextureRenderingInfo
    ---@field woodplank TextureRenderingInfo
    ---@field woodpanel_bottomcutout1 TextureRenderingInfo
    ---@field woodpanel_bottomcutout2 TextureRenderingInfo
    ---@field woodpanel_bottomcutout3 TextureRenderingInfo
    ---@field unknown_all_forced TextureRenderingInfo
    ---@field stats_scroll_top_bottom TextureRenderingInfo
    ---@field killcount_rounded_rect TextureRenderingInfo
    ---@field level_completed_panel TextureRenderingInfo
    ---@field stats_scroll_state_1 integer
    ---@field stats_scroll_state_2 integer
    ---@field hide_press_to_go_next_level boolean
    ---@field mama_tunnel TextureRenderingInfo
    ---@field speechbubble TextureRenderingInfo
    ---@field speechbubble_arrow TextureRenderingInfo
    ---@field mama_tunnel_fade_targetvalue number
    ---@field mama_tunnel_text_id STRINGID
    ---@field mama_tunnel_choice_visible boolean
    ---@field mama_tunnel_agree_with_gift boolean
    ---@field mama_tunnel_face_invisible boolean
    ---@field mama_tunnel_face_transparency number
    ---@field mama_tunnel_agree_panel TextureRenderingInfo
    ---@field mama_tunnel_agree_panel_indicator TextureRenderingInfo
    ---@field woodpanel_cutout_big_money1 TextureRenderingInfo
    ---@field woodpanel_cutout_big_money2 TextureRenderingInfo
    ---@field woodpanel_cutout_big_money3 TextureRenderingInfo
    ---@field big_dollar_sign TextureRenderingInfo
    ---@field unknown26 TextureRenderingInfo
    ---@field player_stats_scroll_numeric_value integer[]
    ---@field player_secondary_icon TextureRenderingInfo[]
    ---@field player_icon TextureRenderingInfo[]
    ---@field player_secondary_icon_type integer[]
    ---@field player_icon_index integer[]
    ---@field hourglasses TextureRenderingInfo
    ---@field small_dollar_signs TextureRenderingInfo
    ---@field this_level_money_color Color

---@class ScreenDeath : Screen

---@class ScreenWin : Screen
    ---@field sequence_timer integer
    ---@field frame_timer integer
    ---@field animation_state integer
    ---@field rescuing_ship_entity Entity

---@class ScreenCredits : Screen

---@class ScreenScores : Screen
    ---@field animation_state integer
    ---@field woodpanel1 TextureRenderingInfo
    ---@field woodpanel2 TextureRenderingInfo
    ---@field woodpanel3 TextureRenderingInfo
    ---@field woodpanel_cutout TextureRenderingInfo
    ---@field dollarsign TextureRenderingInfo
    ---@field hourglass TextureRenderingInfo
    ---@field animation_timer integer
    ---@field woodpanel_slidedown_timer number

---@class ScreenConstellation : Screen
    ---@field sequence_state integer
    ---@field animation_timer integer
    ---@field constellation_text_opacity number

---@class ScreenRecap : Screen

---@class ScreenOnlineLoading : Screen
    ---@field ouroboros TextureRenderingInfo
    ---@field ouroboros_angle number

---@class ScreenOnlineLobby : Screen
    ---@field woodpanels_slidein_timer number
    ---@field scroll_unfurl_timer number
    ---@field woodpanel_bottom TextureRenderingInfo
    ---@field woodpanel_top TextureRenderingInfo
    ---@field left_scroll_handle TextureRenderingInfo
    ---@field right_scroll_handle TextureRenderingInfo
    ---@field scroll_text_id STRINGID
    ---@field btn_left_text_id STRINGID
    ---@field btn_right_text_id STRINGID
    ---@field btn_center_text_id STRINGID
    ---@field woodpanel_top_visible boolean
    ---@field woodpanel_bottom_visible boolean
    ---@field toggle_panels_slidein boolean
    ---@field players OnlineLobbyScreenPlayer[]
    ---@field background_image TextureRenderingInfo
    ---@field topleft_woodpanel_esc TextureRenderingInfo
    ---@field topleft_woodpanel_esc_slidein_timer number
    ---@field character_walk_offset number
    ---@field character_facing_left boolean
    ---@field move_direction integer
    ---@field character TextureRenderingInfo
    ---@field player_ready_icon TextureRenderingInfo
    ---@field arrow_left TextureRenderingInfo
    ---@field arrow_right TextureRenderingInfo
    ---@field arrow_left_hor_offset number
    ---@field arrow_right_hor_offset number
    ---@field platform_icon TextureRenderingInfo
    ---@field player_count integer
    ---@field searching_for_players boolean
    ---@field show_code_panel boolean
    ---@field enter_code_woodpanel_bottom_slidein_pos number
    ---@field enter_code_woodpanel_bottom TextureRenderingInfo
    ---@field enter_code_btn_right_text_id STRINGID
    ---@field enter_code_woodpanel_top_visible boolean
    ---@field enter_code_woodpanel_bottom_visible boolean
    ---@field enter_code_toggle_panels_slidein boolean
    ---@field selected_character integer
    ---@field characters_entered_count integer
    ---@field enter_code_topleft_woodpanel_esc_slidein_timer number
    ---@field enter_code_banner_text_id STRINGID
    ---@field enter_code_OK_text_id STRINGID
    ---@field enter_code_main_woodpanel_left TextureRenderingInfo
    ---@field enter_code_main_woodpanel_center TextureRenderingInfo
    ---@field enter_code_main_woodpanel_right TextureRenderingInfo
    ---@field enter_code_banner TextureRenderingInfo
    ---@field enter_code_char_cutouts TextureRenderingInfo
    ---@field enter_code_pointing_hand TextureRenderingInfo
    ---@field enter_code_buttons TextureRenderingInfo
    ---@field enter_code_OK_panel TextureRenderingInfo
    ---@field enter_code_OK_panel_slidein_timer number
    ---@field enter_code_your_code_scroll TextureRenderingInfo
    ---@field enter_code_your_code_scroll_left_handle TextureRenderingInfo
    ---@field enter_code_your_code_scroll_right_handle TextureRenderingInfo
    ---@field set_code fun(self, code: string): nil

---@class PauseUI
    ---@field menu_slidein_progress number
    ---@field blurred_background TextureRenderingInfo
    ---@field woodpanel_left TextureRenderingInfo
    ---@field woodpanel_middle TextureRenderingInfo
    ---@field woodpanel_right TextureRenderingInfo
    ---@field woodpanel_top TextureRenderingInfo
    ---@field scroll TextureRenderingInfo
    ---@field confirmation_panel TextureRenderingInfo
    ---@field previously_selected_menu_index integer
    ---@field visibility integer

---@class JournalUI
    ---@field state integer
    ---@field chapter_shown integer
    ---@field current_page integer
    ---@field flipping_to_page integer
    ---@field max_page_count integer
    ---@field book_background TextureRenderingInfo
    ---@field arrow_left TextureRenderingInfo
    ---@field arrow_right TextureRenderingInfo
    ---@field unknown23 TextureRenderingInfo
    ---@field entire_book TextureRenderingInfo
    ---@field page_timer integer

---@class JournalPage
    ---@field background TextureRenderingInfo
    ---@field page_number integer

---@class JournalPageProgress : JournalPage
    ---@field coffeestain_top TextureRenderingInfo

---@class JournalPageJournalMenu : JournalPage
    ---@field selected_menu_index integer
    ---@field journal_text_info TextRenderingInfo
    ---@field completion_badge TextureRenderingInfo

---@class JournalPageDiscoverable : JournalPage
    ---@field show_main_image boolean
    ---@field title_text_info TextRenderingInfo
    ---@field entry_text_info TextRenderingInfo
    ---@field chapter_title_text_info TextRenderingInfo

---@class JournalPagePlaces : JournalPageDiscoverable
    ---@field main_image TextureRenderingInfo

---@class JournalPagePeople : JournalPageDiscoverable
    ---@field character_background TextureRenderingInfo
    ---@field character_icon TextureRenderingInfo
    ---@field character_drawing TextureRenderingInfo

---@class JournalPageBestiary : JournalPageDiscoverable
    ---@field monster_background TextureRenderingInfo
    ---@field monster_icon TextureRenderingInfo
    ---@field defeated_killedby_black_bars TextureRenderingInfo
    ---@field defeated_text_info TextRenderingInfo
    ---@field defeated_value_text_info TextRenderingInfo
    ---@field killedby_text_info TextRenderingInfo
    ---@field killedby_value_text_info TextRenderingInfo

---@class JournalPageItems : JournalPageDiscoverable
    ---@field item_icon TextureRenderingInfo
    ---@field item_background TextureRenderingInfo

---@class JournalPageTraps : JournalPageDiscoverable
    ---@field trap_icon TextureRenderingInfo
    ---@field trap_background TextureRenderingInfo

---@class JournalPageStory : JournalPage

---@class JournalPageFeats : JournalPage
    ---@field chapter_title_text_info TextRenderingInfo
    ---@field feat_icons TextureRenderingInfo

---@class JournalPageDeathCause : JournalPage
    ---@field death_cause_text_info TextRenderingInfo

---@class JournalPageDeathMenu : JournalPage
    ---@field selected_menu_index integer
    ---@field game_over_text_info TextRenderingInfo
    ---@field level_text_info TextRenderingInfo
    ---@field level_value_text_info TextRenderingInfo
    ---@field money_text_info TextRenderingInfo
    ---@field money_value_text_info TextRenderingInfo
    ---@field time_text_info TextRenderingInfo
    ---@field time_value_text_info TextRenderingInfo

---@class JournalPageRecap : JournalPage

---@class JournalPagePlayerProfile : JournalPage
    ---@field player_icon TextureRenderingInfo
    ---@field player_icon_id integer
    ---@field player_profile_text_info TextRenderingInfo
    ---@field plays_text_info TextRenderingInfo
    ---@field plays_value_text_info TextRenderingInfo
    ---@field wins_text_info TextRenderingInfo
    ---@field wins_value_text_info TextRenderingInfo
    ---@field deaths_text_info TextRenderingInfo
    ---@field deaths_value_text_info TextRenderingInfo
    ---@field win_pct_text_info TextRenderingInfo
    ---@field win_pct_value_text_info TextRenderingInfo
    ---@field average_score_text_info TextRenderingInfo
    ---@field average_score_value_text_info TextRenderingInfo
    ---@field top_score_text_info TextRenderingInfo
    ---@field top_score_value_text_info TextRenderingInfo
    ---@field deepest_level_text_info TextRenderingInfo
    ---@field deepest_level_value_text_info TextRenderingInfo
    ---@field deadliest_level_text_info TextRenderingInfo
    ---@field deadliest_level_value_text_info TextRenderingInfo
    ---@field average_time_text_info TextRenderingInfo
    ---@field average_time_value_text_info TextRenderingInfo
    ---@field best_time_text_info TextRenderingInfo
    ---@field best_time_value_text_info TextRenderingInfo

---@class JournalPageLastGamePlayed : JournalPage
    ---@field main_image TextureRenderingInfo
    ---@field last_game_played_text_info TextRenderingInfo
    ---@field level_text_info TextRenderingInfo
    ---@field level_value_text_info TextRenderingInfo
    ---@field money_text_info TextRenderingInfo
    ---@field money_value_text_info TextRenderingInfo
    ---@field time_text_info TextRenderingInfo
    ---@field time_value_text_info TextRenderingInfo
    ---@field sticker_count integer
    ---@field stickers TextureRenderingInfo[]

---@class ScreenArenaMenu : Screen
    ---@field brick_background_animation ScreenZoomAnimation
    ---@field blurry_border_animation ScreenZoomAnimation
    ---@field top_woodpanel_slidein_timer number
    ---@field top_scroll_unfurl_timer number
    ---@field unknown13 TextureRenderingInfo
    ---@field woodpanel_top TextureRenderingInfo
    ---@field unknown15 TextureRenderingInfo
    ---@field left_scroll_handle TextureRenderingInfo
    ---@field right_scroll_handle TextureRenderingInfo
    ---@field scroll_text_id STRINGID
    ---@field unknown17_text_id STRINGID
    ---@field unknown18_text_id STRINGID
    ---@field unknown19_text_id STRINGID
    ---@field top_woodpanel_visible boolean
    ---@field bottom_woodpanel_visible boolean
    ---@field woodpanels_toggle boolean
    ---@field brick_background TextureRenderingInfo
    ---@field blurry_border TextureRenderingInfo
    ---@field blurry_border2 TextureRenderingInfo
    ---@field characters_drawing TextureRenderingInfo
    ---@field info_black_background TextureRenderingInfo
    ---@field main_panel_top_left_corner TextureRenderingInfo
    ---@field main_panel_top TextureRenderingInfo
    ---@field main_panel_top_right_corner TextureRenderingInfo
    ---@field main_panel_left TextureRenderingInfo
    ---@field main_panel_center TextureRenderingInfo
    ---@field main_panel_right TextureRenderingInfo
    ---@field main_panel_bottom_left_corner TextureRenderingInfo
    ---@field main_panel_bottom TextureRenderingInfo
    ---@field main_panel_bottom_right_corner TextureRenderingInfo
    ---@field rules_scroll TextureRenderingInfo
    ---@field black_option_boxes_left TextureRenderingInfo
    ---@field black_option_boxes_center TextureRenderingInfo
    ---@field black_option_boxes_right TextureRenderingInfo
    ---@field gold_option_outline TextureRenderingInfo
    ---@field option_icons TextureRenderingInfo
    ---@field option_left_arrow TextureRenderingInfo
    ---@field option_right_arrow TextureRenderingInfo
    ---@field bottom_left_bricks TextureRenderingInfo
    ---@field top_left_esc_panel TextureRenderingInfo
    ---@field next_panel TextureRenderingInfo
    ---@field center_panels_hor_slide_position number
    ---@field esc_next_panels_slide_timer number
    ---@field main_panel_vertical_scroll_position number
    ---@field selected_option_index integer

---@class ScreenZoomAnimation
    ---@field zoom_target number

---@class ScreenArenaStagesSelect : Screen
    ---@field woodenpanel_top_slidein_timer number
    ---@field woodenpanel_top_scroll_unfurl_timer number
    ---@field woodenpanel_top TextureRenderingInfo
    ---@field woodenpanel_top_left_scroll TextureRenderingInfo
    ---@field woodenpanel_top_right_scroll TextureRenderingInfo
    ---@field text_id_1 STRINGID
    ---@field text_id_2 STRINGID
    ---@field text_id_3 STRINGID
    ---@field text_id_4 STRINGID
    ---@field woodenpanel_top_visible boolean
    ---@field woodenpanel_bottom_visible boolean
    ---@field woodenpanels_toggle boolean
    ---@field buttons integer
    ---@field brick_background TextureRenderingInfo
    ---@field info_black_background TextureRenderingInfo
    ---@field woodenpanel_center TextureRenderingInfo
    ---@field blocky_level_representation TextureRenderingInfo
    ---@field theme_indicator TextureRenderingInfo
    ---@field bricks_bottom_left TextureRenderingInfo
    ---@field grid_background_row_0 TextureRenderingInfo
    ---@field grid_background_row_1 TextureRenderingInfo
    ---@field grid_background_row_2 TextureRenderingInfo
    ---@field grid_background_row_3 TextureRenderingInfo
    ---@field grid_background_row_4 TextureRenderingInfo
    ---@field grid_background_row_5 TextureRenderingInfo
    ---@field grid_background_row_6 TextureRenderingInfo
    ---@field grid_background_row_7 TextureRenderingInfo
    ---@field grid_background_disabled_cross TextureRenderingInfo
    ---@field grid_background_manipulators TextureRenderingInfo
    ---@field unknown21 TextureRenderingInfo
    ---@field grid_disabled_cross TextureRenderingInfo
    ---@field grid_yellow_highlighter TextureRenderingInfo
    ---@field woodpanel_esc TextureRenderingInfo
    ---@field woodpanel_fight TextureRenderingInfo
    ---@field big_player_drawing TextureRenderingInfo
    ---@field players_turn_scroll TextureRenderingInfo
    ---@field players_turn_scroll_handle TextureRenderingInfo
    ---@field grid_player_icon TextureRenderingInfo

---@class ScreenArenaItems : Screen
    ---@field woodpanel_top_slidein_timer number
    ---@field woodpanel_top_scroll_unfurl_timer number
    ---@field unknown9 TextureRenderingInfo
    ---@field woodpanel_top TextureRenderingInfo
    ---@field unknown11 TextureRenderingInfo
    ---@field top_scroll_left_handle TextureRenderingInfo
    ---@field top_scroll_right_handle TextureRenderingInfo
    ---@field scroll_text_id STRINGID
    ---@field text_id_2 STRINGID
    ---@field text_id_3 STRINGID
    ---@field text_id_4 STRINGID
    ---@field woodpanel_top_visible boolean
    ---@field woodpanel_bottom_visible boolean
    ---@field woodpanels_toggle boolean
    ---@field brick_background TextureRenderingInfo
    ---@field black_background_bottom_right TextureRenderingInfo
    ---@field woodpanel_bottom TextureRenderingInfo
    ---@field scroll_bottom TextureRenderingInfo
    ---@field scroll_right_handle_bottom TextureRenderingInfo
    ---@field held_item_crate_on_scroll TextureRenderingInfo
    ---@field held_item_on_scroll TextureRenderingInfo
    ---@field item_background TextureRenderingInfo
    ---@field toggles_background TextureRenderingInfo
    ---@field item_selection_gold_outline TextureRenderingInfo
    ---@field item_icons TextureRenderingInfo
    ---@field item_held_badge TextureRenderingInfo
    ---@field item_equipped_badge TextureRenderingInfo
    ---@field item_off_gray_overlay TextureRenderingInfo
    ---@field esc_woodpanel TextureRenderingInfo
    ---@field center_panels_horizontal_slide_position number
    ---@field esc_panel_slide_timer number
    ---@field selected_item_index integer

---@class ScreenArenaIntro : Screen
    ---@field players TextureRenderingInfo
    ---@field background_colors TextureRenderingInfo
    ---@field vertical_lines TextureRenderingInfo
    ---@field vertical_line_electricity_effect TextureRenderingInfo
    ---@field unknown_all_forced TextureRenderingInfo
    ---@field left_scroll TextureRenderingInfo
    ---@field right_scroll TextureRenderingInfo
    ---@field scroll_unfurl_timer number
    ---@field waiting boolean
    ---@field names_opacity number
    ---@field line_electricity_effect_timer number
    ---@field state integer
    ---@field countdown integer

---@class ScreenArenaLevel : Screen
    ---@field get_ready TextureRenderingInfo
    ---@field get_ready_gray_background TextureRenderingInfo
    ---@field get_ready_outline TextureRenderingInfo

---@class ScreenArenaScore : Screen
    ---@field woodpanel_slide_timer number
    ---@field scroll_unfurl_timer number
    ---@field unknown10 TextureRenderingInfo
    ---@field woodpanel TextureRenderingInfo
    ---@field unknown_all_forced TextureRenderingInfo
    ---@field woodpanel_left_scroll TextureRenderingInfo
    ---@field woodpanel_right_scroll TextureRenderingInfo
    ---@field text_id_1 STRINGID
    ---@field text_id_2 STRINGID
    ---@field woodpanel_visible boolean
    ---@field woodpanel_slide_toggle boolean
    ---@field animation_sequence integer
    ---@field background TextureRenderingInfo
    ---@field ok_panel TextureRenderingInfo
    ---@field ready_panel TextureRenderingInfo
    ---@field ready_speechbubble_indicator TextureRenderingInfo
    ---@field pillars TextureRenderingInfo
    ---@field bottom_lava TextureRenderingInfo
    ---@field players TextureRenderingInfo
    ---@field player_shadows TextureRenderingInfo
    ---@field unknown24 TextureRenderingInfo
    ---@field unknown25 TextureRenderingInfo
    ---@field score_counter TextureRenderingInfo
    ---@field unknown27 TextureRenderingInfo
    ---@field lava_bubbles TextureRenderingInfo
    ---@field player_won boolean[]
    ---@field victory_jump_y_pos number
    ---@field victory_jump_velocity number
    ---@field animation_frame integer
    ---@field squash_and_celebrate boolean
    ---@field player_ready boolean[]
    ---@field next_transition_timer integer
    ---@field player_bottom_pillar_offset number[]
    ---@field player_crushing_pillar_height number[]
    ---@field player_create_giblets boolean[]
    ---@field next_sidepanel_slidein_timer number


--## Constructors

Color = nil
---Create a new color - defaults to black
---@return Color
function Color.new(self) end
---@param Color Color
---@return Color
function Color.new(self, Color) end
---Create a new color by specifying its values
---@param r_ number
---@param g_ number
---@param b_ number
---@param a_ number
---@return Color
function Color.new(self, r_, g_, b_, a_) end

CustomTheme = nil
---Create a new theme with an id and base theme, overriding defaults. Check [theme fun(): anys that are default enabled here](https://github.com/spelunky-fyi/overlunky/blob/main/src/game_api/script/usertypes/level_lua.cpp).
---@param theme_id_ integer
---@param base_theme_ integer
---@param defaults boolean
---@return CustomTheme
function CustomTheme.new(self, theme_id_, base_theme_, defaults) end
---Create a new theme with defaults.
---@param theme_id_ integer
---@param base_theme_ integer
---@return CustomTheme
function CustomTheme.new(self, theme_id_, base_theme_) end
---Create a new theme with base dwelling and id 100.
---@return CustomTheme
function CustomTheme.new(self) end

Vec2 = nil
---@return Vec2
function Vec2.new(self) end
---@param Vec2 Vec2
---@return Vec2
function Vec2.new(self, Vec2) end
---@param x_ number
---@param y_ number
---@return Vec2
function Vec2.new(self, x_, y_) end
---@param number> p tuple<number,
---@return Vec2
function Vec2.new(self, number> p) end

AABB = nil
---Create a new axis aligned bounding box - defaults to all zeroes
---@return AABB
function AABB.new(self) end
---Copy an axis aligned bounding box
---@param AABB AABB
---@return AABB
function AABB.new(self, AABB) end
---Create a new axis aligned bounding box by specifying its values
---@param left_ number
---@param top_ number
---@param right_ number
---@param bottom_ number
---@return AABB
function AABB.new(self, left_, top_, right_, bottom_) end

Quad = nil
---@return Quad
function Quad.new(self) end
---@param Quad Quad
---@return Quad
function Quad.new(self, Quad) end
---@param bottom_left_ Vec2
---@param bottom_right_ Vec2
---@param top_right_ Vec2
---@param top_left_ Vec2
---@return Quad
function Quad.new(self, bottom_left_, bottom_right_, top_right_, top_left_) end
---@param _bottom_left_x number
---@param _bottom_left_y number
---@param _bottom_right_x number
---@param _bottom_right_y number
---@param _top_right_x number
---@param _top_right_y number
---@param _top_left_x number
---@param _top_left_y number
---@return Quad
function Quad.new(self, _bottom_left_x, _bottom_left_y, _bottom_right_x, _bottom_right_y, _top_right_x, _top_right_y, _top_left_x, _top_left_y) end
---@param AABB AABB
---@return Quad
function Quad.new(self, AABB) end

--## Enums


BUTTON = {
  BOMB = 4,
  DOOR = 32,
  JUMP = 1,
  ROPE = 8,
  RUN = 16,
  WHIP = 2
}
---@alias BUTTON integer
CAUSE_OF_DEATH = {
  DEATH = 0,
  ENTITY = 1,
  LONG_FALL = 2,
  MISSED = 4,
  POISONED = 5,
  STILL_FALLING = 3
}
---@alias CAUSE_OF_DEATH integer
CHAR_STATE = {
  ATTACKING = 12,
  CLIMBING = 6,
  DROPPING = 10,
  DUCKING = 5,
  DYING = 22,
  ENTERING = 19,
  EXITING = 21,
  FALLING = 9,
  FLAILING = 0,
  HANGING = 4,
  JUMPING = 8,
  LOADING = 20,
  PUSHING = 7,
  SITTING = 2,
  STANDING = 1,
  STUNNED = 18,
  THROWING = 17
}
---@alias CHAR_STATE integer
CONST = {
  ENGINE_FPS = 60,
  MAX_PLAYERS = 4,
  MAX_TILES_HORIZ = 86,
  MAX_TILES_VERT = 126,
  NOF_DRAW_DEPTHS = 53,
  ROOM_HEIGHT = 8,
  ROOM_WIDTH = 10
}
---@alias CONST integer
COSUBTHEME = {
  DWELLING = 0,
  ICE_CAVES = 5,
  JUNGLE = 1,
  NEO_BABYLON = 6,
  NONE = -1,
  RESET = -1,
  SUNKEN_CITY = 7,
  TEMPLE = 4,
  TIDE_POOL = 3,
  VOLCANA = 2
}
---@alias COSUBTHEME integer
DROP = {
  ALIENQUEEN_ALIENBLAST = 183,
  ALIENQUEEN_ALIENBLAST_RE = 185,
  ALIENQUEEN_ALIENBLAST_RI = 184,
  ALTAR_DICE_CLIMBINGGLOVES = 0,
  ALTAR_DICE_COOKEDTURKEY = 1,
  ALTAR_DICE_DIAMOND = 2,
  ALTAR_DICE_HIREDHAND = 10,
  ALTAR_DICE_MACHETE = 3,
  ALTAR_DICE_ROPEPILE = 4,
  ALTAR_DICE_SNAKE = 6,
  ALTAR_DICE_SPECTACLES = 5,
  ALTAR_DICE_TELEPACK = 7,
  ALTAR_DICE_VAMPIRE = 8,
  ALTAR_DICE_WEBGUN = 9,
  ALTAR_GIFT_BOMBBAG = 21,
  ALTAR_HIREDHAND_SHOTGUN = 20,
  ALTAR_IDOL_GOLDEN_MONKEY = 11,
  ALTAR_KAPALA = 12,
  ALTAR_PRESENT_EGGPLANT = 13,
  ALTAR_ROCK_WOODENARROW = 14,
  ALTAR_ROYAL_JELLY = 15,
  ALTAR_USHABTI_CAVEMAN = 16,
  ALTAR_USHABTI_HIREDHAND = 19,
  ALTAR_USHABTI_TURKEY = 17,
  ALTAR_USHABTI_VAMPIRE = 18,
  ANUBIS2_ANUBIS_COFFIN = 158,
  ANUBIS2_JETPACK = 22,
  ANUBIS2_SPECIALSHOT_R = 188,
  ANUBIS_COFFIN_SORCERESS = 110,
  ANUBIS_COFFIN_VAMPIRE = 109,
  ANUBIS_COFFIN_WITCHDOCTOR = 111,
  ANUBIS_SCEPTER = 23,
  ANUBIS_SPECIALSHOT_R = 187,
  ARROWTRAP_WOODENARROW = 155,
  AXOLOTL_BUBBLE = 176,
  BEG_BOMBBAG = 24,
  BEG_TELEPACK = 26,
  BEG_TRUECROWN = 25,
  BONEPILE_SKELETONKEY = 27,
  BONEPILE_SKULL = 28,
  CANDLE_NUGGET = 149,
  CATMUMMY_CURSINGCLOUD = 186,
  CATMUMMY_DIAMOND = 121,
  CHEST_BOMB = 140,
  CHEST_EMERALD = 135,
  CHEST_LEPRECHAUN = 139,
  CHEST_RUBY = 137,
  CHEST_SAPPHIRE = 136,
  CHEST_SMALLEMERALD = 134,
  CHEST_SMALLRUBY = 138,
  CLONEGUN_SHOT = 168,
  COBRA_ACIDSPIT = 179,
  COFFIN_SKULL = 152,
  COOKEDTURKEY_HEALTH = 190,
  COOKFIRE_TORCH = 150,
  CROCMAN_TELEPACK = 29,
  CROCMAN_TELEPORTER = 30,
  CRUSHTRAP_NUGGET = 131,
  CUTSCENE_GOLDCOIN = 147,
  DUATALTAR_BOMBBAG = 127,
  DUATALTAR_BOMBBOX = 128,
  DUATALTAR_COOKEDTURKEY = 129,
  EGGSAC_GRUB_1 = 114,
  EGGSAC_GRUB_2 = 115,
  EGGSAC_GRUB_3 = 116,
  EMBED_NUGGET = 133,
  FACTORY_GENERATOR_SCRAP = 93,
  FIREBUG_FIREBALL = 178,
  FLOORSTYLEDCOG_NUGGET = 130,
  FREEZERAY_SHOT = 167,
  GHIST_GOLDCOIN = 63,
  GHOSTJAR_DIAMOND = 31,
  GHOST_DIAMOND = 32,
  GIANTFOOD_HEALTH = 191,
  GIANTFROG_FROG = 112,
  GIANTFROG_TADPOLE = 113,
  GIANTSPIDER_PASTE = 33,
  GIANTSPIDER_WEBSHOT = 160,
  GOLDENMONKEY_NUGGET = 37,
  GOLDENMONKEY_SMALLEMERALD = 34,
  GOLDENMONKEY_SMALLRUBY = 36,
  GOLDENMONKEY_SMALLSAPPHIRE = 35,
  HANGINGSPIDER_WEBGUN = 38,
  HERMITCRAB_ACIDBUBBLE = 181,
  HUMPHEAD_HIREDHAND = 122,
  HUNDUN_FIREBALL = 177,
  ICECAVE_BOULDER = 39,
  JIANGSHIASSASSIN_SPIKESHOES = 40,
  JIANGSHI_SPRINGSHOES = 41,
  KAPALA_HEALTH = 193,
  KINGU_FEMALE_JIANGSHI = 45,
  KINGU_JIANGSHI = 44,
  KINGU_OCTOPUS = 43,
  KINGU_TABLETOFDESTINY = 42,
  LAMASSU_DIAMOND = 126,
  LAMASSU_EMERALD = 125,
  LAMASSU_LASERSHOT = 171,
  LAMASSU_RUBY = 124,
  LAMASSU_SAPPHIRE = 123,
  LASERTRAP_SHOT = 157,
  LAVAMANDER_RUBY = 120,
  LAVAPOT_MAGMAMAN = 119,
  LEPRECHAUN_CLOVER = 46,
  LOCKEDCHEST_UDJATEYE = 144,
  MADAME_TUSK_KEY = 108,
  MATTOCK_BROKENMATTOCK = 47,
  MOLE_MATTOCK = 48,
  MOSQUITO_HOVERPACK = 49,
  MOTHERSTATUE_HEALTH = 189,
  MUMMY_DIAMOND = 50,
  MUMMY_FLY = 159,
  NECROMANCER_RUBY = 51,
  OCTOPUS_INKSPIT = 180,
  OLMEC_BOMB = 161,
  OLMEC_CAVEMAN_1 = 52,
  OLMEC_CAVEMAN_2 = 53,
  OLMEC_CAVEMAN_3 = 54,
  OLMEC_SISTERS_BOMBBOX = 154,
  OLMEC_SISTERS_ROPEPILE = 153,
  OLMEC_UFO = 162,
  OSIRIS_EMERALDS = 55,
  OSIRIS_PORTAL = 57,
  OSIRIS_TABLETOFDESTINY = 56,
  PANGXIE_ACIDBUBBLE = 182,
  PANGXIE_WOODENSHIELD = 58,
  PLASMACANNON_SHOT = 166,
  POISONEDARROWTRAP_WOODENARROW = 156,
  POTOFGOLD_GOLDCOIN = 146,
  QILIN_FIREBALL = 175,
  QUEENBEE_ROYALJELLY = 59,
  QUILLBACK_BOMBBAG = 117,
  QUILLBACK_COOKEDTURKEY = 118,
  REDLANTERN_SMALLNUGGET = 148,
  ROBOT_METALSHIELD = 60,
  ROCKDOG_FIREBALL = 174,
  ROYALJELLY_HEALTH = 192,
  SACRIFICE_EGGPLANT = 104,
  SACRIFICE_IDOL = 101,
  SACRIFICE_PRESENT = 102,
  SACRIFICE_ROCK = 103,
  SCEPTER_ANUBISSPECIALSHOT = 164,
  SCEPTER_PLAYERSHOT = 165,
  SCRAP_ALIEN = 99,
  SCRAP_COBRA = 97,
  SCRAP_SCORPION = 98,
  SCRAP_SNAKE = 96,
  SCRAP_SPIDER = 95,
  SHOPKEEPER_GENERATOR_1 = 94,
  SHOPKEEPER_GOLDBAR = 62,
  SHOPKEEPER_GOLDCOIN = 61,
  SHOTGUN_BULLET = 169,
  SKELETON_SKELETONKEY = 64,
  SKELETON_SKULL = 65,
  SKULLDROPTRAP_SKULL = 151,
  SLIDINGWALL_NUGGET = 132,
  SORCERESS_DAGGERSHOT = 172,
  SORCERESS_RUBY = 66,
  SPARROW_ROPEPILE = 67,
  SPARROW_SKELETONKEY = 68,
  TIAMAT_BAT = 69,
  TIAMAT_BEE = 70,
  TIAMAT_CAVEMAN = 71,
  TIAMAT_COBRA = 72,
  TIAMAT_HERMITCRAB = 73,
  TIAMAT_MONKEY = 74,
  TIAMAT_MOSQUITO = 75,
  TIAMAT_OCTOPUS = 76,
  TIAMAT_OLMITE = 77,
  TIAMAT_SCORPION = 78,
  TIAMAT_SHOT = 79,
  TIAMAT_SNAKE = 80,
  TIAMAT_TIAMATSHOT = 173,
  TIAMAT_UFO = 81,
  TIAMAT_YETI = 82,
  TORCH_SMALLNUGGET = 83,
  TURKEY_COOKEDTURKEY = 84,
  UFO_ALIEN = 100,
  UFO_LASERSHOT = 170,
  UFO_PARACHUTE = 85,
  USHABTI_QILIN = 145,
  VAMPIRE_CAPE = 86,
  VAN_HORSING_COMPASS = 87,
  VAN_HORSING_DIAMOND = 88,
  VAULTCHEST_DIAMOND = 142,
  VAULTCHEST_EMERALD = 141,
  VAULTCHEST_RUBY = 143,
  VLAD_VLADSCAPE = 89,
  YAMA_EGGPLANTCROWN = 105,
  YAMA_GIANTFOOD = 106,
  YANG_KEY = 107,
  YETIKING_FREEZERAY = 90,
  YETIKING_ICESPIRE = 163,
  YETIQUEEN_POWERPACK = 91,
  YETI_PITCHERSMITT = 92
}
---@alias DROP integer
DROPCHANCE = {
  BONEBLOCK_SKELETONKEY = 0,
  CROCMAN_TELEPACK = 1,
  HANGINGSPIDER_WEBGUN = 2,
  JIANGSHIASSASSIN_SPIKESHOES = 3,
  JIANGSHI_SPRINGSHOES = 4,
  MOLE_MATTOCK = 5,
  MOSQUITO_HOVERPACK = 6,
  ROBOT_METALSHIELD = 7,
  SKELETON_SKELETONKEY = 8,
  UFO_PARACHUTE = 9,
  YETI_PITCHERSMITT = 10
}
---@alias DROPCHANCE integer
DYNAMIC_TEXTURE = {
  BACKGROUND = -4,
  BACKGROUND_DECORATION = -8,
  COFFIN = -10,
  DOOR = -6,
  DOOR_LAYER = -7,
  FLOOR = -5,
  INVISIBLE = -2,
  KALI_STATUE = -9
}
---@alias DYNAMIC_TEXTURE integer
ENT_FLAG = {
  CAN_BE_STOMPED = 15,
  CLIMBABLE = 9,
  COLLIDES_WALLS = 13,
  DEAD = 29,
  ENABLE_BUTTON_PROMPT = 20,
  FACING_LEFT = 17,
  HAS_BACKITEM = 32,
  INDESTRUCTIBLE_OR_SPECIAL_FLOOR = 2,
  INTERACT_WITH_SEMISOLIDS = 14,
  INTERACT_WITH_WATER = 11,
  INTERACT_WITH_WEBS = 21,
  INVISIBLE = 1,
  IS_PLATFORM = 8,
  LOCKED = 22,
  NO_GRAVITY = 10,
  PASSES_THROUGH_EVERYTHING = 5,
  PASSES_THROUGH_OBJECTS = 4,
  PASSES_THROUGH_PLAYER = 25,
  PAUSE_AI_AND_PHYSICS = 28,
  PICKUPABLE = 18,
  POWER_STOMPS = 16,
  SHOP_FLOOR = 24,
  SHOP_ITEM = 23,
  SOLID = 3,
  STUNNABLE = 12,
  TAKE_NO_DAMAGE = 6,
  THROWABLE_OR_KNOCKBACKABLE = 7,
  USABLE_ITEM = 19
}
---@alias ENT_FLAG integer
ENT_MORE_FLAG = {
  CURSED_EFFECT = 15,
  DISABLE_INPUT = 17,
  ELIXIR_BUFF = 16,
  FALLING = 14,
  HIRED_HAND_REVIVED = 2,
  HIT_GROUND = 12,
  HIT_WALL = 13,
  SWIMMING = 11
}
---@alias ENT_MORE_FLAG integer
ENT_TYPE = {
  ACIDBUBBLE = 1000,
  ACTIVEFLOOR_BONEBLOCK = 601,
  ACTIVEFLOOR_BOULDER = 599,
  ACTIVEFLOOR_BUBBLE_PLATFORM = 622,
  ACTIVEFLOOR_BUSHBLOCK = 602,
  ACTIVEFLOOR_CHAINEDPUSHBLOCK = 604,
  ACTIVEFLOOR_CHAINED_SPIKEBALL = 608,
  ACTIVEFLOOR_CRUSHING_ELEVATOR = 623,
  ACTIVEFLOOR_CRUSH_TRAP = 611,
  ACTIVEFLOOR_CRUSH_TRAP_LARGE = 612,
  ACTIVEFLOOR_DRILL = 610,
  ACTIVEFLOOR_EGGSHIPBLOCKER = 597,
  ACTIVEFLOOR_EGGSHIPPLATFORM = 596,
  ACTIVEFLOOR_ELEVATOR = 617,
  ACTIVEFLOOR_FALLING_PLATFORM = 607,
  ACTIVEFLOOR_GIANTCLAM_BASE = 618,
  ACTIVEFLOOR_KINGU_PLATFORM = 619,
  ACTIVEFLOOR_LIGHTARROWPLATFORM = 606,
  ACTIVEFLOOR_METALARROWPLATFORM = 605,
  ACTIVEFLOOR_OLMEC = 613,
  ACTIVEFLOOR_POWDERKEG = 603,
  ACTIVEFLOOR_PUSHBLOCK = 600,
  ACTIVEFLOOR_REGENERATINGBLOCK = 625,
  ACTIVEFLOOR_SHIELD = 624,
  ACTIVEFLOOR_SLIDINGWALL = 615,
  ACTIVEFLOOR_THINICE = 616,
  ACTIVEFLOOR_TIAMAT_PLATFORM = 620,
  ACTIVEFLOOR_TIAMAT_SHOULDERPLATFORM = 621,
  ACTIVEFLOOR_TIMEDPOWDERKEG = 614,
  ACTIVEFLOOR_UNCHAINED_SPIKEBALL = 609,
  ACTIVEFLOOR_WOODENLOG_TRAP = 598,
  ALIEN = 1001,
  ALTAR = 1002,
  AMMIT = 1003,
  ANKHPOWERUP = 1004,
  ANUBIS = 1005,
  APEPHEAD = 1006,
  APEPPART = 1007,
  ARROW = 1008,
  ARROWTRAP = 1009,
  AXOLOTL = 1010,
  AXOLOTLSHOT = 1011,
  BACKPACK = 1012,
  BAT = 1013,
  BEE = 1014,
  BEG = 1015,
  BGBACKLAYERDOOR = 1016,
  BGEGGSHIPROOM = 1017,
  BGFLOATINGDEBRIS = 1018,
  BGMOVINGSTAR = 1019,
  BGRELATIVEELEMENT = 1020,
  BGSHOOTINGSTAR = 1021,
  BGSHOPENTRENCE = 1022,
  BGSHOPKEEPERPRIME = 1023,
  BGSURFACELAYER = 1024,
  BGSURFACESTAR = 1025,
  BGTUTORIALSIGN = 1026,
  BG_ANUBIS_THRONE = 819,
  BG_BASECAMP_BUNKBED = 799,
  BG_BASECAMP_DININGTABLE_DISHES = 801,
  BG_BASECAMP_DRESSER = 798,
  BG_BASECAMP_SHORTCUTSTATIONBANNER = 802,
  BG_BASECAMP_SIDETABLE = 800,
  BG_BOULDER_STATUE = 828,
  BG_CONSTELLATION_CONNECTION = 776,
  BG_CONSTELLATION_FLASH = 772,
  BG_CONSTELLATION_GLOW = 775,
  BG_CONSTELLATION_HALO = 774,
  BG_CONSTELLATION_STAR = 773,
  BG_COSMIC_FARFLOATINGDEBRIS = 840,
  BG_COSMIC_FLOATINGDEBRIS = 839,
  BG_CROWN_STATUE = 818,
  BG_DOOR = 786,
  BG_DOORGEM = 797,
  BG_DOOR_BACK_LAYER = 788,
  BG_DOOR_BLACK_MARKET = 790,
  BG_DOOR_COG = 791,
  BG_DOOR_EGGPLANT_WORLD = 793,
  BG_DOOR_FRONT_LAYER = 787,
  BG_DOOR_GHIST_SHOP = 789,
  BG_DOOR_LARGE = 785,
  BG_DOOR_OLMEC_SHIP = 792,
  BG_DRILL_INDICATOR = 816,
  BG_DUAT_BLOODMOON = 825,
  BG_DUAT_FARFLOATINGDEBRIS = 827,
  BG_DUAT_FLOATINGDEBRIS = 826,
  BG_DUAT_LAYER = 822,
  BG_DUAT_PYRAMID_LAYER = 824,
  BG_DUAT_SIDE_DECORATION = 823,
  BG_EGGSAC_STAINS = 841,
  BG_EGGSHIP_ROOM = 777,
  BG_ENDINGTREASURE_HUNDUN_GOLD = 779,
  BG_ICE_CRYSTAL = 821,
  BG_KALI_STATUE = 809,
  BG_LEVEL_BACKWALL = 780,
  BG_LEVEL_BOMB_SOOT = 783,
  BG_LEVEL_COSMIC = 838,
  BG_LEVEL_DECO = 781,
  BG_LEVEL_POWEREDBOMB_SOOT = 784,
  BG_LEVEL_SHADOW = 782,
  BG_MOAI_STATUE = 829,
  BG_MOTHER_STATUE = 835,
  BG_OLMEC_PILLAR = 820,
  BG_OUROBORO = 796,
  BG_PALACE_CANDLE = 833,
  BG_PALACE_DISHES = 834,
  BG_PARENTSHIP_LANDINGLEG = 778,
  BG_SHOP = 803,
  BG_SHOPWANTEDPORTRAIT = 807,
  BG_SHOPWANTEDPOSTER = 806,
  BG_SHOP_BACKDOOR = 805,
  BG_SHOP_DICEPOSTER = 808,
  BG_SHOP_ENTRANCEDOOR = 804,
  BG_SPACE = 759,
  BG_SURFACE_BACKGROUNDSEAM = 771,
  BG_SURFACE_ENTITY = 769,
  BG_SURFACE_LAYER = 766,
  BG_SURFACE_LAYER_HOLE = 768,
  BG_SURFACE_LAYER_OCCLUDER = 767,
  BG_SURFACE_MOVING_STAR = 764,
  BG_SURFACE_NEBULA = 765,
  BG_SURFACE_OLMEC_LAYER = 770,
  BG_SURFACE_SHOOTING_STAR = 761,
  BG_SURFACE_SHOOTING_STAR_TRAIL = 762,
  BG_SURFACE_SHOOTING_STAR_TRAIL_PARTICLE = 763,
  BG_SURFACE_STAR = 760,
  BG_TUTORIAL_SIGN_BACK = 794,
  BG_TUTORIAL_SIGN_FRONT = 795,
  BG_UDJATSOCKET_DECORATION = 815,
  BG_VAT_BACK = 830,
  BG_VAT_FRONT = 832,
  BG_VAT_SHOPKEEPER_PRIME = 831,
  BG_VLAD_WINDOW = 817,
  BG_WATER_FOUNTAIN = 836,
  BG_YAMA_BODY = 837,
  BIGSPEARTRAP = 1027,
  BIRDIES = 1028,
  BODYGUARD = 1029,
  BOMB = 1030,
  BONEBLOCK = 1031,
  BOOMBOX = 1032,
  BOOMERANG = 1033,
  BOULDER = 1034,
  BOULDERSPAWNER = 1035,
  BULLET = 1036,
  BURNINGROPEEFFECT = 1037,
  BUTTON = 1038,
  CAMERAFLASH = 1039,
  CAPE = 1040,
  CATMUMMY = 1041,
  CAVEMAN = 1042,
  CAVEMANSHOPKEEPER = 1043,
  CHAIN = 1044,
  CHAINEDPUSHBLOCK = 1045,
  CHAR_AMAZON = 200,
  CHAR_ANA_SPELUNKY = 194,
  CHAR_AU = 207,
  CHAR_BANDA = 198,
  CHAR_CLASSIC_GUY = 213,
  CHAR_COCO_VON_DIAMONDS = 202,
  CHAR_COLIN_NORTHWARD = 196,
  CHAR_DEMI_VON_DIAMONDS = 208,
  CHAR_DIRK_YAMAOKA = 211,
  CHAR_EGGPLANT_CHILD = 216,
  CHAR_GREEN_GIRL = 199,
  CHAR_GUY_SPELUNKY = 212,
  CHAR_HIREDHAND = 215,
  CHAR_LISE_SYSTEM = 201,
  CHAR_MANFRED_TUNNEL = 203,
  CHAR_MARGARET_TUNNEL = 195,
  CHAR_OTAKU = 204,
  CHAR_PILOT = 209,
  CHAR_PRINCESS_AIRYN = 210,
  CHAR_ROFFY_D_SLOTH = 197,
  CHAR_TINA_FLAN = 205,
  CHAR_VALERIE_CRUMP = 206,
  CHEST = 1046,
  CINEMATICANCHOR = 1047,
  CITYOFGOLDDOOR = 1048,
  CLAMBASE = 1049,
  CLAW = 1050,
  CLIMBABLEROPE = 1051,
  CLONEGUNSHOT = 1052,
  COBRA = 1053,
  COFFIN = 1054,
  COIN = 1055,
  CONTAINER = 1056,
  CONVEYORBELT = 1057,
  COOKFIRE = 1058,
  CRABMAN = 1059,
  CRITTER = 1060,
  CRITTERBEETLE = 1061,
  CRITTERBUTTERFLY = 1062,
  CRITTERCRAB = 1063,
  CRITTERDRONE = 1064,
  CRITTERFIREFLY = 1065,
  CRITTERFISH = 1066,
  CRITTERLOCUST = 1067,
  CRITTERPENGUIN = 1068,
  CRITTERSLIME = 1069,
  CRITTERSNAIL = 1070,
  CROCMAN = 1071,
  CROSSBEAM = 1072,
  CRUSHTRAP = 1073,
  CURSEDEFFECT = 1074,
  CURSEDPOT = 1075,
  DECORATEDDOOR = 1076,
  DECORATION_BABYLON = 127,
  DECORATION_BABYLONBUSH = 138,
  DECORATION_BABYLON_FLOWER = 141,
  DECORATION_BABYLON_HANGING_FLOWER = 144,
  DECORATION_BABYLON_NEON_SIGN = 145,
  DECORATION_BASECAMPDOGSIGN = 152,
  DECORATION_BASECAMPSIGN = 151,
  DECORATION_BEEHIVE = 162,
  DECORATION_BG_TRANSITIONCOVER = 128,
  DECORATION_BONEBLOCK = 121,
  DECORATION_BORDER = 115,
  DECORATION_BRANCH = 146,
  DECORATION_BUSHBLOCK = 122,
  DECORATION_CHAINANDBLOCKS_CHAINDECORATION = 163,
  DECORATION_COG = 169,
  DECORATION_CONVEYORBELT_RAILING = 164,
  DECORATION_CROSS_BEAM = 131,
  DECORATION_DUAT = 171,
  DECORATION_DUAT_DARKSAND = 173,
  DECORATION_DUAT_DESTRUCTIBLE_BG = 174,
  DECORATION_DUAT_SAND = 172,
  DECORATION_DWELLINGBUSH = 136,
  DECORATION_EGGPLANT_ALTAR = 180,
  DECORATION_GENERIC = 116,
  DECORATION_GUTS = 179,
  DECORATION_HANGING_BANNER = 134,
  DECORATION_HANGING_HIDE = 132,
  DECORATION_HANGING_SEAWEED = 133,
  DECORATION_HANGING_WIRES = 135,
  DECORATION_JUNGLE = 119,
  DECORATION_JUNGLEBUSH = 137,
  DECORATION_JUNGLE_FLOWER = 140,
  DECORATION_JUNGLE_HANGING_FLOWER = 143,
  DECORATION_KELP = 166,
  DECORATION_LARGETOMB = 185,
  DECORATION_MINEWOOD = 120,
  DECORATION_MINEWOOD_POLE = 129,
  DECORATION_MOTHERSHIP = 170,
  DECORATION_MOTHER_STATUE_HAND = 181,
  DECORATION_MUSHROOM_HAT = 160,
  DECORATION_PAGODA = 125,
  DECORATION_PAGODA_POLE = 130,
  DECORATION_PALACE = 175,
  DECORATION_PALACE_CHANDELIER = 177,
  DECORATION_PALACE_PORTRAIT = 178,
  DECORATION_PALACE_SIGN = 176,
  DECORATION_PIPE = 182,
  DECORATION_POTOFGOLD_RAINBOW = 189,
  DECORATION_REGENERATING_BORDER = 187,
  DECORATION_REGENERATING_SMALL_BLOCK = 186,
  DECORATION_SHOPFORE = 148,
  DECORATION_SHOPSIGN = 149,
  DECORATION_SHOPSIGNICON = 150,
  DECORATION_SKULLDROP_TRAP = 188,
  DECORATION_SLIDINGWALL_CHAINDECORATION = 167,
  DECORATION_SPIKES_BLOOD = 147,
  DECORATION_STONE = 123,
  DECORATION_SUNKEN = 126,
  DECORATION_SUNKEN_BRIDGE = 183,
  DECORATION_SURFACE = 117,
  DECORATION_SURFACE_COVER = 118,
  DECORATION_TEMPLE = 124,
  DECORATION_TEMPLE_SAND = 168,
  DECORATION_THORN_VINE = 161,
  DECORATION_TIDEPOOLBUSH = 139,
  DECORATION_TIDEPOOL_CORAL = 142,
  DECORATION_TOMB = 184,
  DECORATION_TREE = 153,
  DECORATION_TREETRUNK_BROKEN = 157,
  DECORATION_TREETRUNK_CLIMBINGHINT = 154,
  DECORATION_TREETRUNK_TOPBACK = 156,
  DECORATION_TREETRUNK_TOPFRONT = 155,
  DECORATION_TREE_VINE = 159,
  DECORATION_TREE_VINE_TOP = 158,
  DECORATION_VLAD = 165,
  DECOREGENERATINGBLOCK = 1077,
  DESTRUCTIBLEBG = 1078,
  DMALIENBLAST = 1079,
  DMSPAWNING = 1080,
  DOOR = 1081,
  DRILL = 1082,
  DUSTWALLAPEP = 1083,
  EGGPLANTMINISTER = 1084,
  EGGPLANTTHROWER = 1085,
  EGGSAC = 1086,
  EGGSHIPCENTERJETFLAME = 1087,
  EGGSHIPDOOR = 1088,
  EGGSHIPDOORS = 1089,
  ELEVATOR = 1090,
  EMBED_GOLD = 190,
  EMBED_GOLD_BIG = 191,
  EMPRESSGRAVE = 1091,
  ENTITY = 1092,
  EXCALIBUR = 1093,
  EXITDOOR = 1094,
  EXPLOSION = 1095,
  FALLINGPLATFORM = 1096,
  FIREBALL = 1097,
  FIREBUG = 1098,
  FIREBUGUNCHAINED = 1099,
  FIREFROG = 1100,
  FISH = 1101,
  FLAME = 1102,
  FLAMESIZE = 1103,
  FLOOR = 1104,
  FLOORSTYLED_BABYLON = 106,
  FLOORSTYLED_BEEHIVE = 108,
  FLOORSTYLED_COG = 110,
  FLOORSTYLED_DUAT = 112,
  FLOORSTYLED_GUTS = 114,
  FLOORSTYLED_MINEWOOD = 102,
  FLOORSTYLED_MOTHERSHIP = 111,
  FLOORSTYLED_PAGODA = 105,
  FLOORSTYLED_PALACE = 113,
  FLOORSTYLED_STONE = 103,
  FLOORSTYLED_SUNKEN = 107,
  FLOORSTYLED_TEMPLE = 104,
  FLOORSTYLED_VLAD = 109,
  FLOOR_ALTAR = 47,
  FLOOR_ARROW_TRAP = 40,
  FLOOR_BASECAMP_DININGTABLE = 8,
  FLOOR_BASECAMP_LONGTABLE = 9,
  FLOOR_BASECAMP_SINGLEBED = 7,
  FLOOR_BIGSPEAR_TRAP = 79,
  FLOOR_BORDERTILE = 1,
  FLOOR_BORDERTILE_METAL = 2,
  FLOOR_BORDERTILE_OCTOPUS = 3,
  FLOOR_CHAINANDBLOCKS_CEILING = 61,
  FLOOR_CHAINANDBLOCKS_CHAIN = 62,
  FLOOR_CHAIN_CEILING = 63,
  FLOOR_CHALLENGE_ENTRANCE = 87,
  FLOOR_CHALLENGE_WAITROOM = 88,
  FLOOR_CLIMBING_POLE = 20,
  FLOOR_CONVEYORBELT_LEFT = 64,
  FLOOR_CONVEYORBELT_RIGHT = 65,
  FLOOR_DICE_FORCEFIELD = 86,
  FLOOR_DOOR_COG = 31,
  FLOOR_DOOR_EGGPLANT_WORLD = 36,
  FLOOR_DOOR_EGGSHIP = 33,
  FLOOR_DOOR_EGGSHIP_ATREZZO = 34,
  FLOOR_DOOR_EGGSHIP_ROOM = 35,
  FLOOR_DOOR_ENTRANCE = 22,
  FLOOR_DOOR_EXIT = 23,
  FLOOR_DOOR_GHISTSHOP = 28,
  FLOOR_DOOR_LAYER = 26,
  FLOOR_DOOR_LAYER_DROP_HELD = 27,
  FLOOR_DOOR_LOCKED = 29,
  FLOOR_DOOR_LOCKED_PEN = 30,
  FLOOR_DOOR_MAIN_EXIT = 24,
  FLOOR_DOOR_MOAI_STATUE = 32,
  FLOOR_DOOR_PLATFORM = 37,
  FLOOR_DOOR_STARTING_EXIT = 25,
  FLOOR_DUAT_ALTAR = 71,
  FLOOR_DUSTWALL = 70,
  FLOOR_EGGPLANT_ALTAR = 74,
  FLOOR_EMPRESS_GRAVE = 96,
  FLOOR_EXCALIBUR_STONE = 69,
  FLOOR_FACTORY_GENERATOR = 66,
  FLOOR_FORCEFIELD = 85,
  FLOOR_FORCEFIELD_TOP = 90,
  FLOOR_GENERIC = 4,
  FLOOR_GIANTFROG_PLATFORM = 83,
  FLOOR_GROWABLE_CLIMBING_POLE = 21,
  FLOOR_GROWABLE_VINE = 19,
  FLOOR_HORIZONTAL_FORCEFIELD = 91,
  FLOOR_HORIZONTAL_FORCEFIELD_TOP = 92,
  FLOOR_ICE = 72,
  FLOOR_IDOL_BLOCK = 48,
  FLOOR_IDOL_TRAP_CEILING = 49,
  FLOOR_JUNGLE = 10,
  FLOOR_JUNGLE_SPEAR_TRAP = 43,
  FLOOR_LADDER = 15,
  FLOOR_LADDER_PLATFORM = 16,
  FLOOR_LASER_TRAP = 45,
  FLOOR_LION_TRAP = 44,
  FLOOR_MOAI_PLATFORM = 75,
  FLOOR_MOTHER_STATUE = 81,
  FLOOR_MOTHER_STATUE_PLATFORM = 82,
  FLOOR_MUSHROOM_BASE = 55,
  FLOOR_MUSHROOM_HAT_PLATFORM = 58,
  FLOOR_MUSHROOM_TOP = 57,
  FLOOR_MUSHROOM_TRUNK = 56,
  FLOOR_PAGODA_PLATFORM = 14,
  FLOOR_PALACE_BOOKCASE_PLATFORM = 100,
  FLOOR_PALACE_CHANDELIER_PLATFORM = 99,
  FLOOR_PALACE_TABLE_PLATFORM = 97,
  FLOOR_PALACE_TRAY_PLATFORM = 98,
  FLOOR_PEN = 93,
  FLOOR_PIPE = 78,
  FLOOR_PLATFORM = 13,
  FLOOR_POISONED_ARROW_TRAP = 41,
  FLOOR_QUICKSAND = 68,
  FLOOR_SHOPKEEPER_GENERATOR = 76,
  FLOOR_SLIDINGWALL_CEILING = 67,
  FLOOR_SPARK_TRAP = 46,
  FLOOR_SPIKEBALL_CEILING = 60,
  FLOOR_SPIKES = 38,
  FLOOR_SPIKES_UPSIDEDOWN = 39,
  FLOOR_SPRING_TRAP = 73,
  FLOOR_STICKYTRAP_CEILING = 80,
  FLOOR_STORAGE = 50,
  FLOOR_SUNCHALLENGE_GENERATOR = 77,
  FLOOR_SURFACE = 5,
  FLOOR_SURFACE_HIDDEN = 6,
  FLOOR_TELEPORTINGBORDER = 84,
  FLOOR_TENTACLE_BOTTOM = 101,
  FLOOR_THORN_VINE = 59,
  FLOOR_TIMED_FORCEFIELD = 89,
  FLOOR_TOMB = 94,
  FLOOR_TOTEM_TRAP = 42,
  FLOOR_TREE_BASE = 51,
  FLOOR_TREE_BRANCH = 54,
  FLOOR_TREE_TOP = 53,
  FLOOR_TREE_TRUNK = 52,
  FLOOR_TUNNEL_CURRENT = 11,
  FLOOR_TUNNEL_NEXT = 12,
  FLOOR_VINE = 17,
  FLOOR_VINE_TREE_TOP = 18,
  FLOOR_YAMA_PLATFORM = 95,
  FLY = 1105,
  FLYHEAD = 1106,
  FORCEFIELD = 1107,
  FORESTSISTER = 1108,
  FROG = 1109,
  FROSTBREATHEFFECT = 1110,
  FROZENLIQUID = 1111,
  FXALIENBLAST = 1112,
  FXANKHBROKENPIECE = 1113,
  FXANKHROTATINGSPARK = 1114,
  FXCOMPASS = 1115,
  FXEMPRESS = 1116,
  FXFIREFLYLIGHT = 1117,
  FXHUNDUNNECKPIECE = 1118,
  FXJELLYFISHSTAR = 1119,
  FXJETPACKFLAME = 1120,
  FXKINGUSLIDING = 1121,
  FXLAMASSUATTACK = 1122,
  FXMAINEXITDOOR = 1123,
  FXNECROMANCERANKH = 1124,
  FXOUROBORODRAGONPART = 1125,
  FXOUROBOROOCCLUDER = 1126,
  FXPICKUPEFFECT = 1127,
  FXPLAYERINDICATOR = 1128,
  FXQUICKSAND = 1129,
  FXSALECONTAINER = 1130,
  FXSHOTGUNBLAST = 1131,
  FXSORCERESSATTACK = 1132,
  FXSPARKSMALL = 1133,
  FXSPRINGTRAPRING = 1134,
  FXTIAMATHEAD = 1135,
  FXTIAMATTAIL = 1136,
  FXTIAMATTORSO = 1137,
  FXTORNJOURNALPAGE = 1138,
  FXUNDERWATERBUBBLE = 1139,
  FXVATBUBBLE = 1140,
  FXWATERDROP = 1141,
  FXWEBBEDEFFECT = 1142,
  FXWITCHDOCTORHINT = 1143,
  FX_ALIENBLAST = 694,
  FX_ALIENBLAST_RETICULE_EXTERNAL = 693,
  FX_ALIENBLAST_RETICULE_INTERNAL = 692,
  FX_ALIENQUEEN_EYE = 691,
  FX_ALIENQUEEN_EYEBALL = 690,
  FX_ANKH_BACKGLOW = 752,
  FX_ANKH_BROKENPIECE = 755,
  FX_ANKH_FALLINGSPARK = 751,
  FX_ANKH_FRONTGLOW = 753,
  FX_ANKH_LIGHTBEAM = 754,
  FX_ANKH_ROTATINGSPARK = 750,
  FX_ANUBIS_SPECIAL_SHOT_RETICULE = 735,
  FX_APEP_FIRE = 681,
  FX_APEP_MOUTHPIECE = 682,
  FX_AXOLOTL_HEAD_ENTERING_DOOR = 742,
  FX_BASECAMP_COUCH_ARM = 743,
  FX_BIRDIES = 636,
  FX_BUTTON = 670,
  FX_BUTTON_DIALOG = 671,
  FX_CINEMATIC_BLACKBAR = 663,
  FX_COMPASS = 646,
  FX_CRITTERFIREFLY_LIGHT = 741,
  FX_CRUSHINGELEVATOR_DECO = 717,
  FX_CRUSHINGELEVATOR_FILL = 716,
  FX_DIEINDICATOR = 711,
  FX_DRILL_TURNING = 683,
  FX_EGGSHIP_CENTERJETFLAME = 630,
  FX_EGGSHIP_DOOR = 629,
  FX_EGGSHIP_HOOK_CHAIN = 745,
  FX_EGGSHIP_JETFLAME = 631,
  FX_EGGSHIP_SHADOW = 632,
  FX_EGGSHIP_SHELL = 628,
  FX_EMPRESS = 744,
  FX_EXPLOSION = 637,
  FX_HORIZONTALLASERBEAM = 714,
  FX_HUNDUN_EGG_CRACK = 721,
  FX_HUNDUN_EYE = 726,
  FX_HUNDUN_EYEBALL = 725,
  FX_HUNDUN_EYELID = 724,
  FX_HUNDUN_LIMB_CALF = 719,
  FX_HUNDUN_LIMB_FOOT = 720,
  FX_HUNDUN_LIMB_THIGH = 718,
  FX_HUNDUN_NECK_PIECE = 722,
  FX_HUNDUN_WING = 723,
  FX_INK_BLINDNESS = 673,
  FX_INK_SPLAT = 674,
  FX_JETPACKFLAME = 657,
  FX_KINGU_HEAD = 685,
  FX_KINGU_LIMB = 688,
  FX_KINGU_PLATFORM = 687,
  FX_KINGU_SHADOW = 686,
  FX_KINGU_SLIDING = 689,
  FX_LAMASSU_ATTACK = 740,
  FX_LASERBEAM = 713,
  FX_LAVA_BUBBLE = 675,
  FX_LAVA_GLOW = 676,
  FX_LEADER_FLAG = 684,
  FX_MAIN_EXIT_DOOR = 635,
  FX_MECH_COLLAR = 736,
  FX_MEGAJELLYFISH_BOTTOM = 732,
  FX_MEGAJELLYFISH_CROWN = 728,
  FX_MEGAJELLYFISH_EYE = 729,
  FX_MEGAJELLYFISH_FLIPPER = 731,
  FX_MEGAJELLYFISH_STAR = 730,
  FX_MEGAJELLYFISH_TAIL = 733,
  FX_MEGAJELLYFISH_TAIL_BG = 734,
  FX_MINIGAME_SHIP_CENTERJETFLAME = 747,
  FX_MINIGAME_SHIP_DOOR = 746,
  FX_MINIGAME_SHIP_JETFLAME = 748,
  FX_MODERNEXPLOSION = 639,
  FX_NECROMANCER_ANKH = 661,
  FX_OLMECPART_FLOATER = 664,
  FX_OLMECPART_LARGE = 665,
  FX_OLMECPART_MEDIUM = 666,
  FX_OLMECPART_SMALL = 667,
  FX_OLMECPART_SMALLEST = 668,
  FX_OUROBORO_HEAD = 641,
  FX_OUROBORO_OCCLUDER = 640,
  FX_OUROBORO_TAIL = 642,
  FX_OUROBORO_TEXT = 643,
  FX_OUROBORO_TRAIL = 644,
  FX_PICKUPEFFECT = 655,
  FX_PLAYERINDICATOR = 648,
  FX_PLAYERINDICATORPORTRAIT = 649,
  FX_PORTAL = 727,
  FX_POWEREDEXPLOSION = 638,
  FX_QUICKSAND_DUST = 737,
  FX_QUICKSAND_RUBBLE = 738,
  FX_SALEDIALOG_CONTAINER = 651,
  FX_SALEDIALOG_ICON = 654,
  FX_SALEDIALOG_TITLE = 652,
  FX_SALEDIALOG_VALUE = 653,
  FX_SALEICON = 650,
  FX_SHADOW = 633,
  FX_SHOTGUNBLAST = 656,
  FX_SLEEP_BUBBLE = 672,
  FX_SMALLFLAME = 658,
  FX_SORCERESS_ATTACK = 739,
  FX_SPARK = 695,
  FX_SPARK_SMALL = 696,
  FX_SPECIALCOMPASS = 647,
  FX_SPRINGTRAP_RING = 659,
  FX_STORAGE_INDICATOR = 712,
  FX_TELEPORTSHADOW = 662,
  FX_TIAMAT_ARM_LEFT1 = 704,
  FX_TIAMAT_ARM_LEFT2 = 705,
  FX_TIAMAT_ARM_LEFT3 = 706,
  FX_TIAMAT_ARM_RIGHT1 = 707,
  FX_TIAMAT_ARM_RIGHT2 = 708,
  FX_TIAMAT_HEAD = 710,
  FX_TIAMAT_NECK = 709,
  FX_TIAMAT_TAIL = 699,
  FX_TIAMAT_TAIL_DECO1 = 700,
  FX_TIAMAT_TAIL_DECO2 = 701,
  FX_TIAMAT_TAIL_DECO3 = 702,
  FX_TIAMAT_THRONE = 697,
  FX_TIAMAT_TORSO = 703,
  FX_TIAMAT_WAIST = 698,
  FX_TORNJOURNALPAGE = 634,
  FX_UNDERWATER_BUBBLE = 677,
  FX_VAT_BUBBLE = 715,
  FX_WATER_DROP = 678,
  FX_WATER_SPLASH = 679,
  FX_WATER_SURFACE = 680,
  FX_WEBBEDEFFECT = 669,
  FX_WITCHDOCTOR_HINT = 660,
  GENERATOR = 1144,
  GHIST = 1145,
  GHOST = 1146,
  GHOSTBREATH = 1147,
  GIANTCLAMTOP = 1148,
  GIANTFISH = 1149,
  GIANTFLY = 1150,
  GIANTFROG = 1151,
  GOLDBAR = 1152,
  GOLDMONKEY = 1153,
  GRUB = 1154,
  GUN = 1155,
  HANGANCHOR = 1156,
  HANGSPIDER = 1157,
  HANGSTRAND = 1158,
  HERMITCRAB = 1159,
  HONEY = 1160,
  HORIZONTALFORCEFIELD = 1161,
  HORNEDLIZARD = 1162,
  HOVERPACK = 1163,
  HUNDUN = 1164,
  HUNDUNCHEST = 1165,
  HUNDUNHEAD = 1166,
  ICESLIDINGSOUND = 1167,
  IDOL = 1168,
  IMP = 1169,
  ITEM_ACIDBUBBLE = 391,
  ITEM_ACIDSPIT = 389,
  ITEM_ALIVE_EMBEDDED_ON_ICE = 463,
  ITEM_ANUBIS_COFFIN = 453,
  ITEM_AUTOWALLTORCH = 415,
  ITEM_AXOLOTL_BUBBLESHOT = 456,
  ITEM_BASECAMP_TUTORIAL_SIGN = 408,
  ITEM_BIG_SPEAR = 364,
  ITEM_BLOOD = 352,
  ITEM_BOMB = 347,
  ITEM_BONES = 483,
  ITEM_BOOMBOX = 409,
  ITEM_BOOMERANG = 583,
  ITEM_BROKENEXCALIBUR = 586,
  ITEM_BROKEN_ARROW = 372,
  ITEM_BROKEN_MATTOCK = 428,
  ITEM_BULLET = 424,
  ITEM_CAMERA = 580,
  ITEM_CAPE = 564,
  ITEM_CHAIN = 431,
  ITEM_CHAIN_LASTPIECE = 432,
  ITEM_CHEST = 395,
  ITEM_CLIMBABLE_ROPE = 350,
  ITEM_CLONEGUN = 589,
  ITEM_CLONEGUNSHOT = 426,
  ITEM_COFFIN = 435,
  ITEM_CONSTRUCTION_SIGN = 405,
  ITEM_COOKFIRE = 484,
  ITEM_CRABMAN_ACIDBUBBLE = 392,
  ITEM_CRABMAN_CLAW = 393,
  ITEM_CRABMAN_CLAWCHAIN = 394,
  ITEM_CRATE = 402,
  ITEM_CROSSBOW = 579,
  ITEM_CURSEDPOT = 481,
  ITEM_CURSING_CLOUD = 440,
  ITEM_DEPLOYED_PARACHUTE = 464,
  ITEM_DIAMOND = 497,
  ITEM_DICE_BET = 449,
  ITEM_DICE_PRIZE_DISPENSER = 450,
  ITEM_DIE = 448,
  ITEM_DMCRATE = 403,
  ITEM_EGGPLANT = 487,
  ITEM_EGGSAC = 492,
  ITEM_EGGSHIP = 353,
  ITEM_EGGSHIP_HOOK = 455,
  ITEM_EMERALD = 498,
  ITEM_EMERALD_SMALL = 503,
  ITEM_EMPRESS_GRAVE = 470,
  ITEM_ENDINGTREASURE_HUNDUN = 398,
  ITEM_ENDINGTREASURE_TIAMAT = 397,
  ITEM_EXCALIBUR = 585,
  ITEM_FIREBALL = 385,
  ITEM_FLAMETHROWER_FIREBALL = 387,
  ITEM_FLOATING_ORB = 491,
  ITEM_FLY = 436,
  ITEM_FREEZERAY = 578,
  ITEM_FREEZERAYSHOT = 425,
  ITEM_FROZEN_LIQUID = 462,
  ITEM_GHIST_PRESENT = 423,
  ITEM_GIANTCLAM_TOP = 445,
  ITEM_GIANTFLY_HEAD = 467,
  ITEM_GIANTSPIDER_WEBSHOT = 368,
  ITEM_GOLDBAR = 495,
  ITEM_GOLDBARS = 496,
  ITEM_GOLDCOIN = 502,
  ITEM_HANGANCHOR = 370,
  ITEM_HANGSTRAND = 369,
  ITEM_HOLDTHEIDOL = 359,
  ITEM_HONEY = 444,
  ITEM_HORIZONTALLASERBEAM = 452,
  ITEM_HOUYIBOW = 590,
  ITEM_HOVERPACK = 572,
  ITEM_HUNDUN_FIREBALL = 386,
  ITEM_ICECAGE = 427,
  ITEM_ICESPIRE = 488,
  ITEM_IDOL = 356,
  ITEM_INKSPIT = 390,
  ITEM_JETPACK = 567,
  ITEM_JETPACK_MECH = 568,
  ITEM_JUNGLE_SPEAR_COSMETIC = 361,
  ITEM_JUNGLE_SPEAR_DAMAGING = 362,
  ITEM_KEY = 399,
  ITEM_LAMASSU_LASER_SHOT = 380,
  ITEM_LAMP = 418,
  ITEM_LAMPFLAME = 419,
  ITEM_LANDMINE = 439,
  ITEM_LASERBEAM = 451,
  ITEM_LASERTRAP_SHOT = 382,
  ITEM_LAVAPOT = 485,
  ITEM_LEAF = 388,
  ITEM_LIGHT_ARROW = 374,
  ITEM_LION_SPEAR = 363,
  ITEM_LITWALLTORCH = 414,
  ITEM_LOCKEDCHEST = 400,
  ITEM_LOCKEDCHEST_KEY = 401,
  ITEM_MACHETE = 584,
  ITEM_MADAMETUSK_IDOL = 357,
  ITEM_MADAMETUSK_IDOLNOTE = 358,
  ITEM_MATTOCK = 582,
  ITEM_METAL_ARROW = 373,
  ITEM_METAL_SHIELD = 592,
  ITEM_MINIGAME_ASTEROID = 477,
  ITEM_MINIGAME_ASTEROID_BG = 476,
  ITEM_MINIGAME_BROKEN_ASTEROID = 478,
  ITEM_MINIGAME_SHIP = 474,
  ITEM_MINIGAME_UFO = 475,
  ITEM_NUGGET = 501,
  ITEM_NUGGET_SMALL = 506,
  ITEM_OLMECCANNON_BOMBS = 437,
  ITEM_OLMECCANNON_UFO = 438,
  ITEM_OLMECSHIP = 355,
  ITEM_PALACE_CANDLE = 489,
  ITEM_PALACE_CANDLE_FLAME = 468,
  ITEM_PARENTSSHIP = 354,
  ITEM_PASTEBOMB = 348,
  ITEM_PICKUP_12BAG = 515,
  ITEM_PICKUP_24BAG = 516,
  ITEM_PICKUP_ANKH = 539,
  ITEM_PICKUP_BOMBBAG = 513,
  ITEM_PICKUP_BOMBBOX = 514,
  ITEM_PICKUP_CLIMBINGGLOVES = 525,
  ITEM_PICKUP_CLOVER = 521,
  ITEM_PICKUP_COMPASS = 530,
  ITEM_PICKUP_COOKEDTURKEY = 518,
  ITEM_PICKUP_CROWN = 536,
  ITEM_PICKUP_EGGPLANTCROWN = 537,
  ITEM_PICKUP_ELIXIR = 520,
  ITEM_PICKUP_GIANTFOOD = 519,
  ITEM_PICKUP_HEDJET = 535,
  ITEM_PICKUP_JOURNAL = 510,
  ITEM_PICKUP_KAPALA = 534,
  ITEM_PICKUP_PARACHUTE = 532,
  ITEM_PICKUP_PASTE = 529,
  ITEM_PICKUP_PITCHERSMITT = 526,
  ITEM_PICKUP_PLAYERBAG = 543,
  ITEM_PICKUP_ROPE = 511,
  ITEM_PICKUP_ROPEPILE = 512,
  ITEM_PICKUP_ROYALJELLY = 517,
  ITEM_PICKUP_SEEDEDRUNSUNLOCKER = 522,
  ITEM_PICKUP_SKELETON_KEY = 541,
  ITEM_PICKUP_SPECIALCOMPASS = 531,
  ITEM_PICKUP_SPECTACLES = 524,
  ITEM_PICKUP_SPIKESHOES = 528,
  ITEM_PICKUP_SPRINGSHOES = 527,
  ITEM_PICKUP_TABLETOFDESTINY = 540,
  ITEM_PICKUP_TORNJOURNALPAGE = 509,
  ITEM_PICKUP_TRUECROWN = 538,
  ITEM_PICKUP_UDJATEYE = 533,
  ITEM_PLASMACANNON = 587,
  ITEM_PLASMACANNON_SHOT = 375,
  ITEM_PLAYERGHOST = 446,
  ITEM_PLAYERGHOST_BREATH = 447,
  ITEM_POT = 480,
  ITEM_POTOFGOLD = 457,
  ITEM_POWERPACK = 574,
  ITEM_POWERUP_ANKH = 560,
  ITEM_POWERUP_CLIMBING_GLOVES = 546,
  ITEM_POWERUP_COMPASS = 554,
  ITEM_POWERUP_CROWN = 557,
  ITEM_POWERUP_EGGPLANTCROWN = 558,
  ITEM_POWERUP_HEDJET = 556,
  ITEM_POWERUP_KAPALA = 549,
  ITEM_POWERUP_PARACHUTE = 553,
  ITEM_POWERUP_PASTE = 545,
  ITEM_POWERUP_PITCHERSMITT = 551,
  ITEM_POWERUP_SKELETON_KEY = 562,
  ITEM_POWERUP_SPECIALCOMPASS = 555,
  ITEM_POWERUP_SPECTACLES = 550,
  ITEM_POWERUP_SPIKE_SHOES = 547,
  ITEM_POWERUP_SPRING_SHOES = 548,
  ITEM_POWERUP_TABLETOFDESTINY = 561,
  ITEM_POWERUP_TRUECROWN = 559,
  ITEM_POWERUP_UDJATEYE = 552,
  ITEM_PRESENT = 422,
  ITEM_PUNISHBALL = 429,
  ITEM_PUNISHCHAIN = 430,
  ITEM_PURCHASABLE_CAPE = 566,
  ITEM_PURCHASABLE_HOVERPACK = 573,
  ITEM_PURCHASABLE_JETPACK = 569,
  ITEM_PURCHASABLE_POWERPACK = 575,
  ITEM_PURCHASABLE_TELEPORTER_BACKPACK = 571,
  ITEM_REDLANTERN = 420,
  ITEM_REDLANTERNFLAME = 421,
  ITEM_ROCK = 365,
  ITEM_ROPE = 349,
  ITEM_RUBBLE = 645,
  ITEM_RUBY = 500,
  ITEM_RUBY_SMALL = 505,
  ITEM_SAPPHIRE = 499,
  ITEM_SAPPHIRE_SMALL = 504,
  ITEM_SCEPTER = 588,
  ITEM_SCEPTER_ANUBISSHOT = 376,
  ITEM_SCEPTER_ANUBISSPECIALSHOT = 377,
  ITEM_SCEPTER_PLAYERSHOT = 378,
  ITEM_SCRAP = 486,
  ITEM_SHORTCUT_SIGN = 406,
  ITEM_SHOTGUN = 577,
  ITEM_SKULL = 482,
  ITEM_SKULLDROPTRAP = 461,
  ITEM_SKULLDROPTRAP_SKULL = 490,
  ITEM_SLIDINGWALL_CHAIN = 433,
  ITEM_SLIDINGWALL_CHAIN_LASTPIECE = 434,
  ITEM_SLIDINGWALL_SWITCH = 465,
  ITEM_SLIDINGWALL_SWITCH_REWARD = 466,
  ITEM_SNAP_TRAP = 469,
  ITEM_SORCERESS_DAGGER_SHOT = 381,
  ITEM_SPARK = 383,
  ITEM_SPEEDRUN_SIGN = 407,
  ITEM_SPIKES = 454,
  ITEM_STICKYTRAP_BALL = 460,
  ITEM_STICKYTRAP_LASTPIECE = 459,
  ITEM_STICKYTRAP_PIECE = 458,
  ITEM_TELEPORTER = 581,
  ITEM_TELEPORTER_BACKPACK = 570,
  ITEM_TELESCOPE = 411,
  ITEM_TENTACLE = 471,
  ITEM_TENTACLE_LAST_PIECE = 473,
  ITEM_TENTACLE_PIECE = 472,
  ITEM_TIAMAT_SHOT = 384,
  ITEM_TORCH = 416,
  ITEM_TORCHFLAME = 417,
  ITEM_TOTEM_SPEAR = 360,
  ITEM_TURKEY_NECK = 443,
  ITEM_TUTORIAL_MONSTER_SIGN = 404,
  ITEM_TV = 410,
  ITEM_UDJAT_SOCKET = 441,
  ITEM_UFO_LASER_SHOT = 379,
  ITEM_UNROLLED_ROPE = 351,
  ITEM_USHABTI = 442,
  ITEM_VAULTCHEST = 396,
  ITEM_VLADS_CAPE = 565,
  ITEM_WALLTORCH = 412,
  ITEM_WALLTORCHFLAME = 413,
  ITEM_WEB = 366,
  ITEM_WEBGUN = 576,
  ITEM_WEBSHOT = 367,
  ITEM_WHIP = 345,
  ITEM_WHIP_FLAME = 346,
  ITEM_WOODEN_ARROW = 371,
  ITEM_WOODEN_SHIELD = 591,
  JETPACK = 1170,
  JIANGSHI = 1171,
  JUMPDOG = 1172,
  JUNGLESPEARCOSMETIC = 1173,
  JUNGLETRAPTRIGGER = 1174,
  KAPALAPOWERUP = 1175,
  KINGU = 1176,
  LAHAMU = 1177,
  LAMASSU = 1178,
  LAMPFLAME = 1179,
  LANDMINE = 1180,
  LASERBEAM = 1181,
  LASERTRAP = 1182,
  LAVA = 1183,
  LAVAMANDER = 1184,
  LEAF = 1185,
  LEPRECHAUN = 1186,
  LIGHTARROW = 1187,
  LIGHTARROWPLATFORM = 1188,
  LIGHTEMITTER = 1189,
  LIGHTSHOT = 1190,
  LIMBANCHOR = 1191,
  LIQUID = 1192,
  LIQUIDSURFACE = 1193,
  LIQUID_COARSE_LAVA = 915,
  LIQUID_COARSE_WATER = 910,
  LIQUID_IMPOSTOR_LAKE = 911,
  LIQUID_IMPOSTOR_LAVA = 914,
  LIQUID_LAVA = 912,
  LIQUID_STAGNANT_LAVA = 913,
  LIQUID_WATER = 909,
  LOCKEDDOOR = 1194,
  LOGICALANCHOVYFLOCK = 1195,
  LOGICALCONVEYORBELTSOUND = 1196,
  LOGICALDOOR = 1197,
  LOGICALDRAIN = 1198,
  LOGICALLIQUIDSTREAMSOUND = 1199,
  LOGICALMINIGAME = 1200,
  LOGICALREGENERATINGBLOCK = 1201,
  LOGICALSOUND = 1202,
  LOGICALSTATICSOUND = 1203,
  LOGICALTRAPTRIGGER = 1204,
  LOGICAL_ANCHOVY_FLOCK = 873,
  LOGICAL_ARROW_TRAP_TRIGGER = 849,
  LOGICAL_BIGSPEAR_TRAP_TRIGGER = 884,
  LOGICAL_BLACKMARKET_DOOR = 848,
  LOGICAL_BOULDERSPAWNER = 880,
  LOGICAL_BURNING_ROPE_EFFECT = 863,
  LOGICAL_CAMERA_ANCHOR = 859,
  LOGICAL_CAMERA_FLASH = 865,
  LOGICAL_CINEMATIC_ANCHOR = 862,
  LOGICAL_CONSTELLATION = 844,
  LOGICAL_CONVEYORBELT_SOUND_SOURCE = 872,
  LOGICAL_CRUSH_TRAP_TRIGGER = 853,
  LOGICAL_CURSED_EFFECT = 858,
  LOGICAL_DM_ALIEN_BLAST = 889,
  LOGICAL_DM_CAMERA_ANCHOR = 887,
  LOGICAL_DM_CRATE_SPAWNING = 890,
  LOGICAL_DM_DEATH_MIST = 888,
  LOGICAL_DM_IDOL_SPAWNING = 891,
  LOGICAL_DM_SPAWN_POINT = 886,
  LOGICAL_DOOR = 846,
  LOGICAL_DOOR_AMBIENT_SOUND = 847,
  LOGICAL_DUSTWALL_APEP = 864,
  LOGICAL_DUSTWALL_SOUND_SOURCE = 877,
  LOGICAL_EGGPLANT_THROWER = 894,
  LOGICAL_FROST_BREATH = 893,
  LOGICAL_ICESLIDING_SOUND_SOURCE = 878,
  LOGICAL_JUNGLESPEAR_TRAP_TRIGGER = 851,
  LOGICAL_LAVA_DRAIN = 882,
  LOGICAL_LIMB_ANCHOR = 867,
  LOGICAL_MINIGAME = 895,
  LOGICAL_MUMMYFLIES_SOUND_SOURCE = 874,
  LOGICAL_ONFIRE_EFFECT = 856,
  LOGICAL_OUROBORO_CAMERA_ANCHOR = 860,
  LOGICAL_OUROBORO_CAMERA_ANCHOR_ZOOMIN = 861,
  LOGICAL_PIPE_TRAVELER_SOUND_SOURCE = 879,
  LOGICAL_PLATFORM_SPAWNER = 885,
  LOGICAL_POISONED_EFFECT = 857,
  LOGICAL_PORTAL = 868,
  LOGICAL_QUICKSAND_AMBIENT_SOUND_SOURCE = 875,
  LOGICAL_QUICKSAND_SOUND_SOURCE = 876,
  LOGICAL_REGENERATING_BLOCK = 883,
  LOGICAL_ROOM_LIGHT = 866,
  LOGICAL_SHOOTING_STARS_SPAWNER = 845,
  LOGICAL_SPIKEBALL_TRIGGER = 852,
  LOGICAL_SPLASH_BUBBLE_GENERATOR = 892,
  LOGICAL_STATICLAVA_SOUND_SOURCE = 869,
  LOGICAL_STREAMLAVA_SOUND_SOURCE = 870,
  LOGICAL_STREAMWATER_SOUND_SOURCE = 871,
  LOGICAL_TENTACLE_TRIGGER = 854,
  LOGICAL_TOTEM_TRAP_TRIGGER = 850,
  LOGICAL_WATER_DRAIN = 881,
  LOGICAL_WET_EFFECT = 855,
  MAGMAMAN = 1205,
  MAINEXIT = 1206,
  MANTRAP = 1207,
  MATTOCK = 1208,
  MECH = 1209,
  MEGAJELLYFISH = 1210,
  MIDBG = 810,
  MIDBG_BEEHIVE = 813,
  MIDBG_PALACE_STYLEDDECORATION = 812,
  MIDBG_PLATFORM_STRUCTURE = 814,
  MIDBG_STYLEDDECORATION = 811,
  MINIGAMEASTEROID = 1211,
  MINIGAMESHIP = 1212,
  MINIGAMESHIPOFFSET = 1213,
  MOLE = 1214,
  MONKEY = 1215,
  MONSTER = 1216,
  MONS_ALIEN = 267,
  MONS_ALIENQUEEN = 271,
  MONS_AMMIT = 280,
  MONS_ANUBIS = 253,
  MONS_ANUBIS2 = 259,
  MONS_APEP_BODY = 255,
  MONS_APEP_HEAD = 254,
  MONS_APEP_TAIL = 256,
  MONS_BAT = 224,
  MONS_BEE = 278,
  MONS_BODYGUARD = 306,
  MONS_CATMUMMY = 251,
  MONS_CAVEMAN = 225,
  MONS_CAVEMAN_BOSS = 232,
  MONS_CAVEMAN_SHOPKEEPER = 226,
  MONS_COBRA = 248,
  MONS_CRABMAN = 311,
  MONS_CRITTERANCHOVY = 335,
  MONS_CRITTERBUTTERFLY = 332,
  MONS_CRITTERCRAB = 336,
  MONS_CRITTERDRONE = 340,
  MONS_CRITTERDUNGBEETLE = 331,
  MONS_CRITTERFIREFLY = 339,
  MONS_CRITTERFISH = 334,
  MONS_CRITTERLOCUST = 337,
  MONS_CRITTERPENGUIN = 338,
  MONS_CRITTERSLIME = 341,
  MONS_CRITTERSNAIL = 333,
  MONS_CROCMAN = 247,
  MONS_EGGPLANT_MINISTER = 290,
  MONS_FEMALE_JIANGSHI = 261,
  MONS_FIREBUG = 241,
  MONS_FIREBUG_UNCHAINED = 242,
  MONS_FIREFROG = 284,
  MONS_FISH = 262,
  MONS_FROG = 283,
  MONS_GHIST = 314,
  MONS_GHIST_SHOPKEEPER = 315,
  MONS_GHOST = 317,
  MONS_GHOST_MEDIUM_HAPPY = 319,
  MONS_GHOST_MEDIUM_SAD = 318,
  MONS_GHOST_SMALL_ANGRY = 320,
  MONS_GHOST_SMALL_HAPPY = 323,
  MONS_GHOST_SMALL_SAD = 321,
  MONS_GHOST_SMALL_SURPRISED = 322,
  MONS_GIANTFISH = 265,
  MONS_GIANTFLY = 288,
  MONS_GIANTFROG = 285,
  MONS_GIANTSPIDER = 223,
  MONS_GOLDMONKEY = 309,
  MONS_GRUB = 286,
  MONS_HANGSPIDER = 222,
  MONS_HERMITCRAB = 264,
  MONS_HORNEDLIZARD = 230,
  MONS_HUNDUN = 292,
  MONS_HUNDUNS_SERVANT = 307,
  MONS_HUNDUN_BIRDHEAD = 293,
  MONS_HUNDUN_SNAKEHEAD = 294,
  MONS_IMP = 243,
  MONS_JIANGSHI = 260,
  MONS_JUMPDOG = 289,
  MONS_KINGU = 281,
  MONS_LAMASSU = 274,
  MONS_LAVAMANDER = 244,
  MONS_LEPRECHAUN = 310,
  MONS_MADAMETUSK = 305,
  MONS_MAGMAMAN = 239,
  MONS_MANTRAP = 233,
  MONS_MARLA_TUNNEL = 299,
  MONS_MEGAJELLYFISH = 312,
  MONS_MEGAJELLYFISH_BACKGROUND = 313,
  MONS_MERCHANT = 297,
  MONS_MOLE = 231,
  MONS_MONKEY = 238,
  MONS_MOSQUITO = 237,
  MONS_MUMMY = 249,
  MONS_NECROMANCER = 252,
  MONS_OCTOPUS = 263,
  MONS_OLD_HUNTER = 303,
  MONS_OLMITE_BODYARMORED = 276,
  MONS_OLMITE_HELMET = 275,
  MONS_OLMITE_NAKED = 277,
  MONS_OSIRIS_HAND = 258,
  MONS_OSIRIS_HEAD = 257,
  MONS_PET_CAT = 327,
  MONS_PET_DOG = 326,
  MONS_PET_HAMSTER = 328,
  MONS_PET_TUTORIAL = 219,
  MONS_PROTOSHOPKEEPER = 272,
  MONS_QUEENBEE = 279,
  MONS_REDSKELETON = 228,
  MONS_ROBOT = 240,
  MONS_SCARAB = 295,
  MONS_SCORPION = 229,
  MONS_SHOPKEEPER = 296,
  MONS_SHOPKEEPERCLONE = 273,
  MONS_SISTER_PARMESAN = 302,
  MONS_SISTER_PARSLEY = 300,
  MONS_SISTER_PARSNIP = 301,
  MONS_SKELETON = 227,
  MONS_SNAKE = 220,
  MONS_SORCERESS = 250,
  MONS_SPIDER = 221,
  MONS_STORAGEGUY = 308,
  MONS_TADPOLE = 287,
  MONS_THIEF = 304,
  MONS_TIAMAT = 282,
  MONS_TIKIMAN = 234,
  MONS_UFO = 266,
  MONS_VAMPIRE = 245,
  MONS_VLAD = 246,
  MONS_WITCHDOCTOR = 235,
  MONS_WITCHDOCTORSKULL = 236,
  MONS_YAMA = 291,
  MONS_YANG = 298,
  MONS_YETI = 268,
  MONS_YETIKING = 269,
  MONS_YETIQUEEN = 270,
  MOSQUITO = 1217,
  MOTHERSTATUE = 1218,
  MOUNT = 1219,
  MOUNT_AXOLOTL = 901,
  MOUNT_BASECAMP_CHAIR = 905,
  MOUNT_BASECAMP_COUCH = 906,
  MOUNT_MECH = 902,
  MOUNT_QILIN = 903,
  MOUNT_ROCKDOG = 900,
  MOUNT_TURKEY = 899,
  MOVABLE = 1220,
  MOVINGICON = 1221,
  MUMMY = 1222,
  MUMMYFLIESSOUND = 1223,
  NECROMANCER = 1224,
  NPC = 1225,
  OCTOPUS = 1226,
  OLMEC = 1227,
  OLMECCANNON = 1228,
  OLMECFLOATER = 1229,
  OLMITE = 1230,
  ONFIREEFFECT = 1231,
  ORB = 1232,
  OSIRISHAND = 1233,
  OSIRISHEAD = 1234,
  OUROBOROCAMERAANCHOR = 1235,
  OUROBOROCAMERAZOOMIN = 1236,
  PALACESIGN = 1237,
  PARACHUTEPOWERUP = 1238,
  PET = 1239,
  PIPE = 1240,
  PIPETRAVELERSOUND = 1241,
  PLAYER = 1242,
  PLAYERBAG = 1243,
  PLAYERGHOST = 1244,
  POISONEDEFFECT = 1245,
  POLEDECO = 1246,
  PORTAL = 1247,
  POT = 1248,
  POWERUP = 1249,
  POWERUPCAPABLE = 1250,
  PROTOSHOPKEEPER = 1251,
  PUNISHBALL = 1252,
  PUSHBLOCK = 1253,
  QILIN = 1254,
  QUICKSAND = 1255,
  QUICKSANDSOUND = 1256,
  QUILLBACK = 1257,
  REGENBLOCK = 1258,
  ROBOT = 1259,
  ROCKDOG = 1260,
  ROLLINGITEM = 1261,
  ROOMLIGHT = 1262,
  ROOMOWNER = 1263,
  RUBBLE = 1264,
  SCARAB = 1265,
  SCEPTERSHOT = 1266,
  SCORPION = 1267,
  SHIELD = 1268,
  SHOOTINGSTARSPAWNER = 1269,
  SHOPKEEPER = 1270,
  SKELETON = 1271,
  SKULLDROPTRAP = 1272,
  SLEEPBUBBLE = 1273,
  SLIDINGWALLCEILING = 1274,
  SNAPTRAP = 1275,
  SORCERESS = 1276,
  SOUNDSHOT = 1277,
  SPARK = 1278,
  SPARKTRAP = 1279,
  SPEAR = 1280,
  SPECIALSHOT = 1281,
  SPIDER = 1282,
  SPIKEBALLTRAP = 1283,
  SPLASHBUBBLEGENERATOR = 1284,
  STICKYTRAP = 1285,
  STRETCHCHAIN = 1286,
  SWITCH = 1287,
  TADPOLE = 1288,
  TELEPORTER = 1289,
  TELEPORTERBACKPACK = 1290,
  TELEPORTINGBORDER = 1291,
  TELESCOPE = 1292,
  TENTACLE = 1293,
  TENTACLEBOTTOM = 1294,
  TERRA = 1295,
  THINICE = 1296,
  TIAMAT = 1297,
  TIAMATSHOT = 1298,
  TIMEDFORCEFIELD = 1299,
  TIMEDPOWDERKEG = 1300,
  TIMEDSHOT = 1301,
  TORCH = 1302,
  TORCHFLAME = 1303,
  TOTEMTRAP = 1304,
  TRANSFERFLOOR = 1305,
  TRAPPART = 1306,
  TREASURE = 1307,
  TREASUREHOOK = 1308,
  TRUECROWNPOWERUP = 1310,
  TUN = 1311,
  TV = 1312,
  UDJATSOCKET = 1313,
  UFO = 1314,
  UNCHAINEDSPIKEBALL = 1315,
  USHABTI = 1316,
  VAMPIRE = 1317,
  VANHORSING = 1318,
  VLAD = 1319,
  VLADSCAPE = 1320,
  WADDLER = 1321,
  WALKINGMONSTER = 1322,
  WALLTORCH = 1323,
  WEBSHOT = 1324,
  WETEFFECT = 1325,
  WITCHDOCTOR = 1326,
  WITCHDOCTORSKULL = 1327,
  WOODENLOGTRAP = 1328,
  YAMA = 1329,
  YANG = 1330,
  YELLOWCAPE = 1331,
  YETIKING = 1332,
  YETIQUEEN = 1333
}
---@alias ENT_TYPE integer
FLOOR_SIDE = {
  BOTTOM = 1,
  BOTTOM_LEFT = 6,
  BOTTOM_RIGHT = 7,
  LEFT = 2,
  RIGHT = 3,
  TOP = 0,
  TOP_LEFT = 4,
  TOP_RIGHT = 5
}
---@alias FLOOR_SIDE integer
GAME_SETTING = {
  ANGRY_SHOPKEEPER = 28,
  BRIGHTNESS = 10,
  BRIGHT_FLASHES = 41,
  BUTTON_PROMPTS = 30,
  BUTTON_TEXTURE = 31,
  CLASSIC_AGGRO_MUSIC = 29,
  CROSSPLAY = 42,
  CROSSPROGRESS_AUTOSYNC = 47,
  CROSSPROGRESS_ENABLED = 46,
  CURRENT_PROFILE = 18,
  DIALOG_TEXT = 37,
  FEAT_POPUPS = 32,
  FREQUENCY_DENOMINATOR = 5,
  FREQUENCY_NUMERATOR = 4,
  GHOST_TEXT = 39,
  HUD_SIZE = 24,
  HUD_STYLE = 23,
  INPUT_DELAY = 43,
  INSTANT_RESTART = 22,
  KALI_TEXT = 38,
  LANGUAGE = 40,
  LEVEL_FEELINGS = 36,
  LEVEL_NUMBER = 27,
  LEVEL_TIMER = 25,
  MASTER_ENABLED = 15,
  MASTER_VOLUME = 16,
  MONITOR = 8,
  MUSIC_ENABLED = 13,
  MUSIC_VOLUME = 14,
  OUTPUT_DELAY = 44,
  OVERSCAN = 17,
  PET_STYLE = 20,
  PREV_LANGUAGE = 19,
  PSEUDONYMIZATION = 45,
  RESOLUTIONX = 2,
  RESOLUTIONY = 3,
  RESOLUTION_SCALE = 1,
  SCREEN_SHAKE = 21,
  SOUND_ENABLED = 11,
  SOUND_VOLUME = 12,
  TEXTBOX_DURATION = 34,
  TEXTBOX_OPACITY = 35,
  TEXTBOX_SIZE = 33,
  TIMER_DETAIL = 26,
  VFX = 9,
  VSYNC = 7,
  WINDOW_MODE = 6,
  WINDOW_SCALE = 0
}
---@alias GAME_SETTING integer
GHOST_BEHAVIOR = {
  MEDIUM_HAPPY = 1,
  MEDIUM_SAD = 0,
  SAD = 0,
  SMALL_ANGRY = 0,
  SMALL_HAPPY = 3,
  SMALL_SAD = 2,
  SMALL_SURPRISED = 1
}
---@alias GHOST_BEHAVIOR integer
HUNDUNFLAGS = {
  BIRDHEADEMERGED = 2,
  BIRDHEADSHOTLAST = 16,
  SNAKEHEADEMERGED = 4,
  TOPLEVELARENAREACHED = 8,
  WILLMOVELEFT = 1
}
---@alias HUNDUNFLAGS integer
INPUTS = {
  BOMB = 4,
  DOOR = 32,
  DOWN = 2048,
  JOURNAL = 128,
  JUMP = 1,
  LEFT = 256,
  MENU = 64,
  NONE = 0,
  RIGHT = 512,
  ROPE = 8,
  RUN = 16,
  UP = 1024,
  WHIP = 2
}
---@alias INPUTS integer
JOURNALUI_PAGE_SHOWN = {
  BESTIARY = 5,
  DEATH = 10,
  ITEMS = 6,
  JOURNAL = 2,
  PEOPLE = 4,
  PLACES = 3,
  PLAYER_PROFILE = 1,
  RECAP = 9,
  STORY = 8,
  TRAPS = 7
}
---@alias JOURNALUI_PAGE_SHOWN integer
JOURNALUI_STATE = {
  FADING_IN = 1,
  FADING_OUT = 5,
  FLIPPING_LEFT = 3,
  FLIPPING_RIGHT = 4,
  INVISIBLE = 0,
  STABLE = 2
}
---@alias JOURNALUI_STATE integer
JOURNAL_PAGE_TYPE = {
  BESTIARY = 4,
  DEATH_CAUSE = 9,
  DEATH_MENU = 10,
  FEATS = 8,
  ITEMS = 5,
  JOURNAL_MENU = 1,
  LAST_GAME_PLAYED = 13,
  PEOPLE = 3,
  PLACES = 2,
  PLAYER_PROFILE = 12,
  PROGRESS = 0,
  RECAP = 11,
  STORY = 7,
  TRAPS = 6
}
---@alias JOURNAL_PAGE_TYPE integer
JUNGLESISTERS = {
  GREAT_PARTY_HUH = 5,
  I_WISH_BROUGHT_A_JACKET = 6,
  PARMESAN_RESCUED = 3,
  PARSLEY_RESCUED = 1,
  PARSNIP_RESCUED = 2,
  WARNING_ONE_WAY_DOOR = 4
}
---@alias JUNGLESISTERS integer
LAYER = {
  BACK = 1,
  BOTH = -128,
  FRONT = 0,
  PLAYER = -1,
  PLAYER1 = -1,
  PLAYER2 = -2,
  PLAYER3 = -3,
  PLAYER4 = -4
}
---@alias LAYER integer
LEVEL_CONFIG = {
  ALTAR_ROOM_CHANCE = 5,
  BACKGROUND_CHANCE = 9,
  BACK_ROOM_CHANCE = 0,
  BACK_ROOM_HIDDEN_DOOR_CACHE_CHANCE = 3,
  BACK_ROOM_HIDDEN_DOOR_CHANCE = 2,
  BACK_ROOM_INTERCONNECTION_CHANCE = 1,
  FLAGGED_LIQUID_ROOMS = 16,
  FLOOR_BOTTOM_SPREAD_CHANCE = 8,
  FLOOR_SIDE_SPREAD_CHANCE = 7,
  GROUND_BACKGROUND_CHANCE = 10,
  IDOL_ROOM_CHANCE = 6,
  MACHINE_BIGROOM_CHANCE = 11,
  MACHINE_REWARDROOM_CHANCE = 14,
  MACHINE_TALLROOM_CHANCE = 13,
  MACHINE_WIDEROOM_CHANCE = 12,
  MAX_LIQUID_PARTICLES = 15,
  MOUNT_CHANCE = 4
}
---@alias LEVEL_CONFIG integer
LIQUID_POOL = {
  COARSE_LAVA = 4,
  COARSE_WATER = 2,
  LAVA = 3,
  STAGNANT_LAVA = 5,
  WATER = 1
}
---@alias LIQUID_POOL integer
MASK = {
  ACTIVEFLOOR = 128,
  ANY = 0,
  BG = 1024,
  DECORATION = 512,
  EXPLOSION = 16,
  FLOOR = 256,
  FX = 64,
  ITEM = 8,
  LAVA = 16384,
  LIQUID = 24576,
  LOGICAL = 4096,
  MONSTER = 4,
  MOUNT = 2,
  PLAYER = 1,
  ROPE = 32,
  SHADOW = 2048,
  WATER = 8192
}
---@alias MASK integer
ON = {
  ARENA_INTRO = 25,
  ARENA_MATCH = 26,
  ARENA_MENU = 21,
  ARENA_SCORE = 27,
  CAMP = 11,
  CHARACTER_SELECT = 9,
  CONSTELLATION = 19,
  CREDITS = 17,
  DEATH = 14,
  FRAME = 101,
  GAMEFRAME = 108,
  GUIFRAME = 100,
  INTRO = 1,
  LEADERBOARD = 7,
  LEVEL = 12,
  LOAD = 107,
  LOADING = 104,
  LOGO = 0,
  MENU = 4,
  ONLINE_LOADING = 28,
  ONLINE_LOBBY = 29,
  OPTIONS = 5,
  POST_LEVEL_GENERATION = 112,
  POST_ROOM_GENERATION = 111,
  PRE_GET_RANDOM_ROOM = 113,
  PRE_HANDLE_ROOM_TILES = 114,
  PRE_LEVEL_GENERATION = 110,
  PRE_LOAD_LEVEL_FILES = 109,
  PROLOGUE = 2,
  RECAP = 20,
  RENDER_POST_DRAW_DEPTH = 122,
  RENDER_POST_HUD = 118,
  RENDER_POST_JOURNAL_PAGE = 123,
  RENDER_POST_PAUSE_MENU = 120,
  RENDER_PRE_DRAW_DEPTH = 121,
  RENDER_PRE_HUD = 117,
  RENDER_PRE_PAUSE_MENU = 119,
  RESET = 105,
  SAVE = 106,
  SCORES = 18,
  SCREEN = 102,
  SCRIPT_DISABLE = 116,
  SCRIPT_ENABLE = 115,
  SEED_INPUT = 8,
  SPACESHIP = 15,
  SPEECH_BUBBLE = 124,
  START = 103,
  TEAM_SELECT = 10,
  TITLE = 3,
  TOAST = 125,
  TRANSITION = 13,
  WIN = 16
}
---@alias ON integer
PARTICLEEMITTER = {
  ACIDBUBBLEBURST_BUBBLES = 101,
  ACIDBUBBLEBURST_SPARKS = 102,
  ALIENBLAST_SHOCKWAVE = 179,
  ALTAR_MONSTER_APPEAR_POOF = 162,
  ALTAR_SKULL = 95,
  ALTAR_SMOKE = 96,
  ALTAR_SPARKS = 97,
  APEP_DUSTWALL = 158,
  ARROWPOOF = 67,
  AU_GOLD_SPARKLES = 74,
  AXOLOTL_BIGBUBBLEKILL = 186,
  AXOLOTL_SMALLBUBBLEKILL = 185,
  BLAST_PLASMAWARP_TRAIL = 137,
  BLOODTRAIL = 64,
  BLUESPARKS = 106,
  BOMB_SMOKE = 24,
  BOOMERANG_TRAIL = 172,
  BROKENORB_BLAST_LARGE = 204,
  BROKENORB_BLAST_MEDIUM = 203,
  BROKENORB_BLAST_SMALL = 202,
  BROKENORB_ORBS_LARGE = 210,
  BROKENORB_ORBS_MEDIUM = 209,
  BROKENORB_ORBS_SMALL = 208,
  BROKENORB_SHOCKWAVE_LARGE = 216,
  BROKENORB_SHOCKWAVE_MEDIUM = 215,
  BROKENORB_SHOCKWAVE_SMALL = 214,
  BROKENORB_SPARKS_LARGE = 213,
  BROKENORB_SPARKS_MEDIUM = 212,
  BROKENORB_SPARKS_SMALL = 211,
  BROKENORB_WARP_LARGE = 207,
  BROKENORB_WARP_MEDIUM = 206,
  BROKENORB_WARP_SMALL = 205,
  BULLETPOOF = 66,
  CAMERA_FRAME = 105,
  CAVEMAN_SPITTLE = 190,
  CHARSELECTOR_MIST = 197,
  CHARSELECTOR_TORCHFLAME_FLAMES = 8,
  CHARSELECTOR_TORCHFLAME_SMOKE = 7,
  CLOVER_WITHER_HUD = 78,
  COFFINDOORPOOF_SPARKS = 141,
  COG_SPARKLE = 80,
  COG_TUNNEL_FOG = 81,
  COLLECTPOOF_CLOUDS = 99,
  COLLECTPOOF_SPARKS = 98,
  CONTACTEFFECT_SPARKS = 131,
  COOKFIRE_FLAMES = 34,
  COOKFIRE_SMOKE = 33,
  COOKFIRE_WARP = 35,
  CRUSHTRAPPOOF = 58,
  CURSEDEFFECT_PIECES = 116,
  CURSEDEFFECT_PIECES_HUD = 117,
  CURSEDEFFECT_SKULL = 118,
  CURSEDPOT_BEHINDSMOKE = 47,
  CURSEDPOT_SMOKE = 46,
  DMCOUNTDOWN_BLAST = 21,
  DMCOUNTDOWN_DUST = 17,
  DMCOUNTDOWN_FLAMES = 20,
  DMCOUNTDOWN_FOG = 23,
  DMCOUNTDOWN_HIGH_TENSION_THUNDERBOLT = 22,
  DMCOUNTDOWN_RUBBLES = 15,
  DMCOUNTDOWN_RUBBLES_LARGE = 16,
  DMCOUNTDOWN_SPARKS = 18,
  DMCOUNTDOWN_SPARKS_SMALL = 19,
  DMPREMATCH_ASH_2P = 151,
  DMPREMATCH_ASH_3P = 152,
  DMPREMATCH_ASH_4P = 153,
  DMPREMATCH_SEPARATOR_GLOW_TRAIL = 201,
  DMRESULTS_ASH = 150,
  DMRESULT_BLOOD = 13,
  DMRESULT_MEATPIECES = 14,
  DM_DEATH_MIST = 178,
  DUSTWALL = 157,
  EGGSHIP_SMOKE = 43,
  ELIXIREFFECT_WORNOUT = 119,
  ENDINGTREASURE_DUST = 45,
  ENDING_TREASURE_HUNDUN_SPARKLE = 73,
  ENDING_TREASURE_TIAMAT_SPARKLE = 72,
  EVAPORATION_WATER = 144,
  EXPLOSION_SHOCKWAVE = 27,
  EXPLOSION_SMOKE = 25,
  EXPLOSION_SPARKS = 26,
  EXPLOSION_WHITESMOKE = 28,
  FIREBALL_DESTROYED = 42,
  FIREBALL_TRAIL = 41,
  FLAMETHROWER_SMOKE = 40,
  FLAMETRAIL_FLAMES = 82,
  FLAMETRAIL_SMOKE = 83,
  FLOORDUST = 48,
  FLOORFALLINGDUST_RUBBLE = 50,
  FLOORFALLINGDUST_SMOKE = 49,
  FLOORPOOF = 52,
  FLOORPOOF_BIG = 54,
  FLOORPOOF_SMALL = 53,
  FLOORPOOF_TRAIL = 59,
  FLOORPOOF_TRAIL_BIG = 60,
  FLYPOOF = 56,
  FROST_BREATH = 198,
  GASTRAIL = 142,
  GASTRAIL_BIG = 143,
  GHOST_FOG = 92,
  GHOST_MIST = 90,
  GHOST_WARP = 91,
  GREENBLOODTRAIL = 65,
  GRUB_TRAIL = 174,
  HIGH_TENSION_THUNDERBOLT = 191,
  HITEFFECT_HALO = 126,
  HITEFFECT_RING = 124,
  HITEFFECT_SMACK = 125,
  HITEFFECT_SPARKS = 120,
  HITEFFECT_SPARKS_BIG = 121,
  HITEFFECT_STARS_BIG = 123,
  HITEFFECT_STARS_SMALL = 122,
  HORIZONTALLASERBEAM_SPARKLES = 164,
  HORIZONTALLASERBEAM_SPARKLES_END = 166,
  HORIZONTALLASERBEAM_SPARKS = 168,
  ICECAGE_MIST = 156,
  ICECAVES_DIAMONDDUST = 154,
  ICEFLOOR_MIST = 155,
  ICESPIRETRAIL_SPARKLES = 108,
  INKSPIT_BUBBLEBURST = 104,
  INKSPIT_TRAIL = 103,
  ITEMDUST = 62,
  ITEM_CRUSHED_SPARKS = 79,
  JETPACK_LITTLEFLAME = 85,
  JETPACK_SMOKETRAIL = 84,
  KINGUDUST = 170,
  KINGUSLIDINGDUST = 171,
  LAMASSU_AIMING_SPARKLES = 195,
  LAMASSU_SHOT_SPARKLES = 194,
  LAMASSU_SHOT_WARP = 193,
  LARGEITEMDUST = 63,
  LASERBEAM_CONTACT = 169,
  LASERBEAM_SPARKLES = 163,
  LASERBEAM_SPARKLES_END = 165,
  LASERBEAM_SPARKS = 167,
  LAVAHEAT = 146,
  LAVAPOT_DRIP = 187,
  LEVEL_MIST = 192,
  LIONTRAP_SPARKLE = 77,
  MAGMAMANHEAT = 147,
  MAINMENU_CEILINGDUST_RUBBLE = 10,
  MAINMENU_CEILINGDUST_RUBBLE_SMALL = 12,
  MAINMENU_CEILINGDUST_SMOKE = 9,
  MAINMENU_CEILINGDUST_SMOKE_SMALL = 11,
  MERCHANT_APPEAR_POOF = 161,
  MINIGAME_ASTEROID_DUST = 217,
  MINIGAME_ASTEROID_DUST_SMALL = 218,
  MINIGAME_BROKENASTEROID_SMOKE = 220,
  MINIGAME_UFO_SMOKE = 219,
  MOLEFLOORPOOF = 61,
  MOUNT_TAMED = 159,
  MUSIC_NOTES = 199,
  NECROMANCER_SUMMON = 184,
  NOHITEFFECT_RING = 129,
  NOHITEFFECT_SMACK = 130,
  NOHITEFFECT_SPARKS = 127,
  NOHITEFFECT_STARS = 128,
  OLMECFLOORPOOF = 57,
  OLMECSHIP_HOLE_DUST = 44,
  ONFIREEFFECT_FLAME = 111,
  ONFIREEFFECT_SMOKE = 110,
  OUROBORO_EMBERS = 89,
  OUROBORO_FALLING_RUBBLE = 51,
  OUROBORO_MIST = 88,
  PETTING_PET = 160,
  PINKSPARKS = 107,
  PLAYERGHOST_FREEZESPARKLES = 93,
  POISONEDEFFECT_BUBBLES_BASE = 112,
  POISONEDEFFECT_BUBBLES_BURST = 113,
  POISONEDEFFECT_BUBBLES_HUD = 114,
  POISONEDEFFECT_SKULL = 115,
  PORTAL_DUST_FAST = 176,
  PORTAL_DUST_SLOW = 175,
  PORTAL_WARP = 177,
  PRIZEAPPEARING_CLOUDS = 100,
  SANDFLOORPOOF = 55,
  SCEPTERKILL_SPARKLES = 134,
  SCEPTERKILL_SPARKS = 135,
  SCEPTER_BLAST = 136,
  SHOTGUNBLAST_SMOKE = 86,
  SHOTGUNBLAST_SPARKS = 87,
  SMALLFLAME_FLAMES = 37,
  SMALLFLAME_SMOKE = 36,
  SMALLFLAME_WARP = 38,
  SPARKTRAP_TRAIL = 200,
  SPLASH_WATER = 145,
  TELEPORTEFFECT_GREENSPARKLES = 139,
  TELEPORTEFFECT_REDSPARKLES = 140,
  TELEPORTEFFECT_SPARKS = 138,
  TIAMAT_SCREAM_WARP = 196,
  TITLE_TORCHFLAME_ASH = 6,
  TITLE_TORCHFLAME_BACKFLAMES = 2,
  TITLE_TORCHFLAME_BACKFLAMES_ANIMATED = 4,
  TITLE_TORCHFLAME_FLAMES = 3,
  TITLE_TORCHFLAME_FLAMES_ANIMATED = 5,
  TITLE_TORCHFLAME_SMOKE = 1,
  TOMB_FOG = 94,
  TORCHFLAME_FLAMES = 31,
  TORCHFLAME_IGNITION_SPARK = 29,
  TORCHFLAME_SMOKE = 30,
  TORCHFLAME_WARP = 32,
  TREASURE_SPARKLE_HIGH = 70,
  TREASURE_SPARKLE_HUD = 71,
  TREASURE_SPARKLE_LOW = 68,
  TREASURE_SPARKLE_MEDIUM = 69,
  UFOLASERSHOTHITEFFECT_BIG = 132,
  UFOLASERSHOTHITEFFECT_SMALL = 133,
  USHABTI_GOLD = 75,
  USHABTI_JADE = 76,
  VOLCANO_ASH = 149,
  VOLCANO_FOG = 148,
  WATER_DROP_DESTROYED = 188,
  WATER_DROP_DESTROYED_UPWARDS = 189,
  WETEFFECT_DROPS = 109,
  WHIPFLAME_FLAMES = 39,
  WITCHDOCTORSKULL_TRAIL = 173,
  YETIKING_YELL_DUST = 181,
  YETIKING_YELL_FOG = 180,
  YETIKING_YELL_SPARKLES = 182,
  YETIQUEEN_LANDING_SNOWDUST = 183
}
---@alias PARTICLEEMITTER integer
PAUSEUI_VISIBILITY = {
  INVISIBLE = 0,
  SLIDING_DOWN = 1,
  SLIDING_UP = 3,
  VISIBLE = 2
}
---@alias PAUSEUI_VISIBILITY integer
PRNG_CLASS = {
  ENTITY_VARIATION = 3,
  EXTRA_SPAWNS = 5,
  LEVEL_DECO = 8,
  PARTICLES = 2,
  PROCEDURAL_SPAWNS = 0
}
---@alias PRNG_CLASS integer
PROCEDURAL_CHANCE = {
  ADD_GOLD_BAR = 444,
  ADD_GOLD_BARS = 445,
  ARROWTRAP_CHANCE = 0,
  BAT = 224,
  BEE = 278,
  BEEHIVE_CHANCE = 16,
  BIGSPEARTRAP_CHANCE = 11,
  CAT = 251,
  CAVEMAN = 225,
  CHAIN_BLOCKS_CHANCE = 6,
  COBRA = 248,
  CRABMAN = 311,
  CRITTERANCHOVY = 335,
  CRITTERBUTTERFLY = 332,
  CRITTERCRAB = 336,
  CRITTERDRONE = 340,
  CRITTERDUNGBEETLE = 331,
  CRITTERFIREFLY = 339,
  CRITTERFISH = 334,
  CRITTERLOCUST = 337,
  CRITTERPENGUIN = 338,
  CRITTERSLIME = 341,
  CRITTERSNAIL = 333,
  CROCMAN = 247,
  CRUSHER_TRAP_CHANCE = 7,
  DIAMOND = 446,
  EGGSAC_CHANCE = 14,
  ELEVATOR = 443,
  EMERALD = 447,
  FEMALE_JIANGSHI = 261,
  FIREBUG = 241,
  FIREFROG = 284,
  FISH = 262,
  FROG = 283,
  GIANTFLY = 288,
  GIANTSPIDER = 223,
  HANGSPIDER = 222,
  HERMITCRAB = 264,
  HORNEDLIZARD = 230,
  IMP = 243,
  JIANGSHI = 260,
  JUNGLE_SPEAR_TRAP_CHANCE = 4,
  LANDMINE = 439,
  LASERTRAP_CHANCE = 9,
  LAVAMANDER = 244,
  LEPRECHAUN = 310,
  LEPRECHAUN_CHANCE = 17,
  LIONTRAP_CHANCE = 8,
  LITWALLTORCH = 442,
  MANTRAP = 233,
  MINISTER_CHANCE = 15,
  MOLE = 231,
  MONKEY = 238,
  MOSQUITO = 237,
  NECROMANCER = 252,
  OCTOPUS = 263,
  OLMITE = 276,
  PUSHBLOCK_CHANCE = 2,
  RED_SKELETON = 440,
  ROBOT = 240,
  RUBY = 449,
  SAPPHIRE = 448,
  SKULLDROP_CHANCE = 13,
  SNAKE = 220,
  SNAP_TRAP_CHANCE = 3,
  SORCERESS = 250,
  SPARKTRAP_CHANCE = 10,
  SPIDER = 221,
  SPIKE_BALL_CHANCE = 5,
  SPRINGTRAP = 73,
  STICKYTRAP_CHANCE = 12,
  TADPOLE = 287,
  TIKIMAN = 234,
  TOTEMTRAP_CHANCE = 1,
  UFO = 266,
  VAMPIRE = 245,
  WALLTORCH = 441,
  WITCHDOCTOR = 235,
  YETI = 268
}
---@alias PROCEDURAL_CHANCE integer
REPEAT_TYPE = {
  BACK_AND_FORTH = 2,
  LINEAR = 1,
  NO_REPEAT = 0
}
---@alias REPEAT_TYPE integer
ROOM_TEMPLATE = {
  ABZU_BACKDOOR = 132,
  ALTAR = 115,
  ANUBIS_ROOM = 38,
  APEP = 128,
  BEEHIVE = 31,
  BEEHIVE_ENTRANCE = 32,
  BLACKMARKET = 118,
  BLACKMARKET_COFFIN = 34,
  BLACKMARKET_ENTRANCE = 33,
  BLACKMARKET_EXIT = 35,
  BOSS_ARENA = 22,
  CACHE = 14,
  CAVEMANSHOP = 79,
  CAVEMANSHOP_LEFT = 80,
  CHALLANGE_ENTRANCE_BACKLAYER = 90,
  CHALLENGE_0_0 = 92,
  CHALLENGE_0_1 = 93,
  CHALLENGE_0_2 = 94,
  CHALLENGE_0_3 = 95,
  CHALLENGE_1_0 = 96,
  CHALLENGE_1_1 = 97,
  CHALLENGE_1_2 = 98,
  CHALLENGE_1_3 = 99,
  CHALLENGE_BOTTOM = 91,
  CHALLENGE_ENTRANCE = 81,
  CHALLENGE_ENTRANCE_LEFT = 82,
  CHALLENGE_SPECIAL = 100,
  CHUNK_AIR = 17,
  CHUNK_DOOR = 18,
  CHUNK_GROUND = 16,
  COFFIN_FROG = 111,
  COFFIN_PLAYER = 25,
  COFFIN_PLAYER_VERTICAL = 26,
  COFFIN_UNLOCKABLE = 27,
  COFFIN_UNLOCKABLE_LEFT = 28,
  COG_ALTAR_TOP = 125,
  CRASHEDSHIP_ENTRANCE = 61,
  CRASHEDSHIP_ENTRANCE_NOTOP = 62,
  CURIOSHOP = 77,
  CURIOSHOP_LEFT = 78,
  DICESHOP = 75,
  DICESHOP_LEFT = 76,
  EMPRESS_GRAVE = 136,
  EMPTY_BACKLAYER = 9,
  ENTRANCE = 5,
  ENTRANCE_DROP = 6,
  EXIT = 7,
  EXIT_NOTOP = 8,
  FEELING_FACTORY = 104,
  FEELING_PRISON = 105,
  FEELING_TOMB = 106,
  GHISTROOM = 15,
  GHISTSHOP = 135,
  GHISTSHOP_BACKLAYER = 87,
  IDOL = 116,
  IDOL_TOP = 117,
  LAKEOFFIRE_BACK_ENTRANCE = 36,
  LAKEOFFIRE_BACK_EXIT = 37,
  LAKE_EXIT = 129,
  LAKE_NORMAL = 130,
  LAKE_NOTOP = 131,
  MACHINE_BIGROOM_PATH = 102,
  MACHINE_BIGROOM_SIDE = 103,
  MACHINE_KEYROOM = 113,
  MACHINE_REWARDROOM = 114,
  MACHINE_TALLROOM_PATH = 109,
  MACHINE_TALLROOM_SIDE = 110,
  MACHINE_WIDEROOM_PATH = 107,
  MACHINE_WIDEROOM_SIDE = 108,
  MOAI = 39,
  MOTHERSHIP_COFFIN = 41,
  MOTHERSHIP_ENTRANCE = 40,
  MOTHERSHIP_EXIT = 127,
  MOTHERSHIP_ROOM = 125,
  MOTHERSTATUE_ROOM = 43,
  OLDHUNTER_CURSEDROOM = 139,
  OLDHUNTER_KEYROOM = 137,
  OLDHUNTER_REWARDROOM = 138,
  OLMECSHIP_ROOM = 42,
  PALACEOFPLEASURE_0_0 = 49,
  PALACEOFPLEASURE_0_1 = 50,
  PALACEOFPLEASURE_0_2 = 51,
  PALACEOFPLEASURE_1_0 = 52,
  PALACEOFPLEASURE_1_1 = 53,
  PALACEOFPLEASURE_1_2 = 54,
  PALACEOFPLEASURE_2_0 = 55,
  PALACEOFPLEASURE_2_1 = 56,
  PALACEOFPLEASURE_2_2 = 57,
  PALACEOFPLEASURE_3_0 = 58,
  PALACEOFPLEASURE_3_1 = 59,
  PALACEOFPLEASURE_3_2 = 60,
  PASSAGE_HORZ = 11,
  PASSAGE_TURN = 13,
  PASSAGE_VERT = 12,
  PATH_DROP = 2,
  PATH_DROP_NOTOP = 4,
  PATH_NORMAL = 1,
  PATH_NOTOP = 3,
  PEN_ROOM = 45,
  POSSE = 24,
  QUEST_THIEF1 = 140,
  QUEST_THIEF2 = 141,
  ROOM2 = 10,
  SETROOM0_0 = 142,
  SETROOM0_1 = 142,
  SETROOM0_2 = 142,
  SETROOM0_3 = 142,
  SETROOM0_4 = 142,
  SETROOM0_5 = 142,
  SETROOM0_6 = 142,
  SETROOM0_7 = 142,
  SETROOM1_0 = 142,
  SETROOM1_1 = 142,
  SETROOM1_2 = 142,
  SETROOM1_3 = 142,
  SETROOM1_4 = 142,
  SETROOM1_5 = 142,
  SETROOM1_6 = 142,
  SETROOM1_7 = 142,
  SETROOM2_0 = 142,
  SETROOM2_1 = 142,
  SETROOM2_2 = 142,
  SETROOM2_3 = 142,
  SETROOM2_4 = 142,
  SETROOM2_5 = 142,
  SETROOM2_6 = 142,
  SETROOM2_7 = 142,
  SETROOM3_0 = 142,
  SETROOM3_1 = 142,
  SETROOM3_2 = 142,
  SETROOM3_3 = 142,
  SETROOM3_4 = 142,
  SETROOM3_5 = 142,
  SETROOM3_6 = 142,
  SETROOM3_7 = 142,
  SETROOM4_0 = 142,
  SETROOM4_1 = 142,
  SETROOM4_2 = 142,
  SETROOM4_3 = 142,
  SETROOM4_4 = 142,
  SETROOM4_5 = 142,
  SETROOM4_6 = 142,
  SETROOM4_7 = 142,
  SETROOM5_0 = 142,
  SETROOM5_1 = 142,
  SETROOM5_2 = 142,
  SETROOM5_3 = 142,
  SETROOM5_4 = 142,
  SETROOM5_5 = 142,
  SETROOM5_6 = 142,
  SETROOM5_7 = 142,
  SETROOM6_0 = 142,
  SETROOM6_1 = 142,
  SETROOM6_2 = 142,
  SETROOM6_3 = 142,
  SETROOM6_4 = 142,
  SETROOM6_5 = 142,
  SETROOM6_6 = 142,
  SETROOM6_7 = 142,
  SETROOM7_0 = 142,
  SETROOM7_1 = 142,
  SETROOM7_2 = 142,
  SETROOM7_3 = 142,
  SETROOM7_4 = 142,
  SETROOM7_5 = 142,
  SETROOM7_6 = 142,
  SETROOM7_7 = 142,
  SETROOM8_0 = 142,
  SETROOM8_1 = 142,
  SETROOM8_2 = 142,
  SETROOM8_3 = 142,
  SETROOM8_4 = 142,
  SETROOM8_5 = 142,
  SETROOM8_6 = 142,
  SETROOM8_7 = 142,
  SETROOM9_0 = 142,
  SETROOM9_1 = 142,
  SETROOM9_2 = 142,
  SETROOM9_3 = 142,
  SETROOM9_4 = 142,
  SETROOM9_5 = 142,
  SETROOM9_6 = 142,
  SETROOM9_7 = 142,
  SETROOM10_0 = 142,
  SETROOM10_1 = 142,
  SETROOM10_2 = 142,
  SETROOM10_3 = 142,
  SETROOM10_4 = 142,
  SETROOM10_5 = 142,
  SETROOM10_6 = 142,
  SETROOM10_7 = 142,
  SETROOM11_0 = 142,
  SETROOM11_1 = 142,
  SETROOM11_2 = 142,
  SETROOM11_3 = 142,
  SETROOM11_4 = 142,
  SETROOM11_5 = 142,
  SETROOM11_6 = 142,
  SETROOM11_7 = 142,
  SETROOM12_0 = 142,
  SETROOM12_1 = 142,
  SETROOM12_2 = 142,
  SETROOM12_3 = 142,
  SETROOM12_4 = 142,
  SETROOM12_5 = 142,
  SETROOM12_6 = 142,
  SETROOM12_7 = 142,
  SETROOM13_0 = 142,
  SETROOM13_1 = 142,
  SETROOM13_2 = 142,
  SETROOM13_3 = 142,
  SETROOM13_4 = 142,
  SETROOM13_5 = 142,
  SETROOM13_6 = 142,
  SETROOM13_7 = 142,
  SETROOM14_0 = 142,
  SETROOM14_1 = 142,
  SETROOM14_2 = 142,
  SETROOM14_3 = 142,
  SETROOM14_4 = 142,
  SETROOM14_5 = 142,
  SETROOM14_6 = 142,
  SETROOM14_7 = 142,
  SHOP = 65,
  SHOP_ATTIC = 71,
  SHOP_ATTIC_LEFT = 72,
  SHOP_BASEMENT = 73,
  SHOP_BASEMENT_LEFT = 74,
  SHOP_ENTRANCE_DOWN = 69,
  SHOP_ENTRANCE_DOWN_LEFT = 70,
  SHOP_ENTRANCE_UP = 67,
  SHOP_ENTRANCE_UP_LEFT = 68,
  SHOP_JAIL_BACKLAYER = 44,
  SHOP_LEFT = 66,
  SIDE = 0,
  SISTERS_ROOM = 46,
  SOLID = 21,
  STORAGE_ROOM = 118,
  TUSKDICESHOP = 83,
  TUSKDICESHOP_LEFT = 84,
  TUSKFRONTDICESHOP = 47,
  TUSKFRONTDICESHOP_LEFT = 48,
  UDJATENTRANCE = 29,
  UDJATTOP = 30,
  USHABTI_ENTRANCE = 133,
  USHABTI_ROOM = 134,
  VAULT = 23,
  VLAD_BOTTOM_EXIT = 123,
  VLAD_BOTTOM_TUNNEL = 122,
  VLAD_DRILL = 120,
  VLAD_ENTRANCE = 121,
  VLAD_TUNNEL = 124,
  WADDLER = 86
}
---@alias ROOM_TEMPLATE integer
ROOM_TEMPLATE_TYPE = {
  ENTRANCE = 1,
  EXIT = 2,
  MACHINE_ROOM = 4,
  NONE = 0,
  SHOP = 3
}
---@alias ROOM_TEMPLATE_TYPE integer
SCREEN = {
  ARENA_INTRO = 25,
  ARENA_ITEMS = 23,
  ARENA_LEVEL = 26,
  ARENA_MENU = 21,
  ARENA_SCORE = 27,
  ARENA_SELECT = 24,
  ARENA_STAGES = 22,
  CAMP = 11,
  CHARACTER_SELECT = 9,
  CONSTELLATION = 19,
  CREDITS = 17,
  DEATH = 14,
  INTRO = 1,
  LEADERBOARD = 7,
  LEVEL = 12,
  LOGO = 0,
  MENU = 4,
  ONLINE_LOADING = 28,
  ONLINE_LOBBY = 29,
  OPTIONS = 5,
  PLAYER_PROFILE = 6,
  PROLOGUE = 2,
  RECAP = 20,
  SCORES = 18,
  SEED_INPUT = 8,
  SPACESHIP = 15,
  TEAM_SELECT = 10,
  TITLE = 3,
  TRANSITION = 13,
  WIN = 16
}
---@alias SCREEN integer
SHAPE = {
  RECTANGLE = 1,
  CIRCLE = 2
}
---@alias SHAPE integer
SHOP_TYPE = {
  CAVEMAN_SHOP = 10,
  CLOTHING_SHOP = 1,
  CURIO_SHOP = 9,
  DICE_SHOP = 6,
  GENERAL_STORE = 0,
  GHIST_SHOP = 12,
  HEDJET_SHOP = 8,
  HIRED_HAND_SHOP = 4,
  PET_SHOP = 5,
  SPECIALTY_SHOP = 3,
  TURKEY_SHOP = 11,
  TUSK_DICE_SHOP = 13,
  WEAPON_SHOP = 2
}
---@alias SHOP_TYPE integer
SOUND_LOOP_MODE = {
  BIDIRECTIONAL = 2,
  LOOP = 1,
  OFF = 0
}
---@alias SOUND_LOOP_MODE integer
SOUND_TYPE = {
  MUSIC = 1,
  SFX = 0
}
---@alias SOUND_TYPE integer
SPARROW = {
  FINISHED_LEVEL_WITH_THIEF_STATUS = 2,
  FIRST_ENCOUNTER_ROPES_THROWN = 4,
  FIRST_HIDEOUT_SPAWNED_ROPE_THROW = 3,
  MEETING_AT_TUSK_BASEMENT = 8,
  QUEST_NOT_STARTED = 0,
  SECOND_ENCOUNTER_INTERACTED = 7,
  SECOND_HIDEOUT_SPAWNED_NEOBAB = 6,
  THIEF_STATUS = 1,
  TUSK_IDOL_STOLEN = 5
}
---@alias SPARROW integer
SPAWN_TYPE = {
  ANY = 63,
  LEVEL_GEN = 15,
  LEVEL_GEN_FLOOR_SPREADING = 4,
  LEVEL_GEN_GENERAL = 8,
  LEVEL_GEN_PROCEDURAL = 2,
  LEVEL_GEN_TILE_CODE = 1,
  SCRIPT = 16,
  SYSTEMIC = 32
}
---@alias SPAWN_TYPE integer
TEXTURE = {
  DATA_TEXTURES_BASE_EGGSHIP2_0 = 108,
  DATA_TEXTURES_BASE_EGGSHIP2_1 = 109,
  DATA_TEXTURES_BASE_EGGSHIP2_2 = 110,
  DATA_TEXTURES_BASE_EGGSHIP3_0 = 111,
  DATA_TEXTURES_BASE_EGGSHIP3_1 = 112,
  DATA_TEXTURES_BASE_EGGSHIP3_2 = 113,
  DATA_TEXTURES_BASE_EGGSHIP3_3 = 114,
  DATA_TEXTURES_BASE_EGGSHIP_0 = 102,
  DATA_TEXTURES_BASE_EGGSHIP_1 = 103,
  DATA_TEXTURES_BASE_EGGSHIP_2 = 104,
  DATA_TEXTURES_BASE_EGGSHIP_3 = 105,
  DATA_TEXTURES_BASE_EGGSHIP_4 = 106,
  DATA_TEXTURES_BASE_EGGSHIP_5 = 107,
  DATA_TEXTURES_BASE_SKYNIGHT_0 = 115,
  DATA_TEXTURES_BASE_SURFACE2_0 = 118,
  DATA_TEXTURES_BASE_SURFACE_0 = 116,
  DATA_TEXTURES_BASE_SURFACE_1 = 117,
  DATA_TEXTURES_BG_BABYLON_0 = 195,
  DATA_TEXTURES_BG_BEEHIVE_0 = 226,
  DATA_TEXTURES_BG_CAVE_0 = 136,
  DATA_TEXTURES_BG_DUAT2_0 = 215,
  DATA_TEXTURES_BG_DUAT_0 = 211,
  DATA_TEXTURES_BG_DUAT_1 = 213,
  DATA_TEXTURES_BG_DUAT_2 = 214,
  DATA_TEXTURES_BG_EGGPLANT_0 = 223,
  DATA_TEXTURES_BG_GOLD_0 = 269,
  DATA_TEXTURES_BG_ICE_0 = 184,
  DATA_TEXTURES_BG_JUNGLE_0 = 143,
  DATA_TEXTURES_BG_MOTHERSHIP_0 = 272,
  DATA_TEXTURES_BG_STONE_0 = 158,
  DATA_TEXTURES_BG_SUNKEN_0 = 207,
  DATA_TEXTURES_BG_TEMPLE_0 = 165,
  DATA_TEXTURES_BG_TIDEPOOL_0 = 175,
  DATA_TEXTURES_BG_VLAD_0 = 260,
  DATA_TEXTURES_BG_VOLCANO_0 = 153,
  DATA_TEXTURES_BORDER_MAIN_0 = 283,
  DATA_TEXTURES_BORDER_MAIN_1 = 284,
  DATA_TEXTURES_CHAR_BLACK_0 = 288,
  DATA_TEXTURES_CHAR_BLUE_0 = 294,
  DATA_TEXTURES_CHAR_CERULEAN_0 = 293,
  DATA_TEXTURES_CHAR_CINNABAR_0 = 289,
  DATA_TEXTURES_CHAR_CYAN_0 = 287,
  DATA_TEXTURES_CHAR_EGGCHILD_0 = 306,
  DATA_TEXTURES_CHAR_GOLD_0 = 298,
  DATA_TEXTURES_CHAR_GRAY_0 = 302,
  DATA_TEXTURES_CHAR_GREEN_0 = 290,
  DATA_TEXTURES_CHAR_HIRED_0 = 305,
  DATA_TEXTURES_CHAR_IRIS_0 = 297,
  DATA_TEXTURES_CHAR_KHAKI_0 = 303,
  DATA_TEXTURES_CHAR_LEMON_0 = 296,
  DATA_TEXTURES_CHAR_LIME_0 = 295,
  DATA_TEXTURES_CHAR_MAGENTA_0 = 286,
  DATA_TEXTURES_CHAR_OLIVE_0 = 291,
  DATA_TEXTURES_CHAR_ORANGE_0 = 304,
  DATA_TEXTURES_CHAR_PINK_0 = 300,
  DATA_TEXTURES_CHAR_RED_0 = 299,
  DATA_TEXTURES_CHAR_VIOLET_0 = 301,
  DATA_TEXTURES_CHAR_WHITE_0 = 292,
  DATA_TEXTURES_CHAR_YELLOW_0 = 285,
  DATA_TEXTURES_COFFINS_0 = 385,
  DATA_TEXTURES_COFFINS_1 = 386,
  DATA_TEXTURES_COFFINS_2 = 387,
  DATA_TEXTURES_COFFINS_3 = 388,
  DATA_TEXTURES_COFFINS_4 = 389,
  DATA_TEXTURES_COFFINS_5 = 390,
  DATA_TEXTURES_CREDITS_0 = 391,
  DATA_TEXTURES_CREDITS_1 = 392,
  DATA_TEXTURES_DECO_BABYLON_0 = 191,
  DATA_TEXTURES_DECO_BABYLON_1 = 192,
  DATA_TEXTURES_DECO_BABYLON_2 = 193,
  DATA_TEXTURES_DECO_BASECAMP_0 = 119,
  DATA_TEXTURES_DECO_BASECAMP_1 = 120,
  DATA_TEXTURES_DECO_BASECAMP_2 = 121,
  DATA_TEXTURES_DECO_BASECAMP_3 = 122,
  DATA_TEXTURES_DECO_BASECAMP_4 = 123,
  DATA_TEXTURES_DECO_BASECAMP_5 = 124,
  DATA_TEXTURES_DECO_BASECAMP_6 = 125,
  DATA_TEXTURES_DECO_BASECAMP_7 = 126,
  DATA_TEXTURES_DECO_CAVE_0 = 134,
  DATA_TEXTURES_DECO_CAVE_1 = 135,
  DATA_TEXTURES_DECO_COSMIC_0 = 228,
  DATA_TEXTURES_DECO_COSMIC_1 = 229,
  DATA_TEXTURES_DECO_COSMIC_2 = 230,
  DATA_TEXTURES_DECO_EGGPLANT_0 = 202,
  DATA_TEXTURES_DECO_EGGPLANT_1 = 222,
  DATA_TEXTURES_DECO_EXTRA_0 = 279,
  DATA_TEXTURES_DECO_EXTRA_1 = 280,
  DATA_TEXTURES_DECO_GOLD_0 = 266,
  DATA_TEXTURES_DECO_GOLD_1 = 267,
  DATA_TEXTURES_DECO_GOLD_2 = 268,
  DATA_TEXTURES_DECO_ICE_0 = 180,
  DATA_TEXTURES_DECO_ICE_1 = 181,
  DATA_TEXTURES_DECO_ICE_2 = 182,
  DATA_TEXTURES_DECO_ICE_3 = 183,
  DATA_TEXTURES_DECO_JUNGLE_0 = 141,
  DATA_TEXTURES_DECO_JUNGLE_1 = 142,
  DATA_TEXTURES_DECO_JUNGLE_2 = 156,
  DATA_TEXTURES_DECO_SUNKEN_0 = 203,
  DATA_TEXTURES_DECO_SUNKEN_1 = 204,
  DATA_TEXTURES_DECO_SUNKEN_2 = 205,
  DATA_TEXTURES_DECO_SUNKEN_3 = 206,
  DATA_TEXTURES_DECO_TEMPLE_0 = 163,
  DATA_TEXTURES_DECO_TEMPLE_1 = 164,
  DATA_TEXTURES_DECO_TEMPLE_2 = 216,
  DATA_TEXTURES_DECO_TIDEPOOL_0 = 173,
  DATA_TEXTURES_DECO_TIDEPOOL_1 = 174,
  DATA_TEXTURES_DECO_TUTORIAL_0 = 127,
  DATA_TEXTURES_DECO_TUTORIAL_1 = 128,
  DATA_TEXTURES_DECO_VOLCANO_0 = 149,
  DATA_TEXTURES_DECO_VOLCANO_1 = 150,
  DATA_TEXTURES_DECO_VOLCANO_2 = 151,
  DATA_TEXTURES_DECO_VOLCANO_3 = 152,
  DATA_TEXTURES_FLOORMISC_0 = 281,
  DATA_TEXTURES_FLOORMISC_1 = 282,
  DATA_TEXTURES_FLOORSTYLED_BABYLON_0 = 246,
  DATA_TEXTURES_FLOORSTYLED_BABYLON_1 = 247,
  DATA_TEXTURES_FLOORSTYLED_BABYLON_2 = 248,
  DATA_TEXTURES_FLOORSTYLED_BABYLON_3 = 249,
  DATA_TEXTURES_FLOORSTYLED_BABYLON_4 = 250,
  DATA_TEXTURES_FLOORSTYLED_BEEHIVE_0 = 225,
  DATA_TEXTURES_FLOORSTYLED_BEEHIVE_1 = 227,
  DATA_TEXTURES_FLOORSTYLED_DUAT_0 = 212,
  DATA_TEXTURES_FLOORSTYLED_DUAT_1 = 273,
  DATA_TEXTURES_FLOORSTYLED_GOLD_0 = 261,
  DATA_TEXTURES_FLOORSTYLED_GOLD_1 = 262,
  DATA_TEXTURES_FLOORSTYLED_GOLD_2 = 263,
  DATA_TEXTURES_FLOORSTYLED_GOLD_3 = 264,
  DATA_TEXTURES_FLOORSTYLED_GOLD_4 = 270,
  DATA_TEXTURES_FLOORSTYLED_GOLD_NORMAL_0 = 265,
  DATA_TEXTURES_FLOORSTYLED_GUTS_0 = 278,
  DATA_TEXTURES_FLOORSTYLED_MOTHERSHIP_0 = 271,
  DATA_TEXTURES_FLOORSTYLED_PAGODA_0 = 243,
  DATA_TEXTURES_FLOORSTYLED_PAGODA_1 = 244,
  DATA_TEXTURES_FLOORSTYLED_PAGODA_2 = 245,
  DATA_TEXTURES_FLOORSTYLED_PALACE_0 = 274,
  DATA_TEXTURES_FLOORSTYLED_PALACE_1 = 275,
  DATA_TEXTURES_FLOORSTYLED_PALACE_2 = 276,
  DATA_TEXTURES_FLOORSTYLED_PALACE_3 = 277,
  DATA_TEXTURES_FLOORSTYLED_STONE_0 = 157,
  DATA_TEXTURES_FLOORSTYLED_STONE_1 = 159,
  DATA_TEXTURES_FLOORSTYLED_STONE_2 = 236,
  DATA_TEXTURES_FLOORSTYLED_STONE_3 = 237,
  DATA_TEXTURES_FLOORSTYLED_STONE_4 = 238,
  DATA_TEXTURES_FLOORSTYLED_STONE_5 = 239,
  DATA_TEXTURES_FLOORSTYLED_SUNKEN_0 = 251,
  DATA_TEXTURES_FLOORSTYLED_SUNKEN_1 = 252,
  DATA_TEXTURES_FLOORSTYLED_SUNKEN_2 = 253,
  DATA_TEXTURES_FLOORSTYLED_SUNKEN_3 = 254,
  DATA_TEXTURES_FLOORSTYLED_TEMPLE_0 = 240,
  DATA_TEXTURES_FLOORSTYLED_TEMPLE_1 = 241,
  DATA_TEXTURES_FLOORSTYLED_TEMPLE_2 = 242,
  DATA_TEXTURES_FLOORSTYLED_VLAD_0 = 255,
  DATA_TEXTURES_FLOORSTYLED_VLAD_1 = 256,
  DATA_TEXTURES_FLOORSTYLED_VLAD_2 = 257,
  DATA_TEXTURES_FLOORSTYLED_VLAD_3 = 258,
  DATA_TEXTURES_FLOORSTYLED_VLAD_4 = 259,
  DATA_TEXTURES_FLOORSTYLED_WOOD_0 = 231,
  DATA_TEXTURES_FLOORSTYLED_WOOD_1 = 232,
  DATA_TEXTURES_FLOORSTYLED_WOOD_2 = 233,
  DATA_TEXTURES_FLOORSTYLED_WOOD_3 = 234,
  DATA_TEXTURES_FLOORSTYLED_WOOD_4 = 235,
  DATA_TEXTURES_FLOOR_BABYLON_0 = 187,
  DATA_TEXTURES_FLOOR_BABYLON_1 = 188,
  DATA_TEXTURES_FLOOR_BABYLON_2 = 189,
  DATA_TEXTURES_FLOOR_BABYLON_3 = 190,
  DATA_TEXTURES_FLOOR_BABYLON_4 = 196,
  DATA_TEXTURES_FLOOR_CAVE_0 = 129,
  DATA_TEXTURES_FLOOR_CAVE_1 = 130,
  DATA_TEXTURES_FLOOR_CAVE_2 = 131,
  DATA_TEXTURES_FLOOR_CAVE_3 = 132,
  DATA_TEXTURES_FLOOR_CAVE_4 = 133,
  DATA_TEXTURES_FLOOR_CAVE_5 = 137,
  DATA_TEXTURES_FLOOR_EGGPLANT_0 = 217,
  DATA_TEXTURES_FLOOR_EGGPLANT_1 = 218,
  DATA_TEXTURES_FLOOR_EGGPLANT_2 = 219,
  DATA_TEXTURES_FLOOR_EGGPLANT_3 = 220,
  DATA_TEXTURES_FLOOR_EGGPLANT_4 = 221,
  DATA_TEXTURES_FLOOR_EGGPLANT_5 = 224,
  DATA_TEXTURES_FLOOR_ICE_0 = 177,
  DATA_TEXTURES_FLOOR_ICE_1 = 178,
  DATA_TEXTURES_FLOOR_ICE_2 = 179,
  DATA_TEXTURES_FLOOR_ICE_3 = 185,
  DATA_TEXTURES_FLOOR_ICE_4 = 186,
  DATA_TEXTURES_FLOOR_JUNGLE_0 = 138,
  DATA_TEXTURES_FLOOR_JUNGLE_1 = 139,
  DATA_TEXTURES_FLOOR_JUNGLE_2 = 140,
  DATA_TEXTURES_FLOOR_JUNGLE_3 = 144,
  DATA_TEXTURES_FLOOR_SUNKEN_0 = 197,
  DATA_TEXTURES_FLOOR_SUNKEN_1 = 198,
  DATA_TEXTURES_FLOOR_SUNKEN_2 = 199,
  DATA_TEXTURES_FLOOR_SUNKEN_3 = 200,
  DATA_TEXTURES_FLOOR_SUNKEN_4 = 201,
  DATA_TEXTURES_FLOOR_SUNKEN_5 = 208,
  DATA_TEXTURES_FLOOR_SUNKEN_6 = 209,
  DATA_TEXTURES_FLOOR_SUNKEN_7 = 210,
  DATA_TEXTURES_FLOOR_SURFACE_0 = 101,
  DATA_TEXTURES_FLOOR_TEMPLE_0 = 160,
  DATA_TEXTURES_FLOOR_TEMPLE_1 = 161,
  DATA_TEXTURES_FLOOR_TEMPLE_2 = 162,
  DATA_TEXTURES_FLOOR_TEMPLE_3 = 166,
  DATA_TEXTURES_FLOOR_TEMPLE_4 = 167,
  DATA_TEXTURES_FLOOR_TIDEPOOL_0 = 168,
  DATA_TEXTURES_FLOOR_TIDEPOOL_1 = 169,
  DATA_TEXTURES_FLOOR_TIDEPOOL_2 = 170,
  DATA_TEXTURES_FLOOR_TIDEPOOL_3 = 171,
  DATA_TEXTURES_FLOOR_TIDEPOOL_4 = 172,
  DATA_TEXTURES_FLOOR_TIDEPOOL_5 = 176,
  DATA_TEXTURES_FLOOR_VOLCANO_0 = 145,
  DATA_TEXTURES_FLOOR_VOLCANO_1 = 146,
  DATA_TEXTURES_FLOOR_VOLCANO_2 = 147,
  DATA_TEXTURES_FLOOR_VOLCANO_3 = 148,
  DATA_TEXTURES_FLOOR_VOLCANO_4 = 154,
  DATA_TEXTURES_FLOOR_VOLCANO_5 = 155,
  DATA_TEXTURES_FONTDEBUG_0 = 20,
  DATA_TEXTURES_FONTFIRASANS_0 = 7,
  DATA_TEXTURES_FONTMONO_0 = 19,
  DATA_TEXTURES_FONTNEWRODIN_0 = 8,
  DATA_TEXTURES_FONTNOTOSANSBOLDCS_0_0 = 12,
  DATA_TEXTURES_FONTNOTOSANSBOLDCT_0_0 = 14,
  DATA_TEXTURES_FONTNOTOSANSBOLDKO_0_0 = 16,
  DATA_TEXTURES_FONTNOTOSANSBOLDNICKNAMES_0_0 = 18,
  DATA_TEXTURES_FONTNOTOSANSBOLDRU_0_0 = 10,
  DATA_TEXTURES_FONTNOTOSANSITALICCS_0_0 = 13,
  DATA_TEXTURES_FONTNOTOSANSITALICCT_0_0 = 15,
  DATA_TEXTURES_FONTNOTOSANSITALICKO_0_0 = 17,
  DATA_TEXTURES_FONTNOTOSANSITALICRU_0_0 = 11,
  DATA_TEXTURES_FONTRODINCATTLEYA_0 = 9,
  DATA_TEXTURES_FONTYORKTEN_0 = 6,
  DATA_TEXTURES_FX_ANKH_0 = 382,
  DATA_TEXTURES_FX_ANKH_1 = 383,
  DATA_TEXTURES_FX_BIG_0 = 380,
  DATA_TEXTURES_FX_EXPLOSION_0 = 375,
  DATA_TEXTURES_FX_RUBBLE_0 = 381,
  DATA_TEXTURES_FX_SMALL2_0 = 377,
  DATA_TEXTURES_FX_SMALL3_0 = 378,
  DATA_TEXTURES_FX_SMALL3_1 = 379,
  DATA_TEXTURES_FX_SMALL_0 = 376,
  DATA_TEXTURES_HUD_0 = 65,
  DATA_TEXTURES_HUD_1 = 66,
  DATA_TEXTURES_HUD_2 = 67,
  DATA_TEXTURES_HUD_CONTROLLER_BUTTONS_0 = 69,
  DATA_TEXTURES_HUD_CONTROLLER_BUTTONS_1 = 70,
  DATA_TEXTURES_HUD_CONTROLLER_BUTTONS_2 = 71,
  DATA_TEXTURES_HUD_CONTROLLER_BUTTONS_3 = 72,
  DATA_TEXTURES_HUD_CONTROLLER_BUTTONS_4 = 73,
  DATA_TEXTURES_HUD_TEXT_0 = 68,
  DATA_TEXTURES_ITEMS_0 = 373,
  DATA_TEXTURES_ITEMS_USHABTI_0 = 194,
  DATA_TEXTURES_JOURNAL_BACK_0 = 76,
  DATA_TEXTURES_JOURNAL_ELEMENTS_0 = 93,
  DATA_TEXTURES_JOURNAL_ELEMENTS_1 = 94,
  DATA_TEXTURES_JOURNAL_ENTRY_BG_0 = 86,
  DATA_TEXTURES_JOURNAL_ENTRY_ITEMS_0 = 92,
  DATA_TEXTURES_JOURNAL_ENTRY_MONS_0 = 88,
  DATA_TEXTURES_JOURNAL_ENTRY_MONS_BIG_0 = 89,
  DATA_TEXTURES_JOURNAL_ENTRY_PEOPLE_0 = 90,
  DATA_TEXTURES_JOURNAL_ENTRY_PEOPLE_1 = 91,
  DATA_TEXTURES_JOURNAL_ENTRY_PLACE_0 = 87,
  DATA_TEXTURES_JOURNAL_ENTRY_TRAPS_0 = 95,
  DATA_TEXTURES_JOURNAL_ENTRY_TRAPS_1 = 96,
  DATA_TEXTURES_JOURNAL_ENTRY_TRAPS_2 = 97,
  DATA_TEXTURES_JOURNAL_ENTRY_TRAPS_3 = 100,
  DATA_TEXTURES_JOURNAL_PAGEFLIP_0 = 77,
  DATA_TEXTURES_JOURNAL_PAGETORN_0 = 75,
  DATA_TEXTURES_JOURNAL_SELECT_0 = 78,
  DATA_TEXTURES_JOURNAL_STICKERS_0 = 79,
  DATA_TEXTURES_JOURNAL_STICKERS_1 = 80,
  DATA_TEXTURES_JOURNAL_STICKERS_2 = 81,
  DATA_TEXTURES_JOURNAL_STORY_0 = 98,
  DATA_TEXTURES_JOURNAL_TOP_ENTRY_0 = 83,
  DATA_TEXTURES_JOURNAL_TOP_GAMEOVER_0 = 84,
  DATA_TEXTURES_JOURNAL_TOP_MAIN_0 = 82,
  DATA_TEXTURES_JOURNAL_TOP_PROFILE_0 = 85,
  DATA_TEXTURES_JOURNAL_TROPHIES_0 = 99,
  DATA_TEXTURES_KEYBOARD_BUTTONS_0 = 74,
  DATA_TEXTURES_LOADING_0 = 1,
  DATA_TEXTURES_LUT_BACKLAYER_0 = 396,
  DATA_TEXTURES_LUT_BLACKMARKET_0 = 397,
  DATA_TEXTURES_LUT_ICECAVES_0 = 399,
  DATA_TEXTURES_LUT_ORIGINAL_0 = 395,
  DATA_TEXTURES_LUT_VLAD_0 = 398,
  DATA_TEXTURES_MAIN_BODY_0 = 23,
  DATA_TEXTURES_MAIN_DIRT_0 = 24,
  DATA_TEXTURES_MAIN_DOORBACK_0 = 26,
  DATA_TEXTURES_MAIN_DOORFRAME_0 = 27,
  DATA_TEXTURES_MAIN_DOOR_0 = 25,
  DATA_TEXTURES_MAIN_FORE1_0 = 28,
  DATA_TEXTURES_MAIN_FORE2_0 = 29,
  DATA_TEXTURES_MAIN_HEAD_0 = 30,
  DATA_TEXTURES_MENU_BASIC_0 = 41,
  DATA_TEXTURES_MENU_BASIC_1 = 42,
  DATA_TEXTURES_MENU_BASIC_2 = 43,
  DATA_TEXTURES_MENU_BASIC_3 = 44,
  DATA_TEXTURES_MENU_BASIC_4 = 45,
  DATA_TEXTURES_MENU_BASIC_5 = 46,
  DATA_TEXTURES_MENU_BASIC_6 = 47,
  DATA_TEXTURES_MENU_BRICK1_0 = 39,
  DATA_TEXTURES_MENU_BRICK2_0 = 40,
  DATA_TEXTURES_MENU_CAVE1_0 = 37,
  DATA_TEXTURES_MENU_CAVE2_0 = 38,
  DATA_TEXTURES_MENU_CHARDOOR_0 = 35,
  DATA_TEXTURES_MENU_CHARSEL_0 = 34,
  DATA_TEXTURES_MENU_DEATHMATCH2_0 = 54,
  DATA_TEXTURES_MENU_DEATHMATCH2_1 = 55,
  DATA_TEXTURES_MENU_DEATHMATCH3_0 = 56,
  DATA_TEXTURES_MENU_DEATHMATCH4_0 = 57,
  DATA_TEXTURES_MENU_DEATHMATCH5_0 = 58,
  DATA_TEXTURES_MENU_DEATHMATCH5_1 = 59,
  DATA_TEXTURES_MENU_DEATHMATCH5_2 = 60,
  DATA_TEXTURES_MENU_DEATHMATCH5_3 = 61,
  DATA_TEXTURES_MENU_DEATHMATCH6_0 = 62,
  DATA_TEXTURES_MENU_DEATHMATCH_0 = 53,
  DATA_TEXTURES_MENU_DISP_0 = 31,
  DATA_TEXTURES_MENU_DISP_1 = 32,
  DATA_TEXTURES_MENU_DISP_2 = 33,
  DATA_TEXTURES_MENU_GENERIC_0 = 36,
  DATA_TEXTURES_MENU_HEADER_0 = 48,
  DATA_TEXTURES_MENU_LEADER_0 = 49,
  DATA_TEXTURES_MENU_LEADER_1 = 50,
  DATA_TEXTURES_MENU_LEADER_2 = 51,
  DATA_TEXTURES_MENU_LEADER_3 = 52,
  DATA_TEXTURES_MENU_ONLINE_0 = 63,
  DATA_TEXTURES_MENU_TITLEGAL_0 = 22,
  DATA_TEXTURES_MENU_TITLE_0 = 21,
  DATA_TEXTURES_MENU_TUNNEL_0 = 64,
  DATA_TEXTURES_MONSTERS01_0 = 311,
  DATA_TEXTURES_MONSTERS02_0 = 312,
  DATA_TEXTURES_MONSTERS02_1 = 371,
  DATA_TEXTURES_MONSTERS02_2 = 372,
  DATA_TEXTURES_MONSTERS03_0 = 313,
  DATA_TEXTURES_MONSTERS03_1 = 314,
  DATA_TEXTURES_MONSTERSBASIC01_0 = 308,
  DATA_TEXTURES_MONSTERSBASIC02_0 = 309,
  DATA_TEXTURES_MONSTERSBASIC03_0 = 310,
  DATA_TEXTURES_MONSTERSBIG01_0 = 315,
  DATA_TEXTURES_MONSTERSBIG02_0 = 316,
  DATA_TEXTURES_MONSTERSBIG02_1 = 317,
  DATA_TEXTURES_MONSTERSBIG02_2 = 318,
  DATA_TEXTURES_MONSTERSBIG03_0 = 319,
  DATA_TEXTURES_MONSTERSBIG04_0 = 320,
  DATA_TEXTURES_MONSTERSBIG04_1 = 321,
  DATA_TEXTURES_MONSTERSBIG04_2 = 322,
  DATA_TEXTURES_MONSTERSBIG04_3 = 370,
  DATA_TEXTURES_MONSTERSBIG05_0 = 323,
  DATA_TEXTURES_MONSTERSBIG05_1 = 324,
  DATA_TEXTURES_MONSTERSBIG05_2 = 326,
  DATA_TEXTURES_MONSTERSBIG05_3 = 327,
  DATA_TEXTURES_MONSTERSBIG05_4 = 328,
  DATA_TEXTURES_MONSTERSBIG06_0 = 329,
  DATA_TEXTURES_MONSTERSBIG06_1 = 330,
  DATA_TEXTURES_MONSTERSBIG06_2 = 331,
  DATA_TEXTURES_MONSTERSBIG06_3 = 332,
  DATA_TEXTURES_MONSTERSBIG06_4 = 333,
  DATA_TEXTURES_MONSTERSBIG06_5 = 334,
  DATA_TEXTURES_MONSTERSBIG06_6 = 335,
  DATA_TEXTURES_MONSTERSBIG06_7 = 336,
  DATA_TEXTURES_MONSTERSBIG06_8 = 337,
  DATA_TEXTURES_MONSTERSBIG06_9 = 338,
  DATA_TEXTURES_MONSTERSBIG06_10 = 339,
  DATA_TEXTURES_MONSTERS_GHOST_0 = 340,
  DATA_TEXTURES_MONSTERS_GHOST_1 = 341,
  DATA_TEXTURES_MONSTERS_HUNDUN_0 = 364,
  DATA_TEXTURES_MONSTERS_HUNDUN_1 = 365,
  DATA_TEXTURES_MONSTERS_HUNDUN_2 = 366,
  DATA_TEXTURES_MONSTERS_HUNDUN_3 = 367,
  DATA_TEXTURES_MONSTERS_HUNDUN_4 = 368,
  DATA_TEXTURES_MONSTERS_HUNDUN_5 = 369,
  DATA_TEXTURES_MONSTERS_OLMEC_0 = 342,
  DATA_TEXTURES_MONSTERS_OLMEC_1 = 343,
  DATA_TEXTURES_MONSTERS_OLMEC_2 = 344,
  DATA_TEXTURES_MONSTERS_OLMEC_3 = 345,
  DATA_TEXTURES_MONSTERS_OLMEC_4 = 346,
  DATA_TEXTURES_MONSTERS_OSIRIS_0 = 347,
  DATA_TEXTURES_MONSTERS_OSIRIS_1 = 348,
  DATA_TEXTURES_MONSTERS_OSIRIS_2 = 349,
  DATA_TEXTURES_MONSTERS_OSIRIS_3 = 350,
  DATA_TEXTURES_MONSTERS_OSIRIS_4 = 351,
  DATA_TEXTURES_MONSTERS_PETS_0 = 307,
  DATA_TEXTURES_MONSTERS_TIAMAT_0 = 352,
  DATA_TEXTURES_MONSTERS_TIAMAT_1 = 353,
  DATA_TEXTURES_MONSTERS_TIAMAT_2 = 354,
  DATA_TEXTURES_MONSTERS_TIAMAT_3 = 355,
  DATA_TEXTURES_MONSTERS_TIAMAT_4 = 356,
  DATA_TEXTURES_MONSTERS_TIAMAT_5 = 357,
  DATA_TEXTURES_MONSTERS_TIAMAT_6 = 358,
  DATA_TEXTURES_MONSTERS_TIAMAT_7 = 359,
  DATA_TEXTURES_MONSTERS_TIAMAT_8 = 360,
  DATA_TEXTURES_MONSTERS_YAMA_0 = 361,
  DATA_TEXTURES_MONSTERS_YAMA_1 = 362,
  DATA_TEXTURES_MONSTERS_YAMA_2 = 363,
  DATA_TEXTURES_MOUNTS_0 = 374,
  DATA_TEXTURES_NOISE0_0 = 393,
  DATA_TEXTURES_NOISE1_0 = 394,
  DATA_TEXTURES_PLACEHOLDER_0 = 0,
  DATA_TEXTURES_SAVING_0 = 2,
  DATA_TEXTURES_SHADOWS_0 = 384,
  DATA_TEXTURES_SHINE_0 = 400,
  DATA_TEXTURES_SPLASH0_0 = 3,
  DATA_TEXTURES_SPLASH1_0 = 4,
  DATA_TEXTURES_SPLASH2_0 = 5
}
---@alias TEXTURE integer
THEME = {
  ABZU = 13,
  ARENA = 18,
  BASE_CAMP = 17,
  CITY_OF_GOLD = 11,
  COSMIC_OCEAN = 10,
  DUAT = 12,
  DWELLING = 1,
  EGGPLANT_WORLD = 15,
  HUNDUN = 16,
  ICE_CAVES = 7,
  JUNGLE = 2,
  NEO_BABYLON = 8,
  OLMEC = 4,
  SUNKEN_CITY = 9,
  TEMPLE = 6,
  TIAMAT = 14,
  TIDE_POOL = 5,
  VOLCANA = 3
}
---@alias THEME integer
THEME_OVERRIDE = {
  BACKLAYER_LIGHT_LEVEL = 40,
  BASE = 0,
  BASE_ID = 27,
  COFFIN = 10,
  ENT_BACKWALL = 33,
  ENT_BORDER = 34,
  ENT_CRITTER = 35,
  ENT_FLOOR_SPREADING = 28,
  ENT_FLOOR_SPREADING2 = 29,
  FEELING = 11,
  GET_UNKNOWN1_OR_2 = 43,
  GRAVITY = 36,
  INIT_FLAGS = 2,
  INIT_LEVEL = 3,
  LEVEL_HEIGHT = 46,
  LOOP = 41,
  LVL_FILE = 25,
  PLAYER_DAMAGE = 37,
  POST_PROCESS_ENTITIES = 17,
  POST_PROCESS_LEVEL = 15,
  POST_TRANSITION = 22,
  PRE_TRANSITION = 45,
  SPAWN_BACKGROUND = 19,
  SPAWN_BORDER = 14,
  SPAWN_DECORATION = 48,
  SPAWN_DECORATION2 = 49,
  SPAWN_EFFECTS = 24,
  SPAWN_EXTRA = 50,
  SPAWN_LEVEL = 13,
  SPAWN_LIGHTS = 20,
  SPAWN_PLAYERS = 23,
  SPAWN_PROCEDURAL = 18,
  SPAWN_TRANSITION = 21,
  SPAWN_TRAPS = 16,
  SPECIAL_ROOMS = 6,
  TEXTURE_BACKLAYER_LUT = 39,
  TEXTURE_DYNAMIC = 44,
  THEME_ID = 26,
  TRANSITION_MODIFIER = 31,
  UNKNOWN_V1 = 1,
  UNKNOWN_V4 = 4,
  UNKNOWN_V5 = 5,
  UNKNOWN_V7 = 7,
  UNKNOWN_V8 = 8,
  UNKNOWN_V12 = 12,
  UNKNOWN_V30 = 30,
  UNKNOWN_V32 = 32,
  UNKNOWN_V38 = 38,
  UNKNOWN_V47 = 47,
  UNKNOWN_V51 = 51,
  VAULT = 9,
  VAULT_LEVEL = 42
}
---@alias THEME_OVERRIDE integer
TILE_CODE = {
  ADJACENT_FLOOR = 29,
  ALIEN = 148,
  ALIENQUEEN = 154,
  ALIEN_GENERATOR = 156,
  ALTAR = 185,
  ALTAR_DUAT = 341,
  AMMIT = 174,
  ANKH = 197,
  ANUBIS = 130,
  ANUBIS2 = 253,
  APEP = 379,
  APEP_LEFT = 380,
  APEP_RIGHT = 381,
  ARROW_TRAP = 55,
  ASSASSIN = 254,
  AUTOWALLTORCH = 100,
  BABYLON_FLOOR = 18,
  BACK_HOVERPACK = 311,
  BACK_JETPACK = 309,
  BACK_POWERPACK = 312,
  BACK_TELEPACK = 310,
  BAT = 241,
  BAT_FLYING = 242,
  BEE = 257,
  BEEHIVE_FLOOR = 21,
  BEE_QUEEN = 258,
  BIGSPEAR_TRAP = 176,
  BODYGUARD = 230,
  BOMB = 285,
  BOMB_BAG = 283,
  BOMB_BOX = 284,
  BONE_BLOCK = 6,
  BONE_KEY = 305,
  BOOMBOX = 392,
  BOOMERANG = 318,
  BOULDER = 378,
  BUBBLE_PLATFORM = 369,
  BUNKBED = 75,
  BUSH_BLOCK = 7,
  CAMERA = 316,
  CAPE = 307,
  CATMUMMY = 135,
  CAVEMAN = 114,
  CAVEMANBOSS = 117,
  CAVEMANSHOPKEEPER = 219,
  CAVEMAN_ASLEEP = 115,
  CHAINANDBLOCKS_CEILING = 59,
  CHAIN_CEILING = 60,
  CHAIR_LOOKING_LEFT = 78,
  CHAIR_LOOKING_RIGHT = 79,
  CHALLENGE_WAITROOM = 218,
  CHUNK_AIR = 2,
  CHUNK_DOOR = 3,
  CHUNK_GROUND = 1,
  CLIMBING_GLOVES = 290,
  CLIMBING_POLE = 36,
  CLONEGUN = 324,
  CLOVER = 107,
  COARSE_LAVA = 235,
  COARSE_WATER = 233,
  COBRA = 132,
  COBWEB = 343,
  COFFIN = 196,
  COG_DOOR = 239,
  COG_FLOOR = 23,
  COMPASS = 295,
  COMPASS_ALIEN = 296,
  CONSTRUCTION_SIGN = 72,
  CONVEYORBELT_LEFT = 61,
  CONVEYORBELT_RIGHT = 62,
  COOKED_TURKEY = 105,
  COOKFIRE = 192,
  COSMIC_JELLY = 263,
  COSMIC_ORB = 339,
  COUCH = 80,
  CRABMAN = 374,
  CRATE = 92,
  CRATE_BOMBS = 93,
  CRATE_PARACHUTE = 95,
  CRATE_ROPES = 94,
  CRITTER_BUTTERFLY = 361,
  CRITTER_CRAB = 364,
  CRITTER_DRONE = 368,
  CRITTER_DUNGBEETLE = 360,
  CRITTER_FIREFLY = 367,
  CRITTER_FISH = 363,
  CRITTER_LOCUST = 365,
  CRITTER_PENGUIN = 366,
  CRITTER_SLIME = 389,
  CRITTER_SNAIL = 362,
  CROCMAN = 131,
  CROSSBOW = 202,
  CROWN = 301,
  CROWN_STATUE = 127,
  CRUSHING_ELEVATOR = 184,
  CRUSHTRAP = 64,
  CRUSHTRAPLARGE = 65,
  CURSED_POT = 109,
  DIAMOND = 277,
  DIE = 215,
  DININGTABLE = 76,
  DM_SPAWN_POINT = 50,
  DOG_SIGN = 82,
  DOOR = 43,
  DOOR2 = 45,
  DOOR2_SECRET = 46,
  DOOR_DROP_HELD = 47,
  DRESSER = 74,
  DRILL = 193,
  DUAT_FLOOR = 25,
  DUSTWALL = 240,
  EGGPLANT = 275,
  EGGPLANT_ALTAR = 157,
  EGGPLANT_CHILD = 159,
  EGGPLANT_CROWN = 302,
  EGGPLANT_DOOR = 179,
  EGGPLUP = 407,
  EGGSAC = 344,
  EGGSAC_BOTTOM = 348,
  EGGSAC_LEFT = 345,
  EGGSAC_RIGHT = 347,
  EGGSAC_TOP = 346,
  ELEVATOR = 68,
  ELIXIR = 287,
  EMERALD = 278,
  EMPRESS_GRAVE = 160,
  EMPTY = 0,
  EMPTY_MECH = 111,
  ENTRANCE = 40,
  ENTRANCE_SHORTCUT = 41,
  EXCALIBUR = 320,
  EXCALIBUR_BROKEN = 321,
  EXCALIBUR_STONE = 198,
  EXCALIBUR_STONE_EMPTY = 322,
  EXIT = 42,
  FACTORY_GENERATOR = 63,
  FALLING_PLATFORM = 58,
  FIREBUG = 248,
  FLOOR = 4,
  FLOOR_HARD = 28,
  FLYING_FISH = 373,
  FORCEFIELD = 217,
  FORCEFIELD_HORIZONTAL = 333,
  FORCEFIELD_HORIZONTAL_TOP = 334,
  FORCEFIELD_TIMED = 411,
  FORCEFIELD_TOP = 70,
  FOUNTAIN_DRAIN = 143,
  FOUNTAIN_HEAD = 142,
  FROG = 259,
  FROG_ORANGE = 260,
  FURNITURE_CHAIR_LOOKING_LEFT = 400,
  FURNITURE_CHAIR_LOOKING_RIGHT = 401,
  FURNITURE_CONSTRUCTION_SIGN = 397,
  FURNITURE_DININGTABLE = 402,
  FURNITURE_DRESSER = 393,
  FURNITURE_SIDETABLE = 404,
  FURNITURE_SINGLEBED = 398,
  GHIST_DOOR2 = 48,
  GHIST_PRESENT = 358,
  GHIST_SHOPKEEPER = 220,
  GHOST = 264,
  GHOST_MED_HAPPY = 266,
  GHOST_MED_SAD = 265,
  GHOST_SMALL_ANGRY = 267,
  GHOST_SMALL_HAPPY = 270,
  GHOST_SMALL_SAD = 268,
  GHOST_SMALL_SURPRISED = 269,
  GIANTCLAM = 141,
  GIANTFOOD = 286,
  GIANT_FLY = 372,
  GIANT_FROG = 180,
  GIANT_SPIDER = 122,
  GOLDBARS = 91,
  GOLD_BAR = 276,
  GROWABLE_CLIMBING_POLE = 37,
  GROWABLE_VINE = 35,
  GRUB = 349,
  GUN_FREEZERAY = 315,
  GUN_SHOTGUN = 314,
  GUN_WEBGUN = 313,
  GUTS_FLOOR = 27,
  HAUNTED_CORPSE = 110,
  HEDJET = 300,
  HERMITCRAB = 140,
  HONEY_DOWNWARDS = 200,
  HONEY_UPWARDS = 199,
  HOUYIBOW = 205,
  HUMPHEAD = 331,
  HUNDUN = 261,
  HUNDUN_SPIKES = 403,
  ICEFLOOR = 152,
  IDOL = 186,
  IDOL_FLOOR = 187,
  IDOL_HOLD = 188,
  IMP = 124,
  JIANGSHI = 138,
  JUMPDOG = 181,
  JUNGLE_FLOOR = 10,
  JUNGLE_SPEAR_TRAP = 57,
  KAPALA = 299,
  KEY = 203,
  KINGU = 144,
  LADDER = 32,
  LADDER_PLAT = 33,
  LAMASSU = 161,
  LAMP_HANG = 209,
  LANDMINE = 149,
  LASER_TRAP = 162,
  LAVA = 234,
  LAVAMANDER = 125,
  LAVA_POT = 354,
  LEAF = 271,
  LEPRECHAUN = 137,
  LIGHTARROW = 206,
  LION_TRAP = 238,
  LITTORCH = 97,
  LITWALLTORCH = 99,
  LIZARD = 245,
  LOCKEDCHEST = 101,
  LOCKED_DOOR = 49,
  MACHETE = 319,
  MADAMETUSK = 229,
  MANTRAP = 120,
  MATTOCK = 201,
  MERCHANT = 216,
  MINEWOOD_FLOOR = 12,
  MINEWOOD_FLOOR_HANGING_HIDE = 14,
  MINEWOOD_FLOOR_NOREPLACE = 13,
  MINISTER = 182,
  MOAI_STATUE = 158,
  MOLE = 246,
  MONKEY = 247,
  MONKEY_GOLD = 340,
  MOSQUITO = 121,
  MOTHERSHIP_FLOOR = 24,
  MOTHER_STATUE = 178,
  MOUNT_AXOLOTL = 329,
  MOUNT_QILIN = 330,
  MOUNT_ROCKDOG = 328,
  MOVABLE_SPIKES = 391,
  MUMMY = 133,
  MUSHROOM_BASE = 103,
  NECROMANCER = 136,
  NONREPLACEABLE_BABYLON_FLOOR = 19,
  NONREPLACEABLE_FLOOR = 5,
  OCTOPUS = 139,
  OLDHUNTER = 227,
  OLMEC = 128,
  OLMECSHIP = 173,
  OLMITE = 164,
  OLMITE_ARMORED = 384,
  OLMITE_HELMET = 383,
  OLMITE_NAKED = 382,
  OSIRIS = 252,
  PAGODA_FLOOR = 17,
  PAGODA_PLATFORM = 39,
  PALACE_BOOKCASE = 171,
  PALACE_CANDLE = 170,
  PALACE_CHANDELIER = 169,
  PALACE_ENTRANCE = 166,
  PALACE_FLOOR = 26,
  PALACE_SIGN = 359,
  PALACE_TABLE = 167,
  PALACE_TABLE_TRAY = 168,
  PANGXIE = 410,
  PARACHUTE = 297,
  PASTE = 294,
  PEN_FLOOR = 224,
  PEN_LOCKED_DOOR = 225,
  PET_MONTY = 335,
  PET_PERCY = 336,
  PET_POOCHI = 337,
  PILLAR = 129,
  PIPE = 175,
  PITCHERS_MITT = 291,
  PLASMA_CANNON = 204,
  PLATFORM = 38,
  PLAYERBAG = 306,
  POT = 108,
  POTOFGOLD = 90,
  POWDER_KEG = 54,
  POWDER_KEG_TIMED = 412,
  PRESENT = 332,
  PROTO_GENERATOR = 406,
  PROTO_SHOPKEEPER = 355,
  PUNISHBALL = 370,
  PUNISHBALL_ATTACH = 371,
  PUNISHBALL_ATTACH_BOTTOM = 388,
  PUNISHBALL_ATTACH_LEFT = 385,
  PUNISHBALL_ATTACH_RIGHT = 386,
  PUNISHBALL_ATTACH_TOP = 387,
  PUSH_BLOCK = 53,
  QUICKSAND = 66,
  QUILLBACK = 396,
  REDSKELETON = 244,
  REGENERATING_BLOCK = 31,
  ROBOT = 123,
  ROCK = 96,
  ROPE = 281,
  ROPE_PILE = 282,
  ROPE_UNROLLED = 338,
  ROYAL_JELLY = 106,
  RUBY = 280,
  SAPPHIRE = 279,
  SCARAB = 262,
  SCEPTER = 323,
  SCORPION = 116,
  SEEDED_RUN_UNLOCKER = 288,
  SHIELD_METAL = 326,
  SHIELD_WOODEN = 325,
  SHOES_SPIKE = 293,
  SHOES_SPRING = 292,
  SHOPKEEPER = 214,
  SHOPKEEPER_CLONE = 356,
  SHOPKEEPER_VAT = 155,
  SHOP_DOOR = 207,
  SHOP_ITEM = 221,
  SHOP_PAGODAWALL = 212,
  SHOP_SIGN = 208,
  SHOP_WALL = 210,
  SHOP_WOODWALL = 211,
  SHORTCUT_STATION_BANNER = 83,
  SIDETABLE = 77,
  SINGLEBED = 73,
  SISTER = 226,
  SKELETON = 243,
  SKELETON_KEY = 395,
  SKULL = 390,
  SKULL_DROP_TRAP = 353,
  SLEEPING_HIREDHAND = 222,
  SLIDINGWALL = 375,
  SLIDINGWALL_CEILING = 146,
  SLIDINGWALL_SWITCH = 145,
  SNAKE = 113,
  SNAP_TRAP = 112,
  SORCERESS = 134,
  SPARK_TRAP = 163,
  SPARROW = 405,
  SPECS = 289,
  SPIDER = 350,
  SPIDER_FALLING = 351,
  SPIDER_HANGING = 352,
  SPIKEBALL = 342,
  SPIKEBALL_NO_BOUNCE = 377,
  SPIKEBALL_TRAP = 376,
  SPIKES = 51,
  SPIKES_UPSIDEDOWN = 413,
  SPRING_TRAP = 151,
  STARTING_EXIT = 44,
  STICKY_TRAP = 177,
  STONE_FLOOR = 15,
  STORAGE_FLOOR = 189,
  STORAGE_GUY = 231,
  STYLED_FLOOR = 11,
  SUNKEN_FLOOR = 20,
  SURFACE_FLOOR = 8,
  SURFACE_HIDDEN_FLOOR = 9,
  TABLET = 304,
  TADPOLE = 357,
  TELEPORTER = 317,
  TELESCOPE = 84,
  TEMPLE_FLOOR = 16,
  THIEF = 228,
  THINICE = 153,
  THIN_ICE = 394,
  THORN_VINE = 56,
  TIAMAT = 172,
  TIKIMAN = 118,
  TIMED_FORCEFIELD = 69,
  TIMED_POWDER_KEG = 67,
  TOMB_FLOOR = 30,
  TOTEM_TRAP = 237,
  TREASURE = 87,
  TREASURE_CHEST = 88,
  TREASURE_VAULTCHEST = 89,
  TREE_BASE = 102,
  TRUE_CROWN = 303,
  TUN = 408,
  TURKEY = 104,
  TUTORIAL_MENU_SIGN = 274,
  TUTORIAL_SPEEDRUN_SIGN = 273,
  TV = 81,
  UDJAT_CHEST = 399,
  UDJAT_EYE = 298,
  UDJAT_KEY = 272,
  UDJAT_SOCKET = 194,
  UDJAT_TARGET = 327,
  UFO = 147,
  UPSIDEDOWN_SPIKES = 52,
  USHABTI = 71,
  VAMPIRE = 249,
  VAMPIRE_FLYING = 250,
  VAN_HORSING = 409,
  VAULT_WALL = 195,
  VINE = 34,
  VLAD = 126,
  VLADS_CAPE = 308,
  VLAD_FLOOR = 22,
  VLAD_FLYING = 251,
  WALLTORCH = 98,
  WANTED_POSTER = 213,
  WATER = 232,
  WITCHDOCTOR = 119,
  WOODENLOG_TRAP = 190,
  WOODENLOG_TRAP_CEILING = 191,
  YAMA = 183,
  YANG = 223,
  YETI = 150,
  YETI_KING = 255,
  YETI_QUEEN = 256,
  ZOO_EXHIBIT = 165
}
---@alias TILE_CODE integer
TUSK = {
  ANGRY = -2,
  DEAD = -1,
  DICE_HOUSE_SPAWNED = 1,
  HIGH_ROLLER_STATUS = 2,
  PALACE_WELCOME_MESSAGE = 3,
  QUEST_NOT_STARTED = 0
}
---@alias TUSK integer
VANHORSING = {
  FIRST_ENCOUNTER_DIAMOND_THROWN = 2,
  JAILCELL_SPAWNED = 1,
  QUEST_NOT_STARTED = 0,
  SECOND_ENCOUNTER_COMPASS_THROWN = 6,
  SHOT_VLAD = 4,
  SPAWNED_IN_VLADS_CASTLE = 3,
  TEMPLE_HIDEOUT_SPAWNED = 5,
  TUSK_CELLAR = 7
}
---@alias VANHORSING integer
VANILLA_FONT_STYLE = {
  BOLD = 2,
  ITALIC = 1,
  NORMAL = 0
}
---@alias VANILLA_FONT_STYLE integer
VANILLA_SOUND = {
  BGM_BGM_BASECAMP = "BGM/BGM_basecamp",
  BGM_BGM_CREDITS = "BGM/BGM_credits",
  BGM_BGM_DM = "BGM/BGM_dm",
  BGM_BGM_ENDING = "BGM/BGM_ending",
  BGM_BGM_MASTER = "BGM/BGM_master",
  BGM_BGM_MENU = "BGM/BGM_menu",
  BGM_BGM_TITLE = "BGM/BGM_title",
  CRITTERS_DRONE_CRASH = "Critters/Drone_crash",
  CRITTERS_DRONE_LOOP = "Critters/Drone_loop",
  CRITTERS_FIREFLY_FLASH = "Critters/Firefly_flash",
  CRITTERS_LOCUST_LOOP = "Critters/Locust_loop",
  CRITTERS_PENGUIN_JUMP1 = "Critters/Penguin_jump1",
  CRITTERS_PENGUIN_JUMP2 = "Critters/Penguin_jump2",
  CRITTERS_SNAIL_ATTACH = "Critters/Snail_attach",
  CUTSCENE_ANKH_CRACK = "Cutscene/Ankh_crack",
  CUTSCENE_ANKH_LOOP = "Cutscene/Ankh_loop",
  CUTSCENE_ANKH_PULSE = "Cutscene/Ankh_pulse",
  CUTSCENE_ANKH_SHATTER = "Cutscene/Ankh_shatter",
  CUTSCENE_BIG_TREASURE_LAND = "Cutscene/Big_treasure_land",
  CUTSCENE_BIG_TREASURE_OPEN = "Cutscene/Big_treasure_open",
  CUTSCENE_CAVE_RUMBLE = "Cutscene/Cave_rumble",
  CUTSCENE_CONSTELLATION_LOOP = "Cutscene/Constellation_loop",
  CUTSCENE_CREDITS_ASTEROID = "Cutscene/Credits_asteroid",
  CUTSCENE_CREDITS_THRUSTER_LOOP = "Cutscene/Credits_thruster_loop",
  CUTSCENE_CREDITS_UFO_BONK = "Cutscene/Credits_ufo_bonk",
  CUTSCENE_EGGSHIP_AMB_LOOP = "Cutscene/Eggship_amb_loop",
  CUTSCENE_EGGSHIP_DOOR = "Cutscene/Eggship_door",
  CUTSCENE_EGGSHIP_EMERGE = "Cutscene/Eggship_emerge",
  CUTSCENE_EGGSHIP_LAND = "Cutscene/Eggship_land",
  CUTSCENE_EGGSHIP_LOOP = "Cutscene/Eggship_loop",
  CUTSCENE_EGGSHIP_THRUSTER_LOOP = "Cutscene/Eggship_thruster_loop",
  CUTSCENE_JOURNAL_PAGE = "Cutscene/Journal_page",
  CUTSCENE_KEY_DROP = "Cutscene/Key_drop",
  CUTSCENE_MENU_INTRO_LOOP = "Cutscene/Menu_intro_loop",
  CUTSCENE_OUROBOROS_DOOR_LOOP = "Cutscene/Ouroboros_door_loop",
  CUTSCENE_OUROBOROS_LOOP = "Cutscene/Ouroboros_loop",
  CUTSCENE_OUROBOROS_SHAKE = "Cutscene/Ouroboros_shake",
  CUTSCENE_RUMBLE_LOOP = "Cutscene/Rumble_loop",
  DEATHMATCH_DM_BANNER = "Deathmatch/dm_banner",
  DEATHMATCH_DM_COUNTDOWN = "Deathmatch/dm_countdown",
  DEATHMATCH_DM_ITEM_SPAWN = "Deathmatch/dm_item_spawn",
  DEATHMATCH_DM_ITEM_WARN = "Deathmatch/dm_item_warn",
  DEATHMATCH_DM_PILLAR_CRUSH = "Deathmatch/dm_pillar_crush",
  DEATHMATCH_DM_PILLAR_LOOP = "Deathmatch/dm_pillar_loop",
  DEATHMATCH_DM_SCORE = "Deathmatch/dm_score",
  DEATHMATCH_DM_SPLASH = "Deathmatch/dm_splash",
  DEATHMATCH_DM_TIMER = "Deathmatch/dm_timer",
  DEFAULT_SOUND = "default_sound",
  ENEMIES_ALIEN_JUMP = "Enemies/Alien_jump",
  ENEMIES_ALIEN_QUEEN_LOOP = "Enemies/Alien_queen_loop",
  ENEMIES_ALIEN_QUEEN_SHOT = "Enemies/Alien_queen_shot",
  ENEMIES_ALIEN_QUEEN_SIGHT_LOOP = "Enemies/Alien_queen_sight_loop",
  ENEMIES_ALIEN_SPEECH = "Enemies/Alien_speech",
  ENEMIES_AMMIT_WALK = "Enemies/Ammit_walk",
  ENEMIES_ANUBIS_ACTIVATE = "Enemies/Anubis_activate",
  ENEMIES_ANUBIS_ATK = "Enemies/Anubis_atk",
  ENEMIES_ANUBIS_SPECIAL_SHOT = "Enemies/Anubis_special_shot",
  ENEMIES_ANUBIS_WARN = "Enemies/Anubis_warn",
  ENEMIES_APEP_BODY_LOOP = "Enemies/Apep_body_loop",
  ENEMIES_APEP_HEAD_LOOP = "Enemies/Apep_head_loop",
  ENEMIES_BAT_FLAP = "Enemies/Bat_flap",
  ENEMIES_BEE_LOOP = "Enemies/Bee_loop",
  ENEMIES_BEE_QUEEN_LOOP = "Enemies/Bee_queen_loop",
  ENEMIES_BOSS_CAVEMAN_BONK = "Enemies/Boss_caveman_bonk",
  ENEMIES_BOSS_CAVEMAN_CRUSH = "Enemies/Boss_caveman_crush",
  ENEMIES_BOSS_CAVEMAN_JUMP = "Enemies/Boss_caveman_jump",
  ENEMIES_BOSS_CAVEMAN_LAND = "Enemies/Boss_caveman_land",
  ENEMIES_BOSS_CAVEMAN_ROLL_LOOP = "Enemies/Boss_caveman_roll_loop",
  ENEMIES_BOSS_CAVEMAN_STEP = "Enemies/Boss_caveman_step",
  ENEMIES_BOSS_CAVEMAN_STOMP = "Enemies/Boss_caveman_stomp",
  ENEMIES_CATMUMMY_ATK = "Enemies/Catmummy_atk",
  ENEMIES_CATMUMMY_JUMP = "Enemies/Catmummy_jump",
  ENEMIES_CATMUMMY_RUN = "Enemies/Catmummy_run",
  ENEMIES_CAVEMAN_PRAY_LOOP = "Enemies/Caveman_pray_loop",
  ENEMIES_CAVEMAN_STEP = "Enemies/Caveman_step",
  ENEMIES_CAVEMAN_TALK = "Enemies/Caveman_talk",
  ENEMIES_CAVEMAN_TRIGGER = "Enemies/Caveman_trigger",
  ENEMIES_COBRA_ATK = "Enemies/Cobra_atk",
  ENEMIES_CROCMAN_ATK = "Enemies/Crocman_atk",
  ENEMIES_CROCMAN_TRIGGER = "Enemies/Crocman_trigger",
  ENEMIES_EGGPLANT_DOG_BOUNCE = "Enemies/Eggplant_dog_bounce",
  ENEMIES_EGGPLANT_MINISTER_LOOP = "Enemies/Eggplant_minister_loop",
  ENEMIES_EGGPLANT_MINISTER_MORPH = "Enemies/Eggplant_minister_morph",
  ENEMIES_EGGSAC_BURST = "Enemies/Eggsac_burst",
  ENEMIES_EGGSAC_WARN = "Enemies/Eggsac_warn",
  ENEMIES_ENEMY_HIT_INVINCIBLE = "Enemies/Enemy_hit_invincible",
  ENEMIES_FIREBUG_ARM = "Enemies/Firebug_arm",
  ENEMIES_FIREBUG_ATK_LOOP = "Enemies/Firebug_atk_loop",
  ENEMIES_FIREBUG_FLY_LOOP = "Enemies/Firebug_fly_loop",
  ENEMIES_FLYINGFISH_BONK = "Enemies/Flyingfish_bonk",
  ENEMIES_FLYINGFISH_FLAP = "Enemies/Flyingfish_flap",
  ENEMIES_FLYINGFISH_WIGGLE = "Enemies/Flyingfish_wiggle",
  ENEMIES_FROG_CHARGE_LOOP = "Enemies/Frog_charge_loop",
  ENEMIES_FROG_EAT = "Enemies/Frog_eat",
  ENEMIES_FROG_GIANT_OPEN = "Enemies/Frog_giant_open",
  ENEMIES_FROG_JUMP = "Enemies/Frog_jump",
  ENEMIES_GHIST_LOOP = "Enemies/Ghist_loop",
  ENEMIES_GHOST_LOOP = "Enemies/Ghost_loop",
  ENEMIES_GHOST_SPLIT = "Enemies/Ghost_split",
  ENEMIES_GIANT_FLY_EAT = "Enemies/Giant_fly_eat",
  ENEMIES_GIANT_FLY_LOOP = "Enemies/Giant_fly_loop",
  ENEMIES_GIANT_SPIDER_DROP = "Enemies/Giant_spider_drop",
  ENEMIES_GIANT_SPIDER_JUMP = "Enemies/Giant_spider_jump",
  ENEMIES_GIANT_SPIDER_WALK = "Enemies/Giant_spider_walk",
  ENEMIES_GOLD_MONKEY_JUMP = "Enemies/Gold_monkey_jump",
  ENEMIES_GOLD_MONKEY_POOP = "Enemies/Gold_monkey_poop",
  ENEMIES_GRUB_EVOLVE = "Enemies/Grub_evolve",
  ENEMIES_GRUB_JUMP = "Enemies/Grub_jump",
  ENEMIES_GRUB_LOOP = "Enemies/Grub_loop",
  ENEMIES_HANGSPIDER_ATK = "Enemies/Hangspider_atk",
  ENEMIES_HERMITCRAB_ATK = "Enemies/Hermitcrab_atk",
  ENEMIES_HERMITCRAB_MORPH = "Enemies/Hermitcrab_morph",
  ENEMIES_HUMPHEAD_LOOP = "Enemies/Humphead_loop",
  ENEMIES_HUNDUN_ATK = "Enemies/Hundun_atk",
  ENEMIES_HUNDUN_DEATH_LAND = "Enemies/Hundun_death_land",
  ENEMIES_HUNDUN_HEAD_DESTROY = "Enemies/Hundun_head_destroy",
  ENEMIES_HUNDUN_HEAD_EMERGE = "Enemies/Hundun_head_emerge",
  ENEMIES_HUNDUN_HURT = "Enemies/Hundun_hurt",
  ENEMIES_HUNDUN_STEP = "Enemies/Hundun_step",
  ENEMIES_HUNDUN_WARN = "Enemies/Hundun_warn",
  ENEMIES_HUNDUN_WINGS_EMERGE = "Enemies/Hundun_wings_emerge",
  ENEMIES_HUNDUN_WING_FLAP = "Enemies/Hundun_wing_flap",
  ENEMIES_IMP_DROP = "Enemies/Imp_drop",
  ENEMIES_IMP_FLAP = "Enemies/Imp_flap",
  ENEMIES_JELLYFISH_LOOP = "Enemies/Jellyfish_loop",
  ENEMIES_JIANGSHI_CHARGE = "Enemies/Jiangshi_charge",
  ENEMIES_JIANGSHI_FEMALE_JUMP = "Enemies/Jiangshi_female_jump",
  ENEMIES_JIANGSHI_FLIP = "Enemies/Jiangshi_flip",
  ENEMIES_JIANGSHI_JUMP = "Enemies/Jiangshi_jump",
  ENEMIES_KILLED_ENEMY = "Enemies/Killed_enemy",
  ENEMIES_KILLED_ENEMY_BONES = "Enemies/Killed_enemy_bones",
  ENEMIES_KILLED_ENEMY_CORPSE = "Enemies/Killed_enemy_corpse",
  ENEMIES_KINGU_GRIP = "Enemies/Kingu_grip",
  ENEMIES_KINGU_HURT = "Enemies/Kingu_hurt",
  ENEMIES_KINGU_SLIDE_LOOP = "Enemies/Kingu_slide_loop",
  ENEMIES_LAMASSU_AIM_LOCK = "Enemies/Lamassu_aim_lock",
  ENEMIES_LAMASSU_AIM_LOOP = "Enemies/Lamassu_aim_loop",
  ENEMIES_LAMASSU_ATK_HIT = "Enemies/Lamassu_atk_hit",
  ENEMIES_LAMASSU_ATK_LOOP = "Enemies/Lamassu_atk_loop",
  ENEMIES_LAMASSU_FLY = "Enemies/Lamassu_fly",
  ENEMIES_LAMASSU_WALK = "Enemies/Lamassu_walk",
  ENEMIES_LAVAMANDER_ATK = "Enemies/Lavamander_atk",
  ENEMIES_LAVAMANDER_CHARGE = "Enemies/Lavamander_charge",
  ENEMIES_LAVAMANDER_JUMP = "Enemies/Lavamander_jump",
  ENEMIES_LAVAMANDER_TRANSFORM = "Enemies/Lavamander_transform",
  ENEMIES_LEPRECHAUN_JUMP = "Enemies/Leprechaun_jump",
  ENEMIES_LEPRECHAUN_LOOP = "Enemies/Leprechaun_loop",
  ENEMIES_LEPRECHAUN_STEAL_LOOP = "Enemies/Leprechaun_steal_loop",
  ENEMIES_LIZARD_BONK = "Enemies/Lizard_bonk",
  ENEMIES_LIZARD_CURL_LOOP = "Enemies/Lizard_curl_loop",
  ENEMIES_LIZARD_JUMP = "Enemies/Lizard_jump",
  ENEMIES_LIZARD_UNROLL = "Enemies/Lizard_unroll",
  ENEMIES_MAGMAMAN_JUMP = "Enemies/Magmaman_jump",
  ENEMIES_MAGMAMAN_TRANSFORM = "Enemies/Magmaman_transform",
  ENEMIES_MANTRAP_BITE = "Enemies/Mantrap_bite",
  ENEMIES_MOLERAT_DIG_LOOP = "Enemies/Molerat_dig_loop",
  ENEMIES_MOLERAT_RUN_LOOP = "Enemies/Molerat_run_loop",
  ENEMIES_MONKEY_JUMP = "Enemies/Monkey_jump",
  ENEMIES_MONKEY_STEAL_END = "Enemies/Monkey_steal_end",
  ENEMIES_MONKEY_STEAL_LOOP = "Enemies/Monkey_steal_loop",
  ENEMIES_MOSQUITO_LOOP = "Enemies/Mosquito_loop",
  ENEMIES_MOSQUITO_PIERCE = "Enemies/Mosquito_pierce",
  ENEMIES_MUMMY_FLIES_LOOP = "Enemies/Mummy_flies_loop",
  ENEMIES_MUMMY_STEP = "Enemies/Mummy_step",
  ENEMIES_MUMMY_VOMIT = "Enemies/Mummy_vomit",
  ENEMIES_NECROMANCER_CHARGE_LOOP = "Enemies/Necromancer_charge_loop",
  ENEMIES_NECROMANCER_SPAWN = "Enemies/Necromancer_spawn",
  ENEMIES_OCTOPUS_ATK = "Enemies/Octopus_atk",
  ENEMIES_OCTOPUS_BONK = "Enemies/Octopus_bonk",
  ENEMIES_OCTOPUS_JUMP = "Enemies/Octopus_jump",
  ENEMIES_OCTOPUS_WALK = "Enemies/Octopus_walk",
  ENEMIES_OLMEC_BOMB_SPAWN = "Enemies/Olmec_bomb_spawn",
  ENEMIES_OLMEC_CRUSH = "Enemies/Olmec_crush",
  ENEMIES_OLMEC_HOVER_LOOP = "Enemies/Olmec_hover_loop",
  ENEMIES_OLMEC_PAD_BREAK = "Enemies/Olmec_pad_break",
  ENEMIES_OLMEC_PAD_SHOW = "Enemies/Olmec_pad_show",
  ENEMIES_OLMEC_SPLASH = "Enemies/Olmec_splash",
  ENEMIES_OLMEC_STOMP = "Enemies/Olmec_stomp",
  ENEMIES_OLMEC_TRANSFORM_CLOSE = "Enemies/Olmec_transform_close",
  ENEMIES_OLMEC_TRANSFORM_OPEN = "Enemies/Olmec_transform_open",
  ENEMIES_OLMEC_UFO_SPAWN = "Enemies/Olmec_ufo_spawn",
  ENEMIES_OLMEC_UNCOVER = "Enemies/Olmec_uncover",
  ENEMIES_OLMITE_ARMOR_BREAK = "Enemies/Olmite_armor_break",
  ENEMIES_OLMITE_JUMP = "Enemies/Olmite_jump",
  ENEMIES_OLMITE_STOMP = "Enemies/Olmite_stomp",
  ENEMIES_OSIRIS_APPEAR = "Enemies/Osiris_appear",
  ENEMIES_OSIRIS_PUNCH = "Enemies/Osiris_punch",
  ENEMIES_PANGXIE_BUBBLE_ATK = "Enemies/Pangxie_bubble_atk",
  ENEMIES_PANGXIE_PUNCH1 = "Enemies/Pangxie_punch1",
  ENEMIES_PANGXIE_PUNCH2 = "Enemies/Pangxie_punch2",
  ENEMIES_PROTO_BURST_LOOP = "Enemies/Proto_burst_loop",
  ENEMIES_PROTO_CRAWL = "Enemies/Proto_crawl",
  ENEMIES_ROBOT_LOOP = "Enemies/Robot_loop",
  ENEMIES_ROBOT_TRIGGER = "Enemies/Robot_trigger",
  ENEMIES_SCORPION_ATK = "Enemies/Scorpion_atk",
  ENEMIES_SKELETON_COLLAPSE = "Enemies/Skeleton_collapse",
  ENEMIES_SKELETON_MATERIALIZE = "Enemies/Skeleton_materialize",
  ENEMIES_SNAKE_ATK = "Enemies/Snake_atk",
  ENEMIES_SORCERESS_ATK = "Enemies/Sorceress_atk",
  ENEMIES_SORCERESS_ATK_SPAWN = "Enemies/Sorceress_atk_spawn",
  ENEMIES_SORCERESS_CHARGE_LOOP = "Enemies/Sorceress_charge_loop",
  ENEMIES_SORCERESS_JUMP = "Enemies/Sorceress_jump",
  ENEMIES_SPIDER_JUMP = "Enemies/Spider_jump",
  ENEMIES_SPIDER_TRIGGER = "Enemies/Spider_trigger",
  ENEMIES_STONE_TRANSFORM_LOOP = "Enemies/Stone_transform_loop",
  ENEMIES_STORAGE_KEEPER_DIE = "Enemies/Storage_keeper_die",
  ENEMIES_STORAGE_KEEPER_JUMP = "Enemies/Storage_keeper_jump",
  ENEMIES_TADPOLE_SWIM = "Enemies/Tadpole_swim",
  ENEMIES_TIAMAT_HURT = "Enemies/Tiamat_hurt",
  ENEMIES_TIAMAT_ORB_LOOP = "Enemies/Tiamat_orb_loop",
  ENEMIES_TIAMAT_SCEPTER = "Enemies/Tiamat_scepter",
  ENEMIES_TIAMAT_SCREAM1 = "Enemies/Tiamat_scream1",
  ENEMIES_TIAMAT_SCREAM2 = "Enemies/Tiamat_scream2",
  ENEMIES_TIKIMAN_TALK = "Enemies/Tikiman_talk",
  ENEMIES_UFO_ATK_END = "Enemies/UFO_atk_end",
  ENEMIES_UFO_ATK_LOOP = "Enemies/UFO_atk_loop",
  ENEMIES_UFO_CHARGE = "Enemies/UFO_charge",
  ENEMIES_UFO_DAMAGE = "Enemies/UFO_damage",
  ENEMIES_UFO_EJECT = "Enemies/UFO_eject",
  ENEMIES_UFO_LOOP = "Enemies/UFO_loop",
  ENEMIES_VAMPIRE_JUMP = "Enemies/Vampire_jump",
  ENEMIES_VLAD_TRIGGER = "Enemies/Vlad_trigger",
  ENEMIES_WITCHDOCTOR_CHANT_LOOP = "Enemies/Witchdoctor_chant_loop",
  ENEMIES_WITCHDOCTOR_STAB = "Enemies/Witchdoctor_stab",
  ENEMIES_WITCHDOCTOR_TALK = "Enemies/Witchdoctor_talk",
  ENEMIES_WITCHDOCTOR_TRIGGER = "Enemies/Witchdoctor_trigger",
  ENEMIES_YETI_BIG_CHARGE = "Enemies/Yeti_big_charge",
  ENEMIES_YETI_BIG_PUNCH = "Enemies/Yeti_big_punch",
  ENEMIES_YETI_BIG_STEP = "Enemies/Yeti_big_step",
  ENEMIES_YETI_KING_ROAR = "Enemies/Yeti_king_roar",
  ENEMIES_YETI_QUEEN_JUMP = "Enemies/Yeti_queen_jump",
  ENEMIES_YETI_QUEEN_SLAM = "Enemies/Yeti_queen_slam",
  FX_FX_ANUBIS_WARN = "FX/FX_anubis_warn",
  FX_FX_COSMIC_ORB = "FX/FX_cosmic_orb",
  FX_FX_CURSE = "FX/FX_curse",
  FX_FX_DM_BANNER = "FX/FX_dm_banner",
  FX_FX_JOURNAL_ENTRY = "FX/FX_journal_entry",
  FX_FX_JOURNAL_PAGE = "FX/FX_journal_page",
  ITEMS_ARROW_STICK = "Items/Arrow_stick",
  ITEMS_BACKPACK_WARN = "Items/Backpack_warn",
  ITEMS_BOMB_BIG_TIMER = "Items/Bomb_big_timer",
  ITEMS_BOMB_STICK = "Items/Bomb_stick",
  ITEMS_BOMB_TIMER = "Items/Bomb_timer",
  ITEMS_BOOMBOX_OFF = "Items/Boombox_off",
  ITEMS_BOOMERANG_CATCH = "Items/Boomerang_catch",
  ITEMS_BOOMERANG_LOOP = "Items/Boomerang_loop",
  ITEMS_BOW = "Items/Bow",
  ITEMS_BOW_RELOAD = "Items/Bow_reload",
  ITEMS_CAMERA = "Items/Camera",
  ITEMS_CAPE_LOOP = "Items/Cape_loop",
  ITEMS_CAPE_VLAD_FLAP = "Items/Cape_vlad_flap",
  ITEMS_CLONE_GUN = "Items/Clone_gun",
  ITEMS_COIN_BOUNCE = "Items/Coin_bounce",
  ITEMS_CROSSBOW = "Items/Crossbow",
  ITEMS_CROSSBOW_RELOAD = "Items/Crossbow_reload",
  ITEMS_DAMSEL_CALL = "Items/Damsel_call",
  ITEMS_DAMSEL_PET = "Items/Damsel_pet",
  ITEMS_EXCALIBUR = "Items/Excalibur",
  ITEMS_FREEZE_RAY = "Items/Freeze_ray",
  ITEMS_FREEZE_RAY_HIT = "Items/Freeze_ray_hit",
  ITEMS_HOVERPACK_LOOP = "Items/Hoverpack_loop",
  ITEMS_JETPACK_END = "Items/Jetpack_end",
  ITEMS_JETPACK_IGNITE = "Items/Jetpack_ignite",
  ITEMS_JETPACK_LOOP = "Items/Jetpack_loop",
  ITEMS_MACHETE = "Items/Machete",
  ITEMS_MATTOCK_BREAK = "Items/Mattock_break",
  ITEMS_MATTOCK_HIT = "Items/Mattock_hit",
  ITEMS_MATTOCK_SWING = "Items/Mattock_swing",
  ITEMS_PARACHUTE = "Items/Parachute",
  ITEMS_PLASMA_CANNON = "Items/Plasma_cannon",
  ITEMS_PLASMA_CANNON_CHARGE = "Items/Plasma_cannon_charge",
  ITEMS_ROPE_ATTACH = "Items/Rope_attach",
  ITEMS_ROPE_BURN_LOOP = "Items/Rope_burn_loop",
  ITEMS_SCEPTER = "Items/Scepter",
  ITEMS_SHOTGUN_FIRE = "Items/Shotgun_fire",
  ITEMS_SPRING_SHOES = "Items/Spring_shoes",
  ITEMS_TV_LOOP = "Items/TV_loop",
  ITEMS_UDJAT_BLINK = "Items/Udjat_blink",
  ITEMS_USHABTI_RATTLE = "Items/Ushabti_rattle",
  ITEMS_WEBGUN = "Items/Webgun",
  ITEMS_WEBGUN_HIT = "Items/Webgun_hit",
  ITEMS_WITCHDOCTORSKULL_LOOP = "Items/Witchdoctorskull_loop",
  ITEMS_WOODEN_SHIELD_BREAK = "Items/Wooden_shield_break",
  ITEMS_WOODEN_SHIELD_DAMAGE = "Items/Wooden_shield_damage",
  LIQUIDS_LAVA_STATIC_LOOP = "Liquids/Lava_static_loop",
  LIQUIDS_LAVA_STREAM_LOOP = "Liquids/Lava_stream_loop",
  LIQUIDS_WATER_REV_STREAM_LOOP = "Liquids/Water_rev_stream_loop",
  LIQUIDS_WATER_SPLASH = "Liquids/Water_splash",
  LIQUIDS_WATER_STREAM_LOOP = "Liquids/Water_stream_loop",
  MENU_CANCEL = "Menu/Cancel",
  MENU_CHARSEL_DESELECTION = "Menu/Charsel_deselection",
  MENU_CHARSEL_DOOR = "Menu/Charsel_door",
  MENU_CHARSEL_NAVI = "Menu/Charsel_navi",
  MENU_CHARSEL_QUICK_NAVI = "Menu/Charsel_quick_navi",
  MENU_CHARSEL_QUICK_NOPE = "Menu/Charsel_quick_nope",
  MENU_CHARSEL_QUICK_OPEN = "Menu/Charsel_quick_open",
  MENU_CHARSEL_SCROLL = "Menu/Charsel_scroll",
  MENU_CHARSEL_SELECTION = "Menu/Charsel_selection",
  MENU_CHARSEL_SELECTION2 = "Menu/Charsel_selection2",
  MENU_DIRT_FALL = "Menu/Dirt_fall",
  MENU_JOURNAL_STICKER = "Menu/Journal_sticker",
  MENU_MM_BAR = "Menu/MM_bar",
  MENU_MM_NAVI = "Menu/MM_navi",
  MENU_MM_OPTIONS_SUB = "Menu/MM_options_sub",
  MENU_MM_RESET = "Menu/MM_reset",
  MENU_MM_SELECTION = "Menu/MM_selection",
  MENU_MM_SET = "Menu/MM_set",
  MENU_MM_TOGGLE = "Menu/MM_toggle",
  MENU_NAVI = "Menu/Navi",
  MENU_PAGE_RETURN = "Menu/Page_return",
  MENU_PAGE_TURN = "Menu/Page_turn",
  MENU_SELECTION = "Menu/Selection",
  MENU_TITLE_SELECTION = "Menu/Title_selection",
  MENU_TITLE_TORCH_LOOP = "Menu/Title_torch_loop",
  MENU_ZOOM_IN = "Menu/Zoom_in",
  MENU_ZOOM_OUT = "Menu/Zoom_out",
  MOUNTS_AXOLOTL_ATK = "Mounts/Axolotl_atk",
  MOUNTS_AXOLOTL_ATK_HIT = "Mounts/Axolotl_atk_hit",
  MOUNTS_AXOLOTL_JUMP1 = "Mounts/Axolotl_jump1",
  MOUNTS_AXOLOTL_JUMP2 = "Mounts/Axolotl_jump2",
  MOUNTS_AXOLOTL_UNTAMED_LOOP = "Mounts/Axolotl_untamed_loop",
  MOUNTS_AXOLOTL_WALK = "Mounts/Axolotl_walk",
  MOUNTS_MECH_DRIVE_LOOP = "Mounts/Mech_drive_loop",
  MOUNTS_MECH_JUMP = "Mounts/Mech_jump",
  MOUNTS_MECH_PUNCH1 = "Mounts/Mech_punch1",
  MOUNTS_MECH_SMASH = "Mounts/Mech_smash",
  MOUNTS_MECH_SPARK = "Mounts/Mech_spark",
  MOUNTS_MECH_TRANSFORM = "Mounts/Mech_transform",
  MOUNTS_MECH_TURN = "Mounts/Mech_turn",
  MOUNTS_MECH_WALK1 = "Mounts/Mech_walk1",
  MOUNTS_MECH_WALK2 = "Mounts/Mech_walk2",
  MOUNTS_MECH_WARN = "Mounts/Mech_warn",
  MOUNTS_MOUNT = "Mounts/Mount",
  MOUNTS_MOUNT_LAND = "Mounts/Mount_land",
  MOUNTS_MOUNT_TAME = "Mounts/Mount_tame",
  MOUNTS_QILIN_FLY_LOOP = "Mounts/Qilin_fly_loop",
  MOUNTS_QILIN_HATCH = "Mounts/Qilin_hatch",
  MOUNTS_QILIN_JUMP1 = "Mounts/Qilin_jump1",
  MOUNTS_QILIN_JUMP2 = "Mounts/Qilin_jump2",
  MOUNTS_QILIN_WALK = "Mounts/Qilin_walk",
  MOUNTS_TURKEY_ATK = "Mounts/Turkey_atk",
  MOUNTS_TURKEY_FLAP = "Mounts/Turkey_flap",
  MOUNTS_TURKEY_JUMP = "Mounts/Turkey_jump",
  MOUNTS_TURKEY_UNTAMED_LOOP = "Mounts/Turkey_untamed_loop",
  MOUNTS_TURKEY_WALK = "Mounts/Turkey_walk",
  MOUNTS_WILDDOG_FIREBALL_LOOP = "Mounts/Wilddog_fireball_loop",
  MOUNTS_WILDDOG_JUMP1 = "Mounts/Wilddog_jump1",
  MOUNTS_WILDDOG_JUMP2 = "Mounts/Wilddog_jump2",
  MOUNTS_WILDDOG_UNTAMED_LOOP = "Mounts/Wilddog_untamed_loop",
  MOUNTS_WILDDOG_WALK = "Mounts/Wilddog_walk",
  PLAYER_DEATH_GHOST = "Player/Death_ghost",
  PLAYER_ENTER_DOOR = "Player/Enter_door",
  PLAYER_EQUIP = "Player/Equip",
  PLAYER_GRAB_LEDGE = "Player/Grab_ledge",
  PLAYER_INKED = "Player/Inked",
  PLAYER_JUMP = "Player/Jump",
  PLAYER_LAND_CHAIN = "Player/Land_chain",
  PLAYER_LISE_DRIVE_LOOP = "Player/LISE_drive_loop",
  PLAYER_LISE_LOADING_LOOP = "Player/LISE_loading_loop",
  PLAYER_LISE_PUSH_LOOP = "Player/LISE_push_loop",
  PLAYER_LISE_RADAR_LOOP = "Player/LISE_radar_loop",
  PLAYER_LISE_WARNING = "Player/LISE_warning",
  PLAYER_NO_ITEM = "Player/No_item",
  PLAYER_PGHOST_ATK = "Player/Pghost_atk",
  PLAYER_PGHOST_CHARGE_LOOP = "Player/Pghost_charge_loop",
  PLAYER_PGHOST_DASH = "Player/Pghost_dash",
  PLAYER_PGHOST_SHAKE = "Player/Pghost_shake",
  PLAYER_PGHOST_SPAWN = "Player/Pghost_spawn",
  PLAYER_PGHOST_SPIN = "Player/Pghost_spin",
  PLAYER_PUSH_BLOCK_LOOP = "Player/Push_block_loop",
  PLAYER_TOSS_ROPE = "Player/Toss_rope",
  PLAYER_WHIP1 = "Player/Whip1",
  PLAYER_WHIP2 = "Player/Whip2",
  PLAYER_WHIP_JUMP = "Player/Whip_jump",
  SHARED_ANGER = "Shared/Anger",
  SHARED_BLOCK_LAND = "Shared/Block_land",
  SHARED_BLOOD_SPLURT = "Shared/Blood_splurt",
  SHARED_BUBBLE_BONK = "Shared/Bubble_bonk",
  SHARED_BUBBLE_BURST = "Shared/Bubble_burst",
  SHARED_BUBBLE_BURST_BIG = "Shared/Bubble_burst_big",
  SHARED_CEILING_CRUMBLE = "Shared/Ceiling_crumble",
  SHARED_CLIMB = "Shared/Climb",
  SHARED_COFFIN_BREAK = "Shared/Coffin_break",
  SHARED_COFFIN_RATTLE = "Shared/Coffin_rattle",
  SHARED_COLLISION_SURFACE = "Shared/Collision_surface",
  SHARED_COSMIC_ORB_DESTROY = "Shared/Cosmic_orb_destroy",
  SHARED_COSMIC_ORB_LOOP = "Shared/Cosmic_orb_loop",
  SHARED_CURSED_LOOP = "Shared/Cursed_loop",
  SHARED_CURSE_GET = "Shared/Curse_get",
  SHARED_DAMAGED = "Shared/Damaged",
  SHARED_DAMAGED_FIRE = "Shared/Damaged_fire",
  SHARED_DAMAGED_POISON = "Shared/Damaged_poison",
  SHARED_DARK_LEVEL_START = "Shared/Dark_level_start",
  SHARED_DESTRUCTIBLE_BREAK = "Shared/Destructible_break",
  SHARED_DOOR_AMB_LOOP = "Shared/Door_amb_loop",
  SHARED_DOOR_UNLOCK = "Shared/Door_unlock",
  SHARED_DROP = "Shared/Drop",
  SHARED_EXPLOSION = "Shared/Explosion",
  SHARED_EXPLOSION_MODERN = "Shared/Explosion_modern",
  SHARED_FIRE_IGNITE = "Shared/Fire_ignite",
  SHARED_FIRE_LOOP = "Shared/Fire_loop",
  SHARED_GRAB_CLIMBABLE = "Shared/Grab_climbable",
  SHARED_HH_ANGER = "Shared/HH_anger",
  SHARED_HH_OBEY = "Shared/HH_obey",
  SHARED_HUMANOID_JUMP = "Shared/Humanoid_jump",
  SHARED_ICE_BREAK = "Shared/Ice_break",
  SHARED_ICE_SLIDE_LOOP = "Shared/Ice_slide_loop",
  SHARED_IMPALED = "Shared/Impaled",
  SHARED_LAND = "Shared/Land",
  SHARED_LANTERN_BREAK = "Shared/Lantern_break",
  SHARED_NEON_SIGN_LOOP = "Shared/Neon_sign_loop",
  SHARED_OPEN_CHEST = "Shared/Open_chest",
  SHARED_OPEN_CRATE = "Shared/Open_crate",
  SHARED_PICK_UP = "Shared/Pick_up",
  SHARED_POISON_WARN = "Shared/Poison_warn",
  SHARED_PORTAL_LOOP = "Shared/Portal_loop",
  SHARED_RICOCHET = "Shared/Ricochet",
  SHARED_RUBBLE_BREAK = "Shared/Rubble_break",
  SHARED_SACRIFICE = "Shared/Sacrifice",
  SHARED_SACRIFICE_EGGPLANT = "Shared/Sacrifice_eggplant",
  SHARED_SCARAB_LOOP = "Shared/Scarab_loop",
  SHARED_SLEEP_BUBBLE = "Shared/Sleep_bubble",
  SHARED_SMOKE_TELEPORT = "Shared/Smoke_teleport",
  SHARED_STORAGE_PAD_ACTIVATE = "Shared/Storage_pad_activate",
  SHARED_STUNNED_WAKE = "Shared/Stunned_wake",
  SHARED_TELEPORT = "Shared/Teleport",
  SHARED_TILE_BREAK = "Shared/Tile_break",
  SHARED_TOSS = "Shared/Toss",
  SHARED_TOSS_FIRE = "Shared/Toss_fire",
  SHARED_TRIP = "Shared/Trip",
  SHARED_WAKE_BLINK = "Shared/Wake_blink",
  SHARED_WEBBED = "Shared/Webbed",
  SHOP_SHOP_BUY = "Shop/Shop_buy",
  SHOP_SHOP_ENTER = "Shop/Shop_enter",
  SHOP_SHOP_FOCUS = "Shop/Shop_focus",
  SHOP_SHOP_NOPE = "Shop/Shop_nope",
  SHOP_SHOP_PICK_UP = "Shop/Shop_pick_up",
  TRANSITIONS_TRANS_ANGER = "Transitions/Trans_anger",
  TRANSITIONS_TRANS_ANKH = "Transitions/Trans_ankh",
  TRANSITIONS_TRANS_DARK = "Transitions/Trans_dark",
  TRANSITIONS_TRANS_DARK_FIRST = "Transitions/Trans_dark_first",
  TRANSITIONS_TRANS_DEATH = "Transitions/Trans_death",
  TRANSITIONS_TRANS_DM_RESULTS = "Transitions/Trans_dm_results",
  TRANSITIONS_TRANS_LAYER = "Transitions/Trans_layer",
  TRANSITIONS_TRANS_LAYER_SPECIAL = "Transitions/Trans_layer_special",
  TRANSITIONS_TRANS_OUROBOROS = "Transitions/Trans_ouroboros",
  TRANSITIONS_TRANS_PAUSE = "Transitions/Trans_pause",
  TRANSITIONS_TRANS_PIPE = "Transitions/Trans_pipe",
  TRANSITIONS_TRANS_SHOP = "Transitions/Trans_shop",
  TRANSITIONS_TRANS_THEME = "Transitions/Trans_theme",
  TRANSITIONS_TRANS_TUNNEL = "Transitions/Trans_tunnel",
  TRAPS_ARROWTRAP_TRIGGER = "Traps/Arrowtrap_trigger",
  TRAPS_BOULDER_CRUSH = "Traps/Boulder_crush",
  TRAPS_BOULDER_EMERGE = "Traps/Boulder_emerge",
  TRAPS_BOULDER_LOOP = "Traps/Boulder_loop",
  TRAPS_BOULDER_WARN_LOOP = "Traps/Boulder_warn_loop",
  TRAPS_CONVEYOR_BELT_LOOP = "Traps/Conveyor_belt_loop",
  TRAPS_CRUSHTRAP_BIG_STOP = "Traps/Crushtrap_big_stop",
  TRAPS_CRUSHTRAP_STOP = "Traps/Crushtrap_stop",
  TRAPS_DRILL_LOOP = "Traps/Drill_loop",
  TRAPS_DUAT_WALL_LOOP = "Traps/Duat_wall_loop",
  TRAPS_ELEVATOR_DOWN = "Traps/Elevator_down",
  TRAPS_ELEVATOR_UP = "Traps/Elevator_up",
  TRAPS_GENERATOR_GENERATE = "Traps/Generator_generate",
  TRAPS_GIANTCLAM_CLOSE = "Traps/Giantclam_close",
  TRAPS_GIANTCLAM_OPEN = "Traps/Giantclam_open",
  TRAPS_KALI_ANGERED = "Traps/Kali_angered",
  TRAPS_LASERBEAM_CHARGE = "Traps/Laserbeam_charge",
  TRAPS_LASERBEAM_COLLISION = "Traps/Laserbeam_collision",
  TRAPS_LASERBEAM_END = "Traps/Laserbeam_end",
  TRAPS_LASERBEAM_LOOP = "Traps/Laserbeam_loop",
  TRAPS_LASERTRAP_CHARGE = "Traps/Lasertrap_charge",
  TRAPS_LASERTRAP_TRIGGER = "Traps/Lasertrap_trigger",
  TRAPS_LIONTRAP_ATK = "Traps/Liontrap_atk",
  TRAPS_LIONTRAP_TRIGGER = "Traps/Liontrap_trigger",
  TRAPS_MINE_ACTIVATE = "Traps/Mine_activate",
  TRAPS_MINE_BLINK = "Traps/Mine_blink",
  TRAPS_MINE_DEACTIVATE = "Traps/Mine_deactivate",
  TRAPS_PIPE_LOOP = "Traps/Pipe_loop",
  TRAPS_PLATFORM_BREAK = "Traps/Platform_break",
  TRAPS_PLATFORM_TRIGGER = "Traps/Platform_trigger",
  TRAPS_QUICKSAND_AMB_LOOP = "Traps/Quicksand_amb_loop",
  TRAPS_QUICKSAND_LOOP = "Traps/Quicksand_loop",
  TRAPS_REGENBLOCK_GROW = "Traps/Regenblock_grow",
  TRAPS_SKULLBLOCK_ATK = "Traps/Skullblock_atk",
  TRAPS_SKULLBLOCK_TRIGGER = "Traps/Skullblock_trigger",
  TRAPS_SKULLDROP_DROP = "Traps/Skulldrop_drop",
  TRAPS_SKULLDROP_LOOP = "Traps/Skulldrop_loop",
  TRAPS_SLIDEWALL_STOMP = "Traps/Slidewall_stomp",
  TRAPS_SNAPTRAP_CLOSE = "Traps/Snaptrap_close",
  TRAPS_SNAPTRAP_OPEN = "Traps/Snaptrap_open",
  TRAPS_SPARK_HIT = "Traps/Spark_hit",
  TRAPS_SPARK_LOOP = "Traps/Spark_loop",
  TRAPS_SPEARTRAP_ATK = "Traps/Speartrap_atk",
  TRAPS_SPEARTRAP_TRIGGER = "Traps/Speartrap_trigger",
  TRAPS_SPIKE_BALL_DROP_LOOP = "Traps/Spike_ball_drop_loop",
  TRAPS_SPIKE_BALL_END = "Traps/Spike_ball_end",
  TRAPS_SPIKE_BALL_HIT = "Traps/Spike_ball_hit",
  TRAPS_SPIKE_BALL_RISE_LOOP = "Traps/Spike_ball_rise_loop",
  TRAPS_SPRING_TRIGGER = "Traps/Spring_trigger",
  TRAPS_STICKYTRAP_DROP_LOOP = "Traps/Stickytrap_drop_loop",
  TRAPS_STICKYTRAP_END = "Traps/Stickytrap_end",
  TRAPS_STICKYTRAP_HIT = "Traps/Stickytrap_hit",
  TRAPS_STICKYTRAP_RISE_LOOP = "Traps/Stickytrap_rise_loop",
  TRAPS_STICKYTRAP_WAKE = "Traps/Stickytrap_wake",
  TRAPS_SWITCH_FLICK = "Traps/Switch_flick",
  TRAPS_THINICE_CRACK = "Traps/Thinice_crack",
  TRAPS_TIKI_ATK = "Traps/Tiki_atk",
  TRAPS_TIKI_TRIGGER = "Traps/Tiki_trigger",
  TRAPS_WOODENLOG_CRUSH = "Traps/Woodenlog_crush",
  TRAPS_WOODENLOG_TRIGGER = "Traps/Woodenlog_trigger",
  UI_DAMSEL_KISS = "UI/Damsel_kiss",
  UI_DEPOSIT = "UI/Deposit",
  UI_GET_GEM = "UI/Get_gem",
  UI_GET_GOLD = "UI/Get_gold",
  UI_GET_ITEM1 = "UI/Get_item1",
  UI_GET_ITEM2 = "UI/Get_item2",
  UI_GET_SCARAB = "UI/Get_scarab",
  UI_JOURNAL_ENTRY = "UI/Journal_entry",
  UI_JOURNAL_OFF = "UI/Journal_off",
  UI_JOURNAL_ON = "UI/Journal_on",
  UI_KAPPALA_HEAL = "UI/Kappala_heal",
  UI_NPC_VOCAL = "UI/NPC_vocal",
  UI_PAUSE_MENU_OFF = "UI/Pause_menu_off",
  UI_PAUSE_MENU_ON = "UI/Pause_menu_on",
  UI_SECRET = "UI/Secret",
  UI_SECRET2 = "UI/Secret2",
  UI_TEXT_DESCRIPTION = "UI/Text_description",
  UI_TUNNEL_COUNT = "UI/Tunnel_count",
  UI_TUNNEL_SCROLL = "UI/Tunnel_scroll",
  UI_TUNNEL_TABLET_DOWN = "UI/Tunnel_tablet_down",
  UI_TUNNEL_TABLET_UP = "UI/Tunnel_tablet_up",
  UI_ZOOM_IN = "UI/Zoom_in",
  UI_ZOOM_OUT = "UI/Zoom_out"
}
---@alias VANILLA_SOUND integer
VANILLA_SOUND_CALLBACK_TYPE = {
  CREATED = 1,
  DESTROYED = 2,
  RESTARTED = 16,
  STARTED = 8,
  START_FAILED = 64,
  STOPPED = 32
}
---@alias VANILLA_SOUND_CALLBACK_TYPE integer
VANILLA_SOUND_PARAM = {
  ANGER_PROXIMITY = 11,
  ANGER_STATE = 12,
  CAM_DEPTH = 24,
  COLLISION_MATERIAL = 14,
  CURRENT_LAYER2 = 37,
  CURRENT_LEVEL = 35,
  CURRENT_SHOP_TYPE = 36,
  CURRENT_THEME = 34,
  CURSED = 28,
  DIST_CENTER_X = 1,
  DIST_CENTER_Y = 2,
  DIST_PLAYER = 4,
  DIST_Z = 3,
  DM_STATE = 32,
  FAST_FORWARD = 33,
  FIRST_RUN = 23,
  GHOST = 9,
  LIGHTNESS = 16,
  LIQUID_INTENSITY = 7,
  LIQUID_STREAM = 6,
  MONSTER_ID = 19,
  PAGE = 31,
  PLAYER_ACTIVITY = 20,
  PLAYER_CHARACTER = 30,
  PLAYER_CONTROLLED = 29,
  PLAYER_DEPTH = 22,
  PLAYER_LIFE = 21,
  POISONED = 27,
  POS_SCREEN_X = 0,
  RESTLESS_DEAD = 25,
  SIZE = 17,
  SPECIAL_MACHINE = 26,
  SUBMERGED = 5,
  TORCH_PROXIMITY = 13,
  TRIGGER = 10,
  TYPE_ID = 18,
  VALUE = 8,
  VELOCITY = 15
}
---@alias VANILLA_SOUND_PARAM integer
VANILLA_TEXT_ALIGNMENT = {
  CENTER = 1,
  LEFT = 0,
  RIGHT = 2
}
---@alias VANILLA_TEXT_ALIGNMENT integer
WIN_STATE = {
  COSMIC_OCEAN_WIN = 3,
  HUNDUN_WIN = 2,
  NO_WIN = 0,
  TIAMAT_WIN = 1
}
---@alias WIN_STATE integer
WORLD_SHADER = {
  COLOR = 0,
  DEFERRED_COLOR_TRANSPARENT = 6,
  DEFERRED_TEXTURE_COLOR = 7,
  DEFERRED_TEXTURE_COLOR_CURSED = 9,
  DEFERRED_TEXTURE_COLOR_EMISSIVE = 16,
  DEFERRED_TEXTURE_COLOR_EMISSIVE_COLORIZED_GLOW = 22,
  DEFERRED_TEXTURE_COLOR_EMISSIVE_COLORIZED_GLOW_DYNAMIC_GLOW = 23,
  DEFERRED_TEXTURE_COLOR_EMISSIVE_COLORIZED_GLOW_SATURATION = 24,
  DEFERRED_TEXTURE_COLOR_EMISSIVE_GLOW = 18,
  DEFERRED_TEXTURE_COLOR_EMISSIVE_GLOW_BRIGHTNESS = 20,
  DEFERRED_TEXTURE_COLOR_EMISSIVE_GLOW_HEAVY = 19,
  DEFERRED_TEXTURE_COLOR_POISONED = 8,
  DEFERRED_TEXTURE_COLOR_POISONED_CURSED = 10,
  DEFERRED_TEXTURE_COLOR_TRANSPARENT = 11,
  DEFERRED_TEXTURE_COLOR_TRANSPARENT_CORRECTED = 12,
  TEXTURE = 1,
  TEXTURE_ALPHA_COLOR = 3,
  TEXTURE_COLOR = 2,
  TEXTURE_COLORS_WARP = 5
}
---@alias WORLD_SHADER integer
YANG = {
  ANGRY = -1,
  BOTH_TURKEYS_DELIVERED = 3,
  ONE_TURKEY_BOUGHT = 5,
  QUEST_NOT_STARTED = 0,
  THREE_TURKEYS_BOUGHT = 7,
  TURKEY_PEN_SPAWNED = 2,
  TURKEY_SHOP_SPAWNED = 4,
  TWO_TURKEYS_BOUGHT = 6
}
---@alias YANG integer
local MAX_PLAYERS = 4

---@alias in_port_t number
---@class Logic

---@alias OnlinePlayerShort any
---@alias UdpServer any
---@alias Texture any
---@alias SpearDanglerAnimFrames any
---@alias OnlineLobbyScreenPlayer any
---@alias SoundCallbackFunction fun(): any

--## Aliases

---@alias IMAGE number
---@alias CallbackId integer;
---@alias Flags integer;
---@alias uColor integer;
---@alias SHORT_TILE_CODE integer;
---@alias STRINGID integer;
