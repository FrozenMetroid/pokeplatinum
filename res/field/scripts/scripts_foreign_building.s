#include "macros/scrcmd.inc"
#include "res/text/bank/foreign_building.h"


    ScriptEntry ForeignBuilding_RuinManiac
    ScriptEntry ForeignBuilding_OldMan
    ScriptEntry ForeignBuilding_NinjaBoy
    ScriptEntry ForeignBuilding_OldWoman
    ScriptEntry ForeignBuilding_AceTrainerF
    ScriptEntry ForeignBuilding_PokefanF
    ScriptEntry ForeignBuilding_ExpertM
    ScriptEntry ForeignBuilding_Psychic
    ScriptEntry ForeignBuilding_Lady
    ScriptEntry ForeignBuilding_UnkownCharacter
    ScriptEntryEnd

.set LOCALID_UNKNOWN_CHARACTER, 9

ForeignBuilding_RuinManiac:
    NPCMessage ForeignBuilding_Text_ThereDoISeeMyFather
    End

ForeignBuilding_OldMan:
    NPCMessage ForeignBuilding_Text_CraftingFatiguesOnesSpirit
    End

ForeignBuilding_NinjaBoy:
    NPCMessage ForeignBuilding_Text_PeopleAndPokemonMakeEveryoneComeTogether
    End

ForeignBuilding_OldWoman:
    NPCMessage ForeignBuilding_Text_ThatPeopleAreLonelyIsOnlyNatural
    End

ForeignBuilding_AceTrainerF:
    NPCMessage ForeignBuilding_Text_ThereAreWordsThatNotEveryoneCanDescribe
    End

ForeignBuilding_PokefanF:
    NPCMessage ForeignBuilding_Text_ItsOnlyNaturalWeAreDifferent
    End

ForeignBuilding_ExpertM:
    NPCMessage ForeignBuilding_Text_TheStrongMustShowRestraint
    End

ForeignBuilding_Psychic:
    NPCMessage ForeignBuilding_Text_WeCannotReadMinds
    End

ForeignBuilding_Lady:
    NPCMessage ForeignBuilding_Text_BalanceIsWhatsNeeded
    End

ForeignBuilding_UnkownCharacter:
    LockAll
    // no FacePlayer
    PlaySE SEQ_SE_CONFIRM
    Message ForeignBuilding_Text_Ellipses
    FacePlayer // now face the player
    Message ForeignBuilding_Text_Unknown_Character
    CloseMessage
    GetPlayerMapPos VAR_0x8004, VAR_0x8005
    switch VAR_0x8004
    case 10, ForeignBuilding_UnkownCharacter_Leave1
    case 11, ForeignBuilding_UnkownCharacter_Leave2
    ApplyMovement LOCALID_UNKNOWN_CHARACTER, ForeignBuilding_Movement_Leave2
    WaitTime 45, VAR_RESULT
    ApplyMovement LOCALID_PLAYER, ForeignBuilding_Movement_WalkSouthSite
ForeignBuilding_UnkownCharacter_End:
    WaitMovement
    RemoveObject LOCALID_UNKNOWN_CHARACTER
    PlaySE SEQ_SE_DP_KAIDAN2
    WaitSE SEQ_SE_DP_KAIDAN2
    SetFlag FLAG_HIDE_FOREIGN_BUILDING_UNKNOWN_CHARACTER
    ReleaseAll
    End

ForeignBuilding_UnkownCharacter_Leave1:
    ApplyMovement LOCALID_UNKNOWN_CHARACTER, ForeignBuilding_Movement_Leave1
    ApplyMovement LOCALID_PLAYER, ForeignBuilding_Movement_PlayerWatchCharacterLeave_1
    GoTo ForeignBuilding_UnkownCharacter_End

ForeignBuilding_UnkownCharacter_Leave2:
    ApplyMovement LOCALID_UNKNOWN_CHARACTER, ForeignBuilding_Movement_Leave2
    ApplyMovement LOCALID_PLAYER, ForeignBuilding_Movement_PlayerWatchCharacterLeave_2
    GoTo ForeignBuilding_UnkownCharacter_End

.balign 4, 0
ForeignBuilding_Movement_WalkSouthSite:
    WalkOnSpotNormalSouth
    EndMovement

.balign 4, 0
ForeignBuilding_Movement_PlayerWatchCharacterLeave_1:
    Delay4 2
    WalkOnSpotNormalSouth
    Delay4 1
    WalkOnSpotNormalWest
    Delay4 1
    WalkOnSpotNormalSouth
    EndMovement

.balign 4, 0
ForeignBuilding_Movement_PlayerWatchCharacterLeave_2:
    Delay4 1
    WalkOnSpotNormalWest
    Delay8 4
    WalkOnSpotNormalSouth
    EndMovement

.balign 4, 0
ForeignBuilding_Movement_Leave1:
    WalkNormalSouth 1
    WalkNormalWest 3
    WalkNormalSouth 4
    Delay2 1
    SetInvisible 1
    EndMovement

.balign 4, 0
ForeignBuilding_Movement_Leave2:
    WalkNormalWest 3
    WalkNormalSouth 5
    Delay2 1
    SetInvisible 1
    EndMovement

.balign 4, 0
