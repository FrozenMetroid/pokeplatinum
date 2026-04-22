#include "macros/scrcmd.inc"
#include "res/text/bank/global_terminal_1f.h"
#include "res/text/bank/menu_entries.h"
#include "constants/map_object.h"

.set VAR_PARTY_SLOT,  0x8000
.set VAR_BADGE_COUNT,  0x8001
.set VAR_SENT_POKEMON_LEVEL,  0x8002
.set VAR_SENT_POKEMON_ID,  0x8003
.set VAR_RECEIVED_POKEMON_ID,  0x8004
.set VAR_HELD_ITEM,  0x8005
.set VAR_GENDER,  0x8006
.set VAR_RECEIVED_SPECIES_LEVEL,  0x8007
.set VAR_FORM, 0x8009
.set VAR_FINAL_MESSAGE, 0x800A
.set VAR_UPGRADED_WONDER_TRADE, 0x800B

.set OW_Attendant_Wonder_Trade, 14

    ScriptEntry _00F0
    ScriptEntry _00F2
    ScriptEntry GlobalTerminal1f_GTS_Clerk_Talk
    ScriptEntry _0374
    ScriptEntry _0387
    ScriptEntry _039A
    ScriptEntry _03AD
    ScriptEntry _03C0
    ScriptEntry _03D3
    ScriptEntry _03E6
    ScriptEntry _03F9
    ScriptEntry _006B
    ScriptEntry _0056
    ScriptEntry _040C
    ScriptEntry _0496
    ScriptEntry _0520
    ScriptEntry _0533
    ScriptEntry GlobalTerminal1F_REMOVED
    ScriptEntry _0601
    ScriptEntry _0652
    ScriptEntry _074C
    ScriptEntry GlobalTerminal1f_WonderTrade_Clerk
    ScriptEntryEnd

_0056:
    CallIfEq VAR_UNK_0x40D5, 6, _0065
    End

_0065:
    HideObject LOCALID_PLAYER
    Return

_006B:
    LockAll
    Call GlobalTerminal1f_GTS_WalkOut
    ReleaseAll
    End

GlobalTerminal1f_GTS_WalkOut:
    LoadDoorAnimation 0, 0, 8, 2, ANIMATION_TAG_DOOR_1
    Call _00C5
    ShowObject LOCALID_PLAYER
    ApplyMovement LOCALID_PLAYER, _00D8
    WaitMovement
    Call _00CD
    LoadDoorAnimation 0, 0, 8, 4, ANIMATION_TAG_DOOR_1
    Call _00C5
    ApplyMovement LOCALID_PLAYER, _00E8
    WaitMovement
    Call _00CD
    SetVar VAR_UNK_0x40D5, 0
    Return

_00C5:
    PlayDoorOpenAnimation ANIMATION_TAG_DOOR_1
    WaitForAnimation ANIMATION_TAG_DOOR_1
    Return

_00CD:
    PlayDoorCloseAnimation ANIMATION_TAG_DOOR_1
    WaitForAnimation ANIMATION_TAG_DOOR_1
    UnloadAnimation ANIMATION_TAG_DOOR_1
    Return

    .balign 4, 0
_00D8:
    WalkNormalSouth
    EndMovement

GlobalTerminal1F_UnusedMovement:
    WalkNormalSouth
    EndMovement

    .balign 4, 0
_00E8:
    WalkNormalSouth 2
    EndMovement

_00F0:
    End

_00F2:
    End

GlobalTerminal1f_GTS_Clerk_Talk:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    CheckPartyHasBadEgg VAR_RESULT
    GoToIfEq VAR_RESULT, 1, GlobalTerminal1f_GTS_Exit_BadEgg
    GoToIfSet FLAG_GTS_INTRO_COMPLETED, GlobalTerminal1f_GTS_Clerk_ShortIntro
    SetFlag FLAG_GTS_INTRO_COMPLETED
    Message pl_msg_00000046_00000
    GoTo GlobalTerminal1f_GTS_Clerk_Menu
    End

