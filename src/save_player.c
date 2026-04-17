#include "save_player.h"

#include <nitro.h>
#include <string.h>

#include "coins.h"
#include "game_options.h"
#include "play_time.h"
#include "savedata.h"
#include "trainer_info.h"

int Player_SaveSize(void)
{
    return sizeof(PlayerSave);
}

void Player_Init(PlayerSave *player)
{
    MI_CpuClearFast(player, sizeof(PlayerSave));

    Options_Init(&player->options);
    TrainerInfo_Init(&player->info);
    Coins_Init(&player->coins);
    PlayTime_Init(&player->playTime);
    player->mostRecentRepel = 0;
    player->partyWideExpShare = FALSE;
}

TrainerInfo *SaveData_GetTrainerInfo(SaveData *saveData)
{
    PlayerSave *state = SaveData_SaveTable(saveData, SAVE_TABLE_ENTRY_PLAYER);
    return &state->info;
}

Options *SaveData_GetOptions(SaveData *saveData)
{
    PlayerSave *state = SaveData_SaveTable(saveData, SAVE_TABLE_ENTRY_PLAYER);
    return &state->options;
}

u16 *SaveData_GetCoins(SaveData *saveData)
{
    PlayerSave *state = SaveData_SaveTable(saveData, SAVE_TABLE_ENTRY_PLAYER);
    return &state->coins;
}

PlayTime *SaveData_GetPlayTime(SaveData *saveData)
{
    PlayerSave *state = SaveData_SaveTable(saveData, SAVE_TABLE_ENTRY_PLAYER);
    return &state->playTime;
}

u8 SaveData_GetMostRecentRepel(SaveData *saveData)
{
    PlayerSave *state = SaveData_SaveTable(saveData, SAVE_TABLE_ENTRY_PLAYER);
    return state->mostRecentRepel;
}

void SaveData_SetMostRecentRepel(SaveData *saveData, u16 repel)
{
    PlayerSave *state = SaveData_SaveTable(saveData, SAVE_TABLE_ENTRY_PLAYER);
    state->mostRecentRepel = repel;
    return;
}

BOOL SaveData_GetExpShareStatus(SaveData *saveData)
{
    PlayerSave *state = SaveData_SaveTable(saveData, SAVE_TABLE_ENTRY_PLAYER);
    return state->partyWideExpShare;
}

void SaveData_SetExpShareStatus(SaveData *saveData, u8 status)
{
    GF_ASSERT(status == 0 || status == 1);
    PlayerSave *state = SaveData_SaveTable(saveData, SAVE_TABLE_ENTRY_PLAYER);
    state->partyWideExpShare = status;
    return;
} 
