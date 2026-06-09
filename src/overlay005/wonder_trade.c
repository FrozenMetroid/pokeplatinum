

#include <nitro.h>
#include <nitro/code16.h>
#include <string.h>

#include "constants/charcode.h"
#include "constants/daycare.h"
#include "constants/heap.h"
#include "constants/items.h"
#include "constants/scrcmd.h"
#include "constants/species.h"
#include "constants/string.h"

#include "inlines.h"
#include "field_task.h"
#include "message.h"
#include "message_util.h"
#include "pokemon.h"
#include "save_player.h"
#include "savedata.h"
#include "system_flags.h"
#include "system_vars.h"
#include "text.h"
#include "trainer_data.h"
#include "wonder_trade.h"

#include "field/field_system.h"

#include "generated/evolution_methods.h"
#include "generated/abilities.h"

#include "overlay005/script_message.h"
#include "overlay006/npc_trade.h"

#include "res/text/bank/location_names.h"
#include "res/text/bank/global_terminal_1f.h"

BOOL FieldTask_WonderTrade(FieldTask *task);

static const ExcludedSpecies excludedSpeciesData[] = {
    {SPECIES_ARTICUNO,      0xFFFF},
    {SPECIES_ZAPDOS,        0xFFFF},
    {SPECIES_MOLTRES,       0xFFFF},
    {SPECIES_MEWTWO,        0xFFFF},
    {SPECIES_MEW,           0xFFFF},
    {SPECIES_RAIKOU,        0xFFFF},
    {SPECIES_ENTEI,         0xFFFF},
    {SPECIES_SUICUNE,       0xFFFF},
    {SPECIES_LUGIA,         0xFFFF},
    {SPECIES_HO_OH,         0xFFFF},
    {SPECIES_CELEBI,        0xFFFF},
    {SPECIES_REGIROCK,      0xFFFF},
    {SPECIES_REGICE,        0xFFFF},
    {SPECIES_REGISTEEL,     0xFFFF},
    {SPECIES_LATIAS,        0xFFFF},
    {SPECIES_LATIOS,        0xFFFF},
    {SPECIES_KYOGRE,        0xFFFF},
    {SPECIES_GROUDON,       0xFFFF},
    {SPECIES_RAYQUAZA,      0xFFFF},
    {SPECIES_JIRACHI,       0xFFFF},
    {SPECIES_DEOXYS,        0xFFFF},
    {SPECIES_TURTWIG,       0xFFFF /*FLAG_GOT_OTHER_SINNOH_STARTER*/},
    {SPECIES_GROTLE,        0xFFFF /*FLAG_GOT_OTHER_SINNOH_STARTER*/},
    {SPECIES_TORTERRA,      0xFFFF /*FLAG_GOT_OTHER_SINNOH_STARTER*/},
    {SPECIES_CHIMCHAR,      0xFFFF /*FLAG_GOT_OTHER_SINNOH_STARTER*/},
    {SPECIES_MONFERNO,      0xFFFF /*FLAG_GOT_OTHER_SINNOH_STARTER*/},
    {SPECIES_INFERNAPE,     0xFFFF /*FLAG_GOT_OTHER_SINNOH_STARTER*/},
    {SPECIES_PIPLUP,        0xFFFF /*FLAG_GOT_OTHER_SINNOH_STARTER*/},
    {SPECIES_PRINPLUP,      0xFFFF /*FLAG_GOT_OTHER_SINNOH_STARTER*/},
    {SPECIES_EMPOLEON,      0xFFFF /*FLAG_GOT_OTHER_SINNOH_STARTER*/},
    {SPECIES_SPIRITOMB,     FLAG_CAUGHT_ROUTE_209_SPIRITOMB},
    {SPECIES_ROTOM,         FLAG_CAUGHT_OLD_CHATEAU_ROTOM},
    {0xFFFF, 0xFFFF},
    // everything from Uxie and beyond is prohibited, so no need to add them
};

