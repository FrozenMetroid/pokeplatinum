#include "macros/btlcmd.inc"


_000:
.if BATTLE_UPDATE_TAILWIND_TURNS
    CheckTailwindActive BTLSCR_ATTACKER, _018
.else
    CompareVarToValue OPCODE_FLAG_SET, BTLVAR_SIDE_CONDITIONS_ATTACKER, SIDE_CONDITION_TAILWIND, _018
.endif
    Call BATTLE_SUBSCRIPT_ATTACK_MESSAGE_AND_ANIMATION
    // The tailwind blew from behind your team!
    PrintMessage BattleStrings_Text_TheTailwindBlewFromBehindYourTeam, TAG_NONE_SIDE_CONSCIOUS, BTLSCR_ATTACKER
    Wait 
    WaitButtonABTime 30
.if BATTLE_UPDATE_TAILWIND_TURNS
    StartTailwindCounter BTLSCR_ATTACKER
.else
    UpdateVar OPCODE_FLAG_ON, BTLVAR_SIDE_CONDITIONS_ATTACKER, SIDE_CONDITION_TAILWIND
.endif
    End 

_018:
    UpdateVar OPCODE_FLAG_ON, BTLVAR_MOVE_STATUS_FLAGS, MOVE_STATUS_FAILED
    End 
