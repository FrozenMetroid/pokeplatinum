#include "save_follow_mon.h"

#include <nitro.h>
#include <string.h>

#include "savedata.h"

u32 FollowMon_SaveSize(void) {
    return sizeof(SaveFollowMon);
}

void FollowMon_SaveInit(SaveFollowMon *followMon) {
    MI_CpuClearFast(followMon, sizeof(SaveFollowMon));
    followMon->mapNo = 0;
}

SaveFollowMon *FollowMon_SaveGet(SaveData *saveData) {
    return (SaveFollowMon *)SaveData_SaveTable(saveData, SAVE_TABLE_FOLLOW_MON);
}

void FollowMon_SaveSetMapID(u32 mapNo, SaveFollowMon *followMon) {
    followMon->mapNo = mapNo;
}

u32 FollowMon_SaveGetMapID(SaveFollowMon *followMon) {
    return followMon->mapNo;
}

void FollowMon_SaveSetUnused2bitField(u8 value, SaveFollowMon *followMon) {
    followMon->unused = value;
}

void FollowMon_SaveSetInhibitFlagState(SaveFollowMon *followMon, u8 flag) {
    followMon->inhibitFlag = flag;
}

u8 FollowMon_SaveGetInhibitFlagState(SaveFollowMon *followMon) {
    return (u8)followMon->inhibitFlag;
}
