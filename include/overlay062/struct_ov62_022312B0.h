#ifndef POKEPLATINUM_STRUCT_OV62_022312B0_H
#define POKEPLATINUM_STRUCT_OV62_022312B0_H

#include "struct_decls/font_oam.h"
#include "struct_decls/struct_02012B20_decl.h"

#include "char_transfer.h"
#include "sprite_system.h"

typedef struct {
    u8 padding_00[4];
    ManagedSprite *unk_08;
    FontOAM *unk_0C;
    UnkStruct_02012B20 *unk_10;
    CharTransferAllocation unk_14;
} UnkStruct_ov62_022312B0;

#endif // POKEPLATINUM_STRUCT_OV62_022312B0_H
