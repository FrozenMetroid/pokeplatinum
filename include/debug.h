#ifndef DEBUGGING_H
#define DEBUGGING_H

#define LOGGING_ENABLED

#ifdef LOGGING_ENABLED

#define LOG_MESSAGE_MAX_LENGTH 1024
#include "charcode.h"
#include "string_gf.h"

// Prints to the emulator's standard output, with printf formatting
__attribute__((format(printf, 1, 2))) void EmulatorPrintf(const char *text, ...);

// Prints to the emulator's standard output, with printf formatting, but adds a marker prefix and a newline at the end
__attribute__((format(printf, 1, 2))) void EmulatorLog(const char *text, ...);

#else

#define EmulatorPrintf(...)
#define EmulatorLog(...)

#endif

#endif

/*
DEBUG_SHINY_CHARM
    Shows debug information about the Shiny Charm when generating a Pokemon
*/
// #define DEBUG_SHINY_CHARM

/*
DEBUG_GIVE_SHINY_CHARM_FROM_START
    Gives you a Shiny Charm at the start of the game,
    can also just be used for fun
*/
#define DEBUG_GIVE_SHINY_CHARM_FROM_START