// special cases for wonder trade evolutions
// this includes mons that you can't check the evolution level for easily
static const WonderTradeSpecialCases wonderTradeSpecialCasesData[] = {
    {SPECIES_PICHU, SPECIES_PIKACHU, SPECIES_RAICHU,            2, 2},
    {SPECIES_CLEFFA, SPECIES_CLEFAIRY, SPECIES_CLEFABLE,        2, 2},
    {SPECIES_IGGLYBUFF, SPECIES_JIGGLYPUFF, SPECIES_WIGGLYTUFF, 2, 2},
    {SPECIES_TOGEPI, SPECIES_TOGETIC, SPECIES_TOGEKISS,         2, 2},
    {SPECIES_HAPPINY, SPECIES_CHANSEY, SPECIES_BLISSEY,         1, 2},
    {SPECIES_RIOLU, SPECIES_LUCARIO, 0xFFFE,                    2, 0xFF},
    {SPECIES_BUNEARY, SPECIES_LOPUNNY, 0xFFFE,                  2, 0xFF},
    {SPECIES_NINCADA, SPECIES_NINJASK, SPECIES_SHEDINJA,        20, 20},
    {SPECIES_ZUBAT, SPECIES_GOLBAT, SPECIES_CROBAT,             22, 22},
    {SPECIES_MAGNEMITE, SPECIES_MAGNETON, SPECIES_MAGNEZONE,    30, 30},
    {SPECIES_SMOOCHUM, SPECIES_JYNX, 0xFFFE,                    30, 0xFF},
    // originally needs an item to evolve
    {SPECIES_GLIGAR, SPECIES_GLISCOR, 0xFFFE,                   2, 0xFF}, // Razor Fang level 2
    {SPECIES_SNEASEL, SPECIES_WEAVILE, 0xFFFE,                  2, 0xFF}, // Razor Claw level 2
    {SPECIES_ELEKID, SPECIES_ELECTABUZZ, SPECIES_ELECTIVIRE,    30, 30},
    {SPECIES_MAGBY, SPECIES_MAGMAR, SPECIES_MAGMORTAR,          30, 30},
    {SPECIES_RHYHORN, SPECIES_RHYDON, SPECIES_RHYPERIOR,        38, 38},
    {SPECIES_HORSEA, SPECIES_SEADRA, SPECIES_KINGDRA,           30, 30},
    // need to know a move at a specific level
    {SPECIES_AIPOM, SPECIES_AMBIPOM, 0xFFFE,                    32, 0xFF},
    {SPECIES_YANMA, SPECIES_YANMEGA, 0xFFFE,                    33, 0xFF},
    {SPECIES_LICKITUNG, SPECIES_LICKILICKY, 0xFFFE,             33, 0xFF},
    {SPECIES_TANGELA, SPECIES_TANGROWTH, 0xFFFE,                33, 0xFF},
    {SPECIES_SWINUB, SPECIES_PILOSWINE, SPECIES_MAMOSWINE,      33, 44}, // ancient power changed to be a level up move for Piloswine at level 44
    {0xFFFF, 0xFFFF, 0xFFFF, 0xFF, 0xFF},
};

static WonderTradeValidBalls validPokeBalls[] = {
    {ITEM_POKE_BALL,    30},
    {ITEM_GREAT_BALL,   20},
    {ITEM_ULTRA_BALL,   10},
    {ITEM_REPEAT_BALL,  5},
    {ITEM_TIMER_BALL,   5},
    {ITEM_NEST_BALL,    5},
    {ITEM_NET_BALL,     5},
    {ITEM_DIVE_BALL,    5},
    {ITEM_HEAL_BALL,    5},
    {ITEM_QUICK_BALL,   4},
    {ITEM_DUSK_BALL,    4},
    {ITEM_LUXURY_BALL,  1},
    {ITEM_PREMIER_BALL, 1},
};

BOOL FieldTask_WonderTrade(FieldTask *task) 
{
    struct WonderTradeData *wonderTradeData = (struct WonderTradeData *)FieldTask_GetEnv(task);
    FieldSystem *fieldSystem = FieldTask_GetFieldSystem(task);
    u32 *taskState = FieldTask_GetState(task);
    switch (*taskState) {
        case WONDER_TRADE_TASK_STATE_GENERATE_SPECIES:
            if (WonderTrade_GetSpeciesAndForm(wonderTradeData, fieldSystem)) {
                (*taskState)++;
            }
            break;
        case WONDER_TRADE_TASK_STATE_GENERATE_ABILITY:
            WonderTrade_GetHiddenAbility(wonderTradeData, taskState); // 5% chance for hidden ability to be selected, otherwise just use the ability found with Pokemon_InitWith
            break;
        case WONDER_TRADE_TASK_STATE_GENERATE_ITEM:
            WonderTrade_GetItem(wonderTradeData, taskState);
            break;
        case WONDER_TRADE_TASK_STATE_GENERATE_BALL:
            if (WonderTrade_GetBall(wonderTradeData)) {
                (*taskState)++;
            }
            break;
        case WONDER_TRADE_TASK_STATE_GIVE_MON:
            WonderTrade_GiveMon(wonderTradeData, fieldSystem, taskState);
            break;
        case WONDER_TRADE_TASK_STATE_GENERATE_LEVELUP_MOVES:
            WonderTrade_GetLevelUpMoves(wonderTradeData, taskState);
            break;
        case WONDER_TRADE_TASK_STATE_GENERATE_EGG_MOVES:
            WonderTrade_GetEggMove(wonderTradeData, taskState);
            break;
        case WONDER_TRADE_TASK_STATE_GENERATE_TM_MOVES:
            WonderTrade_GetTMMoves(wonderTradeData, taskState);
            break;
        case WONDER_TRADE_TASK_STATE_GENERATE_EVS:
            WonderTrade_GetEVs(wonderTradeData, taskState);
            break;
        case WONDER_TRADE_TASK_STATE_DETERMINE_OT_NAME:
            WonderTrade_GetOTName(wonderTradeData, fieldSystem, taskState);
            break;
        case WONDER_TRADE_TASK_STATE_TRADE_GRAPHICS:
            WonderTrade_TradeGraphics(wonderTradeData, fieldSystem, taskState);
            break;
        case WONDER_TRADE_TASK_STATE_END:
            Heap_Free(wonderTradeData);
            return TRUE;    
    }
    return FALSE;
}

