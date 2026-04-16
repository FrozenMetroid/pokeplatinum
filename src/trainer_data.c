#include "trainer_data.h"

#include "constants/battle.h"
#include "constants/pokemon.h"
#include "generated/trainer_message_types.h"

#include "struct_defs/trainer.h"

#include "data/trainer_class_genders.h"

#include "charcode_util.h"
#include "field_battle_data_transfer.h"
#include "heap.h"
#include "math_util.h"
#include "message.h"
#include "narc.h"
#include "party.h"
#include "pokemon.h"
#include "savedata.h"
#include "savedata_misc.h"
#include "string_gf.h"

#include "senate_config.h"

static void TrainerData_BuildParty(FieldBattleDTO *dto, int battler, enum HeapID heapID);

#ifdef BATTLE_EXPANDED_TRAINER_STRUCT
static void TrainerMon_OverridePidGender(int species, int form, int overrideParam, u32 *pid);
static void TrainerMon_FrustrationCheckAndSetFriendship(Pokemon *mon);
#endif

void Trainer_Encounter(FieldBattleDTO *dto, const SaveData *saveData, enum HeapID heapID)
{
    Trainer trdata;
    MessageLoader *msgLoader = MessageLoader_Init(MSG_LOADER_LOAD_ON_DEMAND, NARC_INDEX_MSGDATA__PL_MSG, TEXT_BANK_NPC_TRAINER_NAMES, heapID);
    const charcode_t *rivalName = MiscSaveBlock_RivalName(SaveData_MiscSaveBlockConst(saveData));

    for (int i = 0; i < MAX_BATTLERS; i++) {
        if (!dto->trainerIDs[i]) {
            continue;
        }

        Trainer_Load(dto->trainerIDs[i], &trdata);
        dto->trainer[i] = trdata;

        if (trdata.header.trainerType == TRAINER_CLASS_RIVAL) {
            CharCode_Copy(dto->trainer[i].name, rivalName);
        } else {
            String *trainerName = MessageLoader_GetNewString(msgLoader, dto->trainerIDs[i]);
            String_ToChars(trainerName, dto->trainer[i].name, TRAINER_NAME_LEN + 1);
            String_Free(trainerName);
        }

        TrainerData_BuildParty(dto, i, heapID);
    }

    dto->battleType |= trdata.header.battleType;
    MessageLoader_Free(msgLoader);
}

u32 Trainer_LoadParam(int trainerID, enum TrainerDataParam paramID)
{
    // TODO: can this be trainerheader?
    u32 result;
    Trainer trdata;

    Trainer_Load(trainerID, &trdata);

    switch (paramID) {
    case TRDATA_TYPE:
        result = trdata.header.monDataType;
        break;

    case TRDATA_CLASS:
        result = trdata.header.trainerType;
        break;

    case TRDATA_SPRITE:
        result = trdata.header.sprite;
        break;

    case TRDATA_PARTY_SIZE:
        result = trdata.header.partySize;
        break;

    case TRDATA_ITEM_1:
    case TRDATA_ITEM_2:
    case TRDATA_ITEM_3:
    case TRDATA_ITEM_4:
        result = trdata.header.items[paramID - TRDATA_ITEM_1];
        break;

    case TRDATA_AI_MASK:
        result = trdata.header.aiMask;
        break;

    case TRDATA_BATTLE_TYPE:
        result = trdata.header.battleType;
        break;
    }

    return result;
}

BOOL Trainer_HasMessageType(int trainerID, enum TrainerMessageType msgType, enum HeapID heapID)
{
    NARC *narc; // must declare up here to match
    u16 offset, data[2];

    BOOL result = FALSE;
    int size = NARC_GetMemberSizeByIndexPair(NARC_INDEX_POKETOOL__TRMSG__TRTBL, 0);
    NARC_ReadFromMemberByIndexPair(&offset, NARC_INDEX_POKETOOL__TRMSG__TRTBLOFS, 0, trainerID * 2, 2);
    narc = NARC_ctor(NARC_INDEX_POKETOOL__TRMSG__TRTBL, heapID);

    while (offset != size) {
        NARC_ReadFromMember(narc, 0, offset, 4, data);

        if (data[0] == trainerID && data[1] == msgType) {
            result = TRUE;
            break;
        }

        if (data[0] != trainerID) {
            break;
        }

        offset += 4;
    }

    NARC_dtor(narc);
    return result;
}

