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

    CheckMoveFailureMimesis BTLSCR_DEFENDER, BTLSCR_ATTACKER, _ButItFailed // check if the attacker's copied move will fail against the defender (e.g. the defender has Soundproof or the current move is Growl and the defender's Defense can't go down further)
    CompareVarToValue OPCODE_GT, BTLVAR_SCRIPT_TEMP, 0, _QueueImmunitySubscript
    PlayMoveAnimation BTLSCR_ATTACKER
    Wait
    UpdateVar OPCODE_SET, BTLVAR_SIDE_EFFECT_TYPE, SIDE_EFFECT_TYPE_DIRECT // makes the stat animations show up properly 
    CompareVarToValue OPCODE_EQU, BTLVAR_CURRENT_MOVE, MOVE_GROWL, PostAnimation_Growl
    CompareVarToValue OPCODE_EQU, BTLVAR_CURRENT_MOVE, MOVE_SCREECH, PostAnimation_Screech
    CompareVarToValue OPCODE_EQU, BTLVAR_CURRENT_MOVE, MOVE_HOWL, PostAnimation_Howl
    CompareVarToValue OPCODE_EQU, BTLVAR_CURRENT_MOVE, MOVE_METAL_SOUND, PostAnimation_MetalSound
    CompareVarToValue OPCODE_EQU, BTLVAR_CURRENT_MOVE, MOVE_SUPERSONIC, _ApplyConfusion
    CompareVarToValue OPCODE_EQU, BTLVAR_CURRENT_MOVE, MOVE_PERISH_SONG, _End // skip damage
    // Hyper Voice, Bug Buzz, and Uproar deal damage
    // Uproar will not lock the Mimesis mon into using it -- too much of a hassle and would be too disruptive to that Pokemon to involuntarily lose its actions if someone spams Uproar on it
    CalcCrit 
    CalcDamage
    Call BATTLE_SUBSCRIPT_UPDATE_HP
    Wait
    CompareVarToValue OPCODE_EQU, BTLVAR_CURRENT_MOVE, MOVE_BUG_BUZZ, _CheckLowerSpDef
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
    UpdateVarFromVar OPCODE_SET, BTLVAR_SIDE_EFFECT_MON, BTLVAR_ATTACKER
    GoTo _Update_Stat_Stage

_QueueImmunitySubscript:
    CallFromVar BTLVAR_SCRIPT_TEMP
    End

_ApplyConfusion:
    Call BATTLE_SUBSCRIPT_CONFUSE
    End

PostAnimation_MetalSound:
    UpdateVar OPCODE_SET, BTLVAR_SIDE_EFFECT_PARAM, MOVE_SUBSCRIPT_PTR_SP_DEFENSE_DOWN_2_STAGES
    GoTo _Update_Stat_Stage

_CheckLowerSpDef:
    UpdateVar OPCODE_RANDOM_MOD, BTLVAR_CALC_TEMP, 10
    CompareVarToValue OPCODE_EQU, BTLVAR_CALC_TEMP, 0, _LowerSpDefWithBugBuzz // 1 in 10 chance (0-9)
    GoTo _End

_LowerSpDefWithBugBuzz:
    UpdateVar OPCODE_SET, BTLVAR_SIDE_EFFECT_PARAM, MOVE_SUBSCRIPT_PTR_SP_DEFENSE_DOWN_1_STAGE
    GoTo _Update_Stat_Stage