BOOL WonderTrade_GetSpeciesAndForm(struct WonderTradeData *wonderTradeData, struct FieldSystem_t *fieldSystem)
{
    u16 speciesWithForm;
    int i;

    // generate a random mon before Uxie since everything after and including Uxie is off the table
    wonderTradeData->species = LCRNG_RandMod(SPECIES_UXIE);

    // if you don't have nat dex and the mon is not in the regional dex, regen
    if ((!wonderTradeData->natDexWonderTrade) && (Pokemon_SinnohDexNumber(wonderTradeData->species) == FALSE)) {
        return FALSE;
    }
    // just in case
    if (wonderTradeData->species >= SPECIES_UXIE || wonderTradeData->species <= SPECIES_BULBASAUR) {
        return FALSE;
    }

    // check if the mon is forbidden and/or you haven't met the flag requirement to obtain it, and if so, regen
    for (i = 0; excludedSpeciesData[i].species != 0xFFFF; i++) {
        if (wonderTradeData->species == excludedSpeciesData[i].species) {
            if (!FieldSystem_CheckFlag(fieldSystem, excludedSpeciesData[i].flag)) {
                return FALSE;
            }
        }
    }

    // start generating based on special evos
    for (i = 0; wonderTradeSpecialCasesData[i].species1 != 0xFFFF; i++) {
        if (wonderTradeData->species == wonderTradeSpecialCasesData[i].species2) { // if the generated species is the middle evolution in the table 
            if (wonderTradeData->level < wonderTradeSpecialCasesData[i].level1) { // if the generated level is lower than the required level for second state
                wonderTradeData->species = wonderTradeSpecialCasesData[i].species1; // adjust the species to species 1
                break;
            }
        }
        if (wonderTradeData->species == wonderTradeSpecialCasesData[i].species3) { // if the generated species is the third evolution in the table 
            if ((wonderTradeData->level < wonderTradeSpecialCasesData[i].level2) && (wonderTradeData->level < wonderTradeSpecialCasesData[i].level1)) { // if the generated level is less than level2 and level1, regress all the way back to species1
                wonderTradeData->species = wonderTradeSpecialCasesData[i].species1;
                break;
            }
            if (wonderTradeData->level < wonderTradeSpecialCasesData[i].level2) { // if the generated level is less than level2, regress to species2
                wonderTradeData->species = wonderTradeSpecialCasesData[i].species2;
                break;
            }
        }
    }
    // now check for evolutions that can't be regressed easily because of separation in the national dex order (e.g. Bellossom and Gloom)
    // as well as stone evolutions that are dependent on a middle stage existing at a legal level, like Gloom
        // i.e., a level 1 Arcanine is legal, but a level 1 Vileplume is not
    switch (wonderTradeData->species) 
    {
        case SPECIES_GOLEM:
        case SPECIES_MACHAMP:
        case SPECIES_GENGAR:
            if (wonderTradeData->level < 25) {
                --wonderTradeData->species; // all three of these need to be at least level 25
            }
            break;
        case SPECIES_ALAKAZAM:
            if (wonderTradeData->level < 16) {
                wonderTradeData->species = SPECIES_KADABRA; // needs to be at least level 16
            }
            break;
        case SPECIES_VILEPLUME:
        case SPECIES_BELLOSSOM:
            if (wonderTradeData->level < 21) { // Gloom needs to be at least level 21 to evolve into these
                wonderTradeData->species = SPECIES_GLOOM;
            }
            break;
        case SPECIES_POLIWRATH:
        case SPECIES_POLITOED:
            if (wonderTradeData->level < 25) { // Poliwhirl needs to be at least level 25 to evolve into these
                wonderTradeData->species = SPECIES_POLIWHIRL;
            }
            break;
        case SPECIES_SLOWBRO:
        case SPECIES_SLOWKING:
            if (wonderTradeData->level < 32) { // Slowpoke needs to be at least level 32 to evolve into these
                wonderTradeData->species = SPECIES_SLOWPOKE;
            }
            break;
        case SPECIES_UMBREON:
        case SPECIES_ESPEON:
        case SPECIES_LEAFEON:
        case SPECIES_GLACEON:
        // Not necessary to include the other three eeveelutions because they are all legal at level 1
            if (wonderTradeData->level < 2) { // Eevee needs to be at least level 2 to evolve into these
                wonderTradeData->species = SPECIES_EEVEE;
            }
            break;
        case SPECIES_HITMONCHAN:
        case SPECIES_HITMONLEE:
        case SPECIES_HITMONTOP:
            if (wonderTradeData->level < 20) { // Tyrogue needs to be at least level 20 to evolve into these
                wonderTradeData->species = SPECIES_TYROGUE;
            }
            break;
        case SPECIES_DUSTOX:
        case SPECIES_CASCOON:
        // just handle both together since they both evolve from Wurmple and the regressive check later will fail on Cascoon
            if (wonderTradeData->level < 7) { // Wurmple needs to be at least level 7 to evolve into this
                wonderTradeData->species = SPECIES_WURMPLE;
            }
            else if (wonderTradeData->level < 10) { // Cascoon needs to be at least level 10 to evolve into this
                wonderTradeData->species = SPECIES_CASCOON;
            }
            break;
        case SPECIES_MOTHIM:
            if (wonderTradeData->level < 20) { // Burmy needs to be at least level 20 to evolve into this and you can't check Wormadam evo data for it
                wonderTradeData->species = SPECIES_BURMY;
            }
            break;
        case SPECIES_GALLADE:
            if (wonderTradeData->level < 30) { // Kirlia needs to be at least level 30 to evolve into this and you can't check Kirlia evo data for it since they're separated by like 150 mons
                wonderTradeData->species = SPECIES_KIRLIA;
            }
            break;
        default: // further checks later
            break;
    }

    // generate form for the mon if it has one, otherwise set form to 0
    switch (wonderTradeData->species)
    {
        case SPECIES_UNOWN:
            wonderTradeData->form = LCRNG_RandMod(28); // 28 forms of Unown, 0 - 27
            break;
        case SPECIES_ROTOM:
            wonderTradeData->form = LCRNG_RandMod(5); // 5 forms
            break;
        case SPECIES_BURMY:
        case SPECIES_WORMADAM:
            wonderTradeData->form = LCRNG_RandMod(3); // 3 forms each
            break;
        case SPECIES_SHELLOS:
        case SPECIES_GASTRODON:
            wonderTradeData->form = LCRNG_RandMod(2); // 2 forms each
            break;
        default:
            wonderTradeData->form = 0;
            break;
    }

    // check if need to regress the mon based on level -- for every other case
    for (i = 0; i < 2; i++) { // need to do this twice in case you roll a level 1 Pidgeot for example and simply regressing once isn't enough

        struct SpeciesEvolution *evoTable = Heap_Alloc(HEAP_ID_FIELD1, MAX_EVOLUTIONS * sizeof(struct SpeciesEvolution));
        speciesWithForm = Pokemon_GetFormNarcIndex(wonderTradeData->species, wonderTradeData->form);
        NARC_ReadWholeMemberByIndexPair(evoTable, NARC_INDEX_POKETOOL__PERSONAL__EVO, (speciesWithForm - 1));
        // check to see if the previous evo table has an evolution that matches the generated species and if the method is level-based
        // Shedinja and the Hitmons are also level-based, but they are handled above
        if (evoTable[0].targetSpecies == wonderTradeData->species 
            && (evoTable[0].method == EVO_LEVEL || evoTable[0].method == EVO_LEVEL_MALE || evoTable[0].method ==  EVO_LEVEL_FEMALE)
            && (wonderTradeData->level < evoTable[0].param)) { // param is level in this case
                // regress the species back by 1 and check again
                --wonderTradeData->species;
            }
       Heap_Free(evoTable);
    }

    // now add some addiitonal rng to make stronger mons rarer
    u32 odds = LCRNG_RandMod(10);
    u16 baseStatTotal = 0, attribute = 0;
    for (int i = 0; i < 6; i++) { // determine the base stat total of the mon
        // BASE_HP through BASE_SPDEF is 0-5, so just use i
        attribute = SpeciesData_GetFormValue(wonderTradeData->species, wonderTradeData->form, i);
        baseStatTotal += attribute;
    }

    if (baseStatTotal <= 349) {
        *wonderTradeData->finalMessage = pl_msg_GlobalTerminal1F_LowBST; // Oh, a {STRVAR_1 3, 1, 0}! How charming!\nPlease do visit again.
        if (odds > 3) { // 40%
            return FALSE;
        }
    }
    else if (baseStatTotal >= 350 && baseStatTotal <= 499) {
        *wonderTradeData->finalMessage = pl_msg_GlobalTerminal1F_MediumBST; // Wow, a {STRVAR_1 3, 1, 0}!\nThat’s exciting! Please do visit again.
        if (!(odds >= 4 && odds <= 6)) { // 30%
            return FALSE;
        }
    }
    else if (baseStatTotal >= 500 && baseStatTotal <= 599) {
        *wonderTradeData->finalMessage = pl_msg_GlobalTerminal1F_HighBST; // A Trainer sent you a {STRVAR_1 3, 1, 0}!\nThat’s mighty generous of them.\fPlease do visit again.
        if (!(odds == 7 || odds == 8)) { // 20%
            return FALSE;
        }
    }
    else { // BST is 600 or more, so Slaking and pseudo legendaries
        *wonderTradeData->finalMessage = pl_msg_GlobalTerminal1F_OutstandingBST; // What luck you have to get a\n{STRVAR_1 3, 1, 0}!\rWith that luck, you should play\nthe Jubilife City lottery!\rPlease do visit again.
        if (odds < 9) {
            return FALSE; // 10%
        }
    }

    return TRUE;
}

