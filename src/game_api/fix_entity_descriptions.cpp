#include "fix_entity_descriptions.hpp"
#include "entity.hpp"

#include <iostream>
#include <regex>
#include <sstream>
#include <string>

// To update the description mapping, uncomment the #define below, and paste in the contents
// of the asset doc spreadsheet, run OL and it will dump the vector to stdout. Paste that over
// the vector at the bottom and it's up to date.

// #define RECREATE_ENTITY_DESCRIPTIONS

#ifdef RECREATE_ENTITY_DESCRIPTIONS
void recreate_entity_descriptions()
{
    std::string mapping_data = R"(ITEM_WHIP	
ITEM_WHIP_FLAME	
ITEM_BOMB	
ITEM_PASTEBOMB	
ITEM_ROPE	
ITEM_CLIMBABLE_ROPE	
ITEM_UNROLLED_ROPE	
ITEM_BLOOD	
ITEM_EGGSHIP	
ITEM_PARENTSSHIP	
ITEM_OLMECSHIP	
ITEM_IDOL	
ITEM_MADAMETUSK_IDOL	
ITEM_MADAMETUSK_IDOLNOTE	
ITEM_HOLDTHEIDOL	
ITEM_TOTEM_SPEAR	
ITEM_JUNGLE_SPEAR_COSMETIC	
ITEM_JUNGLE_SPEAR_DAMAGING	
ITEM_LION_SPEAR	
ITEM_BIG_SPEAR	
ITEM_ROCK	
ITEM_WEB	
ITEM_WEBSHOT	
ITEM_GIANTSPIDER_WEBSHOT	
ITEM_HANGSTRAND	
ITEM_HANGANCHOR	
ITEM_WOODEN_ARROW	
ITEM_BROKEN_ARROW	
ITEM_METAL_ARROW	
ITEM_LIGHT_ARROW	
ITEM_PLASMACANNON_SHOT	
ITEM_SCEPTER_ANUBISSHOT	
ITEM_SCEPTER_ANUBISSPECIALSHOT	
ITEM_SCEPTER_PLAYERSHOT	
ITEM_UFO_LASER_SHOT	
ITEM_LAMASSU_LASER_SHOT	
ITEM_SORCERESS_DAGGER_SHOT	
ITEM_LASERTRAP_SHOT	
ITEM_SPARK	
ITEM_TIAMAT_SHOT	
ITEM_FIREBALL	
ITEM_HUNDUN_FIREBALL	
ITEM_FLAMETHROWER_FIREBALL	
ITEM_LEAF	
ITEM_ACIDSPIT	
ITEM_INKSPIT	
ITEM_ACIDBUBBLE	
ITEM_CRABMAN_ACIDBUBBLE	
ITEM_CRABMAN_CLAW	
ITEM_CRABMAN_CLAWCHAIN	
ITEM_CHEST	
ITEM_VAULTCHEST	
ITEM_ENDINGTREASURE_TIAMAT	
ITEM_ENDINGTREASURE_HUNDUN	
ITEM_KEY	
ITEM_LOCKEDCHEST	
ITEM_LOCKEDCHEST_KEY	
ITEM_CRATE	
ITEM_DMCRATE	
ITEM_TUTORIAL_MONSTER_SIGN	
ITEM_CONSTRUCTION_SIGN	
ITEM_SHORTCUT_SIGN	
ITEM_SPEEDRUN_SIGN	
ITEM_BASECAMP_TUTORIAL_SIGN	
ITEM_BOOMBOX	
ITEM_TV	
ITEM_TELESCOPE	
ITEM_WALLTORCH	
ITEM_WALLTORCHFLAME	
ITEM_LITWALLTORCH	
ITEM_AUTOWALLTORCH	
ITEM_TORCH	
ITEM_TORCHFLAME	
ITEM_LAMP	
ITEM_LAMPFLAME	
ITEM_REDLANTERN	
ITEM_REDLANTERNFLAME	
ITEM_PRESENT	
ITEM_GHIST_PRESENT	
ITEM_BULLET	
ITEM_FREEZERAYSHOT	
ITEM_CLONEGUNSHOT	
ITEM_ICECAGE	
ITEM_BROKEN_MATTOCK	
ITEM_PUNISHBALL	
ITEM_PUNISHCHAIN	
ITEM_CHAIN	
ITEM_CHAIN_LASTPIECE	
ITEM_SLIDINGWALL_CHAIN	
ITEM_SLIDINGWALL_CHAIN_LASTPIECE	
ITEM_COFFIN	
ITEM_FLY	
ITEM_OLMECCANNON_BOMBS	
ITEM_OLMECCANNON_UFO	
ITEM_LANDMINE	
ITEM_CURSING_CLOUD	
ITEM_UDJAT_SOCKET	
ITEM_USHABTI	
ITEM_TURKEY_NECK	
ITEM_HONEY	
ITEM_GIANTCLAM_TOP	
ITEM_PLAYERGHOST	
ITEM_PLAYERGHOST_BREATH	
ITEM_DIE	
ITEM_DICE_BET	
ITEM_DICE_PRIZE_DISPENSER	
ITEM_LASERBEAM	
ITEM_HORIZONTALLASERBEAM	
ITEM_ANUBIS_COFFIN	
ITEM_SPIKES	
ITEM_EGGSHIP_HOOK	
ITEM_AXOLOTL_BUBBLESHOT	
ITEM_POTOFGOLD	
ITEM_STICKYTRAP_PIECE	
ITEM_STICKYTRAP_LASTPIECE	
ITEM_STICKYTRAP_BALL	
ITEM_SKULLDROPTRAP	
ITEM_FROZEN_LIQUID	
ITEM_ALIVE_EMBEDDED_ON_ICE	
ITEM_DEPLOYED_PARACHUTE	
ITEM_SLIDINGWALL_SWITCH	
ITEM_SLIDINGWALL_SWITCH_REWARD	
ITEM_GIANTFLY_HEAD	
ITEM_PALACE_CANDLE_FLAME	
ITEM_SNAP_TRAP	
ITEM_EMPRESS_GRAVE	
ITEM_TENTACLE	
ITEM_TENTACLE_PIECE	
ITEM_TENTACLE_LAST_PIECE	
ITEM_MINIGAME_SHIP	
ITEM_MINIGAME_UFO	
ITEM_MINIGAME_ASTEROID_BG	
ITEM_MINIGAME_ASTEROID	
ITEM_MINIGAME_BROKEN_ASTEROID	
ITEM_POT	
ITEM_CURSEDPOT	
ITEM_SKULL	
ITEM_BONES	
ITEM_COOKFIRE	
ITEM_LAVAPOT	
ITEM_SCRAP	
ITEM_EGGPLANT	
ITEM_ICESPIRE	
ITEM_PALACE_CANDLE	
ITEM_SKULLDROPTRAP_SKULL	
ITEM_FLOATING_ORB	
ITEM_EGGSAC	
ITEM_GOLDBAR	
ITEM_GOLDBARS	
ITEM_DIAMOND	
ITEM_EMERALD	
ITEM_SAPPHIRE	
ITEM_RUBY	
ITEM_NUGGET	
ITEM_GOLDCOIN	
ITEM_EMERALD_SMALL	
ITEM_SAPPHIRE_SMALL	
ITEM_RUBY_SMALL	
ITEM_NUGGET_SMALL	
ITEM_PICKUP_TORNJOURNALPAGE	
ITEM_PICKUP_JOURNAL	
ITEM_PICKUP_ROPE	
ITEM_PICKUP_ROPEPILE	1342
ITEM_PICKUP_BOMBBAG	1343
ITEM_PICKUP_BOMBBOX	1344
ITEM_PICKUP_ROYALJELLY	1355
ITEM_PICKUP_COOKEDTURKEY	
ITEM_PICKUP_GIANTFOOD	
ITEM_PICKUP_ELIXIR	
ITEM_PICKUP_CLOVER	
ITEM_PICKUP_SEEDEDRUNSUNLOCKER	
ITEM_PICKUP_SPECTACLES	1345
ITEM_PICKUP_CLIMBINGGLOVES	1346
ITEM_PICKUP_PITCHERSMITT	1347
ITEM_PICKUP_SPRINGSHOES	1348
ITEM_PICKUP_SPIKESHOES	1349
ITEM_PICKUP_PASTE	1350
ITEM_PICKUP_COMPASS	1351
ITEM_PICKUP_SPECIALCOMPASS	
ITEM_PICKUP_PARACHUTE	1352
ITEM_PICKUP_UDJATEYE	
ITEM_PICKUP_KAPALA	
ITEM_PICKUP_HEDJET	1353
ITEM_PICKUP_CROWN	
ITEM_PICKUP_EGGPLANTCROWN	
ITEM_PICKUP_TRUECROWN	
ITEM_PICKUP_ANKH	
ITEM_PICKUP_TABLETOFDESTINY	
ITEM_PICKUP_SKELETON_KEY	1354
ITEM_PICKUP_PLAYERBAG	
ITEM_POWERUP_PASTE	
ITEM_POWERUP_CLIMBING_GLOVES	
ITEM_POWERUP_SPIKE_SHOES	
ITEM_POWERUP_SPRING_SHOES	
ITEM_POWERUP_KAPALA	
ITEM_POWERUP_SPECTACLES	
ITEM_POWERUP_PITCHERSMITT	
ITEM_POWERUP_UDJATEYE	
ITEM_POWERUP_PARACHUTE	
ITEM_POWERUP_COMPASS	
ITEM_POWERUP_SPECIALCOMPASS	
ITEM_POWERUP_HEDJET	
ITEM_POWERUP_CROWN	
ITEM_POWERUP_EGGPLANTCROWN	
ITEM_POWERUP_TRUECROWN	
ITEM_POWERUP_ANKH	
ITEM_POWERUP_TABLETOFDESTINY	
ITEM_POWERUP_SKELETON_KEY	
ITEM_CAPE	
ITEM_VLADS_CAPE	
ITEM_PURCHASABLE_CAPE	
ITEM_JETPACK	-
ITEM_JETPACK_MECH	
ITEM_PURCHASABLE_JETPACK	1356
ITEM_TELEPORTER_BACKPACK	
ITEM_PURCHASABLE_TELEPORTER_BACKPACK	
ITEM_HOVERPACK	
ITEM_PURCHASABLE_HOVERPACK	
ITEM_POWERPACK	
ITEM_PURCHASABLE_POWERPACK	
ITEM_WEBGUN	
ITEM_SHOTGUN	
ITEM_FREEZERAY	
ITEM_CROSSBOW	
ITEM_CAMERA	
ITEM_TELEPORTER	
ITEM_MATTOCK	
ITEM_BOOMERANG	
ITEM_MACHETE	
ITEM_EXCALIBUR	
ITEM_BROKENEXCALIBUR	
ITEM_PLASMACANNON	
ITEM_SCEPTER	
ITEM_CLONEGUN	
ITEM_HOUYIBOW	
ITEM_WOODEN_SHIELD	
ITEM_METAL_SHIELD	)";

    const std::regex line_regex(R"(^([A-Z_]+)\s+([0-9]+)$)");
    auto ss = std::stringstream(mapping_data);
    std::smatch m;
    std::cout << "const std::vector<std::pair<uint32_t, uint32_t>> description_mapping = { \n";
    for (std::string line; std::getline(ss, line, '\n');)
    {
        if (std::regex_match(line, m, line_regex))
        {
            auto entity_id = to_id(fmt::format("ENT_TYPE_{}", m.str(1)));
            if (entity_id != -1)
            {
                std::cout << "{" << entity_id << ", " << m.str(2) << "},\n";
            }
            else
            {
                DEBUG("Entity type {} is unknown", m.str(1));
            }
        }
    }
    std::cout << "};\n\n";
}
#endif

void fix_entity_descriptions(STRINGID invalid_string_id)
{
#ifdef RECREATE_ENTITY_DESCRIPTIONS
    recreate_entity_descriptions();
#endif

    const std::vector<std::pair<uint32_t, uint32_t>> description_mapping = {
        {512, 1342},
        {513, 1343},
        {514, 1344},
        {517, 1355},
        {524, 1345},
        {525, 1346},
        {526, 1347},
        {527, 1348},
        {528, 1349},
        {529, 1350},
        {530, 1351},
        {532, 1352},
        {535, 1353},
        {541, 1354},
        {569, 1356},
    };

    for (const auto& [entity_id, description_id] : description_mapping)
    {
        auto type = get_type(entity_id);
        if (type != nullptr && type->description == invalid_string_id)
        {
            type->description = description_id;
        }
    }
}
