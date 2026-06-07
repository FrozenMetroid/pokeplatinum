#include "scrcmd_shop.h"

#include <nitro.h>
#include <string.h>

#include "generated/badges.h"
#include "generated/mart_decor_id.h"
#include "generated/mart_frontier_id.h"
#include "generated/mart_seal_id.h"
#include "generated/mart_specialties_id.h"

#include "data/mart_items.h"
#include "overlay007/shop_menu.h"

#include "field_script_context.h"
#include "inlines.h"
#include "save_player.h"
#include "trainer_info.h"
#include "unk_0203D1B8.h"

BOOL ScrCmd_PokeMartCommon(ScriptContext *ctx)
{
    u16 shopItems[64];
    u16 unused = ScriptContext_GetVar(ctx);
    u8 i = 0, j = 0, badgeNum = 0;


    for (j = 0; j < MAX_BADGES; j++) {
        if (TrainerInfo_HasBadge(SaveData_GetTrainerInfo(ctx->fieldSystem->saveData), j) == TRUE) {
            badgeNum++;
        }
    }

    for (j = 0; j < (NELEMS(PokeMartCommonItems)); j++) {
        if (badgeNum >= PokeMartCommonItems[j].requiredBadges) {
            shopItems[i] = PokeMartCommonItems[j].itemID;
            i++;
        }
    }

    shopItems[i] = SHOP_ITEM_END;

    Shop_Start(ctx->task, ctx->fieldSystem, shopItems, MART_TYPE_NORMAL, FALSE);
    return TRUE;
}

BOOL ScrCmd_PokeMartSpecialties(ScriptContext *ctx)
{
    u16 martID = ScriptContext_GetVar(ctx);
    BOOL incBuyCount;

    if ((martID == MART_SPECIALTIES_ID_VEILSTONE_1F_RIGHT) || (martID == MART_SPECIALTIES_ID_VEILSTONE_1F_LEFT)
        || (martID == MART_SPECIALTIES_ID_VEILSTONE_2F_UP) || (martID == MART_SPECIALTIES_ID_VEILSTONE_2F_MID)
        || (martID == MART_SPECIALTIES_ID_VEILSTONE_3F_UP) || (martID == MART_SPECIALTIES_ID_VEILSTONE_3F_DOWN)
        || (martID == MART_SPECIALTIES_ID_VEILSTONE_B1F)) {
        incBuyCount = TRUE;
    } else {
        incBuyCount = FALSE;
    }

    Shop_Start(ctx->task, ctx->fieldSystem, (u16 *)PokeMartSpecialties[martID], MART_TYPE_NORMAL, incBuyCount);
    return TRUE;
}

// Veilstone
BOOL ScrCmd_PokeMartDecor(ScriptContext *ctx)
{
    u16 martID = ScriptContext_GetVar(ctx);
    BOOL incBuyCount;

    if ((martID == MART_DECOR_ID_VEILSTONE_4F_UP) || (martID == MART_DECOR_ID_VEILSTONE_4F_DOWN)) {
        incBuyCount = TRUE;
    } else {
        // never reached as the only two instances of this command only ever sets the
        // martID to either MART_DECOR_ID_VEILSTONE_4F_UP or MART_DECOR_ID_VEILSTONE_4F_DOWN
        // respectively.
        incBuyCount = FALSE;
    }

    Shop_Start(ctx->task, ctx->fieldSystem, (u16 *)VeilstoneDeptStoreDecorationStocks[martID], MART_TYPE_DECOR, incBuyCount);
    return TRUE;
}

// Sunyshore
BOOL ScrCmd_PokeMartSeal(ScriptContext *ctx)
{
    u16 martID = ScriptContext_GetVar(ctx);

    Shop_Start(ctx->task, ctx->fieldSystem, (u16 *)SunyshoreMarketDailyStocks[martID], MART_TYPE_SEAL, FALSE);
    return TRUE;
}

BOOL ScrCmd_ShowAccessoryShop(ScriptContext *ctx)
{
    AccessoryShop_Init(ctx->fieldSystem->task);
    return TRUE;
}