void WonderTrade_GetHiddenAbility(struct WonderTradeData *wonderTradeData, u32 *taskState)
{

    u8 hiddenAbility = SpeciesData_GetFormValue(wonderTradeData->species, wonderTradeData->form, SPECIES_DATA_HIDDEN_ABILITY);
    if ((LCRNG_RandMod(100) > 94) && hiddenAbility != 0) { // 5% chance (95, 96, 97, 98, 99) to be hidden ability if it exists
        wonderTradeData->hiddenAbility = hiddenAbility;
    } else {
        wonderTradeData->hiddenAbility = ABILITY_NONE;
    }

    ++(*taskState);
}

BOOL WonderTrade_ItemIsForbidden(u16 item)
{
    if (Item_IsMail(item) || Item_IsPlate(item) || Item_IsTMHM(item)
        || Item_IsPadding(item) || Item_IsKeyItem(item, HEAP_ID_FIELD1)
        || item == ITEM_NONE || item == ITEM_ODD_KEYSTONE || item == ITEM_GRISEOUS_ORB
        || item == ITEM_ADAMANT_ORB || item == ITEM_LUSTROUS_ORB) {
        return TRUE;
    }
    return FALSE;
}

void WonderTrade_GetItem(struct WonderTradeData *wonderTradeData, u32 *taskState)
{
    if (wonderTradeData->guaranteeItem != TRUE) { // if the item is not forced to generate, then roll for it, otherwise just generate an item no matter what
        if (LCRNG_RandMod(10) > 0) { // 90% chance to not have an item
            ++(*taskState);
        } 
    } else {
        wonderTradeData->item = LCRNG_RandMod(MAX_ITEMS);
        if (WonderTrade_ItemIsForbidden(wonderTradeData->item) == FALSE) {
            ++(*taskState);
        } else {
            wonderTradeData->guaranteeItem = TRUE; // reroll for an item if you passed that roll for getting an item the first time but the item was forbidden
        }
    }
}

