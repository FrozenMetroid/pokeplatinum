#include "macros/scrcmd.inc"
#include "res/text/bank/twinleaf_town_player_house_1f.h"
#include "res/field/events/events_twinleaf_town_player_house_1f.h"


    ScriptEntry TwinleafTownPlayerHouse1F_OnTransition
    ScriptEntry TwinleafTownPlayerHouse1F_OnFrame_RivalAlreadyLeft
    ScriptEntry TwinleafTownPlayerHouse1F_OnFrame_CutsceneAfterRivalBattle
    ScriptEntry TwinleafTownPlayerHouse1F_Mom
    ScriptEntry TwinleafTownPlayerHouse1F_DontGoIntoTheTallGrassTrigger
    ScriptEntry TwinleafTownPlayerHouse1F_RivalsMom
    ScriptEntry TwinleafTownPlayerHouse1F_TV
    ScriptEntry TwinleafTownPlayerHouse1F_Fridge
    ScriptEntry TwinleafTownPlayerHouse1F_KitchenSink
    ScriptEntry TwinleafTownPlayerHouse1F_KitchenCounter
    ScriptEntry TwinleafTownPlayerHouse1F_OnFrame_Postgame
    ScriptEntry TwinleafTownPlayerHouse1F_OnFrame_PostChampionRematch
    ScriptEntryEnd

TwinleafTownPlayerHouse1F_OnTransition:
    CallIfEq VAR_PLAYER_HOUSE_STATE, EVENT_STATE_PLAYER_HOUSE_AFTER_201_RIVAL_BATTLE, TwinleafTownPlayerHouse1F_SetMomPositionForCutsceneAfterRivalBattle
    CallIfSet FLAG_RECEIVED_PARCEL, TwinleafTownPlayerHouse1F_HideRivalsMom
    End

TwinleafTownPlayerHouse1F_SetMomPositionForCutsceneAfterRivalBattle:
    SetObjectEventPos LOCALID_MOM, 2, 4
    SetObjectEventDir LOCALID_MOM, DIR_NORTH
    SetObjectEventMovementType LOCALID_MOM, MOVEMENT_TYPE_LOOK_NORTH
    Return

TwinleafTownPlayerHouse1F_HideRivalsMom:
    SetFlag FLAG_HIDE_TWINLEAF_TOWN_PLAYER_HOUSE_1F_RIVAL_MOM
    Return

TwinleafTownPlayerHouse1F_OnFrame_RivalAlreadyLeft:
    LockAll
    ApplyMovement LOCALID_PLAYER, TwinleafTownPlayerHouse1F_Movement_PlayerFaceMom
    ApplyMovement LOCALID_MOM, TwinleafTownPlayerHouse1F_Movement_MomWalkFromCouchToPlayer
    WaitMovement
    SetFlag FLAG_TALKED_TO_MOM
    BufferPlayerName 0
    BufferRivalName 1
    Message TwinleafTownPlayerHouse1F_Text_RivalAlreadyLeft
    CloseMessage
    WaitTime 15, VAR_RESULT
    ApplyMovement LOCALID_MOM, TwinleafTownPlayerHouse1F_Movement_MomWalkFromPlayerToCouch
    WaitMovement
    SetVar VAR_PLAYER_HOUSE_STATE, 1
    ReleaseAll
    End

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerFaceMom:
    Delay4
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MomWalkFromCouchToPlayer:
    WalkOnSpotNormalNorth
    EmoteExclamationMark
    Delay8
    WalkNormalNorth
    WalkNormalEast 3
    WalkNormalNorth 3
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MomWalkFromPlayerToCouch:
    WalkNormalSouth 2
    WalkNormalWest 3
    WalkNormalSouth 2
    WalkOnSpotNormalNorth
    EndMovement

TwinleafTownPlayerHouse1F_OnFrame_Postgame:
    LockAll
    SetVar VAR_PLAYER_HOUSE_POSTGAME_STATE, 2
    GoToIfSet FLAG_TALKED_TO_MOM_ABOUT_RIVAL_SNOWPOINT_CITY, TwinleafTownPlayerHouse1F_PostgameRelease
    GoToIfUnset FLAG_TALKED_TO_MOM_ABOUT_NATIONAL_DEX_PROGRESS, TwinleafTownPlayerHouse1F_DoMomPostgameSequence
    GetNationalDexEnabled VAR_RESULT
    GoToIfEq VAR_RESULT, FALSE, TwinleafTownPlayerHouse1F_PostgameRelease
