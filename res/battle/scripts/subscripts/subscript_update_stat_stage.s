#include "macros/btlcmd.inc"


_000:
    ChangeStatStage _041, _059, _060
    CompareVarToValue OPCODE_NEQ, BTLVAR_SIDE_EFFECT_TYPE, SIDE_EFFECT_TYPE_DIRECT, _010
    PrintAttackMessage 
    Wait 

_010:
    CompareVarToValue OPCODE_NEQ, BTLVAR_SIDE_EFFECT_TYPE, SIDE_EFFECT_TYPE_DIRECT, _018
    PlayMoveAnimation BTLSCR_ATTACKER
    Wait 

_018:
    CompareVarToValue OPCODE_FLAG_SET, BTLVAR_BATTLE_CTX_STATUS_2, SYSCTL_UPDATE_STAT_STAGES, _036
    PlayBattleAnimationFromVar BTLSCR_SIDE_EFFECT_MON, BTLVAR_SCRIPT_TEMP
    Wait 
    CompareVarToValue OPCODE_FLAG_NOT, BTLVAR_BATTLE_CTX_STATUS_2, SYSCTL_STAT_STAGE_CHANGE_SHOWN, _036
    UpdateVar OPCODE_FLAG_ON, BTLVAR_BATTLE_CTX_STATUS_2, SYSCTL_UPDATE_STAT_STAGES

_036:
    CompareVarToValue OPCODE_FLAG_SET, BTLVAR_BATTLE_CTX_STATUS, SYSCTL_HIT_DURING_SHADOW_FORCE, _HandleDefiantAndCompetitive2
    PrintBufferedMessage
    Wait
    WaitButtonABTime 30
    TryTriggerDefiantOrCompetitive _NoNeedHandle, _HandleDefiant, _HandleCompetitive
_HandleDefiant:
    Call BATTLE_SUBSCRIPT_DEFIANT
    GoTo _NoNeedHandle
_HandleCompetitive:
    Call BATTLE_SUBSCRIPT_COMPETITIVE
_NoNeedHandle:
    End

_041:
    CompareVarToValue OPCODE_NEQ, BTLVAR_SIDE_EFFECT_TYPE, SIDE_EFFECT_TYPE_DIRECT, _048
    PrintAttackMessage 
    Wait 

_048:
    CompareVarToValue OPCODE_FLAG_SET, BTLVAR_BATTLE_CTX_STATUS, SYSCTL_TURN_OFF_MESSAGES, _059
    WaitButtonABTime 30
    PrintBufferedMessage 
    Wait 
    WaitButtonABTime 30

_059:
_HandleDefiantAndCompetitive2:
    TryTriggerDefiantOrCompetitive _NoNeedHandle2, _HandleDefiant2, _HandleCompetitive2
_HandleDefiant2:
    Call BATTLE_SUBSCRIPT_DEFIANT
    GoTo _NoNeedHandle
_HandleCompetitive2:
    Call BATTLE_SUBSCRIPT_COMPETITIVE
_NoNeedHandle2:
    End

_060:
    UpdateVar OPCODE_FLAG_ON, BTLVAR_MOVE_STATUS_FLAGS, MOVE_STATUS_FAILED
    End 