BOOL WonderTrade_GetBall(struct WonderTradeData *wonderTradeData)
{
    u8 pos = LCRNG_RandMod(NELEMS(validPokeBalls));
    wonderTradeData->ball = validPokeBalls[pos].ball;

    if (LCRNG_RandMod(100) < validPokeBalls[pos].weight) { // weight is out of 100, so this gives the percentage chance for each ball to be selected
        return TRUE;
    }
    return FALSE;
}

void WonderTrade_GiveMon(struct WonderTradeData *wonderTradeData, struct FieldSystem_t *fieldSystem, u32 *taskState)
{
    wonderTradeData->party = SaveData_GetParty(fieldSystem->saveData);

    u32 otid = LCRNG_Next(); // random ot id
    
    Pokemon *mon = Pokemon_New(HEAP_ID_FIELD1);
    Pokemon_InitWith(mon, wonderTradeData->species, wonderTradeData->level, INIT_IVS_RANDOM, FALSE, 0, OTID_SET, otid);
    
    BoxPokemon_SetMetLocationAndDate(&mon->box, LocationNames_Text_WonderTrade, TRUE);

    Pokemon_SetValue(mon, MON_DATA_HELD_ITEM, &wonderTradeData->item);
    if (wonderTradeData->hiddenAbility != ABILITY_NONE) {
        u8 truthnuke = TRUE;
        Pokemon_SetValue(mon, MON_DATA_ABILITY, &wonderTradeData->hiddenAbility); // only use this line if the hidden ability is selected because the default ability is already determined by the personality value generated in Pokemon_InitWith
        Pokemon_SetValue(mon, MON_DATA_HIDDEN_ABILITY_SET, &truthnuke);
    }
    Pokemon_SetValue(mon, MON_DATA_FORM, &wonderTradeData->form);
    Pokemon_SetValue(mon, MON_DATA_POKEBALL, &wonderTradeData->ball);

    Pokemon_ApplyPokerusAtSlot(wonderTradeData->party, wonderTradeData->partySlot); // includes randomization, so it won't always apply pokerus -- bit of a misnomer

    if (Party_AddPokemon(wonderTradeData->party, mon)) {
        wonderTradeData->receivedPokemon = Party_GetPokemonBySlotIndex(SaveData_GetParty(fieldSystem->saveData), wonderTradeData->partySlot);
        SaveData_UpdateCatchRecords(fieldSystem->saveData, mon);
    }  

    Heap_Free(mon);
    (*taskState)++;
}

