# Overlunky/Playlunky Lua API
## Read this first

- We try not to make breaking changes to the API, but some stupid errors or new stuff that was guessed wrong may have to be changed. Sorry!
- If you encounter something that doesn't seem quite right, please raise your voice instead of conforming to it outright.
- This doc is generated from dozens of C++ files by a janky-ass python script however, so there may be weird documentation errors that hopefully don't reflect weird errors in the API.
- This doc doesn't have a lot of examples, that's why we have [examples/](https://github.com/spelunky-fyi/overlunky/tree/main/examples). There are also [sample mods](https://spelunky.fyi/mods/?q=sample) for things that make more sense in Playlunky.
- This doc and the examples are written for a person who already knows [how to program in Lua](http://lua-users.org/wiki/TutorialDirectory).
- This doc doesn't cover how to actually load scripts. Check the [README](https://github.com/spelunky-fyi/overlunky/#scripts) for instructions.
- This doc is up to date for the Overlunky [WHIP build](https://github.com/spelunky-fyi/overlunky/releases/tag/whip) and Playlunky [nightly build](https://github.com/spelunky-fyi/Playlunky/releases/tag/nightly). If you're using a stable release from the past, you might find some things here don't work.
- Set `OL_DEBUG=1` in the same environment where the game is running to keep the Overlunky terminal open for better debug prints. This could be `cmd` or even the system environment variables if playing on Steam. Playlunky will also print the messages to terminal (even from Overlunky) if ran with the `-console` switch.

## External Function Library
If you use a text editor/IDE that has a Lua linter available you can download [spel2.lua](https://raw.githubusercontent.com/spelunky-fyi/overlunky/main/docs/game_data/spel2.lua), place it in a folder of your choice and specify that folder as a "external function library". For example [VSCode](https://code.visualstudio.com/) with the [Lua Extension](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) offers this feature. This will allow you to get auto-completion of API functions along with linting

# Lua libraries
The following Lua libraries and their functions are available. You can read more about them in the [Lua documentation](https://www.lua.org/manual/5.4/manual.html#6). We're using Lua 5.4 with the [Sol C++ binding](https://sol2.readthedocs.io/en/latest/).

## math

## base

## string

## table

## coroutine

## package

## json
To save data in your mod it makes a lot of sense to use `json` to encode a table into a string and decode strings to table. For example this code that saves table and loads it back:

```lua
local some_mod_data_that_should_be_saved = {{
    kills = 0,
    unlocked = false
}}
set_callback(function(save_ctx)
    local save_data_str = json.encode(some_mod_data_that_should_be_saved)
    save_ctx:save(save_data_str)
end, ON.SAVE)

set_callback(function(load_ctx)
    local load_data_str = load_ctx:load()
    if load_data_str ~= "" then
        some_mod_data_that_should_be_saved = json.decode(load_data_str)
    end
end, ON.LOAD)
```

## inspect
This module is a great substitute for `tostring` because it can convert any type to a string and thus helps a lot with debugging. Use for example like this:

```lua
local look_ma_no_tostring = {
    number = 15,
    nested_table = {
        array = {
            1,
            2,
            4
        }
    }
}
message(inspect(look_ma_no_tostring))
--[[prints:
{
    number = 15,
    nested_table = {
        array = { 1, 2, 4 }
    }
}
]]
```

## format
This allows you to make strings without having to do a lot of `tostring` and `..` by placing your variables directly inside of the string. Use `F` in front of your string and wrap variables you want to print in `{}`, for example like this:

```lua
for _, player in players do
    local royal_title = nil
    if player:is_female() then
        royal_title = 'Queen'
    else
        royal_title = 'King'
    end
    local name = F'{player:get_name()} aka {royal_title} {player:get_short_name()}'
    message(name)
end
```

# Unsafe mode
Setting `meta.unsafe = true` enables the rest of the standard Lua libraries like `io` and `os`, loading dlls with require and `package.loadlib`. Using unsafe scripts requires users to enable the option in the overlunky.ini file which is found in the Spelunky 2 installation directory.

# Modules
You can load modules with `require "mymod"` or `require "mydir.mymod"`, just put `mymod.lua` in the same directory the script is, or in `mydir/` to keep things organized.

Check the [Lua tutorial](http://lua-users.org/wiki/ModulesTutorial) or examples how to actually make modules.

# Aliases


We use those to clarify what kind of values can be passed and returned from a function, even if the underlying type is really just an integer or a string. This should help to avoid bugs where one would for example just pass a random integer to a function expecting a callback id.

Name | Type
---- | ----
CallbackId | int;
Flags | int;
uColor | int;
SHORT_TILE_CODE | int;
STRINGID | int;