TwinleafTownPlayerHouse1F_DoMomPostgameSequence:
    ApplyMovement LOCALID_PLAYER, TwinleafTownPlayerHouse1F_Movement_PlayerFaceMomPostgame
    ApplyMovement LOCALID_MOM, TwinleafTownPlayerHouse1F_Movement_MomNoticePlayer
    WaitMovement
    BufferPlayerName 0
    BufferRivalName 1
    GetNationalDexEnabled VAR_RESULT
    CallIfEq VAR_RESULT, TRUE, TwinleafTownPlayerHouse1F_RivalCameLookingForYou
    CallIfEq VAR_RESULT, FALSE, TwinleafTownPlayerHouse1F_IsYourProjectComingAlong
    WaitButton
    CloseMessage
TwinleafTownPlayerHouse1F_PostgameRelease:
    ReleaseAll
    End

TwinleafTownPlayerHouse1F_RivalCameLookingForYou:
    SetFlag FLAG_TALKED_TO_MOM_ABOUT_RIVAL_SNOWPOINT_CITY
    Message TwinleafTownPlayerHouse1F_Text_RivalCameLookingForYou
    Return

TwinleafTownPlayerHouse1F_IsYourProjectComingAlong:
    SetFlag FLAG_TALKED_TO_MOM_ABOUT_NATIONAL_DEX_PROGRESS
    Message TwinleafTownPlayerHouse1F_Text_IsYourProjectComingAlong
    Return

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerFaceMomPostgame:
    Delay4
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MomNoticePlayer:
    WalkOnSpotNormalNorth
    EmoteExclamationMark
    EndMovement

TwinleafTownPlayerHouse1F_OnFrame_CutsceneAfterRivalBattle:
    LockAll
    WaitTime 30, VAR_RESULT
    ApplyMovement LOCALID_MOM, TwinleafTownPlayerHouse1F_Movement_MomWalkFromKitchenToCouch
    ApplyMovement LOCALID_PLAYER, TwinleafTownPlayerHouse1F_Movement_PlayerFollowMomToCouch
    WaitMovement
    WaitTime 30, VAR_RESULT
    BufferRivalName 0
    BufferPlayerName 1
    Message TwinleafTownPlayerHouse1F_Text_WowThatsWhatHappenedToYou
    SetVar VAR_PLAYER_HOUSE_STATE, EVENT_STATE_PLAYER_HOUSE_AFTER_RETURN_AFTER_RIVAL_BATTLE
    // GoTo TwinleafTownPlayerHouse1F_CloseMessage
    GoTo TwinleafTownPlayerHouse1F_MomGiveJournal

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MomWalkFromKitchenToCouch:
    WalkNormalWest
    FaceNorth
    Delay8 2
    WalkNormalEast 3
    WalkNormalSouth 2
    WalkNormalEast 3
    WalkNormalSouth 2
    WalkOnSpotNormalWest
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerFollowMomToCouch:
    Delay8 4
    WalkOnSpotNormalEast
    Delay8 4
    WalkNormalEast 3
    WalkNormalSouth 2
    WalkNormalEast
    EndMovement

