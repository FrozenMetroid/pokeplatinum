#include "macros/scrcmd.inc"


    InitScriptEntry_OnTransition 1
    InitScriptEntry_OnFrameTable InitScriptFrameTable
    InitScriptEntryEnd

InitScriptFrameTable:
    InitScriptGoToIfEqual VAR_PLAYER_HOUSE_STATE, 0, 2
    InitScriptGoToIfEqual VAR_PLAYER_HOUSE_POSTGAME_STATE, 1, 11
    InitScriptGoToIfEqual VAR_PLAYER_HOUSE_STATE, EVENT_STATE_PLAYER_HOUSE_AFTER_201_RIVAL_BATTLE, 3
    InitScriptGoToIfEqual VAR_SHAYMIN_EVENT_STATE, EVENT_STATE_SHAYMIN_TRIGGER_RECEIVE_OAK_LETTER, 12
    InitScriptFrameTableEnd

    InitScriptEnd
