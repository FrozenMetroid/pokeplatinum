#include "macros/btlcmd.inc"


_000:
    CompareMonDataToValue OPCODE_FLAG_SET, BTLSCR_ATTACKER, BATTLEMON_STATUS, MON_CONDITION_SLEEP, _End
    CompareMonDataToValue OPCODE_FLAG_SET, BTLSCR_ATTACKER, BATTLEMON_STATUS, MON_CONDITION_FREEZE, _End
    
    // {0} mimics {2}'s {3} with its {1}!
    PrintMessage BattleStrings_Text_Mimesis_AllyAlly, TAG_NICKNAME_ABILITY_NICKNAME_MOVE, BTLSCR_ATTACKER, BTLSCR_ATTACKER, BTLSCR_DEFENDER, BTLSCR_MSG_TEMP
    Wait 
    WaitButtonABTime 30
_Use_Move:
    PrintAttackMessage 
    Wait
    CompareVarToValue OPCODE_EQU, BTLVAR_CURRENT_MOVE, MOVE_PERISH_SONG, _TryPerishSong // stop the perish song animation from playing if it would fail
_CheckOtherMoveFailures:
    CheckMoveFailureMimesis BTLSCR_ATTACKER, _ButItFailed
    PlayMoveAnimation BTLSCR_ATTACKER
    Wait
    
    UpdateVar OPCODE_SET, BTLVAR_SIDE_EFFECT_TYPE, SIDE_EFFECT_TYPE_DIRECT // makes the stat animations show up properly 
    CompareVarToValue OPCODE_EQU, BTLVAR_CURRENT_MOVE, MOVE_GROWL, PostAnimation_Growl // update stat if possible
    CompareVarToValue OPCODE_EQU, BTLVAR_CURRENT_MOVE, MOVE_SCREECH, PostAnimation_Screech // update stat if possible
    CompareVarToValue OPCODE_EQU, BTLVAR_CURRENT_MOVE, MOVE_HOWL, PostAnimation_Howl // update stat if possible
    CompareVarToValue OPCODE_EQU, BTLVAR_CURRENT_MOVE, MOVE_PERISH_SONG, _End

    // Hyper Voice is the only one that will deal damage
    CalcCrit 
    CalcDamage
    Call BATTLE_SUBSCRIPT_UPDATE_HP
    Wait
_End:
    End

_TryPerishSong:
    TryPerishSong _ButItFailed
    GoTo _CheckOtherMoveFailures

_ButItFailed:
    UpdateVar OPCODE_FLAG_ON, BTLVAR_MOVE_STATUS_FLAGS, MOVE_STATUS_FAILED
    GoToSubscript BATTLE_SUBSCRIPT_BUT_IT_FAILED
    End

PostAnimation_Growl:
    UpdateVar OPCODE_SET, BTLVAR_SIDE_EFFECT_PARAM, MOVE_SUBSCRIPT_PTR_ATTACK_DOWN_1_STAGE
_Update_Stat_Stage:
    Call BATTLE_SUBSCRIPT_UPDATE_STAT_STAGE
    UpdateVar OPCODE_FLAG_OFF, BTLVAR_BATTLE_CTX_STATUS_2, SYSCTL_UPDATE_STAT_STAGES
    UpdateVar OPCODE_FLAG_OFF, BTLVAR_BATTLE_CTX_STATUS_2, SYSCTL_STAT_STAGE_CHANGE_SHOWN
    End

PostAnimation_Screech:
    UpdateVar OPCODE_SET, BTLVAR_SIDE_EFFECT_PARAM, MOVE_SUBSCRIPT_PTR_DEFENSE_DOWN_2_STAGES
    GoTo _Update_Stat_Stage

PostAnimation_Howl:
    UpdateVar OPCODE_SET, BTLVAR_SIDE_EFFECT_PARAM, MOVE_SUBSCRIPT_PTR_ATTACK_UP_1_STAGE
    GoTo _Update_Stat_Stage