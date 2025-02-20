#include "entities_liquids_lua.hpp"

#include "entities_liquids.hpp"
#include "state_structs.hpp"

#include <sol/sol.hpp>

namespace NEntitiesLiquids
{
void register_usertypes(sol::state& lua)
{
    lua["Entity"]["as_liquid"] = &Entity::as<Liquid>;
    lua["Entity"]["as_lava"] = &Entity::as<Lava>;

    lua.new_usertype<Liquid>(
        "Liquid",
        "fx_surface",
        &Liquid::fx_surface,
        "get_liquid_flags",
        &Liquid::get_liquid_flags,
        "set_liquid_flags",
        &Liquid::set_liquid_flags,
        sol::base_classes,
        sol::bases<Entity>());

    lua.new_usertype<Lava>(
        "Lava",
        "emitted_light",
        &Lava::emitted_light,
        sol::base_classes,
        sol::bases<Entity, Liquid>());
}
} // namespace NEntitiesLiquids
