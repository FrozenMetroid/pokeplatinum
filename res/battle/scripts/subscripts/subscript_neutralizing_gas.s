#include "macros/btlcmd.inc"


_000:
    // {0}’s {1} filled the area!
    PrintMessage BattleStrings_Text_NeutralizingGas_Ally, TAG_NICKNAME_ABILITY, BTLSCR_MSG_TEMP, BTLSCR_MSG_BATTLER_TEMP
    Wait 
    WaitButtonABTime 30
    End 