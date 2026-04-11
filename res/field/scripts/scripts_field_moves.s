#include "macros/scrcmd.inc"
#include "res/text/bank/field_moves.h"


    ScriptEntry FieldMoves_CutTree
    ScriptEntry FieldMoves_Rock
    ScriptEntry FieldMoves_Boulder
    ScriptEntry FieldMoves_RockyWall
    ScriptEntry FieldMoves_Water
    ScriptEntry FieldMoves_Fog_Unused
    ScriptEntry FieldMoves_Waterfall
    ScriptEntry FieldMoves_Dummy
    ScriptEntry FieldMoves_UseCutFromMenu
    ScriptEntry FieldMoves_UseRockSmashFromMenu
    ScriptEntry FieldMoves_UseStrengthFromMenu
    ScriptEntry FieldMoves_UseRockClimbFromMenu
    ScriptEntry FieldMoves_UseSurfFromMenu
    ScriptEntry FieldMoves_UseWaterfallFromMenu
    ScriptEntry FieldMoves_UseDefogFromMenu
    ScriptEntry FieldMoves_UseFlashFromMenu
    ScriptEntryEnd

FieldMoves_Fog_Unused:
FieldMoves_Dummy:
FieldMoves_UseCutFromMenu:
FieldMoves_UseRockSmashFromMenu:
FieldMoves_UseStrengthFromMenu:
FieldMoves_UseRockClimbFromMenu:
FieldMoves_UseSurfFromMenu:
FieldMoves_UseWaterfallFromMenu:
    End
//
//
// THESE SCRIPTS HAVE BEEN UPDATED TO ALLOW YOU TO USE THE HM
// EVEN IF YOU HAVEN'T TAUGHT THE MOVE
//
// YOU CAN USE THEM IF YOU HAVE A POKEMON ON YOUR TEAM THAT CAN
// LEARN THE MOVE, AND IF YOU HAVE THE ASSOCIATED BADGE
//
//

FieldMoves_CutTree:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    CheckTMHMCompatibility MOVE_CUT, VAR_0x8004, VAR_RESULT
    GoToIfEQ VAR_RESULT, FALSE, _CannotUseCut
    CheckItem ITEM_HM01, 1, VAR_RESULT
    GoToIfNe VAR_RESULT, TRUE, _CannotUseCut
    CheckBadgeAcquired BADGE_ID_FOREST, VAR_RESULT
    GoToIfEq VAR_RESULT, 0, _CannotUseCut
    Message FieldMoves_Text_WouldYouLikeToUseCut
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_YES, _UseCut
    CloseMessage
    GoTo _ReleaseAll
    End

_CannotUseCut:
    Message FieldMoves_Text_TreeLooksLikeCanBeCut
    GetCurrentMapID VAR_0x8004
    CallIfEq VAR_0x8004, 203, _014A
    WaitButton
    CloseMessage
    GoTo _ReleaseAll
    End

_UseCut:
    BufferPartyMonNickname 0, VAR_0x8004
    Message FieldMoves_Text_PokemonUsedCut
    CloseMessage
    FieldMoveSummonAnim VAR_0x8004
    ScrCmd_29E 0, VAR_0x8005
    WaitTime 7, VAR_RESULT
    RemoveObject VAR_LAST_TALKED
    GetCurrentMapID VAR_0x8004
    CreateJournalEvent LOCATION_EVENT_USED_CUT, VAR_0x8004, 0, 0, 0
_00E8:
    WaitTime 1, VAR_RESULT
    GoToIfEq VAR_0x8005, 0, _00E8
    GoTo _ReleaseAll
    End

_014A:
    GoToIfNe VAR_ETERNA_FOREST_CHERYL_OLD_CHATEAU_CUTSCENE_STATE, 0, _0221
    GoToIfNe VAR_ETERNA_FOREST_FOLLOWER_CHERYL_STATE, 1, _0221
    Call _017F
    GoToIfEq VAR_RESULT, 0, _0221
    SetVar VAR_ETERNA_FOREST_CHERYL_OLD_CHATEAU_CUTSCENE_STATE, 1
    Return

_017F:
    SetVar VAR_RESULT, 0
    GetPlayerMapPos VAR_0x8004, VAR_0x8005
    GoToIfEq VAR_0x8004, 73, _01CE
    GoToIfEq VAR_0x8004, 74, _01DD
    GoToIfEq VAR_0x8004, 75, _01EC
    GoToIfEq VAR_0x8004, 76, _01FB
    GoToIfEq VAR_0x8004, 77, _020A
    Return

_01CE:
    GoToIfEq VAR_0x8005, 33, _0219
    Return

_01DD:
    GoToIfEq VAR_0x8005, 34, _0219
    Return

_01EC:
    GoToIfEq VAR_0x8005, 34, _0219
    Return

