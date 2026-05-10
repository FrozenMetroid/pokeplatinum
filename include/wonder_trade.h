#include "pokemon.h"
#include "party.h"
#include "string.h"
#include "field/field_system_decl.h"

typedef struct WonderTradeData {
    u16 species; // received
    u16 item;
    u16 ball;
    u16 availableLearnsetMoves; // number of moves in the learnset that mon can learn at the generated level
    u16 trainerClassGender;
    u8 level;
    u8 form;
    u8 hiddenAbility; // only used for if the hidden ability is selected, otherwise the ability is determined by the personality value generated in Pokemon_InitWithSpecies and the form of the mon
    u8 partySlot;
    BOOL natDexWonderTrade;
    u16 *finalMessage; // for the attendant to say based on BST of the received mon
    struct Pokemon sentPokemon; // store its data after removing the mon so we know what to show during the trade anim
    struct String *otName;
    struct Pokemon *receivedPokemon;
    struct Party *party;
}WonderTradeData;

typedef struct ExcludedSpecies {
    u16 species;
    u16 flag;
}ExcludedSpecies;

typedef struct WonderTradeSpecialCases {
    u16 species1;
    u16 species2;
    u16 species3;
    u8 level1; // what level is the minimum for this pokemon to be selected (i.e., if below this level, devolve)
    u8 level2; // what level is the minimum for the next evolution
}WonderTradeSpecialCases;

enum WonderTradeTaskState {
    WONDER_TRADE_TASK_STATE_GENERATE_SPECIES,
    WONDER_TRADE_TASK_STATE_GENERATE_ABILITY,
    WONDER_TRADE_TASK_STATE_GENERATE_ITEM,
    WONDER_TRADE_TASK_STATE_GENERATE_BALL,
    WONDER_TRADE_TASK_STATE_GIVE_MON,
    WONDER_TRADE_TASK_STATE_GENERATE_LEVELUP_MOVES,
    WONDER_TRADE_TASK_STATE_GENERATE_EGG_MOVES,
    WONDER_TRADE_TASK_STATE_GENERATE_TM_MOVES,
    WONDER_TRADE_TASK_STATE_GENERATE_EVS,
    WONDER_TRADE_TASK_STATE_DETERMINE_OT_NAME,
    WONDER_TRADE_TASK_STATE_TRADE_GRAPHICS,
    WONDER_TRADE_TASK_STATE_END,
};

BOOL WonderTrade_GetSpeciesAndForm(WonderTradeData *wonderTradeData, struct FieldSystem_t *fieldSystem);
void WonderTrade_GetHiddenAbility(WonderTradeData *wonderTradeData, u32 *taskState);
void WonderTrade_GetItem(WonderTradeData *wonderTradeData, u32 *taskState);
void WonderTrade_GetBall(WonderTradeData *wonderTradeData, u32 *taskState);
void WonderTrade_GiveMon(WonderTradeData *wonderTradeData, struct FieldSystem_t *fieldSystem, u32 *taskState);
void WonderTrade_GetLevelUpMoves(WonderTradeData *wonderTradeData, u32 *taskState);
void WonderTrade_GetEggMove(WonderTradeData *wonderTradeData, u32 *taskState);
void WonderTrade_GetTMMoves(WonderTradeData *wonderTradeData, u32 *taskState);
void WonderTrade_GetEVs(WonderTradeData *wonderTradeData, u32 *taskState);
void WonderTrade_GetOTName(WonderTradeData *wonderTradeData, struct FieldSystem_t *fieldSystem, u32 *taskState);
void WonderTrade_TradeGraphics(WonderTradeData *wonderTradeData, struct FieldSystem_t *fieldSystem, u32 *taskState);