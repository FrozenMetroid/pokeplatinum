#include "macros/btlcmd.inc"


_000:
    UpdateVar OPCODE_SET, BTLVAR_MSG_MOVE_TEMP, MOVE_HEAL_BLOCK
    CompareMonDataToValue OPCODE_EQU, BTLSCR_DEFENDER, BATTLEMON_ABILITY, ABILITY_MATRIARCH, _HandleMatriarch
    // {0} was prevented from healing due to {1}!
    PrintMessage BattleStrings_Text_PokemonWasPreventedFromHealingDueToMove_Ally, TAG_NICKNAME_MOVE, BTLSCR_MSG_TEMP, BTLSCR_MSG_TEMP
_Wait:
    Wait 
    WaitButtonABTime 30
    End 

_HandleMatriarch:
    PrintMessage BattleStrings_Text_PokemonWasPreventedFromMatriarchHealingDueToMove_Ally, TAG_NICKNAME_ABILITY_MOVE, BTLSCR_MSG_TEMP, BTLSCR_DEFENDER, BTLSCR_MSG_TEMP
    GoTo _Wait