GlobalTerminal1f_GTS_Clerk_Menu:
    InitGlobalTextMenu 1, 1, 0, VAR_RESULT
    AddMenuEntryImm pl_msg_00000361_00129, 0
    AddMenuEntryImm pl_msg_00000361_00128, 1
    AddMenuEntryImm pl_msg_00000361_00130, 2
    ShowMenu
    SetVar VAR_0x8008, VAR_RESULT
    GoToIfEq VAR_0x8008, 0, GlobalTerminal1f_CheckPartyCount
    GoToIfEq VAR_0x8008, 1, _0172
    GoToIfEq VAR_0x8008, 2, GlobalTerminal1f_GTS_Clerk_EndTalk
    GoTo GlobalTerminal1f_GTS_Clerk_EndTalk
    End

_0172:
    Message pl_msg_00000046_00002
    GoTo _017D
    End

_017D:
    InitGlobalTextMenu 1, 1, 0, VAR_RESULT
    AddMenuEntryImm pl_msg_00000361_00131, 0
    AddMenuEntryImm pl_msg_00000361_00132, 1
    AddMenuEntryImm pl_msg_00000361_00133, 2
    ShowMenu
    SetVar VAR_0x8008, VAR_RESULT
    GoToIfEq VAR_0x8008, 0, _01C8
    GoToIfEq VAR_0x8008, 1, _01D3
    GoToIfEq VAR_0x8008, 2, _01DE
    GoTo _01DE
    End

_01C8:
    Message pl_msg_00000046_00003
    GoTo _017D
    End

_01D3:
    Message pl_msg_00000046_00004
    GoTo _017D
    End

_01DE:
    Message pl_msg_00000046_00005
    GoTo GlobalTerminal1f_GTS_Clerk_Menu
    End

GlobalTerminal1f_CheckPartyCount:
    CountPartyNonEggs VAR_RESULT
    GoToIfLt VAR_RESULT, 2, GlobalTerminal1f_GTS_Exit_NotEnoughPokemon
    GoTo GlobalTerminal1f_CheckFreePartySlot
    End

GlobalTerminal1f_GTS_Exit_NotEnoughPokemon:
    Message pl_msg_00000046_00009
    WaitButton
    CloseMessage
    ReleaseAll
    End

GlobalTerminal1f_BeginTrade:
    Common_SaveGame
    SetVar VAR_RESULT, VAR_MAP_LOCAL_0
    GoToIfEq VAR_RESULT, 0, GlobalTerminal1f_GTS_Clerk_EndTalk
    HealParty
    SetVar VAR_UNK_0x40D5, 6
    Message pl_msg_00000046_00007
    CloseMessage
    ApplyMovement LOCALID_PLAYER, _0344
    WaitMovement
    LoadDoorAnimation 0, 0, 8, 4, ANIMATION_TAG_DOOR_1
    Call _00C5
    ApplyMovement LOCALID_PLAYER, _0358
    WaitMovement
    Call _00CD
    LoadDoorAnimation 0, 0, 8, 2, ANIMATION_TAG_DOOR_1
    Call _00C5
    ApplyMovement LOCALID_PLAYER, _0350
    WaitMovement
    HideObject LOCALID_PLAYER
    ApplyMovement LOCALID_PLAYER, _0360
    WaitMovement
    Call _00CD
    FadeScreenOut
    WaitFadeScreen
    ScrCmd_2B2
    ScrCmd_0B3 VAR_RESULT
    SetVar VAR_0x8004, VAR_RESULT
    TryStartGTSApp VAR_0x8004, VAR_RESULT
    GoToIfEq VAR_RESULT, 0, GlobalTerminal1f_GTS_Exit
    ReturnToField
    FadeScreenIn
    WaitFadeScreen
    Call GlobalTerminal1f_GTS_WalkOut
    ReleaseAll
    End

GlobalTerminal1f_GTS_Exit:
    ReturnToField
    FadeScreenIn
    WaitFadeScreen
    Call GlobalTerminal1f_GTS_WalkOut
    GoTo GlobalTerminal1f_GTS_Clerk_EndTalk
    End

