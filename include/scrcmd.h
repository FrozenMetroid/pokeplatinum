#ifndef POKEPLATINUM_SCRCMD_H
#define POKEPLATINUM_SCRCMD_H

#include "field_script_context.h"

BOOL sub_02041CC8(ScriptContext *ctx);
BOOL ScriptContext_WaitForApplicationExit(ScriptContext *ctx);
BOOL ScrCmd_Debug_SetAllTownsVisited(ScriptContext *ctx);
BOOL ScrCmd_Debug_GiveAllPokemon(ScriptContext *ctx);
BOOL ScrCmd_Debug_ReducePokemonLevel(ScriptContext *ctx);
BOOL ScrCmd_WonderTrade(ScriptContext *ctx);

#endif // POKEPLATINUM_SCRCMD_H
