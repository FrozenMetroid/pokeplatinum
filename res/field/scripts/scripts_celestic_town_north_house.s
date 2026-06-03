#include "macros/scrcmd.inc"
#include "res/text/bank/celestic_town_north_house.h"


    ScriptEntry CelesticTownNorthHouse_ExpertM
    ScriptEntry CelesticTownNorthHouse_Elder
    ScriptEntry CelesticTownNorthHouse_Lass
    ScriptEntry CelesticTownNorthHouse_Scroll
    ScriptEntry CelesticTownNorthHouse_OnTransition
    ScriptEntry CelesticTownNorthHouse_Book
    ScriptEntryEnd

CelesticTownNorthHouse_OnTransition:
    End

CelesticTownNorthHouse_ExpertM:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    Message CelesticTownNorthHouse_Text_LikeToKnowMesprit
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_NO, CelesticTownNorthHouse_YouWouldnt
    Message CelesticTownNorthHouse_Text_MespritInfo
    GoTo CelesticTownNorthHouse_ExpertMEnd
    End

CelesticTownNorthHouse_YouWouldnt:
    Message CelesticTownNorthHouse_Text_YouWouldnt
    GoTo CelesticTownNorthHouse_ExpertMEnd
    End

CelesticTownNorthHouse_ExpertMEnd:
    WaitButton
    CloseMessage
    ReleaseAll
    End

CelesticTownNorthHouse_Elder:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    GoToIfSet FLAG_GAME_COMPLETED, CelesticTownNorthHouse_IDidSomeResearch
    GoToIfSet FLAG_FIRST_ARRIVAL_CANALAVE_CITY, CelesticTownNorthHouse_CelesticOldestTown
    Message CelesticTownNorthHouse_Text_UsingSurfGoPlaces
    GoTo CelesticTownNorthHouse_ElderEnd
    End

CelesticTownNorthHouse_IDidSomeResearch:
    GoToIfSet FLAG_CAUGHT_DIALGA, CelesticTownNorthHouse_CheckCaughtPalkia
CelesticTownNorthHouse_UnlockDialgaAndPalkia:
    SetFlag FLAG_UNLOCKED_DIALGA_PALKIA_SPEAR_PILLAR
    Message CelesticTownNorthHouse_Text_IDidSomeResearch
    GoTo CelesticTownNorthHouse_ElderEnd
    End

CelesticTownNorthHouse_CelesticOldestTown:
    Message CelesticTownNorthHouse_Text_CelesticOldestTown
    GoTo CelesticTownNorthHouse_ElderEnd
    End

CelesticTownNorthHouse_ElderEnd:
    WaitButton
    CloseMessage
    ReleaseAll
    End

CelesticTownNorthHouse_CheckCaughtPalkia:
    GoToIfUnset FLAG_CAUGHT_PALKIA, CelesticTownNorthHouse_UnlockDialgaAndPalkia
CelesticTownNorthHouse_CheckCaughtGiratina:
    GoToIfUnset FLAG_CAUGHT_GIRATINA, CelesticTownNorthHouse_UnlockDialgaAndPalkia
    // caught all three of the Creation Trio, now check whether or not to give the azure flute
CelesticTownNorthHouse_CheckHaveAllPlates:
    CheckObtainedAllArceusPlates VAR_RESULT
    GoToIfEq VAR_RESULT, FALSE, CelesticTownNorthHouse_GiveHintAboutArceusPlates
    // if you collected all of the Plates and you do not already have the flute, give the Azure Flute
    CheckItem ITEM_AZURE_FLUTE, 1, VAR_RESULT
    GoToIfEq VAR_RESULT, TRUE, CelesticTownNorthHouse_CheckCaughtArceus // if you already have it, check stuff related to Arceus
    Message CelesticTownNorthHouse_Text_GiveAzureFlute
    SetVar VAR_0x8004, ITEM_AZURE_FLUTE
    SetVar VAR_0x8005, 1
    Common_GiveItemQuantity
    SetVar VAR_DISTRIBUTION_EVENT_ARCEUS, 0x1123 // required for Hall of Origin to start
    GoTo CelesticTownNorthHouse_TalkAboutAzureFlute

CelesticTownNorthHouse_CheckCaughtArceus:
    GoToIfSet FLAG_CAUGHT_ARCEUS, CelesticTownNorthHouse_TalkAboutArceus
CelesticTownNorthHouse_TalkAboutAzureFlute:
    Message CelesticTownNorthHouse_Text_TalkAboutAzureFlute
    GoTo CelesticTownNorthHouse_ElderEnd

CelesticTownNorthHouse_TalkAboutArceus:
    Message CelesticTownNorthHouse_Text_TalkAboutArceus
    GoTo CelesticTownNorthHouse_ElderEnd

CelesticTownNorthHouse_GiveHintAboutArceusPlates:
    Message CelesticTownNorthHouse_Text_GiveHintAboutArceusPlates
    GoTo CelesticTownNorthHouse_ElderEnd

CelesticTownNorthHouse_Lass:
    NPCMessage CelesticTownNorthHouse_Text_MySisterStudiesMyths
    End

CelesticTownNorthHouse_Scroll:
    EventMessage CelesticTownNorthHouse_Text_InvaluableScroll
    End

CelesticTownNorthHouse_Book:
    BufferPlayerName 0
    NPCMessage CelesticTownNorthHouse_Text_OldBook
    End

    .balign 4, 0
