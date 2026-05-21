#include "macros/btlcmd.inc"


_000:
    CompareMonDataToValue OPCODE_EQU, BTLSCR_ATTACKER, BATTLEMON_ABILITY, ABILITY_ACID_MAW, _HandleAcidMaw
    CheckSubstitute BTLSCR_DEFENDER, _034
    CompareMonDataToValue OPCODE_FLAG_SET, BTLSCR_DEFENDER, BATTLEMON_MOVE_EFFECTS_MASK, MOVE_EFFECT_ABILITY_SUPPRESSED, _034
    CompareVarToValue OPCODE_FLAG_SET, BTLVAR_MOVE_STATUS_FLAGS, MOVE_STATUS_MISSED|MOVE_STATUS_SEMI_INVULNERABLE, _034
    CompareMonDataToValue OPCODE_EQU, BTLSCR_DEFENDER, BATTLEMON_ABILITY, ABILITY_MULTITYPE, _034
    CompareMonDataToValue OPCODE_EQU, BTLSCR_DEFENDER, BATTLEMON_ABILITY, ABILITY_NEUTRALIZING_GAS, _034
    Call BATTLE_SUBSCRIPT_ATTACK_MESSAGE_AND_ANIMATION
    // {0}’s ability was suppressed!
    PrintMessage BattleStrings_Text_PokemonsAbilityWasSuppressed_Ally, TAG_NICKNAME, BTLSCR_DEFENDER
    Wait 
    WaitButtonABTime 30
_SuppressAbility:
    UpdateMonData OPCODE_FLAG_ON, BTLSCR_DEFENDER, BATTLEMON_MOVE_EFFECTS_MASK, MOVE_EFFECT_ABILITY_SUPPRESSED
    End 

_034:
    UpdateVar OPCODE_FLAG_ON, BTLVAR_MOVE_STATUS_FLAGS, MOVE_STATUS_FAILED
    End

_HandleAcidMaw:
    // the checke for abilities that you cannot suppress already happens before this subscript happens for Acid Maw
    PrintMessage BattleStrings_Text_PokemonsAbilitySuppressedPokemonsAbility_AllyAlly, TAG_NICKNAME_ABILITY_NICKNAME_ABILITY, BTLSCR_MSG_ATTACKER, BTLSCR_MSG_ATTACKER, BTLSCR_MSG_DEFENDER, BTLSCR_MSG_DEFENDER
    Wait
    WaitButtonABTime 30
    GoTo _SuppressAbility