GlobalTerminal1f_GTS_Clerk_EndTalk:
    SetVar VAR_UNK_0x40D5, 0
    Message pl_msg_00000046_00006
    WaitButton
    CloseMessage
    ReleaseAll
    End

GlobalTerminal1f_GTS_Clerk_ShortIntro:
    Message pl_msg_00000046_00001
    GoTo GlobalTerminal1f_GTS_Clerk_Menu
    End

GlobalTerminal1f_CheckFreePartySlot:
    GetPartyCount VAR_RESULT
    GoToIfEq VAR_RESULT, 6, GlobalTerminal1f_CheckFreeBoxSlot
    GoTo GlobalTerminal1f_BeginTrade
    End

GlobalTerminal1f_CheckFreeBoxSlot:
    GetPCBoxesFreeSlotCount VAR_RESULT
    GoToIfEq VAR_RESULT, 0, GlobalTerminal1f_GTS_Exit_NoSpace
    GoTo GlobalTerminal1f_BeginTrade
    End

GlobalTerminal1f_GTS_Exit_NoSpace:
    Message pl_msg_00000046_00008
    WaitButton
    CloseMessage
    ReleaseAll
    End

    .balign 4, 0
_0344:
    WalkNormalEast
    WalkOnSpotNormalNorth
    EndMovement

    .balign 4, 0
_0350:
    WalkNormalNorth
    EndMovement

    .balign 4, 0
_0358:
    WalkNormalNorth 2
    EndMovement

    .balign 4, 0
_0360:
    FaceSouth
    EndMovement

    .balign 4, 0
Action_Walk_Down_Fast_Site:
    WalkOnSpotNormalSouth
    EndMovement

    .balign 4, 0
Action_Walk_Right_Fast_Site:
    WalkOnSpotNormalEast
    EndMovement

GlobalTerminal1f_GTS_Exit_BadEgg:
    CallCommonScript 0x2338 @ CommonScript_HasBadEgg; outputs pl_msg_00000221_00127
    WaitButton
    CloseMessage
    ReleaseAll
    End

_0374:
    NPCMessage pl_msg_00000046_00010
    End

_0387:
    NPCMessage pl_msg_00000046_00011
    End

_039A:
    NPCMessage pl_msg_00000046_00012
    End

_03AD:
    NPCMessage pl_msg_00000046_00013
    End

_03C0:
    NPCMessage pl_msg_00000046_00014
    End

_03D3:
    NPCMessage pl_msg_00000046_00015
    End

_03E6:
    NPCMessage pl_msg_00000046_00016
    End

_03F9:
    NPCMessage pl_msg_00000046_00017
    End

_040C:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    SetVar VAR_0x8005, 3
    GoTo _0420
    End

_0420:
    Message pl_msg_00000046_00036
    InitLocalTextMenu 31, 11, 0, VAR_RESULT
    SetMenuXOriginToRight
    AddMenuEntryImm pl_msg_00000361_00038, 0
    AddMenuEntryImm pl_msg_00000361_00039, 1
    AddMenuEntryImm pl_msg_00000361_00040, 2
    ShowMenu
    SetVar VAR_0x8008, VAR_RESULT
    GoToIfEq VAR_0x8008, 0, _046A
    GoToIfEq VAR_0x8008, 1, _048B
    GoTo _0464
    End

_0464:
    CloseMessage
    ReleaseAll
    End

_046A:
    Common_SaveGame
    SetVar VAR_RESULT, VAR_MAP_LOCAL_0
    GoToIfEq VAR_RESULT, 0, _0464
    CloseMessage
    CallCommonScript 0x802
    ReleaseAll
    End

_048B:
    Message pl_msg_00000046_00037
    GoTo _0420
    End

_0496:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    SetVar VAR_0x8005, 4
    GoTo _04AA
    End