void WonderTrade_GetLevelUpMoves(struct WonderTradeData *wonderTradeData, u32 *taskState)
{
    #ifndef INIT_MON_RANDOM_MOVES
    // randomize the moves from what it can learn by the generated level

    // only do this if you don't already do this in BoxPokemon_SetDefaultMoves to save time 
    // since the following will be redundant otherwise

    u32 *levelUpLearnset = Heap_Alloc(HEAP_ID_FIELD1, MAX_LEARNSET_ENTRIES * sizeof(u32));
    Pokemon_LoadLevelUpMovesOf(wonderTradeData->species, wonderTradeData->form, levelUpLearnset);
    wonderTradeData->availableLearnsetMoves = 0;
    BOOL alreadyKnowsMove = FALSE;
    u16 rand, learnedMove, move, level;
    u8 i = 0, j = 0;
    while (wonderTradeData->availableLearnsetMoves < MAX_LEARNSET_ENTRIES) {
        move = LEVEL_UP_LEARNSET_MOVE(levelUpLearnset[wonderTradeData->availableLearnsetMoves]);
        level = LEVEL_UP_LEARNSET_LEVEL(levelUpLearnset[wonderTradeData->availableLearnsetMoves]);

        if (move == MOVE_NONE || move == LEVEL_UP_LEARNSET_END || level > wonderTradeData->level) {
            break;
        }
        wonderTradeData->availableLearnsetMoves++;
    }
    // now start adding random moves to the mon if there are more than 4 available because otherwise it can just keep the original four lol
    if (wonderTradeData->availableLearnsetMoves > LEARNED_MOVES_MAX) {
        while (i < LEARNED_MOVES_MAX) {
            alreadyKnowsMove = FALSE;
            rand = LCRNG_RandMod(wonderTradeData->availableLearnsetMoves); // randomly select an eligible move
            move = LEVEL_UP_LEARNSET_MOVE(levelUpLearnset[rand]);
            for (j = 0; j < LEARNED_MOVES_MAX; j++) {
                learnedMove = Pokemon_GetValue(wonderTradeData->receivedPokemon, MON_DATA_MOVE1 + j, NULL);
                if (move == learnedMove) { // already knows the move
                    alreadyKnowsMove = TRUE;
                    break;
                }
            }
            if (!alreadyKnowsMove) {
                Pokemon_ResetMoveSlot(wonderTradeData->receivedPokemon, move, i); // i is slot here
                i++;
            }
        }
    }
    Heap_Free(levelUpLearnset);
    #endif
    (*taskState)++;
}

void WonderTrade_GetEggMove(struct WonderTradeData *wonderTradeData, u32 *taskState)
{

    u16 tempEggMoves[MAX_EGG_MOVES];
    u16 eggSpecies = Pokemon_GetBaseSpeciesFromPersonalData(wonderTradeData->species);
    Pokemon *mon = Pokemon_New(HEAP_ID_FIELD1);
    Pokemon_InitWith(mon, eggSpecies, 1, 0, TRUE, 0, 0, 0); // LoadEggMoves works with PartyPokemon pointer data, so had to make mon data temporarily
    u8 eggMoveLearnsetSize = LoadSpeciesEggMoves(mon, tempEggMoves); // also populates tempEggMoves with the moves
    Heap_Free(mon); // no longer needed after loading the egg moves

    if (eggMoveLearnsetSize > 0) { // some mons are genderless and cannot have egg moves because they can only breed with Ditto
        BOOL alreadyKnowsMove = FALSE;
        u16 rand, learnedMove, move;
        u8 randomSlot = 0, i = 0, j = 0;

        if (LCRNG_RandMod(20) == 0) { // 5% chance to add an egg move
            while (i < 1) { // only add one egg move
                alreadyKnowsMove = FALSE;
                rand = LCRNG_RandMod(eggMoveLearnsetSize); // randomly select an eligible move
                move = tempEggMoves[rand];
                for (j = 0; j < LEARNED_MOVES_MAX; j++) { // check if the mon already knows the move
                    learnedMove = Pokemon_GetValue(wonderTradeData->receivedPokemon, MON_DATA_MOVE1 + j, NULL);
                    if (move == learnedMove) {
                        alreadyKnowsMove = TRUE;
                        break;
                    }
                }
                if (!alreadyKnowsMove) {
                    if (wonderTradeData->availableLearnsetMoves > LEARNED_MOVES_MAX) { 
                        // if the mon has more than four moves at the level,
                        // randomize which slot to add the egg move to
                        // otherwise, go to else
                        randomSlot = LCRNG_RandMod(LEARNED_MOVES_MAX);
                        Pokemon_ResetMoveSlot(wonderTradeData->receivedPokemon, move, randomSlot);
                    } else {
                        // mon has less than four moves at this level, so append the move rather than replacing at a certain slot
                        Pokemon_AddMove(wonderTradeData->receivedPokemon, move);
                    }
                    ++i; // finish adding egg move and exit while loop
                }
            }
        }
    }
    ++(*taskState);
}

