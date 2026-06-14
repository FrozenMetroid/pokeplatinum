#include "scrcmd_game_corner_prize.h"

#include <nitro.h>
#include <string.h>

#include "generated/items.h"

#include "field_script_context.h"
#include "inlines.h"

typedef struct GameCornerPrize {
    u16 item;
    u16 price;
} GameCornerPrize;

BOOL ScrCmd_GetGameCornerPrizeData(ScriptContext *ctx)
{
    u16 index = ScriptContext_GetVar(ctx);
    u16 *item = ScriptContext_GetVarPointer(ctx);
    u16 *price = ScriptContext_GetVarPointer(ctx);

    // TMs removed since they are found elsewhere in the overworld:
    // TM13 - Ice Beam
    // TM21 - Frustration
    // TM24 - Thunderbolt
    // TM27 - Return
    // TM29 - Psychic
    // TM32 - Double Team
    // TM35 - Flamethrower
    // TM89 - U-turn
    // TM90 - Substitute
    static const GameCornerPrize sGameCornerPrizeData[] = {
        { ITEM_SILK_SCARF,      1000 },
        { ITEM_MYSTIC_WATER,    1000 },
        { ITEM_CHARCOAL,        1000 },
        { ITEM_MIRACLE_SEED,    1000 },
        { ITEM_MAGNET,          1000 },
        { ITEM_WIDE_LENS,       1000 },
        { ITEM_ZOOM_LENS,       1000 },
        { ITEM_METRONOME,       1000 },
        { ITEM_LINKING_CORD,    1000 },
        { ITEM_TM58,            2000 },
        { ITEM_TM75,            4000 },
        { ITEM_TM44,            4000 },
        { ITEM_TM10,            6000 },
        { ITEM_TM74,            6000 },
        { ITEM_TM68,            15000}
    };

    *item = sGameCornerPrizeData[index].item;
    *price = sGameCornerPrizeData[index].price;

    return FALSE;
}
