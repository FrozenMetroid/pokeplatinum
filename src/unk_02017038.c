#include "unk_02017038.h"

#include <nitro.h>
#include <string.h>

#include "res/text/bank/location_names.h"
#include "res/text/bank/mystery_gift_event_names.h"
#include "res/text/bank/special_met_location_names.h"

static const u16 sSpecialMetLocBaseValue[] = {
    0, // regular met locations
    2000, // special met locations such as the Togepi Egg from Cynthia
    3000 // mystery gift event locations
};

// determine if the location is a regular met location, special met location, or mystery gift event location and return the corresponding position in the table that denotes type
int SpeciesMetLoc_GetMetLocationType(u32 location)
{
    int type;

    for (type = 0; type < (NELEMS(sSpecialMetLocBaseValue) - 1); type++) {
        if (location < sSpecialMetLocBaseValue[type + 1]) {
            return type;
        }
    }

    return type;
}

int SpeciesMetLoc_GetMetLocationID(u32 location)
{
    int type = SpeciesMetLoc_GetMetLocationType(location);
    return location - sSpecialMetLocBaseValue[type];
}

// baseValue 1 = Transfer mons and eggs
int SpecialMetLoc_GetId(int baseValue, int modifier)
{
    GF_ASSERT(baseValue < NELEMS(sSpecialMetLocBaseValue));
    return sSpecialMetLocBaseValue[baseValue] + modifier;
}

#define METLOC_NAME(__name) (sSpecialMetLocBaseValue[0] + LocationNames_Text_##__name)
#define SPECIAL_METLOC_NAME(__name) (sSpecialMetLocBaseValue[1] + SPECIAL_METLOC_NAME_##__name)
#define MYSTERY_GIFT_EVENT_NAME(__name) (sSpecialMetLocBaseValue[2] + MYSTERY_GIFT_EVENT_NAME_##__name)

BOOL SpeciesMetLoc_IsFromDP(u16 location)
{
    if (((location >= METLOC_NAME(MysteryZone)) && (location <= METLOC_NAME(BattlePark))) 
        || ((location >= SPECIAL_METLOC_NAME(DAYCARE)) && (location <= SPECIAL_METLOC_NAME(RILEY))) 
        || ((location >= MYSTERY_GIFT_EVENT_NAME(LOVELYPLACE)) && (location <= MYSTERY_GIFT_EVENT_NAME(CONCERTEVENT))) ) {
        return TRUE;
    }

    return FALSE;
}
