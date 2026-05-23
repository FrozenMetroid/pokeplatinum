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
Honey Tree levels will vary based on Badge
with 10 being the minimum and 55 being the max with 8 Badges;
also evolves the Pokemon if it can evolve at that level (50% chance to evolve if it can)
*/
#define UPDATE_HONEY_TREE_LEVELS

/*
Testing for changing banks between headers
*/
// #define CHANGE_FIELD_BGM_FADE_OUT


/*
Display the trainer's name as a sprite during the encounter effect
Currently not working
*/
// #define ENCOUNTER_EFFECT_TRAINER_NAME_AS_SPRITE


#define PARTY_MENU_ADD_MOVE_REMINDER


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

#define BATTLE_ADD_ANALYTIC

#define BATTLE_ADD_JUSTIFIED

#define BATTLE_ADD_CURSED_BODY

#define BATTLE_ADD_REGENERATOR

#define BATTLE_UPDATE_SIMPLE_ABILITY_HANDLING // just make Simple... simple... and make it adjust stat stages in the stat change function

#define BATTLE_ADD_RATTLED

#define BATTLE_ADD_SAP_SIPPER

#define BATTLE_ADD_PICKPOCKET

#define BATTLE_ADD_TELEPATHY

#define BATTLE_ADD_UNNERVE

#define BATTLE_ADD_DAMP_BATTLEFIELD // adds the Damp field condition that weakens Fire-type moves

#define BATTLE_ADD_WONDER_SKIN

#define BATTLE_ADD_HARVEST // also for berry patches giving an additional berry if the lead mon has Harvest

#define BATTLE_ADD_NEUTRALIZING_GAS

#define BATTLE_ADD_WEAK_ARMOR

#define BATTLE_ADD_FLUFFY

#define BATTLE_ADD_MULTISCALE

#define BATTLE_ADD_WIND_RIDER

#define BATTLE_ADD_MATRIARCH


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