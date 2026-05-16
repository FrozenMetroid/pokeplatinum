#include "macros/btlcmd.inc"


_000:
    // {0}’s Harvest restored its {1}!
    PrintMessage BattleStrings_Text_HarvestRestoredBerry_Ally, TAG_NICKNAME_ITEM, BTLSCR_MSG_TEMP, BTLSCR_MSG_BATTLER_TEMP
    Wait 
    WaitButtonABTime 30
    End 