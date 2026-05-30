#include "macros/btlcmd.inc"


_000:
    CompareVarToValue OPCODE_FLAG_SET, BTLVAR_FIELD_CONDITIONS, FIELD_CONDITION_GRAVITY, _End
    // {0}'s {1} intensified gravity!
    PrintMessage BattleStrings_Text_CelestialBody_Ally, TAG_NICKNAME_ABILITY, BTLSCR_MSG_BATTLER_TEMP, BTLSCR_MSG_BATTLER_TEMP
    Wait
    WaitButtonABTime 30
    Call BATTLE_SUBSCRIPT_GRAVITY_START
_End:
    End