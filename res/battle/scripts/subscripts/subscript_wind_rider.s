#include "macros/btlcmd.inc"


_000:
    PrintAttackMessage 
    Wait 
    WaitButtonABTime 15
    CompareMonDataToValue OPCODE_EQU, BTLSCR_DEFENDER, BATTLEMON_ATTACK_STAGE, 12, _032
    Call BATTLE_SUBSCRIPT_UPDATE_STAT_STAGE
    End

_032:
    // {0}’s {1} made {2} useless!
    PrintMessage BattleStrings_Text_PokemonsAbilityMadeMoveUseless_Ally, TAG_NICKNAME_ABILITY_MOVE, BTLSCR_MSG_BATTLER_TEMP, BTLSCR_MSG_BATTLER_TEMP, BTLSCR_ATTACKER
    Wait 
    WaitButtonABTime 30
    End 