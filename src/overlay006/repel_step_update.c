#include "overlay006/repel_step_update.h"

#include <nitro.h>
#include <string.h>

#include "field/field_system_decl.h"

#include "savedata.h"
#include "script_manager.h"
#include "special_encounter.h"
#include "bag.h"
#include "item.h"

BOOL Repel_UpdateSteps(SaveData *saveData, FieldSystem *fieldSystem)
{
    u8 *repelSteps = SpecialEncounter_GetRepelSteps(SaveData_GetSpecialEncounters(saveData));
    u16 repelID = SaveData_GetMostRecentRepel(saveData);

    if (*repelSteps > 0) {
        (*repelSteps)--;

        if (*repelSteps == 0) {
            Bag *bag = SaveData_GetBag(saveData);
            u16 script;
            if (Bag_CanRemoveItem(bag, repelID, 1, HEAP_ID_SYSTEM)) {
                script = SCRIPT_ID(COMMON_SCRIPTS, 58);
            } else {
                script = SCRIPT_ID(COMMON_SCRIPTS, 32);
            }
            ScriptManager_Set(fieldSystem, script, NULL);
            return TRUE;
        }
    }

    return FALSE;
}

BOOL Repel_Use(SaveData *saveData, u16 currentRepel, u32 heap)
{
    u8 *repelSteps = SpecialEncounter_GetRepelSteps(SaveData_GetSpecialEncounters(saveData));
    Bag *bag = SaveData_GetBag(saveData);

    // actually use the repel
    if (Bag_TryRemoveItem(bag, currentRepel, 1, heap)) {
        *repelSteps = Item_LoadParam(currentRepel, ITEM_PARAM_HOLD_EFFECT_PARAM, heap);
        return TRUE;
    }

    return FALSE;
}