_04AA:
    Message pl_msg_00000046_00034
    InitLocalTextMenu 31, 11, 0, VAR_RESULT
    SetMenuXOriginToRight
    AddMenuEntryImm pl_msg_00000361_00038, 0
    AddMenuEntryImm pl_msg_00000361_00039, 1
    AddMenuEntryImm pl_msg_00000361_00040, 2
    ShowMenu
    SetVar VAR_0x8008, VAR_RESULT
    GoToIfEq VAR_0x8008, 0, _04F4
    GoToIfEq VAR_0x8008, 1, _0515
    GoTo _04EE
    End

_04EE:
    CloseMessage
    ReleaseAll
    End

_04F4:
    Common_SaveGame
    SetVar VAR_RESULT, VAR_MAP_LOCAL_0
    GoToIfEq VAR_RESULT, 0, _04EE
    CloseMessage
    CallCommonScript 0x802
    ReleaseAll
    End

_0515:
    Message pl_msg_00000046_00035
    GoTo _04AA
    End

_0520:
    NPCMessage pl_msg_00000046_00032
    End

_0533:
    NPCMessage pl_msg_00000046_00033
    End

GlobalTerminal1F_REMOVED:
    End

_05A0:
    Message pl_msg_00000046_00023
    GoTo _05F9
    End

_05AB:
    ScrCmd_300
    Message pl_msg_00000046_00020
    GoTo _05F9
    End

_05B8:
    BufferPartyMonSpecies 0, 0
    Message pl_msg_00000046_00021
    GoTo _05F9
    End

GlobalTerminal1F_Unused:
    Message 18
_05CB:
    Message pl_msg_00000046_00019
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_YES, _05AB
    GoToIfEq VAR_RESULT, MENU_NO, _05EE
    End

_05EE:
    Message pl_msg_00000046_00022
    GoTo _05F9
    End

_05F9:
    WaitButton
    CloseMessage
    ReleaseAll
    End

_0601:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    Message pl_msg_00000046_00029
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_NO, _0647
    FadeScreenOut
    WaitFadeScreen
    CloseMessage
    ScrCmd_30E VAR_0x8004
    GoToIfEq VAR_0x8004, 0, _0647
    Message pl_msg_00000046_00030
    WaitButton
    CloseMessage
    ReleaseAll
    End

_0647:
    Message pl_msg_00000046_00031
    WaitButton
    CloseMessage
    ReleaseAll
    End

_0652:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    CheckItem ITEM_FASHION_CASE, 1, VAR_RESULT
    GoToIfEq VAR_RESULT, 0, _0696
    GoToIfSet FLAG_UNK_0x0AC3, _06FD
    GoToIfSet FLAG_UNK_0x00CF, _06F2
    Message pl_msg_00000046_00024
    SetVar VAR_0x8004, 1
    GoTo _06A1
    End

_0696:
    Message pl_msg_00000046_00042
    GoTo _0708
    End

_06A1:
    CheckBackdrop VAR_0x8004, VAR_RESULT
    GoToIfEq VAR_RESULT, 0, _06D3
    AddVar VAR_0x8004, 1
    GoToIfLe VAR_0x8004, 13, _06A1
    SetFlag FLAG_UNK_0x00CF
    GoTo _06F2
    End

_06D3:
    SetVar VAR_0x8005, 1
    Common_ObtainContestBackdrop
    Message pl_msg_00000046_00028
    Call _0710
    SetFlag FLAG_UNK_0x0AC3
    GoTo _0708
    End

_06F2:
    Message pl_msg_00000046_00027
    GoTo _0708
    End

_06FD:
    Message pl_msg_00000046_00026
    GoTo _0708
    End

_0708:
    WaitButton
    CloseMessage
    ReleaseAll
    End

_0710:
    SetVar VAR_0x8004, 1
    GoTo _071E
    End

_071E:
    CheckBackdrop VAR_0x8004, VAR_RESULT
    GoToIfEq VAR_RESULT, 0, _074A
    AddVar VAR_0x8004, 1
    GoToIfLe VAR_0x8004, 13, _071E
    SetFlag FLAG_UNK_0x00CF
    Return

