#ifndef POKEPLATINUM_MOVEMENT_H
#define POKEPLATINUM_MOVEMENT_H

#include <nnsys.h>

typedef enum MovementCodes {
    MOVEMENT_WalkOnSpotNorth8 = 0x20,
    MOVEMENT_WalkOnSpotSouth8 = 0x21,
    MOVEMENT_WalkOnSpotWest8 = 0x22,
    MOVEMENT_WalkOnSpotEast8 = 0x23,
    MOVEMENT_RunNorth = 0x58,
    MOVEMENT_RunSouth = 0x59,
    MOVEMENT_RunWest = 0x5A,
    MOVEMENT_RunEast = 0x5B,
}MovementCodes;


#endif