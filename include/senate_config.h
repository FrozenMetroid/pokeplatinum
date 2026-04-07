#ifndef POKEPLATINUM_SENATE_CONFIG_H
#define POKEPLATINUM_SENATE_CONFIG_H

/*
===============FIELD==============
*/

/*
Can reuse TMs and their graphics remove
the count in the bag
*/
#define REUSABLE_TMS

/*
Can delete HMs during battle and in the overworld
when teaching a move
*/
#define REMOVABLE_HMS

/*
Never understood why you're not allowed to register the Pokemon as seen
in the Pokedex if you fought it in the Frontier
*/
#define SEENPOKEMON_FRONTIER



/*
===============BATTLE==============
*/

#define BATTLE_HAIL_DEFENSE_BOOST // for ice types

#define BATTLE_BUFF_PINCH_ABILITIES // always active, 1.3x boost; Torrent, Overgrow, Swarm, and Blaze

#define BATTLE_UPDATE_INTIMIDATE_INTERACTIONS // scrappy, inner focus, etc. ignore it

#define BATTLE_BUFF_DAMP // blocks Aftermath

// The following are always applied because they deal with some subscripts
//
// 1) Storm Drain and Lightning Rod are modernized

#endif