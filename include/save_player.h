#ifndef POKEPLATINUM_SAVE_PLAYER_H
#define POKEPLATINUM_SAVE_PLAYER_H

#include "game_options.h"
#include "play_time.h"
#include "savedata.h"
#include "trainer_info.h"

typedef struct PlayerSave {
    Options options; // u16 bitfield
    // u8 padding_02[2]; // implicit padding in vanilla
    TrainerInfo info;
    u16 coins;
    PlayTime playTime;
    u8 padding_2A[2];
    u8 mostRecentRepel; // all the repels IDs are less than 255
    u8 partyWideExpShare:1;
} PlayerSave;

int Player_SaveSize(void);
void Player_Init(PlayerSave *player);
TrainerInfo *SaveData_GetTrainerInfo(SaveData *saveData);
Options *SaveData_GetOptions(SaveData *saveData);
u16 *SaveData_GetCoins(SaveData *saveData);
PlayTime *SaveData_GetPlayTime(SaveData *saveData);
u8 SaveData_GetMostRecentRepel(SaveData *saveData);
void SaveData_SetMostRecentRepel(SaveData *saveData, u16 repel);
BOOL SaveData_GetExpShareStatus(SaveData *saveData);
void SaveData_SetExpShareStatus(SaveData *saveData, u8 status);

#endif // POKEPLATINUM_SAVE_PLAYER_H