_074A:
    Return

_074C:
    EventMessage pl_msg_00000046_00041
    End

GlobalTerminal1f_WonderTrade_Clerk:
    LockAll
    PlaySE SEQ_SE_CONFIRM
	GoToIfSet FLAG_FIRST_TIME_SPEAKING_TO_WONDER_TRADE_LADY, Check_If_Willing_To_Pay
	Message pl_msg_GlobalTerminal1F_WonderTrade_Introduce
	SetFlag FLAG_FIRST_TIME_SPEAKING_TO_WONDER_TRADE_LADY
Check_If_Willing_To_Pay:
	Message pl_msg_GlobalTerminal1F_WonderTrade_AskToSpend
	ShowMoney 20, 2
	ShowYesNoMenu VAR_RESULT
	GoToIfEq VAR_RESULT, MENU_NO, Quit_Wonder_Trade_Before_Pay
	CheckMoney VAR_RESULT, 500
	GoToIfEq VAR_RESULT, FALSE, Not_Enough_Money
	RemoveMoney 500
	UpdateMoneyDisplay
	PlaySE SEQ_SE_DP_REGI
	WaitSE SEQ_SE_DP_REGI
	HideMoney
Select_Pokemon:
	Message pl_msg_GlobalTerminal1F_WonderTrade_TellSelectPokemon
	CloseMessage
	FadeScreenOut
    WaitFadeScreen
    SelectMoveTutorPokemon // works here even though it's not for a move tutor
    GetSelectedPartySlot VAR_PARTY_SLOT
    ReturnToField
    FadeScreenIn
    WaitFadeScreen
	GoToIfEq VAR_PARTY_SLOT, 255, Cancel_Sent_Mon_Selection
	GetPartyMonSpecies VAR_PARTY_SLOT, VAR_SENT_POKEMON_ID
	GoToIfEq VAR_SENT_POKEMON_ID, 0, Selected_Pokemon_Is_Egg
	BufferPartyMonSpecies 1, VAR_PARTY_SLOT
	Message pl_msg_GlobalTerminal1F_WonderTrade_ConfirmSend
	ShowYesNoMenu VAR_RESULT
	GoToIfEq VAR_RESULT, MENU_NO, Cancel_Sent_Mon_Selection
	// add stuff here for sending the following mon back if those are added
	ApplyMovement OW_Attendant_Wonder_Trade, Action_Walk_Down_Fast_Site
	WaitMovement
	Message pl_msg_GlobalTerminal1F_WonderTrade_SendItOver
	CloseMessage
	GetSetNationalDexEnabled 2, VAR_UPGRADED_WONDER_TRADE // stores 1 if you have the national dex
	Call Generate_Level
    CallIfEq VAR_RECEIVED_SPECIES_LEVEL, 0, Raise_Received_Level_By_1
Generate_Rest_Of_Pokemon_Info:
    ApplyMovement OW_Attendant_Wonder_Trade, Action_Walk_Right_Fast_Site
    WaitMovement
	PlaySE SEQ_SE_PL_BREC03
	WaitSE SEQ_SE_PL_BREC03
	WonderTrade VAR_RECEIVED_SPECIES_LEVEL, VAR_PARTY_SLOT, VAR_UPGRADED_WONDER_TRADE, VAR_FINAL_MESSAGE
	ApplyMovement OW_Attendant_Wonder_Trade, Action_Walk_Down_Fast_Site
	WaitMovement

    // un-comment these if the trade graphics are removed for whatever reason
	// Call Check_Gender_For_Display
	// PlayFanfare SEQ_FANFA5
	// PlayCry VAR_RECEIVED_POKEMON_ID, 0
	// BufferPlayerName 0
	// BufferPartyMonSpecies 1, VAR_PARTY_SLOT
	// Message pl_msg_GlobalTerminal1F_ReceivedA
	// WaitFanfare
	// WaitCry
	// RemovePokemonPreview

    GetPartyCount VAR_PARTY_SLOT
    SubVar VAR_PARTY_SLOT, 1
    PlaySE SEQ_SE_CONFIRM
	BufferPartyMonSpecies 1, VAR_PARTY_SLOT
	MessageVar VAR_FINAL_MESSAGE // message based on base stat total of the mon
	GoTo End_Dialogue