void WonderTrade_GetTMMoves(struct WonderTradeData *wonderTradeData, u32 *taskState)
{
    u8 numOfTMsToAdd = LCRNG_RandMod(5); // 0 - 4 TMs
    BOOL alreadyKnowsMove;
    u16 learnedMove, move, i = 0;
    u8 randomSlot, j = 0;
    if (LCRNG_RandMod(20) == 0) { // 5% chance to get a TM added
        u16 tmMoves[NUM_TMS];
        u8 numberOfLearnableTMs = 0;
        for (i = ITEM_TM01; i < ITEM_HM01; i++) {
            if (Pokemon_CanLearnTM(wonderTradeData->receivedPokemon, Item_TMHMNumber(i))) {
                tmMoves[numberOfLearnableTMs] = Item_MoveForTMHM(i);
                numberOfLearnableTMs++;
            }
        }
        while (j <= numOfTMsToAdd && numberOfLearnableTMs != 0) { // 25% chance for 1 TM to be added, 25% for 2, etc. Only do this for mons that can actually learn TMs, so no Magikarp etc.
            alreadyKnowsMove = FALSE;
            move = tmMoves[LCRNG_RandMod(numberOfLearnableTMs)]; // randomly select an eligible tm move
            for (i = 0; i < LEARNED_MOVES_MAX; i++) {
                learnedMove = Pokemon_GetValue(wonderTradeData->receivedPokemon, MON_DATA_MOVE1 + i, NULL);
                if (move == learnedMove) {
                    alreadyKnowsMove = TRUE;
                    break;
                }
            }
            if (!alreadyKnowsMove) {
                if (wonderTradeData->availableLearnsetMoves > LEARNED_MOVES_MAX) { 
                    // if the mon has more than four moves at the level,
                    // randomize which slot to add the tm move to
                    // otherwise, go to else
                    randomSlot = LCRNG_RandMod(LEARNED_MOVES_MAX); // this ends up making it so that the same slot can be hit if multiple tms are selected to be added, but oh well
                    Pokemon_ResetMoveSlot(wonderTradeData->receivedPokemon, move, randomSlot);

                } else {
                    // mon has less than four moves at this level, so append the move rather than replacing
                    Pokemon_AddMove(wonderTradeData->receivedPokemon, move);
                }
                ++j; // finish adding tm move and move on to potentially add another
            }
        }
    }
    ++(*taskState);
}

void WonderTrade_GetEVs(struct WonderTradeData *wonderTradeData, u32 *taskState)
{
    u8 effortValueToAdd;
    u8 stats[6] = {0}; // populate an array for each stat's EVs and set them to 0 for now
    u8 odds = LCRNG_RandMod(10);
    ++odds; // avoid 0
    u8 i, temp;
    u16 totalEvs = LCRNG_RandMod(wonderTradeData->level * odds); // this is my way of making lower levels have few EVs; want to make it more realistic where you can't get a level 1 mon with like 400 EVs lol
    if (totalEvs > 512) { // just in case
        totalEvs = 512;
    }
    if (totalEvs == 0) {
        ++(*taskState);
        return; // no EVs to add, so skip
    }
    u16 remainingEvs = totalEvs;
    while (remainingEvs > 0) {
        i = LCRNG_RandMod(6); // randomize which stat to start incrementing
        effortValueToAdd = LCRNG_RandMod(remainingEvs);
        if (stats[i] + effortValueToAdd > 252) {
            temp = 252 - stats[i]; // figure out the difference between stats[i] and 252: (stat[i] + x = 252)
            remainingEvs -= temp; // subtract from the remaining EVs that which you've added to get to 252
            stats[i] = 252; // finally set the EV to 252
        } else {
            stats[i] += effortValueToAdd;
            remainingEvs -= effortValueToAdd; // all of the EVs from effortValueToAdd were added to the stat, so you can safely subtract the total number of remaining EVs by that
        }
        if (remainingEvs == 1) { // idk what was going on but it kept getting held up on there being 1 EV remaining
            remainingEvs -= 1;
        }
    }
    for (i = 0; i < 6; i++) {
        Pokemon_SetValue(wonderTradeData->receivedPokemon, MON_DATA_HP_EV + i, &stats[i]);
    }
    Pokemon_CalcStats(wonderTradeData->receivedPokemon);
    ++(*taskState);
}

