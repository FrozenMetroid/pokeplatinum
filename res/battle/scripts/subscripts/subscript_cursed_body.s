#include "macros/btlcmd.inc"

.data

_000:
    // {0}’s {1} was disabled by Cursed Body!
    PrintMessage BattleStrings_Text_CursedBody_Ally, TAG_NICKNAME_MOVE, BTLSCR_ATTACKER, BTLSCR_MSG_TEMP
    Wait
    WaitButtonABTime 30
    End 