_01FB:
    GoToIfEq VAR_0x8005, 33, _0219
    Return

_020A:
    GoToIfEq VAR_0x8005, 34, _0219
    Return

_0219:
    SetVar VAR_RESULT, 1
    Return

_0221:
    Return

// ROCK SMASH

FieldMoves_Rock:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    CheckTMHMCompatibility MOVE_ROCK_SMASH, VAR_0x8004, VAR_RESULT
    GoToIfEQ VAR_RESULT, FALSE, _CannotUseRockSmash
    CheckItem ITEM_HM06, 1, VAR_RESULT
    GoToIfNe VAR_RESULT, TRUE, _CannotUseRockSmash
    CheckBadgeAcquired BADGE_ID_COAL, VAR_RESULT
    GoToIfEq VAR_RESULT, 0, _CannotUseRockSmash
    Message FieldMoves_Text_WouldYouLikeToUseRockSmash
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_YES, _UseRockSmash
    CloseMessage
    GoTo _ReleaseAll
    End

_CannotUseRockSmash:
    Message FieldMoves_Text_PokemonMayBeAbleToSmashRock
    WaitButton
    CloseMessage
    GoTo _ReleaseAll
    End

_UseRockSmash:
    BufferPartyMonNickname 0, VAR_0x8004
    Message FieldMoves_Text_PokemonUsedRockSmash
    CloseMessage
    FieldMoveSummonAnim VAR_0x8004
    ScrCmd_29E 1, VAR_0x8005
    WaitTime 10, VAR_RESULT
    RemoveObject VAR_LAST_TALKED
    GetCurrentMapID VAR_0x8004
    CreateJournalEvent LOCATION_EVENT_USED_ROCK_SMASH, VAR_0x8004, 0, 0, 0
_02B2:
    WaitTime 1, VAR_RESULT
    GoToIfEq VAR_0x8005, 0, _02B2
    GoTo _ReleaseAll
    End

// STRENGTH

FieldMoves_Boulder:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    Strength 2, VAR_RESULT
    GoToIfEq VAR_RESULT, TRUE, _StrengthActive
    CheckTMHMCompatibility MOVE_STRENGTH, VAR_0x8004, VAR_RESULT
    GoToIfEQ VAR_RESULT, FALSE, _CannotUseStrength
    CheckItem ITEM_HM04, 1, VAR_RESULT
    GoToIfNe VAR_RESULT, TRUE, _CannotUseStrength
    CheckBadgeAcquired BADGE_ID_MINE, VAR_RESULT
    GoToIfEq VAR_RESULT, 0, _CannotUseStrength
    Message FieldMoves_Text_WouldYouLikeToUseStrength
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_YES, _UseStrength
    CloseMessage
    GoTo _ReleaseAll
    End

_CannotUseStrength:
    Message FieldMoves_Text_BoulderMayBeAbleToPush
    WaitButton
    CloseMessage
    GoTo _ReleaseAll
    End

_UseStrength:
    Strength 1
    BufferPartyMonNickname 0, VAR_0x8004
    Message FieldMoves_Text_PokemonUsedStrength
    FieldMoveSummonAnim VAR_0x8004
    CloseMessage
    Message FieldMoves_Text_PokemonStrengthMadePossibleToMove
    WaitButton
    CloseMessage
    GetCurrentMapID VAR_0x8004
    CreateJournalEvent LOCATION_EVENT_USED_STRENGTH, VAR_0x8004, 0, 0, 0
    GoTo _ReleaseAll
    End

_StrengthActive:
    Message FieldMoves_Text_StrengthMadePossibleToMove
    WaitButton
    CloseMessage
    GoTo _ReleaseAll
    End

// ROCK CLIMB

FieldMoves_RockyWall:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    CheckTMHMCompatibility MOVE_ROCK_CLIMB, VAR_0x8004, VAR_RESULT
    GoToIfEQ VAR_RESULT, FALSE, _CannotUseRockClimb
    CheckItem ITEM_HM08, 1, VAR_RESULT
    GoToIfNe VAR_RESULT, TRUE, _CannotUseRockClimb
    CheckBadgeAcquired BADGE_ID_ICICLE, VAR_RESULT
    GoToIfEq VAR_RESULT, 0, _CannotUseRockClimb
    CheckHasPartner VAR_RESULT
    GoToIfEq VAR_RESULT, 1, _CannotUseRockClimb_Partner
    Message FieldMoves_Text_WouldYouLikeToUseRockClimb
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_YES, _UseRockClimb
    CloseMessage
    GoTo _ReleaseAll
    End

_CannotUseRockClimb:
    Message FieldMoves_Text_RockyWallWillMoveScale
    WaitButton
    CloseMessage
    GoTo _ReleaseAll
    End

