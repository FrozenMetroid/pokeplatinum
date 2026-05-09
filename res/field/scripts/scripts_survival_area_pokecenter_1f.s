#include "macros/scrcmd.inc"
#include "res/text/bank/survival_area_pokecenter_1f.h"
#include "res/field/events/events_survival_area_pokecenter_1f.h"


    ScriptEntry SurvivalAreaPokecenter1F_Nurse
    ScriptEntry SurvivalAreaPokecenter1F_AceTrainerM
    ScriptEntry SurvivalAreaPokecenter1F_ExpertM
    ScriptEntry SurvivalAreaPokecenter1F_Psychic
    ScriptEntryEnd

SurvivalAreaPokecenter1F_Nurse:
    Common_CallPokecenterNurse LOCALID_POKECENTER_NURSE
    End

SurvivalAreaPokecenter1F_AceTrainerM:
    PlaySE SEQ_SE_CONFIRM
    LockAll
    FacePlayer
    GoToIfSet FLAG_VISITED_BATTLEGROUND, SurvivalAreaPokecenter1F_ChallengeWithoutOwnPokemon
    Message SurvivalAreaPokecenter1F_Text_BuildingNextDoor
    WaitButton
    CloseMessage
    ReleaseAll
    End

SurvivalAreaPokecenter1F_ChallengeWithoutOwnPokemon:
    Message SurvivalAreaPokecenter1F_Text_ChallengeWithoutOwnPokemon
    WaitButton
    CloseMessage
    ReleaseAll
    End

SurvivalAreaPokecenter1F_ExpertM:
    ReplaceMove 0, MOVE_EARTHQUAKE, 0
    ReplaceMove 0, MOVE_ICE_FANG, 1
    ReplaceMove 0, MOVE_TAKE_DOWN, 2
    ReplaceMove 0, MOVE_STONE_EDGE, 3
    ReplaceMove 1, MOVE_THUNDERBOLT, 0
    ReplaceMove 1, MOVE_HYPER_FANG, 1
    ReplaceMove 1, MOVE_CHARM, 2
    ReplaceMove 1, MOVE_THUNDER_WAVE, 3
    ReplaceMove 2, MOVE_PETAL_DANCE, 0
    ReplaceMove 2, MOVE_EXTRASENSORY, 1
    ReplaceMove 2, MOVE_SPIKES, 2
    ReplaceMove 2, MOVE_SLUDGE_BOMB 3
    ReplaceMove 3, MOVE_SHADOW_BALL, 0
    ReplaceMove 3, MOVE_NASTY_PLOT, 1
    ReplaceMove 3, MOVE_PSYCHIC, 2
    ReplaceMove 3, MOVE_THUNDERBOLT, 3
    ReplaceMove 4, MOVE_HI_JUMP_KICK, 0
    ReplaceMove 4, MOVE_BODY_SLAM, 1
    ReplaceMove 4, MOVE_CHARM, 2
    ReplaceMove 4, MOVE_FIRE_PUNCH, 3
    ReplaceMove 5, MOVE_WATERFALL, 0
    ReplaceMove 5, MOVE_IRON_HEAD, 1 
    ReplaceMove 5, MOVE_SWORDS_DANCE, 2
    ReplaceMove 5, MOVE_DRILL_PECK, 3
    NPCMessage SurvivalAreaPokecenter1F_Text_CoordinationIsVital
    End

SurvivalAreaPokecenter1F_Psychic:
    NPCMessage SurvivalAreaPokecenter1F_Text_ShapedByEgg
    End

    .balign 4, 0
