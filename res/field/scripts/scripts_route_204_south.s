#include "macros/scrcmd.inc"
#include "res/text/bank/route_204_south.h"


    ScriptEntry Route204South_Youngster
    ScriptEntry Route204South_ArrowSignpostJubilifeCity
    ScriptEntry Route204South_LandmarkSignRavagedPath
    ScriptEntryEnd

Route204South_Youngster:
    NPCMessage Route204South_Text_ThereAreBouldersBlockingTheWayInsideTheCavern
    End

Route204South_ArrowSignpostJubilifeCity:
    ShowArrowSign Route204South_Text_Rt204JubilifeCity
    End

Route204South_LandmarkSignRavagedPath:
//     SetVar VAR_0x8001, SPECIES_MEWTWO
//     GoTo TriggerBattlesWithEveryMon
// _ShowLandMarkSign:
    ShowLandmarkSign Route204South_Text_RavagedPath
    End

// TriggerBattlesWithEveryMon:
//     GoToIfGe VAR_0x8001, SPECIES_ARCEUS, _ShowLandMarkSign
//     StartWildBattle VAR_0x8001, 1
//     CheckWonBattle VAR_RESULT
//     GoToIfEq VAR_RESULT, FALSE, _BlackOut
//     AddVar VAR_0x8001, 1
//     GoTo TriggerBattlesWithEveryMon
// 
// _BlackOut:
//     BlackOutFromBattle
//     ReleaseAll
//     End
// 
    .balign 4, 0
