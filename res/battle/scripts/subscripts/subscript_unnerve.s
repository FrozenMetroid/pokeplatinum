#include "macros/btlcmd.inc"


_000:
    // {0}’s {1} makes the opposing team too nervous to eat Berries!
    PrintMessage BattleStrings_Text_Unnerve_Ally, TAG_NICKNAME_ABILITY, BTLSCR_MSG_TEMP, BTLSCR_MSG_BATTLER_TEMP
    Wait 
    WaitButtonABTime 30
    End 