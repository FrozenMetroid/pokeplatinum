#include "macros/btlcmd.inc"


_000:
    CheckFlingExceptions _FailedFling
    TryFling _FailedFling
    UpdateVar OPCODE_SET, BTLVAR_SIDE_EFFECT_FLAGS_INDIRECT, MOVE_SIDE_EFFECT_ON_HIT|MOVE_SIDE_EFFECT_TO_DEFENDER|MOVE_SUBSCRIPT_PTR_FLING
    CalcCrit 
    CalcDamage 
    PrintAttackMessage 
    Wait 
    WaitButtonABTime 30
    // {0} flung its {1}!
    PrintMessage BattleStrings_Text_PokemonFlungItsItem_Ally, TAG_NICKNAME_ITEM, BTLSCR_ATTACKER, BTLSCR_ATTACKER
    Wait 
    WaitButtonABTime 30
    RemoveItem BTLSCR_ATTACKER
    End 

_FailedFling:
    UpdateVar OPCODE_FLAG_ON, BTLVAR_MOVE_STATUS_FLAGS, MOVE_STATUS_FAILED
    End 