TwinleafTownPlayerHouse1F_Mom:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    GoToIfSet FLAG_UNK_0x0002, TwinleafTownPlayerHouse1F_DoMomMessage
    GoToIfGe VAR_PLAYER_HOUSE_STATE, EVENT_STATE_PLAYER_HOUSE_FINAL, TwinleafTownPlayerHouse1F_CallTakeAQuickRest2
    GoToIfEq VAR_PLAYER_HOUSE_STATE, EVENT_STATE_PLAYER_HOUSE_RECEIVED_JOURNAL, TwinleafTownPlayerHouse1F_EnjoyYourAdventure

    // mom now gives journal after battling the rival on 201
    // GoToIfSet FLAG_HAS_POKEDEX, TwinleafTownPlayerHouse1F_MomGiveJournal

    GoToIfGe VAR_PLAYER_HOUSE_STATE, 5, TwinleafTownPlayerHouse1F_CallTakeAQuickRest
    GoToIfGe VAR_PLAYER_HOUSE_STATE, 4, TwinleafTownPlayerHouse1F_GoingToSandgemIsAnAdventure
    GoToIfSet FLAG_UNK_0x00F8, TwinleafTownPlayerHouse1F_IsntRivalWaitingForYou
    GoToIfGe VAR_PLAYER_HOUSE_STATE, 2, TwinleafTownPlayerHouse1F_YouTakeCareNow
    GoToIfSet FLAG_TALKED_TO_MOM, TwinleafTownPlayerHouse1F_YouKnowHowImpatientRivalIs
    SetFlag FLAG_TALKED_TO_MOM
    BufferPlayerName 0
    BufferRivalName 1
    Message TwinleafTownPlayerHouse1F_Text_RivalAlreadyLeft
    GoTo TwinleafTownPlayerHouse1F_CloseMessage

TwinleafTownPlayerHouse1F_Unused:
    BufferPlayerName 0
    BufferRivalName 1
    Message TwinleafTownPlayerHouse1F_Text_RivalCameLookingForYou
    GoTo TwinleafTownPlayerHouse1F_CloseMessage

TwinleafTownPlayerHouse1F_DoMomMessage:
    GoToIfGe VAR_CANALAVE_LIBRARY_STATE, 2, TwinleafTownPlayerHouse1F_IsEverythingAllRight
    GoTo TwinleafTownPlayerHouse1F_DoMomRandomMessage
    End

TwinleafTownPlayerHouse1F_DoMomRandomMessage:
    GetRandom VAR_RESULT, 4
    GoToIfEq VAR_RESULT, 0, TwinleafTownPlayerHouse1F_YouAndYourPokemonAreLookingGood
    GoToIfEq VAR_RESULT, 1, TwinleafTownPlayerHouse1F_AlwaysTreatYourPokemonWithKindness
    GoToIfEq VAR_RESULT, 2, TwinleafTownPlayerHouse1F_SeeingYouRemindsMeOfYourFather
    GoToIfEq VAR_RESULT, 3, TwinleafTownPlayerHouse1F_WhileYoureGoneIVisitRivalsMom
    End

TwinleafTownPlayerHouse1F_IsEverythingAllRight:
    GoToIfGe VAR_EXITED_DISTORTION_WORLD_STATE, 2, TwinleafTownPlayerHouse1F_DoMomRandomMessage
    BufferPlayerName 0
    Message TwinleafTownPlayerHouse1F_Text_AskIsEverythingAllRight
    GoTo TwinleafTownPlayerHouse1F_CloseMessage
    End

TwinleafTownPlayerHouse1F_YouAndYourPokemonAreLookingGood:
    BufferPlayerName 0
    Message TwinleafTownPlayerHouse1F_Text_YouAndYourPokemonAreLookingGood
    GoTo TwinleafTownPlayerHouse1F_CloseMessage
    End

TwinleafTownPlayerHouse1F_AlwaysTreatYourPokemonWithKindness:
    BufferPlayerName 0
    Message TwinleafTownPlayerHouse1F_Text_AlwaysTreatYourPokemonWithKindness
    GoTo TwinleafTownPlayerHouse1F_CloseMessage
    End

TwinleafTownPlayerHouse1F_SeeingYouRemindsMeOfYourFather:
    BufferPlayerName 0
    Message TwinleafTownPlayerHouse1F_Text_SeeingYouRemindsMeOfYourFather
    GoTo TwinleafTownPlayerHouse1F_CloseMessage
    End

TwinleafTownPlayerHouse1F_WhileYoureGoneIVisitRivalsMom:
    BufferPlayerName 0
    BufferRivalName 1
    Message TwinleafTownPlayerHouse1F_Text_WhileYoureGoneIVisitRivalsMom
    GoTo TwinleafTownPlayerHouse1F_CloseMessage
    End

TwinleafTownPlayerHouse1F_CloseMessage:
    WaitButton
    CloseMessage
    ReleaseAll
    End

