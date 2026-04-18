#include "macros/scrcmd.inc"
#include "res/text/bank/menu_entries.h"
#include "res/text/bank/oreburgh_city_pokecenter_1f.h"
#include "res/field/events/events_oreburgh_city_pokecenter_1f.h"


    ScriptEntry OreburghCityPokecenter1F_Nurse
    ScriptEntry OreburghCityPokecenter1F_NinjaBoy
    ScriptEntry OreburghCityPokecenter1F_AceTrainerF
    ScriptEntry OreburghCityPokecenter1F_Psychic
    ScriptEntry OreburghCityPokecenter1F_Gentleman
    ScriptEntry OreburghCityPokecenter1F_KidWithNDSWest
    ScriptEntry OreburghCityPokecenter1F_KidWithNDSEast
    ScriptEntry OreburghCityPokecenter1F_RowanAssistant
    ScriptEntryEnd

OreburghCityPokecenter1F_Nurse:
    Common_CallPokecenterNurse LOCALID_POKECENTER_NURSE
    End

OreburghCityPokecenter1F_NinjaBoy:
    NPCMessage OreburghCityPokecenter1F_Text_YayIGotAPalPadAtThePokemonWiFiClubDownstairs
    End

OreburghCityPokecenter1F_AceTrainerF:
    NPCMessage OreburghCityPokecenter1F_Text_SwitchOnThePCAtAnyPokemonCenter
    End

OreburghCityPokecenter1F_Psychic:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    GoToIfSet FLAG_CHOSE_UNION_ROOM_APPEARANCE, OreburghCityPokecenter1F_HowAboutTellingMeWhatKindOfTrainerYouLike
    Message OreburghCityPokecenter1F_Text_WhatIsYourFavoriteKindOfTrainerCanYouTellMe
    GoTo OreburghCityPokecenter1F_WhichKindOfTrainerWouldYouLikeToBe

OreburghCityPokecenter1F_HowAboutTellingMeWhatKindOfTrainerYouLike:
    BufferTrainerClassFromAppearance 0
    Message OreburghCityPokecenter1F_Text_HowAboutTellingMeWhatKindOfTrainerYouLike
    GoTo OreburghCityPokecenter1F_WhichKindOfTrainerWouldYouLikeToBe

OreburghCityPokecenter1F_WhichKindOfTrainerWouldYouLikeToBe:
    Message OreburghCityPokecenter1F_Text_WhichKindOfTrainerWouldYouLikeToBe
    LoadTrainerAppearances
    InitGlobalTextMenu 1, 1, 0, VAR_RESULT
    AddMenuEntryImm MenuEntries_Text_TrainerAppearanceVariant1, 0
    AddMenuEntryImm MenuEntries_Text_TrainerAppearanceVariant2, 1
    AddMenuEntryImm MenuEntries_Text_TrainerAppearanceVariant3, 2
    AddMenuEntryImm MenuEntries_Text_TrainerAppearanceVariant4, 3
    AddMenuEntryImm MenuEntries_Text_TrainerAppearancesExit, 4
    ShowMenu
    SetVar VAR_0x8004, VAR_RESULT
    SetVar VAR_0x8008, VAR_RESULT
    GoToIfEq VAR_0x8008, 4, OreburghCityPokecenter1F_OKThenIllJustTalkToYouLater
    GoToIfEq VAR_0x8008, -2, OreburghCityPokecenter1F_OKThenIllJustTalkToYouLater
    GetTrainerInfoTrainerClass VAR_0x8004, VAR_0x8005
    BufferTrainerClassNameWithArticle 0, VAR_0x8005
    CapitalizeFirstLetter 0
    Message OreburghCityPokecenter1F_Text_AskThisIsTheKindOfTrainerYouWantToBe
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_YES, OreburghCityPokecenter1F_SetTrainerClass
    GoTo OreburghCityPokecenter1F_WhichKindOfTrainerWouldYouLikeToBe

OreburghCityPokecenter1F_OKThenIllJustTalkToYouLater:
    Message OreburghCityPokecenter1F_Text_OKThenIllJustTalkToYouLater
    WaitButton
    CloseMessage
    ReleaseAll
    End

