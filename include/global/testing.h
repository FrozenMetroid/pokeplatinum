#ifndef POKEPLATINUM_TESTING_H
#define POKEPLATINUM_TESTING_H

/*
TESTING_SET_BATTLE_SCENE_OFF
    Speeds up battles by skipping animations without needing to open the options menu when you start a save file. Does not affect the battle engine itself, so it can be used to test battle mechanics faster.
*/
// #define TESTING_SET_BATTLE_SCENE_OFF

/*
TESTING_SET_FAST_TEXT 
    Speeds up text by making it Fast from the beginning
*/
#define TESTING_SET_FAST_TEXT

/*
TESTING_GIVE_PERFECT_ENCOUNTERS
    Gives the player perfect starters (IVs, nature, ability, and held item) at the start of the game. Does not affect the starter selection process itself, so it can be used to test starter selection and early game content faster.
*/
// #define TESTING_GIVE_PERFECT_ENCOUNTERS

/*
TESTING_MAP_COORDS_BASED_ON_HEADER
    Updates the Town Map and Fly to display the player's location based on the header
    Just testing this for Legacy eventually
*/
// #define TESTING_MAP_COORDS_BASED_ON_HEADER

#endif