TwinleafTownPlayerHouse1F_EnjoyYourAdventure:
    BufferPlayerName 0
    Message TwinleafTownPlayerHouse1F_Text_EnjoyYourAdventure2
    GoTo TwinleafTownPlayerHouse1F_CloseMessage

TwinleafTownPlayerHouse1F_MomGiveJournal:
    // Call TwinleafTownPlayerHouse1F_TakeAQuickRest
    // BufferPlayerName 0
    // Message TwinleafTownPlayerHouse1F_Text_YourMomsGotYourBack
    SetVar VAR_0x8004, ITEM_JOURNAL
    SetVar VAR_0x8005, 1
    Common_GiveItemQuantity
    GiveJournal
    Message TwinleafTownPlayerHouse1F_Text_ThatsAJournal
    WaitButton
    CloseMessage
    SetVar VAR_PLAYER_HOUSE_STATE, EVENT_STATE_PLAYER_HOUSE_RECEIVED_JOURNAL
    ReleaseAll
    End

TwinleafTownPlayerHouse1F_Unused3:
    // removed when the rival's mom would come in to give the parcel
    End

TwinleafTownPlayerHouse1F_TakeAQuickRest:
    BufferPlayerName 0
    GetTimeOfDay VAR_RESULT
    CallIfEq VAR_RESULT, TIMEOFDAY_MORNING, TwinleafTownPlayerHouse1F_MorningTakeAQuickRest
    CallIfEq VAR_RESULT, TIMEOFDAY_DAY, TwinleafTownPlayerHouse1F_DayTakeAQuickRest
    CallIfEq VAR_RESULT, TIMEOFDAY_TWILIGHT, TwinleafTownPlayerHouse1F_TwilightTakeAQuickRest
    CallIfEq VAR_RESULT, TIMEOFDAY_NIGHT, TwinleafTownPlayerHouse1F_NightTakeAQuickRest
    CallIfEq VAR_RESULT, TIMEOFDAY_LATE_NIGHT, TwinleafTownPlayerHouse1F_LateNightTakeAQuickRest
    CloseMessage
    FadeScreenOut
    WaitFadeScreen
    PlayFanfare SEQ_ASA
    WaitFanfare
    HealParty
    FadeScreenIn
    WaitFadeScreen
    SetFlag FLAG_UNK_0x0002
    Return

TwinleafTownPlayerHouse1F_MorningTakeAQuickRest:
    Message TwinleafTownPlayerHouse1F_Text_EarlyMorningTakeAQuickRest
    Return

TwinleafTownPlayerHouse1F_DayTakeAQuickRest:
    Message TwinleafTownPlayerHouse1F_Text_TakeAQuickRest
    Return

TwinleafTownPlayerHouse1F_TwilightTakeAQuickRest:
    Message TwinleafTownPlayerHouse1F_Text_TakeAQuickRest
    Return

TwinleafTownPlayerHouse1F_NightTakeAQuickRest:
    Message TwinleafTownPlayerHouse1F_Text_JustMadeDinnerTakeAQuickRest
    Return

TwinleafTownPlayerHouse1F_LateNightTakeAQuickRest:
    Message TwinleafTownPlayerHouse1F_Text_SoLateRightNowTakeAQuickRest
    Return

TwinleafTownPlayerHouse1F_GoingToSandgemIsAnAdventure:
    Message TwinleafTownPlayerHouse1F_Text_GoingToSandgemIsAnAdventure
    GoTo TwinleafTownPlayerHouse1F_CloseMessage

TwinleafTownPlayerHouse1F_IsntRivalWaitingForYou:
    BufferRivalName 0
    Message TwinleafTownPlayerHouse1F_Text_IsntRivalWaitingForYou
    GoTo TwinleafTownPlayerHouse1F_CloseMessage

TwinleafTownPlayerHouse1F_YouTakeCareNow:
    SetFlag FLAG_UNK_0x00F8
    BufferPlayerName 0
    Message TwinleafTownPlayerHouse1F_Text_YouTakeCareNow
    GoTo TwinleafTownPlayerHouse1F_CloseMessage