void Trainer_LoadMessage(int trainerID, enum TrainerMessageType msgType, String *string, enum HeapID heapID)
{
    NARC *narc; // must declare up here to match
    u16 offset, data[2];

    int size = NARC_GetMemberSizeByIndexPair(NARC_INDEX_POKETOOL__TRMSG__TRTBL, 0);
    NARC_ReadFromMemberByIndexPair(&offset, NARC_INDEX_POKETOOL__TRMSG__TRTBLOFS, 0, trainerID * 2, 2);
    narc = NARC_ctor(NARC_INDEX_POKETOOL__TRMSG__TRTBL, heapID);

    while (offset != size) {
        NARC_ReadFromMember(narc, 0, offset, 4, data);

        if (data[0] == trainerID && data[1] == msgType) {
            MessageBank_GetStringFromNARC(NARC_INDEX_MSGDATA__PL_MSG, TEXT_BANK_NPC_TRAINER_MESSAGES, offset / 4, heapID, string);
            break;
        }

        offset += 4;
    }

    NARC_dtor(narc);

    if (offset == size) {
        String_Clear(string);
    }
}

void Trainer_Load(int trainerID, Trainer *trdata)
{
    NARC_ReadWholeMemberByIndexPair(trdata, NARC_INDEX_POKETOOL__TRAINER__TRDATA, trainerID);
}

void Trainer_LoadParty(int trainerID, void *trparty)
{
    NARC_ReadWholeMemberByIndexPair(trparty, NARC_INDEX_POKETOOL__TRAINER__TRPOKE, trainerID);
}

u8 TrainerClass_Gender(int trclass)
{
    return sTrainerClassGender[trclass];
}

#ifndef BATTLE_EXPANDED_TRAINER_STRUCT
/**
 * @brief Build the party for a trainer as loaded in the FieldBattleDTO struct.
 *
 * @param dto  The parent FieldBattleDTO struct containing trainer data.
 * @param battler       Which battler's party is to be loaded.
 * @param heapID        Heap on which to perform any allocations.
 */
