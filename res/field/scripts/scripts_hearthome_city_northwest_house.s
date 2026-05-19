#include "macros/scrcmd.inc"
#include "res/text/bank/hearthome_city_northwest_house.h"


    ScriptEntry HearthomeCityNorthwestHouse_Bebe
    ScriptEntry HearthomeCityNorthwestHouse_Scientist // changes the pokeball assigned to the mon
    ScriptEntryEnd

.set VAR_PARTY_SLOT, VAR_MAP_LOCAL_0
.set VAR_SET_BALL, VAR_MAP_LOCAL_1

HearthomeCityNorthwestHouse_Bebe:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    GoToIfSet FLAG_RECEIVED_HEARTHOME_CITY_NORTHWEST_HOUSE_EEVEE, HearthomeCityNorthwestHouse_AlreadyReceivedEevee
    GoToIfSet FLAG_MET_BEBE, HearthomeCityNorthwestHouse_SoDoYouWantEevee
    SetFlag FLAG_MET_BEBE
    Message HearthomeCityNorthwestHouse_Text_MyNamesBebeDoYouWantEevee
    GoTo HearthomeCityNorthwestHouse_AcceptEeveeYesNoMenu
    End

HearthomeCityNorthwestHouse_SoDoYouWantEevee:
    Message HearthomeCityNorthwestHouse_Text_SoDoYouWantEevee
    GoTo HearthomeCityNorthwestHouse_AcceptEeveeYesNoMenu
    End

HearthomeCityNorthwestHouse_AcceptEeveeYesNoMenu:
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_YES, HearthomeCityNorthwestHouse_AcceptEevee
    GoTo HearthomeCityNorthwestHouse_DeclineEevee
    End

HearthomeCityNorthwestHouse_AcceptEevee:
    GetPartyCount VAR_RESULT
    GoToIfEq VAR_RESULT, 6, HearthomeCityNorthwestHouse_PartyIsFull
    Message HearthomeCityNorthwestHouse_Text_PleaseBeGoodToIt
    PlayFanfare SEQ_FANFA4
    BufferPlayerName 0
    Message HearthomeCityNorthwestHouse_Text_PlayerAcceptedTheEevee
    WaitFanfare
    GivePokemon SPECIES_EEVEE, 20, ITEM_NONE, VAR_RESULT
    SetFlag FLAG_RECEIVED_HEARTHOME_CITY_NORTHWEST_HOUSE_EEVEE
    Message HearthomeCityNorthwestHouse_Text_WouldYouLikeToNicknameEevee
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_YES, HearthomeCityNorthwestHouse_GiveNickname
    GoToIfEq VAR_RESULT, MENU_NO, HearthomeCityNorthwestHouse_DontGiveNickname
    End

HearthomeCityNorthwestHouse_GiveNickname:
    CloseMessage
    GetPartyCount VAR_MAP_LOCAL_0
    SubVar VAR_MAP_LOCAL_0, 1
    FadeScreenOut
    WaitFadeScreen
    OpenPokemonNamingScreen VAR_MAP_LOCAL_0, VAR_RESULT
    CallIfNe VAR_RESULT, 1, HearthomeCityNorthwestHouse_IncrementRecordPokemonNicknamed
    FadeScreenIn
    WaitFadeScreen
    ReleaseAll
    End

HearthomeCityNorthwestHouse_IncrementRecordPokemonNicknamed:
    IncrementGameRecord RECORD_POKEMON_NICKNAMED
    Return

HearthomeCityNorthwestHouse_DontGiveNickname:
    CloseMessage
    ReleaseAll
    End

HearthomeCityNorthwestHouse_PartyIsFull:
    Message HearthomeCityNorthwestHouse_Text_YouCantTakeAnyMorePokemon
    WaitButton
    CloseMessage
    ReleaseAll
    End

HearthomeCityNorthwestHouse_DeclineEevee:
    Message HearthomeCityNorthwestHouse_Text_GuessIllRaiseItMyself
    WaitButton
    CloseMessage
    ReleaseAll
    End

HearthomeCityNorthwestHouse_AlreadyReceivedEevee:
    GetNationalDexEnabled VAR_RESULT
    GoToIfEq VAR_RESULT, TRUE, HearthomeCityNorthwestHouse_NowThatsANationalDex
    Message HearthomeCityNorthwestHouse_Text_BillDevelopedTheBasicStorageSystem
    WaitButton
    CloseMessage
    ReleaseAll
    End

HearthomeCityNorthwestHouse_NowThatsANationalDex:
    Message HearthomeCityNorthwestHouse_Text_NowThatsANationalDex
End_Dialogue:
    WaitButton
    CloseMessage
    ReleaseAll
    End

