#include "macros/btlcmd.inc"


_000:
    // {0}'s {1} dampened the battlefield!
    PrintMessage BattleStrings_Text_AbilityDampenedBattlefield_Ally, TAG_NICKNAME_ABILITY, BTLSCR_MSG_TEMP, BTLSCR_MSG_BATTLER_TEMP
    Wait 
    WaitButtonABTime 30
    // tells the AI that the battler has Damp
    SetAIAbility BTLSCR_MSG_BATTLER_TEMP
    UpdateVar OPCODE_FLAG_ON, BTLVAR_FIELD_CONDITIONS, FIELD_CONDITION_DAMP
    End