Check_Gender_For_Display:
	GetPartyCount VAR_PARTY_SLOT
	SubVar VAR_PARTY_SLOT, 1 // party count is 0-6, but party slot is 0-5
	GetPartyMonGender VAR_PARTY_SLOT, VAR_GENDER
    GetPartyMonForm VAR_PARTY_SLOT, VAR_FORM
	GetPartyMonSpecies VAR_PARTY_SLOT, VAR_RECEIVED_POKEMON_ID
	switch VAR_GENDER
	case 0, Show_Male_Pokemon_Pic
	case 1, Show_Female_Pokemon_Pic
	case 2, Show_Male_Pokemon_Pic
	Return

Show_Male_Pokemon_Pic:
	DrawPokemonPreview VAR_RECEIVED_POKEMON_ID, 0, VAR_FORM
	Return

Show_Female_Pokemon_Pic:
	DrawPokemonPreview VAR_RECEIVED_POKEMON_ID, 1, VAR_FORM
	Return

Raise_Received_Level_By_1:
	AddVar VAR_RECEIVED_SPECIES_LEVEL, 1 // in case you roll a 0
	Return

Generate_Level:
	CountBadgesAcquired VAR_BADGE_COUNT
	switch VAR_BADGE_COUNT
    case 0, No_Badges
    case 1, One_Badge
    case 2, Two_Badges
    case 3, Three_Badges
    case 4, Four_Badges
    case 5, Five_Badges
    case 6, Six_Badges
    case 7, Seven_Badges
    GetRandom VAR_RECEIVED_SPECIES_LEVEL, 101
	Return

No_Badges:
One_Badge:
    GetRandom VAR_RECEIVED_SPECIES_LEVEL, 20
	Return

Two_Badges:
    GetRandom VAR_RECEIVED_SPECIES_LEVEL, 30
	Return

Three_Badges:
    GetRandom VAR_RECEIVED_SPECIES_LEVEL, 40
	Return

Four_Badges:
    GetRandom VAR_RECEIVED_SPECIES_LEVEL, 50
	Return

Five_Badges:
    GetRandom VAR_RECEIVED_SPECIES_LEVEL, 65
	Return

Six_Badges:
    GetRandom VAR_RECEIVED_SPECIES_LEVEL, 75
	Return

Seven_Badges:
	GetRandom VAR_RECEIVED_SPECIES_LEVEL, 85
	Return

Quit_Wonder_Trade_Before_Pay:
	HideMoney
	Message pl_msg_GlobalTerminal1F_WonderTrade_QuitBeforePay
End_Dialogue:
    WaitButton
    CloseMessage
    ReleaseAll
    End

Not_Enough_Money:
	Message pl_msg_GlobalTerminal1F_WonderTrade_NotEnoughMoney
	HideMoney
    GoTo End_Dialogue

Cancel_Sent_Mon_Selection:
	Message pl_msg_GlobalTerminal1F_WonderTrade_AskToSelectAnotherPokemon
	ShowYesNoMenu VAR_RESULT
	GoToIfEq VAR_RESULT, MENU_YES, Select_Pokemon
Return_Money:
	ShowMoney 20, 2
	GiveMoney 500
	Message pl_msg_GlobalTerminal1F_WonderTrade_ReturnMoney
	PlaySE SEQ_SE_DP_REGI
	UpdateMoneyDisplay
	WaitSE SEQ_SE_DP_REGI
	HideMoney
    GoTo End_Dialogue

Selected_Pokemon_Is_Egg:
	Message pl_msg_GlobalTerminal1F_CannotAcceptEggs
    GoTo Cancel_Sent_Mon_Selection

    .balign 4, 0
