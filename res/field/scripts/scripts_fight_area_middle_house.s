#include "macros/scrcmd.inc"
#include "res/text/bank/fight_area_middle_house.h"


    ScriptEntry FightArea_MiddleHouse_BottleCapGuy
    ScriptEntry FightAreaMiddleHouse_SchoolKidM
    ScriptEntry FightAreaMiddleHouse_Youngster
    ScriptEntryEnd

FightArea_MiddleHouse_BottleCapGuy:
    PrintMonPersonality 0
    LockAll
    FacePlayer
    PlaySE SEQ_SE_CONFIRM
    Message pl_msg_00000197_00003
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_NO, _Declined
    CheckItem ITEM_BOTTLE_CAP, 1, VAR_RESULT
    GoToIfEq VAR_RESULT, FALSE, _CheckHaveGoldBattleCaps
    // also check them here in case you have gold bottle caps but no regular bottle caps
    CheckItem ITEM_GOLD_BOTTLE_CAP, 1, VAR_RESULT
    GoToIfEq VAR_RESULT, FALSE, _NoBottleCaps
_SelectWhichToGive:
    Message pl_msg_00000197_00006
    InitLocalTextListMenu 1, 1, 0, VAR_RESULT
    AddListMenuEntry pl_msg_00000197_00007, 0
    AddListMenuEntry pl_msg_00000197_00008, 1
    AddListMenuEntry pl_msg_00000197_00009, 2
    ShowListMenu
    GoToIfEq VAR_RESULT, 0, _SelectedBottleCaps
    GoToIfEq VAR_RESULT, 1, _SelectedGoldBottleCaps
    GoTo _Declined

_SelectedBottleCaps:
    CheckItem ITEM_BOTTLE_CAP, 1, VAR_RESULT
    GoToIfEq VAR_RESULT, FALSE, _NoBottleCaps
    SetVar VAR_0x8000, ITEM_BOTTLE_CAP
    GoTo _SelectMon

_SelectedGoldBottleCaps:
    CheckItem ITEM_GOLD_BOTTLE_CAP, 1, VAR_RESULT
    GoToIfEq VAR_RESULT, FALSE, _NoBottleCaps
    SetVar VAR_0x8000, ITEM_GOLD_BOTTLE_CAP
_SelectMon:
    Message pl_msg_00000197_00021
    CloseMessage
    FadeScreenOut COLOR_BLACK
    WaitFadeScreen
    SelectMoveTutorPokemon // works here even though it's not for a move tutor
    GetSelectedPartySlot VAR_0x8003
    ReturnToField
    FadeScreenIn COLOR_BLACK
    WaitFadeScreen
    GoToIfEq VAR_0x8003, PARTY_SLOT_NONE, _Declined
    GoToIfEq VAR_0x8000, ITEM_GOLD_BOTTLE_CAP, _MaxAllStats
    Message pl_msg_00000197_00010
    InitLocalTextListMenu 1, 1, 0, VAR_RESULT
    AddListMenuEntry pl_msg_00000197_00011, 0
    AddListMenuEntry pl_msg_00000197_00012, 1
    AddListMenuEntry pl_msg_00000197_00013, 2
    AddListMenuEntry pl_msg_00000197_00014, 3
    AddListMenuEntry pl_msg_00000197_00015, 4
    AddListMenuEntry pl_msg_00000197_00016, 5
    ShowListMenu
    Message pl_msg_00000197_00019
    WaitTime 15, VAR_0x8001
    GoToIfEq VAR_RESULT, 0, _MaxHP
    GoToIfEq VAR_RESULT, 1, _MaxAtk
    GoToIfEq VAR_RESULT, 2, _MaxDef
    GoToIfEq VAR_RESULT, 3, _MaxSpAtk
    GoToIfEq VAR_RESULT, 4, _MaxSpDef
_MaxSpeed:
    SetVar VAR_0x8002, 3 // speed is before special attack and special defense
_StartStatChange:
    BottleCapStatIncrease VAR_0x8003, VAR_0x8002, VAR_RESULT
    GoToIfEq VAR_RESULT, 0xFFFF, _StatsAlreadyMaxed
_EndBottleCap:
    RemoveItem VAR_0x8000, 1, VAR_RESULT
    Message pl_msg_00000197_00018
    GoTo _EndDialogue

_StatsAlreadyMaxed:
    Message pl_msg_00000197_00020
    GoTo _EndDialogue

_MaxAllStats:
    SetVar 0x8002, 0xFF // makes the following command max all IVs
    BottleCapStatIncrease VAR_0x8003, VAR_0x8002, VAR_RESULT
    GoToIfEq VAR_RESULT, 0xFFFF, _StatsAlreadyMaxed
    Message pl_msg_00000197_00017
    GoTo _EndBottleCap

_MaxHP:
    SetVar VAR_0x8002, 0
    GoTo _StartStatChange

_MaxAtk:
    SetVar VAR_0x8002, 1
    GoTo _StartStatChange

_MaxDef:
    SetVar VAR_0x8002, 2
    GoTo _StartStatChange

_MaxSpAtk:
    SetVar VAR_0x8002, 4
    GoTo _StartStatChange

_MaxSpDef:
    SetVar VAR_0x8002, 5
    GoTo _StartStatChange

_CheckHaveGoldBattleCaps:
    CheckItem ITEM_GOLD_BOTTLE_CAP, 1, VAR_RESULT
    GoToIfEq VAR_RESULT, FALSE, _NoBottleCaps
    GoTo _SelectWhichToGive

_Declined:
    Message pl_msg_00000197_00004
_EndDialogue:
    WaitButton
    CloseMessage
    ReleaseAll
    End

_NoBottleCaps:
    Message pl_msg_00000197_00005
    GoTo _EndDialogue

FightAreaMiddleHouse_SchoolKidM:
    NPCMessage FightAreaMiddleHouse_Text_FanaticalAboutBattling
    End

FightAreaMiddleHouse_Youngster:
    NPCMessage FightAreaMiddleHouse_Text_CheckOutGlobalTerminal
    End

    .balign 4, 0
