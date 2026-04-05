#ifndef POKEPLATINUM_SPECIES_H
#define POKEPLATINUM_SPECIES_H

#define MAX_ABILITIES  2
#define MAX_EGG_GROUPS 2
#define MAX_TYPES      2

#define MAX_EVOLUTIONS 7

#define MAX_LEARNSET_ENTRIES_OLD    20
#define MAX_LEARNSET_ENTRIES        40
#define LEARNSET_NO_MOVE_TO_LEARN   0
#define LEARNSET_MOVE_ALREADY_KNOWN 0xFFFE
#define LEARNSET_ALL_SLOTS_FILLED   0xFFFF
#define LEARNSET_SENTINEL_ENTRY     0xFFFF

// from HeartGold-Engine
#define LEVEL_UP_LEARNSET_END 0xFFFFFFFF
#define LEVEL_UP_LEARNSET_LEVEL_MASK 0xFFFF0000
#define LEVEL_UP_LEARNSET_MOVE_MASK 0xFFFF
#define LEVEL_UP_LEARNSET_LEVEL_SHIFT 16
#define LEVEL_UP_LEARNSET_MOVE(move) (move & LEVEL_UP_LEARNSET_MOVE_MASK)
#define LEVEL_UP_LEARNSET_LEVEL(move) ((move & LEVEL_UP_LEARNSET_LEVEL_MASK) >> LEVEL_UP_LEARNSET_LEVEL_SHIFT)


typedef struct SpeciesBaseStats {
    u8 hp;
    u8 attack;
    u8 defense;
    u8 speed;
    u8 spAttack;
    u8 spDefense;
} SpeciesBaseStats;

typedef struct SpeciesEVYields {
    u16 hp : 2;
    u16 attack : 2;
    u16 defense : 2;
    u16 speed : 2;
    u16 spAttack : 2;
    u16 spDefense : 2;
} SpeciesEVYields;

typedef struct SpeciesWildHeldItems {
    u16 common;
    u16 rare;
} SpeciesWildHeldItems;

typedef struct SpeciesData {
    SpeciesBaseStats baseStats;
    u8 types[MAX_TYPES];
    u8 catchRate;
    u8 baseExpReward;
    SpeciesEVYields evYields;
    SpeciesWildHeldItems wildHeldItems;
    u8 genderRatio;
    u8 hatchCycles;
    u8 baseFriendship;
    u8 expRate;
    u8 eggGroups[MAX_EGG_GROUPS];
    u8 abilities[MAX_ABILITIES];
    u8 safariFleeRate;
    u8 bodyColor : 7;
    u8 flipSprite : 1;
    // u16 padding;

    u32 tmLearnsetMasks[4]; // Bitflags for whether this pokemon can learn a TM
} SpeciesData;

typedef struct SpeciesEvolution {
    u16 method;
    u16 param;
    u16 targetSpecies;
} SpeciesEvolution;

typedef struct SpeciesLearnsetEntry { // expanded from 9 bits for move and 7 for level because fuck it
    u16 move;
    u16 level;
} SpeciesLearnsetEntry;

// This struct is not explicitly used; it is provided to document and enforce the size of
// the learnset entries.
typedef struct SpeciesLearnset {
    ALIGN_4 SpeciesLearnsetEntry entries[MAX_LEARNSET_ENTRIES + 1];
} SpeciesLearnset;

typedef struct SpeciesPalPark {
    u8 landArea;
    u8 waterArea;
    u8 catchingPoints;
    u8 rarity;

    union {
        u8 asU8[2];
        u16 asU16;
    } unused;
} SpeciesPalPark;

#endif // POKEPLATINUM_SPECIES_H
