#include "move_reminder_data.h"

#include <nitro.h>
#include <string.h>

#include "heap.h"
#include "pokemon.h"
#include "species.h"

#define MAX_NUMBER_REMINDER_MOVES_OLD 22 // 2 more than learnsets
#define MAX_NUMBER_REMINDER_MOVES (MAX_LEARNSET_ENTRIES + 2)

#define GET_LEVEL(move) ((move & LEVEL_UP_LEARNSET_LEVEL_MASK) >> LEVEL_UP_LEARNSET_LEVEL_SHIFT)
#define GET_MOVE(move)  (move & LEVEL_UP_LEARNSET_MOVE_MASK)

MoveReminderData *MoveReminderData_Alloc(enum HeapID heapID)
{
    MoveReminderData *data = Heap_Alloc(heapID, sizeof(MoveReminderData));
    memset(data, 0, sizeof(MoveReminderData));
    return data;
}

void MoveReminderData_Free(MoveReminderData *data)
{
    Heap_Free(data);
}

u32 *MoveReminderData_GetMoves(Pokemon *mon, enum HeapID heapID)
{
    u8 h, i, j;

    u16 species = Pokemon_GetValue(mon, MON_DATA_SPECIES, NULL);
    u8 form = Pokemon_GetValue(mon, MON_DATA_FORM, NULL);
    u8 level = Pokemon_GetValue(mon, MON_DATA_LEVEL, NULL);

    u16 currentMoves[LEARNED_MOVES_MAX];
    for (i = 0; i < LEARNED_MOVES_MAX; i++) {
        currentMoves[i] = Pokemon_GetValue(mon, MON_DATA_MOVE1 + i, NULL);
    }

    u32 *levelUpMoves = Heap_Alloc(heapID, MAX_NUMBER_REMINDER_MOVES * sizeof(u32));
    u32 *reminderMoves = Heap_Alloc(heapID, MAX_NUMBER_REMINDER_MOVES * sizeof(u32));

    Pokemon_LoadLevelUpMovesOf(species, form, levelUpMoves);

    j = 0;

    for (i = 0; i < MAX_NUMBER_REMINDER_MOVES; i++) {
        if (levelUpMoves[i] == LEVEL_UP_MOVESET_TERMINATOR) {
            reminderMoves[j] = LEVEL_UP_MOVESET_TERMINATOR;
            break;
        } else if (GET_LEVEL(levelUpMoves[i]) > level) {
            continue;
        } else {
            levelUpMoves[i] = GET_MOVE(levelUpMoves[i]);

            for (h = 0; h < LEARNED_MOVES_MAX; h++) {
                if (levelUpMoves[i] == currentMoves[h]) {
                    break;
                }
            }

            if (h == LEARNED_MOVES_MAX) {
                for (h = 0; h < j; h++) {
                    if (reminderMoves[h] == levelUpMoves[i]) {
                        break;
                    }
                }

                if (h == j) {
                    reminderMoves[j] = levelUpMoves[i];
                    j++;
                }
            }
        }
    }

    Heap_Free(levelUpMoves);

    return reminderMoves;
}

BOOL MoveReminderData_HasMoves(u32 *moves)
{
    return moves[0] != LEVEL_UP_MOVESET_TERMINATOR;
}
