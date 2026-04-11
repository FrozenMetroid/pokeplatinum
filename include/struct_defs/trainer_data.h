#ifndef POKEPLATINUM_STRUCT_TRAINER_DATA_H
#define POKEPLATINUM_STRUCT_TRAINER_DATA_H

/*
 * Note: *most* source files should not include this header directly, and should
 * instead including `struct_defs/trainer.h`. This header is held separately for
 * use by data-packing routines.
 */

#include "constants/moves.h"
#include "senate_config.h"

#ifdef BATTLE_EXPANDED_TRAINER_STRUCT
#define TRAINER_MON_FORM_SHIFT 11
#else
#define TRAINER_MON_FORM_SHIFT 10
#endif

#define MAX_TRAINER_ITEMS 4
#define MAX_IV_SCALE      255

#ifndef BATTLE_EXPANDED_TRAINER_STRUCT
enum TrainerDataType {
    TRDATATYPE_BASE = 0,
    TRDATATYPE_WITH_MOVES,
    TRDATATYPE_WITH_ITEM,
    TRDATATYPE_WITH_MOVES_AND_ITEM,
};
#else
enum TrainerDataType {
    TRDATATYPE_BASE = 0,
    TRDATATYPE_WITH_MOVES,
    TRDATATYPE_WITH_ITEM,
    TRDATATYPE_WITH_ABILITY,
    TRDATATYPE_WITH_BALL,
    TRDATATYPE_WITH_IV_EV_SET,
    TRDATATYPE_WITH_NATURE,
    TRDATATYPE_WITH_SHINY_LOCK,
    TRDATATYPE_WITH_ADDITIONAL_FLAGS,
};
#endif

typedef struct TrainerHeader {
    u8 monDataType;
    u8 trainerType;
    u8 sprite;
    u8 partySize;
    u16 items[MAX_TRAINER_ITEMS];
    u32 aiMask;
    u32 battleType;
} TrainerHeader;

typedef struct TrainerMonBase {
    u16 ivScale;
    u16 level;
    u16 species;
    u16 cbSeal;
} TrainerMonBase;

typedef struct TrainerMonWithMoves {
    u16 ivScale;
    u16 level;
    u16 species;
    u16 moves[LEARNED_MOVES_MAX];
    u16 cbSeal;
} TrainerMonWithMoves;

typedef struct TrainerMonWithItem {
    u16 ivScale;
    u16 level;
    u16 species;
    u16 item;
    u16 cbSeal;
} TrainerMonWithItem;

typedef struct TrainerMonWithMovesAndItem {
    u16 ivScale;
    u16 level;
    u16 species;
    u16 item;
    u16 moves[LEARNED_MOVES_MAX];
    u16 cbSeal;
} TrainerMonWithMovesAndItem;

#ifdef BATTLE_EXPANDED_TRAINER_STRUCT

#define TRDATATYPE_EXTRA_NOTHING  (1 << 0)
#define TRDATATYPE_EXTRA_STATUS (1 << 1)
#define TRDATATYPE_EXTRA_HP (1 << 2)
#define TRDATATYPE_EXTRA_ATTACK (1 << 3)
#define TRDATATYPE_EXTRA_DEFENSE (1 << 4)
#define TRDATATYPE_EXTRA_SPEED (1 << 5)
#define TRDATATYPE_EXTRA_SP_ATTACK (1 << 6)
#define TRDATATYPE_EXTRA_SP_DEFENSE (1 << 7)
#define TRDATATYPE_EXTRA_TYPES (1 << 8)
#define TRDATATYPE_EXTRA_PP (1 << 9)
#define TRDATATYPE_EXTRA_NICKNAME (1 << 10)

// Status
#define STATUS_NONE         0
#define STATUS_SLEEP_0      (1 << 0)
#define STATUS_SLEEP_1      (1 << 1)
#define STATUS_SLEEP_2      (1 << 2)
#define STATUS_POISON       (1 << 3)
#define STATUS_BURN         (1 << 4)
#define STATUS_FREEZE       (1 << 5)
#define STATUS_PARALYSIS    (1 << 6)
#define STATUS_BAD_POISON   (1 << 7)
#define STATUS_POISON_COUNT (15 << 8)

#define CONDITION_NONE      0
#define CONDITION_SLEEP     1
#define CONDITION_POISON    2
#define CONDITION_BURN      3
#define CONDITION_FREEZE    4
#define CONDITION_PARALYSIS 5

#define STATUS_SLEEP      (STATUS_SLEEP_0 | STATUS_SLEEP_1 | STATUS_SLEEP_2)
#define STATUS_NOT_SLEEP  ~STATUS_SLEEP
#define STATUS_POISON_ALL (STATUS_POISON | STATUS_BAD_POISON | STATUS_POISON_COUNT)

#define STATUS_ALL             (STATUS_SLEEP | STATUS_POISON | STATUS_BURN | STATUS_FREEZE | STATUS_PARALYSIS | STATUS_BAD_POISON)
#define STATUS_FACADE_BOOST    (STATUS_POISON | STATUS_BAD_POISON | STATUS_BURN | STATUS_PARALYSIS)
#define STATUS_CAN_SYNCHRONIZE (STATUS_POISON | STATUS_BURN | STATUS_PARALYSIS)
#define STATUS_ANY_PERSISTENT  (STATUS_SLEEP | STATUS_POISON_ALL | STATUS_BURN | STATUS_FREEZE | STATUS_PARALYSIS)

#endif

#endif // POKEPLATINUM_STRUCT_TRAINER_DATA_H
