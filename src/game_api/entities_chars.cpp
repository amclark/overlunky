#include "entities_chars.hpp"

#include "character_def.hpp"
#include "entities_items.hpp"
#include "memory.hpp"
#include "rpc.hpp"

void PowerupCapable::remove_powerup(ENT_TYPE powerup_type)
{
    static size_t offset = 0;
    if (offset == 0)
    {
        offset = get_address("remove_powerup");
    }

    if (offset != 0)
    {
        typedef void internal_remove_powerup_func(PowerupCapable*, uint32_t);
        static internal_remove_powerup_func* irpf = (internal_remove_powerup_func*)(offset);
        irpf(this, powerup_type);
    }
}

void PowerupCapable::give_powerup(ENT_TYPE powerup_type)
{
    static size_t offset = 0;
    if (offset == 0)
    {
        offset = get_address("give_powerup");
    }

    if (offset != 0)
    {
        typedef void internal_give_powerup_func(PowerupCapable*, uint32_t);
        static internal_give_powerup_func* igpf = (internal_give_powerup_func*)(offset);
        igpf(this, powerup_type);
    }
}

bool PowerupCapable::has_powerup(ENT_TYPE powerup_type)
{
    return powerups.find(powerup_type) != powerups.end();
}

std::vector<ENT_TYPE> PowerupCapable::get_powerups()
{
    std::vector<ENT_TYPE> return_powerups;
    return_powerups.reserve(powerups.size());
    for (auto& it : powerups)
    {
        return_powerups.push_back(it.first);
    }
    return return_powerups;
}

uint8_t Player::kapala_blood_amount()
{
    static auto kapalaPowerupID = to_id("ENT_TYPE_ITEM_POWERUP_KAPALA");
    for (auto item : items.entities())
    {
        if (item->type->id == kapalaPowerupID)
        {
            return item->as<KapalaPowerup>()->amount_of_blood;
        }
    }
    return 0;
}

void Player::set_jetpack_fuel(uint8_t fuel)
{
    static auto jetpackID = to_id("ENT_TYPE_ITEM_JETPACK");
    for (auto item : items.entities())
    {
        if (item->type->id == jetpackID)
        {
            item->as<Jetpack>()->fuel = fuel;
            break;
        }
    }
}

void PowerupCapable::unequip_backitem()
{
    ::unequip_backitem(this->uid);
}

int32_t PowerupCapable::worn_backitem()
{
    return ::worn_backitem(this->uid);
}

void Player::set_name(std::u16string name)
{
    return NCharacterDB::set_character_full_name(NCharacterDB::get_character_index(type->id), name);
}
void Player::set_short_name(std::u16string name)
{
    return NCharacterDB::set_character_short_name(NCharacterDB::get_character_index(type->id), name);
}

std::u16string Player::get_name()
{
    return NCharacterDB::get_character_full_name(NCharacterDB::get_character_index(type->id));
}
std::u16string Player::get_short_name()
{
    return NCharacterDB::get_character_short_name(NCharacterDB::get_character_index(type->id));
}
Color Player::get_heart_color()
{
    return NCharacterDB::get_character_heart_color(NCharacterDB::get_character_index(type->id));
}
bool Player::is_female()
{
    return NCharacterDB::get_character_gender(NCharacterDB::get_character_index(type->id));
}

void Player::set_heart_color(Color hcolor)
{
    ::set_character_heart_color(NCharacterDB::get_character_index(type->id), hcolor);
}

std::u16string get_character_name(ENT_TYPE type_id)
{
    return NCharacterDB::get_character_full_name(NCharacterDB::get_character_index(type_id));
}
std::u16string get_character_short_name(ENT_TYPE type_id)
{
    return NCharacterDB::get_character_short_name(NCharacterDB::get_character_index(type_id));
}
Color get_character_heart_color(ENT_TYPE type_id)
{
    return NCharacterDB::get_character_heart_color(NCharacterDB::get_character_index(type_id));
}
bool is_character_female(ENT_TYPE type_id)
{
    return NCharacterDB::get_character_gender(NCharacterDB::get_character_index(type_id));
}

void set_character_heart_color(ENT_TYPE type_id, Color color)
{
    NCharacterDB::set_character_heart_color(NCharacterDB::get_character_index(type_id), color);
}

void Player::let_go()
{
    if (overlay)
    {
        overlay->remove_item_ptr(this);
        // jump_flags_b = 0xFF;
        // last_state = state;
        // state = 1, 9, 0xA; ?
        stand_counter = 0;
        const auto& anim = behaviors_map.find(2);
        if (anim != behaviors_map.end())
            current_behavior = anim->second;
    }
}