OreburghCityPokecenter1F_SetTrainerClass:
    BufferTrainerClassNameWithArticle 0, VAR_0x8005
    Message OreburghCityPokecenter1F_Text_ISeeSoThisIsTheKindOfTrainerYouLike
    SetFlag FLAG_CHOSE_UNION_ROOM_APPEARANCE
    CalculateTrainerInfoAppearance VAR_0x8004, VAR_0x8005
    SetTrainerInfoAppearance VAR_0x8005
    GoTo OreburghCityPokecenter1F_OKThenIllJustTalkToYouLater

OreburghCityPokecenter1F_Gentleman:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    GoToIfSet FLAG_GAME_COMPLETED, OreburghCityPokecenter1F_WhatOrWhoIsThisTeamGalactic
    Message OreburghCityPokecenter1F_Text_WhatOrWhoIsThisTeamGalacticItsAMystery
    WaitButton
    CloseMessage
    ReleaseAll
    End

OreburghCityPokecenter1F_WhatOrWhoIsThisTeamGalactic:
    Message OreburghCityPokecenter1F_Text_WhatOrWhoIsThisTeamGalactic
    WaitButton
    CloseMessage
    ReleaseAll
    End

OreburghCityPokecenter1F_KidWithNDSWest:
    NPCMessage OreburghCityPokecenter1F_Text_NowYouCanCaptureItAsABattleVideoUsingAVsRecorder
    End

OreburghCityPokecenter1F_KidWithNDSEast:
    NPCMessage OreburghCityPokecenter1F_Text_CoolYouHaveAVsRecorder
    End

OreburghCityPokecenter1F_RowanAssistant:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    GoToIfSet FLAG_RECEIVED_EXP_SHARE, OreburghCityPokecenter1F_APokemonHoldingAnExpShareWillGetSomeOfTheExpPointsFromBattle
    BufferPlayerName 0
    BufferCounterpartName 1
    GetPlayerGender VAR_MAP_LOCAL_0
    GoToIfEq VAR_MAP_LOCAL_0, GENDER_MALE, OreburghCityPokecenter1F_PlayerMaleLetMeAskYouHowManyPokemonHaveYouMet
    GoTo OreburghCityPokecenter1F_PlayerFemaleLetMeAskYouHowManyPokemonHaveYouMet

OreburghCityPokecenter1F_PlayerMaleLetMeAskYouHowManyPokemonHaveYouMet:
    Message OreburghCityPokecenter1F_Text_PlayerLetMeAskYouHowManyPokemonHaveYouMet
    GoTo OreburghCityPokecenter1F_CheckAmountPokemonSeen

OreburghCityPokecenter1F_PlayerFemaleLetMeAskYouHowManyPokemonHaveYouMet:
    Message OreburghCityPokecenter1F_Text_PlayerLetMeAskYouHowManyPokemonHaveYouMet2
    GoTo OreburghCityPokecenter1F_CheckAmountPokemonSeen

OreburghCityPokecenter1F_CheckAmountPokemonSeen:
    GetNationalDexSeenCount VAR_0x8004
    BufferNumber 1, VAR_0x8004
    GoToIfLt VAR_0x8004, 20, OreburghCityPokecenter1F_YouveGotToFindAtLeast20
    Message OreburghCityPokecenter1F_Text_ProfessorRowanShouldBeDelightedHereIsSomethingForYou
    SetVar VAR_0x8004, ITEM_EXP_SHARE
    SetVar VAR_0x8005, 1
    GoToIfCannotFitItem VAR_0x8004, VAR_0x8005, VAR_RESULT, OreburghCityPokecenter1F_BagIsFull
    SetFlag FLAG_RECEIVED_EXP_SHARE
    Common_GiveItemQuantityNoLineFeed
    GoTo OreburghCityPokecenter1F_APokemonHoldingAnExpShareWillGetSomeOfTheExpPointsFromBattle

OreburghCityPokecenter1F_BagIsFull:
    Common_MessageBagIsFull
    CloseMessage
    ReleaseAll
    End

OreburghCityPokecenter1F_APokemonHoldingAnExpShareWillGetSomeOfTheExpPointsFromBattle:
    Message OreburghCityPokecenter1F_Text_APokemonHoldingAnExpShareWillGetSomeOfTheExpPointsFromBattle
    WaitButton
    CloseMessage
    ReleaseAll
    End

OreburghCityPokecenter1F_YouveGotToFindAtLeast20:
    Message OreburghCityPokecenter1F_Text_YouveGotToFindAtLeast20
    WaitButton
    CloseMessage
    ReleaseAll
    End

    .balign 4, 0