HearthomeCityNorthwestHouse_Scientist:
    LockAll
    FacePlayer
    PlaySE SEQ_SE_CONFIRM
    GoToIfSet FLAG_SPOKE_TO_HEARTHOME_CITY_POKE_BALL_CHANGER, HearthomeCityNorthwestHouse_SpokeToScientistAlready
    Message HearthomeCityNorthwestHouse_Text_ScientistSpeakFirstTime
    SetFlag FLAG_SPOKE_TO_HEARTHOME_CITY_POKE_BALL_CHANGER
HearthomeCityNorthwestHouse_SpokeToScientistAlready:
    Message HearthomeCityNorthwestHouse_Text_WouldYouLikeToTry
    ShowYesNoMenu VAR_RESULT
    GoToIfEq VAR_RESULT, MENU_NO, HearthomeCityNorthwestHouse_DeclinedScientist
    Message HearthomeCityNorthwestHouse_Text_ScientistExcited
    CloseMessage
    FadeScreenOut
    WaitFadeScreen
    SelectPartyPokemon
    ReturnToField
    FadeScreenIn
    WaitFadeScreen
    GetSelectedPartySlot VAR_PARTY_SLOT
    GoToIfEq VAR_PARTY_SLOT, 0xFF, HearthomeCityNorthwestHouse_DeclinedScientist
    GetPartyMonSpecies VAR_PARTY_SLOT, VAR_RESULT
    GoToIfEq VAR_RESULT, SPECIES_NONE, HearthomeCityNorthwestHouse_EggSelected
    Message HearthomeCityNorthwestHouse_Text_SelectPokeBall
    CloseMessage
    FadeScreenOut
    WaitFadeScreen
    OpenPokeBallsBag
    ReturnToField
    FadeScreenIn
    WaitFadeScreen
    GetSelectedItem VAR_SET_BALL
    switch VAR_SET_BALL
    case ITEM_MASTER_BALL, HearthomeCityNorthwestHouse_CannotSwapToMasterBall
    case ITEM_SAFARI_BALL, HearthomeCityNorthwestHouse_CannotSwapToThisBall
    // case ITEM_PARK_BALL, HearthomeCityNorthwestHouse_CannotSwapToThisBall // Park Ball doesn't exist apparently?
    case ITEM_CHERISH_BALL, HearthomeCityNorthwestHouse_CannotSwapToThisBall
    case ITEM_NONE, HearthomeCityNorthwestHouse_DeclinedScientist
    ChangePokeBall VAR_PARTY_SLOT, VAR_SET_BALL, VAR_RESULT
    switch VAR_RESULT
    case 0xFFFD, HearthomeCityNorthwestHouse_CurrentBallIsDesiredBall
    case 0xFFFE, HearthomeCityNorthwestHouse_NoRoomInBagForSwappedBall
    case 0xFFFF, HearthomeCityNorthwestHouse_Success
    // else, cannot remove the ball because it's special
    BufferItemNameWithArticle 0, VAR_RESULT
    Message HearthomeCityNorthwestHouse__Text_CannotChangeBall
    GoTo End_Dialogue

HearthomeCityNorthwestHouse_DeclinedScientist:
    Message HearthomeCityNorthwestHouse_Text_DeclinedScientist
    GoTo End_Dialogue

HearthomeCityNorthwestHouse_EggSelected:
    Message HearthomeCityNorthwestHouse_Text_EggSelected
    GoTo End_Dialogue

HearthomeCityNorthwestHouse_CannotSwapToMasterBall:
    Message HearthomeCityNorthwestHouse_Text_CannotSwapToMasterBall
    GoTo End_Dialogue

HearthomeCityNorthwestHouse_CannotSwapToThisBall:
    Message HearthomeCityNorthwestHouse_Text_CannotSwapToThisBall
    GoTo End_Dialogue

HearthomeCityNorthwestHouse_CurrentBallIsDesiredBall:
    BufferItemNameWithArticle 0, VAR_SET_BALL
    Message HearthomeCityNorthwestHouse_Text_CurrentBallIsDesiredBall
    GoTo End_Dialogue

HearthomeCityNorthwestHouse_NoRoomInBagForSwappedBall:
    BufferItemNameWithArticle 0, VAR_SET_BALL
    Message HearthomeCityNorthwestHouse_Text_NoRoomInBagForSwappedBall
    GoTo End_Dialogue

HearthomeCityNorthwestHouse_Success:
    Message HearthomeCityNorthwestHouse_Text_123Poof
    PlayFanfare SEQ_FANFA1
    WaitFanfare
    BufferItemNameWithArticle 0, VAR_SET_BALL
    Message HearthomeCityNorthwestHouse_Text_PokeBallChangeSuccess
    GoTo End_Dialogue

    .balign 4, 0
