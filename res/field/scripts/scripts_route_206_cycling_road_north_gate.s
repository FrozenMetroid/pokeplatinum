#include "macros/scrcmd.inc"
#include "res/text/bank/route_206_cycling_road_north_gate.h"
#include "res/field/events/events_route_206_cycling_road_north_gate.h"


    ScriptEntry Route206CyclingRoadNorthGate_OnTransition
    ScriptEntry Route206CyclingRoadNorthGate_CashierM
    ScriptEntry Route206CyclingRoadNorthGate_TriggerOnlyBicycles
    ScriptEntry Route206CyclingRoadNorthGate_TriggerClearFlagForceBikingInGate
    ScriptEntry Route206CyclingRoadNorthGate_ScientistM
    ScriptEntry Route206CyclingRoadNorthGate_OnFrame
    ScriptEntryEnd

Route206CyclingRoadNorthGate_OnFrame:
    GetPlayerMapPos VAR_MAP_LOCAL_4, VAR_MAP_LOCAL_5
    CallIfGe VAR_MAP_LOCAL_5, 12, Route206CyclingRoadNorthGate_OnFrameForceBikingInGate
    SetVar VAR_MAP_LOCAL_3, 1
    End

Route206CyclingRoadNorthGate_OnFrameForceBikingInGate:
    SetFlag FLAG_FORCE_BIKING_IN_GATE
    Return

Route206CyclingRoadNorthGate_OnTransition:
    End

Route206CyclingRoadNorthGate_CashierM:
    NPCMessage Route206CyclingRoadNorthGate_Text_LearnHowToShiftGearsAndYoullBeAbleToRideAnywhere
    End

Route206CyclingRoadNorthGate_TriggerOnlyBicycles:
    LockAll
    CheckPlayerOnBike VAR_RESULT
    GoToIfEq VAR_RESULT, TRUE, Route206CyclingRoadNorthGate_TriggerForceBikingInGate
    ApplyMovement LOCALID_CASHIER_M_WEST, Route206CyclingRoadNorthGate_Movement_CashierMExclamationMark
    WaitMovement
    Message Route206CyclingRoadNorthGate_Text_CyclingRoadIsOnlyForBicycles
    CloseMessage
    ApplyMovement LOCALID_PLAYER, Route206CyclingRoadNorthGate_Movement_PlayerWalkNorth
    WaitMovement
    ReleaseAll
    End

Route206CyclingRoadNorthGate_TriggerForceBikingInGate:
    SetFlag FLAG_FORCE_BIKING_IN_GATE
    SetVar VAR_MAP_LOCAL_2, 1
    ReleaseAll
    End

    .balign 4, 0
Route206CyclingRoadNorthGate_Movement_CashierMExclamationMark:
    EmoteExclamationMark
    EndMovement

    .balign 4, 0
Route206CyclingRoadNorthGate_Movement_PlayerWalkNorth:
    WalkNormalNorth
    EndMovement

Route206CyclingRoadNorthGate_TriggerClearFlagForceBikingInGate:
    LockAll
    ClearFlag FLAG_FORCE_BIKING_IN_GATE
    SetVar VAR_MAP_LOCAL_2, 0
    ReleaseAll
    End

Route206CyclingRoadNorthGate_ScientistM:
    End

    .balign 4, 0
