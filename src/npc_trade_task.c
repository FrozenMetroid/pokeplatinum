#include "npc_trade_task.h"

#include <nitro.h>
#include <string.h>

#include "field/field_system.h"
#include "overlay006/npc_trade.h"
#include "overlay006/struct_npc_trade_animation_template.h"
#include "overlay095/ov95_02246C20.h"

#include "field_task.h"
#include "field_transition.h"
#include "heap.h"
#include "pokemon.h"

FS_EXTERN_OVERLAY(overlay95);

static const ApplicationManagerTemplate tradeSequenceAppMan = {
    TradeSequence_Init,
    TradeSequence_Main,
    TradeSequence_Exit,
    FS_OVERLAY_ID(overlay95),
};

static void StartTradeApplication(FieldTask *task);

void StartTradeApplication(FieldTask *task)
{
    FieldSystem *fieldSystem = FieldTask_GetFieldSystem(task);
    NPCTradeTaskEnv *taskEnv = FieldTask_GetEnv(task);

    FS_EXTERN_OVERLAY(overlay95);

    FieldTask_RunApplication(task, &tradeSequenceAppMan, &taskEnv->tradeAnimTemplate);
}

BOOL FieldTask_ProcessNPCTrade(FieldTask *task)
{
    FieldSystem *fieldSystem = FieldTask_GetFieldSystem(task);
    NPCTradeTaskEnv *taskEnv = FieldTask_GetEnv(task);

    switch (taskEnv->state) {
    case 0:
        NPCTrade_FillAnimationTemplate(fieldSystem, taskEnv->npcTradeData, taskEnv->partySlot, &taskEnv->tradeAnimTemplate, taskEnv->givingMon, taskEnv->receivingMon);
        if (!taskEnv->npcTradeData->wonderTrade) {
            EmulatorLog("Received mon from NPC Trade");
            NPCTrade_ReceiveMon(fieldSystem, taskEnv->npcTradeData, taskEnv->partySlot);
        }
        taskEnv->state++;
        break;
    case 1:
        FieldTransition_FadeOut(task);
        taskEnv->state++;
        break;
    case 2:
        FieldTransition_FinishMap(task);
        taskEnv->state++;
        break;
    case 3:
        StartTradeApplication(task);
        taskEnv->state++;
        break;
    case 4:
        FieldTransition_StartMap(task);
        taskEnv->state++;
        break;
    case 5:
        FieldTransition_FadeIn(task);
        taskEnv->state++;
        break;
    case 6:
        if (!taskEnv->npcTradeData->wonderTrade) { 
            // don't want to free these because the pointer to givingMon is the 
            // points to the mon in the wonder trade struct for the mon you sent, 
            // and the receivingMon points to the one in your party that you just received
            // from wonder trade
            Heap_Free(taskEnv->givingMon);
            Heap_Free(taskEnv->receivingMon);
        }
        Heap_Free(taskEnv);
        return TRUE;
    }

    return FALSE;
}

void FieldTask_StartNPCTrade(FieldTask *task, NPCTradeData *npcTradeData, int partySlot, enum HeapID heapID)
{
    NPCTradeTaskEnv *taskEnv = Heap_Alloc(heapID, sizeof(NPCTradeTaskEnv));

    memset(taskEnv, 0, sizeof(NPCTradeTaskEnv));

    taskEnv->state = 0;
    taskEnv->npcTradeData = npcTradeData;
    taskEnv->partySlot = partySlot;
    taskEnv->givingMon = Pokemon_New(heapID);
    taskEnv->receivingMon = Pokemon_New(heapID);

    FieldTask_InitCall(task, FieldTask_ProcessNPCTrade, taskEnv);
}