static void TrainerData_BuildParty(FieldBattleDTO *dto, int battler, enum HeapID heapID)
{
    // must make declarations C89-style to match
    void *buf;
    int i, j;
    u32 genderMod, rnd, oldSeed;
    u8 ivs;
    Pokemon *mon;

    oldSeed = LCRNG_GetSeed();

    // alloc enough space to support the maximum possible data size
    Party_InitWithCapacity(dto->parties[battler], MAX_PARTY_SIZE);
    buf = Heap_Alloc(heapID, sizeof(TrainerMonWithMovesAndItem) * MAX_PARTY_SIZE);
    mon = Pokemon_New(heapID);

    Trainer_LoadParty(dto->trainerIDs[battler], buf);

    // determine which magic gender-specific modifier to use for the RNG function
    genderMod = TrainerClass_Gender(dto->trainer[battler].header.trainerType) == GENDER_FEMALE
        ? 120
        : 136;

    switch (dto->trainer[battler].header.monDataType) {
    case TRDATATYPE_BASE: {
        TrainerMonBase *trmon = (TrainerMonBase *)buf;
        for (i = 0; i < dto->trainer[battler].header.partySize; i++) {
            u16 species = trmon.species & 0x3FF;
            u8 form = (trmon.species & 0xFC00) >> TRAINER_MON_FORM_SHIFT;

            rnd = trmon.ivScale + trmon.level + species + dto->trainerIDs[battler];
            LCRNG_SetSeed(rnd);

            for (j = 0; j < dto->trainer[battler].header.trainerType; j++) {
                rnd = LCRNG_Next();
            }

            rnd = (rnd << 8) + genderMod;
            ivs = trmon.ivScale * MAX_IVS_SINGLE_STAT / MAX_IV_SCALE;

            Pokemon_InitWith(mon, species, trmon.level, ivs, TRUE, rnd, OTID_NOT_SHINY, 0);
            Pokemon_SetBallSeal(trmon.cbSeal, mon, heapID);
            Pokemon_SetValue(mon, MON_DATA_FORM, &form);
            Party_AddPokemon(dto->parties[battler], mon);
        }

        break;
    }

    case TRDATATYPE_WITH_MOVES: {
        TrainerMonWithMoves *trmon = (TrainerMonWithMoves *)buf;
        for (i = 0; i < dto->trainer[battler].header.partySize; i++) {
            u16 species = trmon.species & 0x3FF;
            u8 form = (trmon.species & 0xFC00) >> TRAINER_MON_FORM_SHIFT;

            rnd = trmon.ivScale + trmon.level + species + dto->trainerIDs[battler];
            LCRNG_SetSeed(rnd);

            for (j = 0; j < dto->trainer[battler].header.trainerType; j++) {
                rnd = LCRNG_Next();
            }

            rnd = (rnd << 8) + genderMod;
            ivs = trmon.ivScale * MAX_IVS_SINGLE_STAT / MAX_IV_SCALE;

            Pokemon_InitWith(mon, species, trmon.level, ivs, TRUE, rnd, OTID_NOT_SHINY, 0);

            for (j = 0; j < 4; j++) {
                Pokemon_SetMoveSlot(mon, trmon.moves[j], j);
            }

            Pokemon_SetBallSeal(trmon.cbSeal, mon, heapID);
            Pokemon_SetValue(mon, MON_DATA_FORM, &form);
            Party_AddPokemon(dto->parties[battler], mon);
        }

        break;
    }

    case TRDATATYPE_WITH_ITEM: {
        TrainerMonWithItem *trmon = (TrainerMonWithItem *)buf;
        for (i = 0; i < dto->trainer[battler].header.partySize; i++) {
            u16 species = trmon.species & 0x3FF;
            u8 form = (trmon.species & 0xFC00) >> TRAINER_MON_FORM_SHIFT;

            rnd = trmon.ivScale + trmon.level + species + dto->trainerIDs[battler];
            LCRNG_SetSeed(rnd);

            for (j = 0; j < dto->trainer[battler].header.trainerType; j++) {
                rnd = LCRNG_Next();
            }

            rnd = (rnd << 8) + genderMod;
            ivs = trmon.ivScale * MAX_IVS_SINGLE_STAT / MAX_IV_SCALE;

            Pokemon_InitWith(mon, species, trmon.level, ivs, TRUE, rnd, OTID_NOT_SHINY, 0);
            Pokemon_SetValue(mon, MON_DATA_HELD_ITEM, &trmon.item);
            Pokemon_SetBallSeal(trmon.cbSeal, mon, heapID);
            Pokemon_SetValue(mon, MON_DATA_FORM, &form);
            Party_AddPokemon(dto->parties[battler], mon);
        }

        break;
    }

    case TRDATATYPE_WITH_MOVES_AND_ITEM: {
        TrainerMonWithMovesAndItem *trmon = (TrainerMonWithMovesAndItem *)buf;
        for (i = 0; i < dto->trainer[battler].header.partySize; i++) {
            u16 species = trmon.species & 0x3FF;
            u8 form = (trmon.species & 0xFC00) >> TRAINER_MON_FORM_SHIFT;

            rnd = trmon.ivScale + trmon.level + species + dto->trainerIDs[battler];
            LCRNG_SetSeed(rnd);

            for (j = 0; j < dto->trainer[battler].header.trainerType; j++) {
                rnd = LCRNG_Next();
            }

            rnd = (rnd << 8) + genderMod;
            ivs = trmon.ivScale * MAX_IVS_SINGLE_STAT / MAX_IV_SCALE;

            Pokemon_InitWith(mon, species, trmon.level, ivs, TRUE, rnd, OTID_NOT_SHINY, 0);
            Pokemon_SetValue(mon, MON_DATA_HELD_ITEM, &trmon.item);

            for (j = 0; j < 4; j++) {
                Pokemon_SetMoveSlot(mon, trmon.moves[j], j);
            }

            Pokemon_SetBallSeal(trmon.cbSeal, mon, heapID);
            Pokemon_SetValue(mon, MON_DATA_FORM, &form);
            Party_AddPokemon(dto->parties[battler], mon);
        }

        break;
    }
    }

    Heap_Free(buf);
    Heap_Free(mon);
    LCRNG_SetSeed(oldSeed);
}

#else

// shiny convenience macro
#define SHINY_VALUE(otid, pid) (((otid & 0xffff0000) >> 16) ^ (otid & 0xffff) ^ ((pid & 0xffff0000) >> 16) ^ (pid & 0xffff))
#define SHINY_CHECK(otid, pid) (SHINY_VALUE(otid, pid) <= SHINY_ODDS)

