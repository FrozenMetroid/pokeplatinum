#ifndef POKEPLATINUM_REPEL_STEP_UPDATE_H
#define POKEPLATINUM_REPEL_STEP_UPDATE_H

#include "field/field_system_decl.h"

#include "savedata.h"

BOOL Repel_UpdateSteps(SaveData *saveData, FieldSystem *fieldSystem);
BOOL Repel_Use(SaveData *saveData, u16 currentRepel, u32 heapID);

#endif // POKEPLATINUM_REPEL_STEP_UPDATE_H
