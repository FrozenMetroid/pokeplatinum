#include "macros/btlcmd.inc"


_Start:
    PlayBattleAnimation BTLSCR_MSG_TEMP, BATTLE_ANIMATION_HELD_ITEM
    Wait
    CompareMonDataToValue OPCODE_FLAG_NOT, BTLSCR_MSG_TEMP, BATTLEMON_VOLATILE_STATUS, VOLATILE_CONDITION_ATTRACT, _HandleTaunt
    // {0} cured its {2} status using its {1}!
    PrintMessage BattleStrings_Text_PokemonCuredItsStatusUsingItsItem_Ally, TAG_NICKNAME_ITEM_STATUS, BTLSCR_MSG_TEMP, BTLSCR_MSG_TEMP, BTLSCR_MSG_TEMP
    Wait 
    WaitButtonABTime 30
    UpdateMonData OPCODE_FLAG_OFF, BTLSCR_MSG_TEMP, BATTLEMON_VOLATILE_STATUS, VOLATILE_CONDITION_ATTRACT

_HandleTaunt:
    CompareMonDataToValue OPCODE_EQU, BTLSCR_DEFENDER, BATTLEMON_TAUNTED_TURNS, 0, _HandleEncore
    // {0} shook off the taunt!
    PrintMessage BattleStrings_Text_PokemonsTauntWoreOff_Ally, TAG_NICKNAME, BTLSCR_MSG_TEMP
    Wait 
    WaitButtonABTime 30
    UpdateMonData OPCODE_SET, BTLSCR_MSG_TEMP, BATTLEMON_TAUNTED_TURNS, 0

_HandleEncore:
    CompareMonDataToValue OPCODE_EQU, BTLSCR_DEFENDER, BATTLEMON_ENCORED_TURNS, 0, _HandleTorment
    // {0}'s encore ended!
    PrintMessage BattleStrings_Text_PokemonsEncoreEnded_Ally, TAG_NICKNAME, BTLSCR_MSG_TEMP
    Wait 
    WaitButtonABTime 30
    UpdateMonData OPCODE_SET, BTLSCR_MSG_TEMP, BATTLEMON_ENCORED_TURNS, 0
    UpdateMonData OPCODE_SET, BTLSCR_MSG_TEMP, BATTLEMON_ENCORED_MOVE, MOVE_NONE

_HandleTorment:
    CompareMonDataToValue OPCODE_FLAG_NOT, BTLSCR_MSG_TEMP, BATTLEMON_VOLATILE_STATUS, VOLATILE_CONDITION_TORMENT, _HandleDisable
    // {0} is no longer tormented!
    PrintMessage BattleStrings_Text_TormentWoreOff_Ally, TAG_NICKNAME_ITEM_STATUS, BTLSCR_MSG_TEMP, BTLSCR_MSG_TEMP, BTLSCR_MSG_TEMP
    Wait 
    WaitButtonABTime 30
    UpdateMonData OPCODE_FLAG_OFF, BTLSCR_MSG_TEMP, BATTLEMON_VOLATILE_STATUS, VOLATILE_CONDITION_TORMENT

_HandleDisable:
    CompareMonDataToValue OPCODE_EQU, BTLSCR_DEFENDER, BATTLEMON_DISABLED_TURNS, 0, _HandleHealBlock
    // {0}'s move is no longer disabled!
    PrintMessage BattleStrings_Text_PokemonIsNoLongerDisabled_Ally, TAG_NICKNAME_ITEM_STATUS, BTLSCR_MSG_TEMP, BTLSCR_MSG_TEMP, BTLSCR_MSG_TEMP
    Wait 
    WaitButtonABTime 30
    UpdateMonData OPCODE_SET, BTLSCR_MSG_TEMP, BATTLEMON_DISABLED_TURNS, 0
    UpdateMonData OPCODE_SET, BTLSCR_MSG_TEMP, BATTLEMON_DISABLED_MOVE, MOVE_NONE

_HandleHealBlock:
    CompareMonDataToValue OPCODE_EQU, BTLSCR_DEFENDER, BATTLEMON_HEAL_BLOCK_TURNS, 0, _CheckPluck
    // {0} is no longer prevented from healing!
    PrintMessage BattleStrings_Text_HealBlockWoreOff_Ally, TAG_NICKNAME_ITEM_STATUS, BTLSCR_MSG_TEMP, BTLSCR_MSG_TEMP, BTLSCR_MSG_TEMP
    Wait 
    WaitButtonABTime 30
    UpdateMonData OPCODE_SET, BTLSCR_MSG_TEMP, BATTLEMON_HEAL_BLOCK_TURNS, 0

_CheckPluck:
    Call BATTLE_SUBSCRIPT_PLUCK_CHECK
    End 