typedef struct __attribute__((packed)) ExpandedTrainerMonData {
    u8 ivs;
    u8 abilityslot;
    u16 level;
    u16 monsno;
    u16 itemno;
    u16 moves[4];
    u16 ability;
    u16 ball;
    u8 ivnums[6];
    u8 evnums[6];
    u8 nature;
    u8 shinyLock;
    u8 padding[2];
    u32 additionalflags;
    u32 status;
    u16 hp;
    u16 atk;
    u16 def;
    u16 speed;
    u16 spatk;
    u16 spdef;
    u8 types[2];
    u8 ppcounts[4];
    u16 nickname[11];
    u16 ballSeal;
} ExpandedTrainerMonData;
// expanded trainer struct
static void TrainerData_BuildParty(FieldBattleDTO *dto, int battler, enum HeapID heapID)
{
    struct ExpandedTrainerMonData *trmon;
    int i, j;
    u32 genderMod, rnd, oldSeed, pid, id;
    u8 ivs;
    u8 form;
    u16 species;
    u8 ability1, ability2;
    Pokemon *mon;

    oldSeed = LCRNG_GetSeed();

    Party_InitWithCapacity(dto->parties[battler], MAX_PARTY_SIZE);
    trmon = Heap_Alloc(heapID, sizeof(ExpandedTrainerMonData) * MAX_PARTY_SIZE);
    EmulatorLog("ExpandedTrainerMonData size: %d", sizeof(ExpandedTrainerMonData));
    mon = Pokemon_New(heapID);

    Trainer_LoadParty(dto->trainerIDs[battler], trmon);

    genderMod = TrainerClass_Gender(dto->trainer[battler].header.trainerType) == GENDER_FEMALE
        ? 120
        : 136;

    u8 partySize = dto->trainer[battler].header.partySize;
    EmulatorLog("Party size: %d", partySize);

    for (i = 0; i < partySize; i++) {
        u8 *base = (u8 *)trmon;
        ExpandedTrainerMonData *data = (ExpandedTrainerMonData *)(base + i * 0x56); // need to specify the offset for each mon because there were issues with the sizeof returning 0x58 instead of 0x56 and so everything was shifted
        EmulatorLog("Processing mon %d", i + 1);
        species = data->monsno & 0x07FF;
        EmulatorLog("Species: %d", species);
        // form is included in the u16 for the species number in the trainer data, so extract it bitwise
        form = (data->monsno & 0xF800) >> TRAINER_MON_FORM_SHIFT;

        rnd = data->ivs + data->level + species + dto->trainerIDs[battler];
        LCRNG_SetSeed(rnd);

        for (j = 0; j < dto->trainer[battler].header.trainerType; j++) {
            rnd = LCRNG_Next();
        }

        rnd = (rnd << 8) + genderMod;
        ivs = data->ivs * MAX_IVS_SINGLE_STAT / MAX_IV_SCALE;

        Pokemon_InitWith(mon, species, data->level, ivs, TRUE, rnd, OTID_NOT_SHINY, 0);
        Pokemon_SetValue(mon, MON_DATA_FORM, &form);

        // Default ability handling if it's not overridden later
        ability1 = SpeciesData_GetFormValue(species, form, SPECIES_DATA_ABILITY_1);
        ability2 = SpeciesData_GetFormValue(species, form, SPECIES_DATA_ABILITY_2);
        // add hidden ability here later
        if (ability2 != 0) {
            if (data->abilityslot & 1 || data->abilityslot == 32) {
                Pokemon_SetValue(mon, MON_DATA_ABILITY, &ability1);
            } else {
                Pokemon_SetValue(mon, MON_DATA_ABILITY, &ability2);
            }
        } else {
            Pokemon_SetValue(mon, MON_DATA_ABILITY, &ability1);
        }
        EmulatorLog("Set ability: %d", Pokemon_GetValue(mon, MON_DATA_ABILITY, NULL));

        // Explicit overrides from expanded record
        Pokemon_SetValue(mon, MON_DATA_HELD_ITEM, &data->itemno);

        for (j = 0; j < 4; j++) {
            if (data->moves[j] != 0) {
                Pokemon_SetMoveSlot(mon, data->moves[j], j);
            }
        }

        if (data->ability != 0) {
            Pokemon_SetValue(mon, MON_DATA_ABILITY, &data->ability);
        }

        if (data->ball != 0) {
            Pokemon_SetValue(mon, MON_DATA_POKEBALL, &data->ball);
        } else {
            u16 pokeBall = ITEM_POKE_BALL;
            Pokemon_SetValue(mon, MON_DATA_POKEBALL, &pokeBall);
        }

        for (j = 0; j < 6; j++) {
            if (data->ivnums[j] > 0) { // only do this if the user specified IVs
                Pokemon_SetValue(mon, MON_DATA_HP_IV + j, &data->ivnums[j]);
            }
        }
        for (j = 0; j < 6; j++) { // defaulting to 0 every time if not specified is fine
            Pokemon_SetValue(mon, MON_DATA_HP_EV + j, &data->evnums[j]);
        }

        if (data->nature != 0xFF) {
            pid = Pokemon_GetValue(mon, MON_DATA_PERSONALITY, NULL);
            u8 currentNature = pid % 25;
            pid = pid + data->nature - currentNature;
            Pokemon_SetValue(mon, MON_DATA_PERSONALITY, &pid);
        }

        if (data->shinyLock != 0) {
            pid = Pokemon_GetValue(mon, MON_DATA_PERSONALITY, NULL);
            do {
                id = (LCRNG_Next() | (LCRNG_Next() << 16));
            } while (!SHINY_CHECK(id, pid));
            Pokemon_SetValue(mon, MON_DATA_OT_ID, &id);
        }

        Pokemon_CalcStats(mon);
        Pokemon_SetValue(mon, MON_DATA_STATUS, &data->status);

        // the following is from HGE but I never foresee myself using them, so

        // if (data->additionalflags & TRDATATYPE_EXTRA_HP) {
        //     Pokemon_SetValue(mon, MON_DATA_MAX_HP, &data->hp);
        //     Pokemon_SetValue(mon, MON_DATA_HP, &data->hp);
        // }
        // if (data->additionalflags & TRDATATYPE_EXTRA_ATTACK) {
        //     Pokemon_SetValue(mon, MON_DATA_ATK, &data->atk);
        // }
        // if (data->additionalflags & TRDATATYPE_EXTRA_DEFENSE) {
        //     Pokemon_SetValue(mon, MON_DATA_DEF, &data->def);
        // }
        // if (data->additionalflags & TRDATATYPE_EXTRA_SPEED) {
        //     Pokemon_SetValue(mon, MON_DATA_SPEED, &data->speed);
        // }
        // if (data->additionalflags & TRDATATYPE_EXTRA_SP_ATTACK) {
        //     Pokemon_SetValue(mon, MON_DATA_SP_ATK, &data->spatk);
        // }
        // if (data->additionalflags & TRDATATYPE_EXTRA_SP_DEFENSE) {
        //     Pokemon_SetValue(mon, MON_DATA_SP_DEF, &data->spdef);
        // }
        // if (data->additionalflags & TRDATATYPE_EXTRA_TYPES) {
        //     for (j = 0; j < 2; j++) {
        //         Pokemon_SetValue(mon, MON_DATA_TYPE_1 + j, &data->types[j]);
        //     }
        // }
        // if (data->additionalflags & TRDATATYPE_EXTRA_PP) {
        //     for (j = 0; j < 4; j++) {
        //         Pokemon_SetValue(mon, MON_DATA_MOVE1_PP + j, &data->ppcounts[j]);
        //     }
        // }
        // if (data->additionalflags & TRDATATYPE_EXTRA_NICKNAME) {
        //     u32 one = 1;
        //     Pokemon_SetValue(mon, MON_DATA_HAS_NICKNAME, &one);
        //     Pokemon_SetValue(mon, MON_DATA_NICKNAME, data->nickname);
        // }

        Pokemon_SetBallSeal(data->ballSeal, mon, heapID);
        TrainerMon_FrustrationCheckAndSetFriendship(mon); // from HeartGold
        Party_AddPokemon(dto->parties[battler], mon);
    }

    Heap_Free(mon);
    Heap_Free(trmon);
    LCRNG_SetSeed(oldSeed);
}

// from PokeHeartGold
static void TrainerMon_OverridePidGender(int species, int form, int overrideParam, u32 *pid) {
    int genderOverride = overrideParam & 0xF;
    int abilityOverride = (overrideParam & 0xF0) >> 4;
    if (overrideParam != 0) {
        if (genderOverride != 0) {
            *pid = SpeciesData_GetFormValue(species, form, SPECIES_DATA_GENDER_RATIO);
            if (genderOverride == 1) {
                *pid += 2;
            } else {
                *pid -= 2;
            }
        }
        if (abilityOverride == 1) {
            *pid &= ~1;
        } else if (abilityOverride == 2) {
            *pid |= 1;
        }
    }
}

// from PokeHeartGold
static void TrainerMon_FrustrationCheckAndSetFriendship(Pokemon *mon) {
    u8 friendship = 255;
    int i;

    for (i = 0; i < 4; i++) {
        if (Pokemon_GetValue(mon, MON_DATA_MOVE1 + i, NULL) == MOVE_FRUSTRATION) {
            friendship = 0;
        }
    }
    Pokemon_SetValue(mon, MON_DATA_FRIENDSHIP, &friendship);
}

#endif