TwinleafTownPlayerHouse1F_YouKnowHowImpatientRivalIs:
    BufferRivalName 0
    Message TwinleafTownPlayerHouse1F_Text_YouKnowHowImpatientRivalIs
    GoTo TwinleafTownPlayerHouse1F_CloseMessage

TwinleafTownPlayerHouse1F_CallTakeAQuickRest:
    Call TwinleafTownPlayerHouse1F_TakeAQuickRest
    ReleaseAll
    End

TwinleafTownPlayerHouse1F_CallTakeAQuickRest2:
    Call TwinleafTownPlayerHouse1F_TakeAQuickRest
    ReleaseAll
    End

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MotherTurnAwaySouth:
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MotherTurnAwayNorth:
    WalkOnSpotNormalNorth
    EndMovement

TwinleafTownPlayerHouse1F_Movement_Unused:
    WalkOnSpotNormalWest
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MomNoticeRivalsMom:
    WalkOnSpotNormalSouth
    EmoteExclamationMark
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MomWalkOnSpotSouth:
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MomTurnSouthToPlayer:
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MomTurnNorthToPlayer:
    WalkOnSpotNormalNorth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MomTurnEastToPlayer:
    WalkOnSpotNormalEast
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MomTurnWestToPlayer:
    WalkOnSpotNormalWest
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MomWatchRivalsMomLeaveSouth:
    Delay8
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MomWatchRivalsMomLeaveWest:
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_RivalsMomEnter:
    WalkNormalNorth
    WalkOnSpotNormalEast
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_RivalsMomTurnEastToPlayer:
    WalkOnSpotNormalEast
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_RivalsMomWalkNorthToPlayer:
    WalkNormalNorth 2
    WalkOnSpotNormalEast
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_RivalsMomWalkEastToPlayer:
    WalkNormalEast 2
    WalkOnSpotNormalNorth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_RivalsMomTurnNorthToPlayer:
    WalkOnSpotNormalNorth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_RivalsMomLeaveNorth:
    WalkNormalSouth
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_RivalsMomLeaveSouth:
    WalkNormalSouth 3
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_RivalsMomLeaveWest:
    WalkNormalWest 2
    WalkNormalSouth
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_RivalsMomLeaveEast:
    WalkNormalSouth
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerFaceRivalsMom:
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerTurnWestToFaceRivalsMom:
    WalkOnSpotNormalWest
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerTurnNorthToMom:
    WalkOnSpotNormalNorth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerTurnSouthToMom:
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerTurnWestToMom:
    WalkOnSpotNormalWest
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerTurnEastToMom:
    WalkOnSpotNormalEast
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerTurnWestToRivalsMom:
    WalkOnSpotNormalWest
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerTurnWestToRivalsMomWithDelay:
    Delay8 2
    WalkOnSpotNormalWest
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerTurnSouthToRivalsMomWithDelay:
    Delay8 2
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerTurnSouthToRivalsMom:
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerWatchRivalsMomLeaveNorth:
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerWatchRivalsMomLeaveSouth:
    WalkOnSpotNormalSouth
    EndMovement

TwinleafTownPlayerHouse1F_Movement_Unused2:
    Delay8 2
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerWatchRivalsMomLeaveEast:
    WalkOnSpotNormalSouth
    EndMovement

TwinleafTownPlayerHouse1F_DontGoIntoTheTallGrassTrigger:
    LockAll
    GoTo TwinleafTownPlayerHouse1F_PlayerAndMomFaceEachOther
    End

TwinleafTownPlayerHouse1F_PlayerAndMomFaceEachOther:
    ApplyMovement LOCALID_PLAYER, TwinleafTownPlayerHouse1F_Movement_PlayerAtDoorFaceMom
    ApplyMovement LOCALID_MOM, TwinleafTownPlayerHouse1F_Movement_MomFacePlayerAtDoor
    WaitMovement
    GoTo TwinleafTownPlayerHouse1F_DontGoIntoTheTallGrass
    End

