#ifndef POKEPLATINUM_SENATE_CONFIG_H
#define POKEPLATINUM_SENATE_CONFIG_H

/*
===============FIELD==============
*/

/*
Can reuse TMs and their count in the bag is no longer shown
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
500 to 1000
*/
#define INCREASE_SAFARI_STEPS

/*
Shortened timer for Honey Tree
30 mins instead of 6 hours
*/
#define HONEYTREE_SHORTENED_TIMER


/*
Display the trainer's name as a sprite during the encounter effect
*/
#define ENCOUNTER_EFFECT_TRAINER_NAME_AS_SPRITE



/*
===============BATTLE==============
*/

#define BATTLE_EXPANDED_TRAINER_STRUCT // this is the big one

#define BATTLE_ADD_CRITICAL_CAPTURES

#define BATTLE_HAIL_DEFENSE_BOOST // for ice types

#define BATTLE_BUFF_PINCH_ABILITIES // always active, 1.3x boost; Torrent, Overgrow, Swarm, and Blaze

#define BATTLE_UPDATE_INTIMIDATE_INTERACTIONS // scrappy, inner focus, etc. ignore it

#define BATTLE_BUFF_DAMP // blocks Aftermath

#define BATTLE_POISON_TYPE_TOXIC // always accurate

#define BATTLE_MICLE_BERRY_ACCURACY // always accurate

#define BATTLE_BUFF_IRON_FIST // 1.2 -> 1.5 like Strong Jaw

#define BATTLE_60_POWER_HIDDEN_POWER

#define BATTLE_ADD_SUPREME_OVERLORD

#define BATTLE_ADD_PRANKSTER

#define BATTLE_ADD_ROCKY_PAYLOAD

#define BATTLE_ADD_PIERCING_EYE

#define BATTLE_ADD_ARTILLERY

#define BATTLE_UPDATE_PARALYSIS_SPEED // speed is reduced by 50% 
#define BATTLE_MAGIC_GUARD_IMMUNITY_TO_PARALYSIS_REMOVED

#define BATTLE_BUFF_FACADE_BURN_DAMAGE // Burn damage no longer halves Facade damage

#define BATTLE_NORMALIZE_POWER_BOOST // Normalize started giving 20% boost in gen 7


// The following are always applied because they deal with some subscripts and/or things that aren't easily configurable
// Modernization:
// 1) Storm Drain and Lightning Rod
// 2) Rapid Spin
// 3) Sturdy
// 4) Modern Exp. Share
// 5) Growth




/*
    TO-DO ONCE MORE IS EXPOSED IN THE DECOMP
*/
// #define BATTLE_GRASS_TYPES_IMMUNE_TO_POWDER

#endif