#include "macros/scrcmd.inc"
#include "res/field/events/events_route_223.h"

    ScriptEntry Route223_OnTransition
    ScriptEntryEnd

Route223_OnTransition:
    GoToIfSet FLAG_HIDE_SUNYSHORE_CITY_JASMINE, Route223_RemoveJasmine
    End

Route223_RemoveJasmine:
    SetObjectEventPos LOCALID_JASMINE, 832, 735
    End