_CannotUseRockClimb_Partner:
    Message FieldMoves_Text_NoRockClimbingWithPartner
    WaitButton
    CloseMessage
    GoTo _ReleaseAll
    End

_UseRockClimb:
    BufferPartyMonNickname 0, VAR_0x8004
    Message FieldMoves_Text_PokemonUsedRockClimb
    CloseMessage
    UseRockClimb VAR_0x8004
    GetCurrentMapID VAR_0x8004
    CreateJournalEvent LOCATION_EVENT_USED_ROCK_CLIMB, VAR_0x8004, 0, 0, 0
    GoTo _ReleaseAll
    End

// SURF

FieldMoves_Water:
    CheckItem ITEM_HM03, 1, VAR_RESULT // much easier to check it here rather than the code that initially checks for Surf
    GoToIfNe VAR_RESULT, TRUE, _End
    PlaySE SEQ_SE_CONFIRM
    LockAll
    CheckHasPartner VAR_RESULT
    GoToIfEq VAR_RESULT, 1, _CannotUseSurf_Partner
    Message FieldMoves_Text_WouldYouLikeToUseSurf
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_YES, _UseSurf
    CloseMessage
    GoTo _ReleaseAll
_End:
    End

_CannotUseSurf_Partner:
    Message FieldMoves_Text_NoSurfingWithPartner
    WaitButton
    CloseMessage
    GoTo _ReleaseAll

_UseSurf:
    CheckTMHMCompatibility MOVE_SURF, VAR_0x8004, VAR_RESULT
    // VAR_RESULT unused here because the check happens outside of the script; we just use this here to get the slot of the mon
    BufferPartyMonNickname 0, VAR_0x8004
    Message FieldMoves_Text_PokemonUsedSurf
    CloseMessage
    UseSurf VAR_0x8004
    GetCurrentMapID VAR_0x8004
    CreateJournalEvent LOCATION_EVENT_USED_SURF, VAR_0x8004, 0, 0, 0
    GoTo _ReleaseAll
    End



// DEFOG

_UsedDefogInLostTower:
    SetFlag FLAG_USED_DEFOG_IN_ROUTE_209_LOST_TOWER_5F
    Return

FieldMoves_UseDefogFromMenu:
    LockAll
    CheckTMHMCompatibility MOVE_DEFOG, VAR_0x8004, VAR_RESULT
    BufferPartyMonNickname 0, VAR_0x8004
    Message FieldMoves_Text_PokemonUsedDefog
    CloseMessage
    FieldMoveSummonAnim VAR_0x8004
    Defog 1
    PlaySE SEQ_SE_DP_FBRADE
    ScrCmd_0C4
    GetCurrentMapID VAR_0x8004
    CreateJournalEvent LOCATION_EVENT_USED_DEFOG, VAR_0x8004, 0, 0, 0
    CallIfEq VAR_0x8004, 0x169, _UsedDefogInLostTower
    GoTo _ReleaseAll

// FLASH

FieldMoves_UseFlashFromMenu:
    LockAll
    CheckTMHMCompatibility MOVE_DEFOG, VAR_0x8004, VAR_RESULT
    BufferPartyMonNickname 0, VAR_0x8004
    Message FieldMoves_Text_PokemonUsedFlash
    CloseMessage
    FieldMoveSummonAnim VAR_0x8004
    Flash 1
    ScrCmd_0C3
    WaitTime 42, VAR_RESULT
    GoTo _ReleaseAll

_ReleaseAll:
    ReleaseAll
    End


// WATERFALL

FieldMoves_Waterfall:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    CheckTMHMCompatibility MOVE_WATERFALL, VAR_0x8004, VAR_RESULT
    GoToIfEq VAR_RESULT, 6, _CannotUseWaterfall
    CheckItem ITEM_HM07, 1, VAR_RESULT
    GoToIfNe VAR_RESULT, TRUE, _CannotUseWaterfall
    CheckBadgeAcquired BADGE_ID_BEACON, VAR_RESULT
    GoToIfEq VAR_RESULT, 0, _CannotUseWaterfall
    Message FieldMoves_Text_WouldYouLikeToUseWaterfall
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_YES, _UseWaterfall
    CloseMessage
    GoTo _ReleaseAll
    End

_CannotUseWaterfall:
    Message FieldMoves_Text_WallOfWater
    WaitButton
    CloseMessage
    GoTo _ReleaseAll
    End

_UseWaterfall:
    BufferPartyMonNickname 0, VAR_0x8004
    Message FieldMoves_Text_PokemonUsedWaterfall
    CloseMessage
    UseWaterfall VAR_0x8004
    GetCurrentMapID VAR_0x8004
    CreateJournalEvent LOCATION_EVENT_USED_WATERFALL, VAR_0x8004, 0, 0, 0
    GoTo _ReleaseAll
    End


    .balign 4, 0
