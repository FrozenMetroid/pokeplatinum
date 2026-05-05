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
        u16 targetSpecies, method;
        Party *party = SaveData_GetParty(fieldSystem->saveData);
        taskEnv->receivingMon = Party_GetPokemonBySlotIndex(party, taskEnv->partySlot); // had to update this pointer because I was having an issue with the mon evolving, but not updating the species at the end, and since it's already in the party, who cares
        if (NPCTrade_ShouldEvolve(taskEnv->receivingMon, &targetSpecies, &method, HEAP_ID_FIELD2)) {
            Heap_Create(HEAP_ID_APPLICATION, HEAP_ID_EVOLUTION, HEAP_SIZE_EVOLUTION);
            taskEnv->evolutionData = Evolution_Begin(party, taskEnv->receivingMon, targetSpecies, SaveData_GetOptions(fieldSystem->saveData), PokemonSummaryScreen_ShowContestData(fieldSystem->saveData), SaveData_GetPokedex(fieldSystem->saveData), SaveData_GetBag(fieldSystem->saveData), SaveData_GetGameRecords(fieldSystem->saveData), SaveData_GetPoketch(fieldSystem->saveData), method, 4, HEAP_ID_EVOLUTION);
            taskEnv->state++;
        } else {
            taskEnv->state = 6; // skip evolution if the mon doesn't evolve after the trade
        }
        break;
    case 5:
        NPCTrade_WaitEvolution(taskEnv->evolutionData, &taskEnv->state);
        break;
    case 6:
        FieldTransition_StartMap(task);
        taskEnv->state++;
        break;
    case 7:
        FieldTransition_FadeIn(task);
        taskEnv->state++;
        break;
    case 8:
        if (!taskEnv->npcTradeData->wonderTrade) { // don't need to free the receiving mon in either case because the pointer is updated to a mon in the party
            // don't want to free this because the pointer to givingMon
            // points to the mon in the wonder trade struct for the mon you sent
            Heap_Free(taskEnv->givingMon);
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

BOOL NPCTrade_ShouldEvolve(Pokemon *mon, u16 *targetSpecies, u16 *method, enum HeapID heapID)
{
    BOOL shouldEvolve = FALSE;

    u16 species = Pokemon_GetValue(mon, MON_DATA_SPECIES, NULL);
    u16 form = Pokemon_GetValue(mon, MON_DATA_FORM, NULL);
    u16 item = Pokemon_GetValue(mon, MON_DATA_HELD_ITEM, NULL);

    u16 speciesWithForm = Pokemon_GetFormNarcIndex(species, form);

    struct SpeciesEvolution *evoTable = Heap_Alloc(heapID, MAX_EVOLUTIONS * sizeof(struct SpeciesEvolution));
    NARC_ReadWholeMemberByIndexPair(evoTable, NARC_INDEX_POKETOOL__PERSONAL__EVO, speciesWithForm);

    for (int i = 0; i < MAX_EVOLUTIONS; i++) {
        if (evoTable[i].method == EVO_TRADE_WITH_HELD_ITEM && evoTable[i].param == item) {
            shouldEvolve = TRUE;
            item = ITEM_NONE;
            Pokemon_SetValue(mon, MON_DATA_HELD_ITEM, &item); // remove the item from the mon
            *targetSpecies = evoTable[i].targetSpecies;
            *method = evoTable[i].method;
            break;
        } else if (evoTable[i].method == EVO_TRADE && item != ITEM_EVERSTONE) {
            shouldEvolve = TRUE;
            *targetSpecies = evoTable[i].targetSpecies;
            *method = evoTable[i].method;
            break;
        }
    }

    Heap_Free(evoTable);
    return shouldEvolve;
}

void NPCTrade_WaitEvolution(EvolutionData *evolutionData, u32 *subTaskState)
{
    if (Evolution_IsDone(evolutionData)) {
        Evolution_Free(evolutionData);
        Heap_Destroy(HEAP_ID_EVOLUTION);
        ++(*subTaskState);
    }
}