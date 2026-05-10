#include "macros/btlcmd.inc"

_000:
    UpdateVar OPCODE_FLAG_ON, BTLVAR_MOVE_STATUS_FLAGS, MOVE_STATUS_FAILED
    // Ability popup for defender
    
    // {0} cannot use {1} because of {2}'s {3}!
    PrintMessage BattleStrings_Text_CannotUseMove_AllyAlly, TAG_NICKNAME_MOVE_NICKNAME_ABILITY, BTLSCR_ATTACKER, BTLSCR_ATTACKER, BTLSCR_DEFENDER, BTLSCR_DEFENDER
    Wait 
    WaitButtonABTime 30
    End 