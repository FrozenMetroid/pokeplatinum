#include "macros/btlcmd.inc"


_000:
    PrintAttackMessage 
    Wait 
    WaitButtonABTime 15
    CheckIgnorableAbility OPCODE_EQU, BTLSCR_DEFENDER, ABILITY_MAGIC_BOUNCE, _Handle_Magic_Bounce
    // {0}’s {1} was bounced back by Magic Coat!
    PrintMessage BattleStrings_Text_PokemonsMoveWasBouncedBackByMagicCoat_Ally, TAG_NICKNAME_MOVE, BTLSCR_ATTACKER, BTLSCR_ATTACKER
_End:
    Wait 
    WaitButtonABTime 30
    MagicCoat 
    UpdateVar OPCODE_FLAG_OFF, BTLVAR_BATTLE_CTX_STATUS, SYSCTL_PLAYED_MOVE_ANIMATION
    End 

_Handle_Magic_Bounce:
    // update the mon's ability to be able to be seen by the AI as Magic Bounce
    // so that it doesn't continue to use status moves
    SetAIAbility BTLSCR_DEFENDER
    // {0}’s {1} was bounced back by Magic Bounce!
    PrintMessage BattleStrings_Text_PokemonsMoveWasBouncedBackByMagicBounce_Ally, TAG_NICKNAME_MOVE, BTLSCR_ATTACKER, BTLSCR_ATTACKER
    GoTo _End