void WonderTrade_GetOTName(struct WonderTradeData *wonderTradeData, struct FieldSystem_t *fieldSystem, u32 *taskState)
{
    BOOL regenName = FALSE;
    // load the two text archives
    MessageLoader *trainerNames = MessageLoader_Init(MSG_LOADER_PRELOAD_ENTIRE_BANK, NARC_INDEX_MSGDATA__PL_MSG, TEXT_BANK_NPC_TRAINER_NAMES, HEAP_ID_FIELD1); // text archive 618 for Trainer names
    MessageLoader *forbiddenNames = MessageLoader_Init(MSG_LOADER_PRELOAD_ENTIRE_BANK, NARC_INDEX_MSGDATA__PL_MSG, TEXT_BANK_FORBIDDEN_WONDER_TRADE_NAMES, HEAP_ID_FIELD1); // text archive 724 for forbidden names
    
    // load the trainer data narc so that the max number of trainers will be determined dynamically without
    // having to update a #define when adding new trainers
    void *trainerNarc = NARC_ctor(NARC_INDEX_POKETOOL__TRAINER__TRDATA, HEAP_ID_FIELD1);
    u16 numTrainers = NARC_GetFileCount(trainerNarc);
    NARC_dtor(trainerNarc);

    u16 selectedTextSlot = LCRNG_RandMod(numTrainers); // get the random text slot from which to read the randomly generated trainer name
    wonderTradeData->otName = MessageLoader_GetNewString(trainerNames, selectedTextSlot); // read it into a string
    MessageLoader_Free(trainerNames); // done with this msg data

    String *stringTrainerName = String_Init(16, HEAP_ID_FIELD1); // arbitrarily using 16
    String *stringRivalName = String_Init(16, HEAP_ID_FIELD1);
    String *stringForbiddenName = String_Init(16, HEAP_ID_FIELD1);

    String_ConcatTrainerName(stringTrainerName, wonderTradeData->otName); // decodes the trainer name and adds it to stringTrainerName
    u32 length = 1; // start from one because string->data[0] == TRNAMECODE if it's a trainer name
    while (stringTrainerName->data[length] != CHAR_EOS) {
        if (stringTrainerName->data[length] == CHAR_AMPERSAND) { // exclude doubles names like Kay & Tia
            regenName = TRUE;
            length = 10; // force skip the next else check, should make it go slightly faster lol
            break;
        }
        length++;
    }
    if (length > TRAINER_NAME_LEN) {
        regenName = TRUE; // OT name can only be 7 characters
    } else { // length of the name is 7 or fewer characters, now check if the name is illegal
        BOOL legalName, matchesRivalName = FALSE;
        u16 numForbiddenNames = MessageLoader_MessageCount(forbiddenNames);
        for (int i = 0; i < numForbiddenNames; i++) { // check if the name matches a forbidden name
            stringForbiddenName = MessageLoader_GetNewString(forbiddenNames, i);
            legalName = String_Compare(stringTrainerName, stringForbiddenName); // returns true if they are different
            if (!legalName) {
                regenName = TRUE;
                break;
            }
        }
        const charcode_t *rivalName = MiscSaveBlock_RivalName(SaveData_MiscSaveBlockConst(fieldSystem->saveData));
        String_CopyChars(stringRivalName, rivalName); // copy the rival name into stringRivalName to compare with the generated name
        matchesRivalName = String_Compare(stringTrainerName, stringRivalName); // returns true if they are different
        if (!matchesRivalName) {
            regenName = TRUE; // OT name can't be the same as the rival name
        }
    }
    if (!regenName) { 
        Pokemon_SetValue(wonderTradeData->receivedPokemon, MON_DATA_OT_NAME_STRING, wonderTradeData->otName);
        u8 trainerClass = Trainer_LoadParam(selectedTextSlot, TRDATA_CLASS);
        wonderTradeData->trainerClassGender = TrainerClass_Gender(trainerClass);
        Pokemon_SetValue(wonderTradeData->receivedPokemon, MON_DATA_OT_GENDER, &wonderTradeData->trainerClassGender);
        ++(*taskState);
    }
    String_Free(stringTrainerName);
    String_Free(stringRivalName);
    String_Free(stringForbiddenName);
    MessageLoader_Free(forbiddenNames);
}

void WonderTrade_TradeGraphics(WonderTradeData *wonderTradeData, struct FieldSystem_t *fieldSystem, u32 *taskState)
{
    struct NPCTradeData *data = Heap_Alloc(HEAP_ID_FIELD2, sizeof(struct NPCTradeData));
    data->mon = Party_GetPokemonBySlotIndex(wonderTradeData->party, wonderTradeData->partySlot);
    data->npcTradeMon = NULL; // not needed since the receiving mon is what is shown in the graphics and that is the wonder trade mon, but just to be safe
    data->heapID = HEAP_ID_FIELD2;
    data->trainerInfo = TrainerInfo_New(data->heapID);
    data->wonderTrade = TRUE;

    TrainerInfo_Init(data->trainerInfo);

    charcode_t otName[TRAINER_NAME_LEN * 2]; // just in case it needs to be larger
    String_ToChars(wonderTradeData->otName, otName, NELEMS(otName)); // trainer info needs ot string in charcode format, so will convert it there
    String_Free(wonderTradeData->otName);
    TrainerInfo_SetName(data->trainerInfo, otName);
    TrainerInfo_SetGender(data->trainerInfo, wonderTradeData->trainerClassGender);

    NPCTradeTaskEnv *taskEnv = Heap_Alloc(data->heapID, sizeof(NPCTradeTaskEnv));

    memset(taskEnv, 0, sizeof(NPCTradeTaskEnv));

    taskEnv->state = 0;
    taskEnv->npcTradeData = data;
    taskEnv->partySlot = wonderTradeData->partySlot;
    taskEnv->givingMon = &wonderTradeData->sentPokemon;
    taskEnv->receivingMon = wonderTradeData->receivedPokemon;

    FieldTask_InitCall(fieldSystem->task, FieldTask_ProcessNPCTrade, taskEnv);
    ++(*taskState);
}