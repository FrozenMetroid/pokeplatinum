#ifndef POKEPLATINUM_SENATE_FEATURES_H
#define POKEPLATINUM_SENATE_FEATURES_H

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

#define BATTLE_BUFF_PINCH_ABILITIES // always active, 1.3x boost

#define BATTLE_UPDATE_INTIMIDATE_INTERACTIONS // scrappy, inner focus, etc. ignore it

#define BATTLE_BUFF_DAMP // blocks Aftermath

#endif