TwinleafTownPlayerHouse1F_DontGoIntoTheTallGrass:
    SetVar VAR_PLAYER_HOUSE_STATE, 2
    BufferPlayerName 0
    Message TwinleafTownPlayerHouse1F_Text_DontGoIntoTheTallGrass
    GoTo TwinleafTownPlayerHouse1F_CloseMessage

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_PlayerAtDoorFaceMom:
    Delay8 2
    WalkOnSpotNormalNorth
    EndMovement

TwinleafTownPlayerHouse1F_Movement_Unused3:
    Delay4 2
    WalkOnSpotNormalNorth
    EndMovement

    .balign 4, 0
TwinleafTownPlayerHouse1F_Movement_MomFacePlayerAtDoor:
    WalkOnSpotNormalSouth
    EndMovement

TwinleafTownPlayerHouse1F_Movement_Unused4:
    WalkOnSpotNormalSouth
    WalkNormalWest 2
    WalkNormalSouth
    EndMovement

TwinleafTownPlayerHouse1F_RivalsMom:
    BufferRivalName 1
    NPCMessage TwinleafTownPlayerHouse1F_Text_HedProbablyHeadStraightToJubilife
    End

TwinleafTownPlayerHouse1F_TV:
    GetTimeOfDay VAR_RESULT
    GoToIfEq VAR_RESULT, TIMEOFDAY_MORNING, TwinleafTownPlayerHouse1F_CuteContestDigest
    GoToIfEq VAR_RESULT, TIMEOFDAY_DAY, TwinleafTownPlayerHouse1F_SmartContestDigest
    GoToIfEq VAR_RESULT, TIMEOFDAY_TWILIGHT, TwinleafTownPlayerHouse1F_SmartContestDigest
    GoToIfEq VAR_RESULT, TIMEOFDAY_NIGHT, TwinleafTownPlayerHouse1F_ToughContestDigest
    GoToIfEq VAR_RESULT, TIMEOFDAY_LATE_NIGHT, TwinleafTownPlayerHouse1F_ToughContestDigest
    End

TwinleafTownPlayerHouse1F_CuteContestDigest:
    EventMessage TwinleafTownPlayerHouse1F_Text_CuteContestDigest
    End

TwinleafTownPlayerHouse1F_SmartContestDigest:
    EventMessage TwinleafTownPlayerHouse1F_Text_SmartContestDigest
    End

TwinleafTownPlayerHouse1F_ToughContestDigest:
    EventMessage TwinleafTownPlayerHouse1F_Text_ToughContestDigest
    End

TwinleafTownPlayerHouse1F_Fridge:
    EventMessage TwinleafTownPlayerHouse1F_Text_MomsFavoriteDessertIsInRefrigerator
    End

TwinleafTownPlayerHouse1F_KitchenSink:
    EventMessage TwinleafTownPlayerHouse1F_Text_MomsKitchenIsSpotless
    End

TwinleafTownPlayerHouse1F_KitchenCounter:
    EventMessage TwinleafTownPlayerHouse1F_Text_ThisIsWhereMomDoesHerDeliciousCooking
    End

TwinleafTownPlayerHouse1F_OnFrame_PostChampionRematch:
    LockAll
    ApplyMovement LOCALID_PLAYER, TwinleafTownPlayerHouse1F_Movement_PlayerFaceMom
    ApplyMovement LOCALID_MOM, TwinleafTownPlayerHouse1F_Movement_MomWalkFromCouchToPlayer
    WaitMovement
    BufferPlayerName 0
    Message TwinleafTownPlayerHouse1F_Text_GiveOaksLetter
    SetVar VAR_0x8004, ITEM_OAKS_LETTER
    SetVar VAR_0x8005, 1
    Common_GiveItemQuantity
    Message TwinleafTownPlayerHouse1F_Text_HeWasInAHurry
    CloseMessage
    WaitTime 5, VAR_RESULT
    ApplyMovement LOCALID_MOM, TwinleafTownPlayerHouse1F_Movement_MomWalkFromPlayerToCouch
    WaitMovement
    SetVar VAR_SHAYMIN_EVENT_STATE, EVENT_STATE_SHAYMIN_OAK_LETTER_RECEIVED
    SetVar VAR_DISTRIBUTION_EVENT_SHAYMIN, 0x1112
    ReleaseAll
    End
    .balign 4, 0
