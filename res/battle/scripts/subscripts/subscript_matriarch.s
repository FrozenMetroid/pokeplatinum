#include "macros/btlcmd.inc"


_000:

    PlayMoveAnimationOnMons 0, BTLSCR_MSG_DEFENDER, BTLSCR_ATTACKER // reverse order so that Heal Order's animation is put on the defender
    Wait
    UpdateVar OPCODE_FLAG_ON, BTLVAR_BATTLE_CTX_STATUS, SYSCTL_SKIP_SPRITE_BLINK
    UpdateVar OPCODE_FLAG_OFF, BTLVAR_BATTLE_CTX_STATUS, SYSCTL_SKIP_SPRITE_BLINK
    UpdateHealthBox BTLSCR_MSG_DEFENDER
    Wait 
    UpdateHealthBoxValue BTLSCR_MSG_DEFENDER
    // {0} was healed by its underlings!
    PrintMessage BattleStrings_Text_HealedByUnderlings_Ally, TAG_NICKNAME, BTLSCR_MSG_DEFENDER
    Wait 
    WaitButtonABTime 30
    End 
