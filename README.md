# Pokémon Platinum, Senate's Version

This is a personal fork of the decompilation of Pokémon Platinum. For instructions on how to set up the repository, please read [`INSTALL.md`](INSTALL.md). 

A full release will not be made given that this is a personal project for my own enjoyment; however, you are able to build the ROM and play it for yourself if you want, or use it to source ideas or features. If you do use any of my original work or are inspired by something I have done, please credit me.

You do not have my permission to release a playable patch of this fork for any reason.

Credits:
- Everyone who contributed to the decompilation, without which this fork would not exist. You all are awesome!
- Everyone who contributed to HeartGold-Engine, whose work helped me to program things such as modernized Sturdy. Special shoutout to BluRose in particular!
- RavePossum for multiple tutorials, such as showing EVs, IVs, and nature-affected stats on the summary screen
- Keyswim for arranging the Battle! Johto Gym Leader theme for Jasmine's fight in the Battleground

- Senate (aka Frozen Metroid)

# Features

- Singleplayer Wonder Trade in the Global Terminal
- Most if not all Pokémon sprites in battle have been updated to use HeartGold/SoulSilver's and/or my own edits (e.g. improving Hoenn palettes)
- Move reminder is accessible from the party menu under normal conditions
- Footstep sounds for walking, running, metal, grass, wood, and caves from HeartGold and Soulsilver
    - Metal, Grass, and Wood metatile behavior have not been applied to any maps because of the inability to edit maps in the decomp currently
- Multiple Premier Balls when buying Poké Balls of any type
- Shiny Charm
- Critical Captures and Catching Charm
- Oval Charm
- Debug/testing code for nearly perfect wild encounters and perfect starters
- Lowercase Pokémon names
- Redone encounters and Trainers (WIP)
- Some Pokémon have moves defined to be learned whenever they evolve, e.g. Close Combat on Infernape
- Infinite TMs and forgettable HMs
- Use HMs without teaching the move
    - Must have a Pokémon capable of using the move in your party, the associated Badge if there is one, and the HM in your Bag
- Hidden Abilities
    - Use the Ability Patch or find them in the wild with Poké Radar chains!
    - Not all Pokémon have their Hidden Abilities due to those Abilities not being programmed
- Ability Capsule and Ability Patch
- Nature mints
- Rocky Helmet
- Eviolite
- Bottle Caps
- Linking Cord
- Prism Scale
- Show EVs and IVs on the Summary Screen
- Reduced BP prices at the Battle Frontier shops for less grinding
- Rebalanced Pokémon and Trainers
- Some different Pokémon encounters
- Pokémon that require trading to evolve can now evolve in singleplayer
    - Pokémon that required holding an item to evolve while trading now simply need to hold the item and level up once
    - Pokémon that evolved by trading will now evolve with a Linking Cord
- 1000 steps in Safari Zone instead of 500
- Toggleable party-wide Exp. Share
- Honey Trees only take 30 minutes to give an encounter rather than 6 hours
- Additional Pokémon included in Sinnoh's regional Pokédex to increase encounter variety and type representation:
    - Aron (Oreburgh Mine, Iron Island)
    - Bagon (Route 210)
    - Electrike (Route 212)
    - Growlithe (Route 204)
    - Horsea (Route 219)
    - Ledyba (Routes 203 and northern 205 during the morning)
    - Makuhita (Ravaged Path, Victory Road)
    - Mankey (Uncommon Honey Trees, northern Route 210)
    - Sableye (Wayward Cave)
    - Shroomish (Eterna Forest)
    - Smoochum (Route 216)
    - Spinarak (Route 203 and northern 205 at night)
    - Vulpix (Route 209 at night)
- Gym Leader sprites, as well as some regular Trainers' sprites, have been improved
- If the player's lead Pokémon has the Ability Harvest, an additional Berry will be harvested when harvesting Berries in the overworld
- Change your Pokémon's Poké Ball in Bebe's house in Hearthome City
- A myriad of changes to the battle system, as documented below

# Battle Changes

### Pokémon

All Pokémon have received changes to any combination of their learnsets, Abilities, and/or stats.

### Additional Abilities:

- Piercing Eye (CUSTOM): Lowers foes' Evasion on switch-in. 
- Artillery (CUSTOM): Raises the power of beam moves (Ice Beam, Bubble Beam, etc.)
- Acid Maw (CUSTOM): Biting moves apply the effect of Gastro Acid on hit
- Matriarch (CUSTOM): Underlings heal the Pokémon for 1/8 of its maximum health when it takes damage
- Supreme Overlord (Supreme Lord in-game): Raises the power of a move by 10% for each fainted ally
- Sharpness: Raises the power of slicing moves (Leaf Blade, Night Slash, etc.)
- Strong Jaw: Raises the power of biting moves (Crunch, Fire Fang, etc.)
- Rocky Payload: Raises the power of Rock-type moves
- Prankster: Gives priority to status moves (Sand-Attack, Growl, etc.)
- Friend Guard: Reduces damage done to allies by 25%
- Justified: Raises Attack if hit by a Dark-type move
- Earth Eater: Restores HP if hit by a Ground-type move
- Healer: An ally Pokémon's status condition (Burn, Poison, etc.) is removed at the end of the turn
- Analytic: Raises the power of moves by 30% if the user moves last
- Cursed Body: 30% chance to disable a move used on the Pokémon
- Regenerator: Restores 30% of max HP when switching out
- Moxie: Raises Attack stage for any Pokémon that is knocked out
- Rattled: Raises Speed stage if hit by a Dark, Ghost, or Bug-type move
- Sap Sipper: Raises Attack if it would be hit by a Grass-type move
- Magic Bounce: Reflects status moves back at the user
- Heavy Metal: Doubles weight (useless now without Heavy Slam)
- Light Metal: Halves weight
- Pickpocket: This Pokémon will steal the attacker's item if they have one and if this Pokémon does not already have an item
- Telepathy: Allies are unable to damage this Pokémon
- Galvanize: Normal-type moves become Electric-type
- Fluffy: Reduces damage done by moves that make contact by 50%; Fire-type moves deal 2x damage
- Defiant: Raises Attack if any stat is lowered
- Competitive: Raises Sp. Attack if any stat is lowered
- Sheer Force: Removes additional effects from most moves, as well as Life Orb and Shell Bell, to increase move power
- Overcoat: Protected from the damaging effects of Hail and Sandstorm
- Queenly Majesty: Moves with increased priority cannot be used against this Pokémon
- Propeller Tail: This Pokémon's moves cannot be redirected by the likes of Follow Me, Storm Drain, Lightning Rod, etc.
- Sand Force: Rock, Ground, and Steel-type moves have a 30% increase in power during Sandstorms
- Flare Boost: Boosts Special Attack damage by 50% when the Pokémon is burned
- Sand Rush: Speed is increased by 50% during Sandstorms
- Slush Rush (unused): Speed is increased by 50% during Hailstorms
- Unnerve: Opposing Pokémon cannot eat their Berries
- Big Pecks: The Pokémon's Defense stat cannot be lowered
- Poison Touch: Moves used by this Pokémon that make contact have a 30% chance to poison the target
- Wonder Skin: Makes status moves more likely to miss
- Harvest: 50% chance (or 100% chance in harsh sunlight) to restore a Berry that was consumed in battle
- Neutralizing Gas: Other Pokémon's Abilities, besides Multitype and Neutralizing Gas, are suppressed
- Weak Armor: When hit by a physical move, this Pokémon's Defense stat lowers by one stage and its Speed stat rises by two stages
- Wind Rider: When hit by a wind move, the Pokémon's Attack stat rises by one stage
    
### Ability Modernizations:

- Lightning Rod
- Sturdy
- Storm Drain
- Stench
- Normalize

### Other Ability Changes:

- Slow Start: 5 turns -> 3 turns
- Healer: Guaranteed chance to occur, no longer a 30% chance
- Damp: Applies a new field condition that dampens the battlefield to reduce Fire-type damage by 50%; the effect is removed when all Pokémon with Damp are switch out or knocked out

### Battle Item Modernizations:

- Mental Herb

### Move Modernizations and Changes:

- Toxic when used by a Poison-type is perfectly accurate
- Moves such as Leech Life and Hi Jump Kick have had their BPs increased to match modern standards
    - Some BP increases are custom, such as Knock Off (now 30BP instead of 65BP), and Fire Spin (50BP instead of 35BP), and some are not changed at all, such as Surf and Thunderbolt
- PP has been increased when applicable for modernization, except the nerf to health-restoring moves' PP
    - Ancient Power and Silver Wind's PPs have been increased from 5 to 15
    Giga Drain's PP has been increased from 10 to 15
- Defog removes hazards from both sides of the field
- Growth raises Special Attack and Attack by one stage; two stages under harsh sunlight
- Air Slash: 85BP, 100% accurate, 10% flinch
- Moves that have been updated to be able to be reflected by Magic Coat and Magic Bounce:
    - Disable
    - Defog
    - Embargo
    - Encore
    - Foresight
    - Heal Block
    - Miracle Eye
    - Odor Sleuth
    - Roar/Whirlwind
    - Spikes (!!!)
    - Spite
    - Stealth Rock (!!!)
    - Taunt (!!!)
    - Torment
    - Toxic Spikes (!!!)
- Eruption is now a physical move to benefit Typhlosion's move to a physical attacker, as well as for Groudon's Eruption to feel like a counterpart to Kyogre's Water Spout
    - This barely affects any other Pokémon that can learn the move as they all have comparable Attack stats to Special Attack
- Tail Glow raises Special Attack by 3 stages
- Needle Arm: 60BP -> 90BP
- Zen Headbutt: 90% accuracy -> 100%
- Double Slap, Fury Attack, Fury Swipes: 15BP -> 20BP, 85% accuracy -> 90%
- Comet Punch: 15BP -> 20BP, 85% accuracy -> 100%
- Fire/Ice/Thunder Punch: 75BP -> 85BP
- Fire/Ice/Thunder Fang: 65BP -> 80BP
- Cut: Normal-type -> Steel-type, 95% accuracy -> 100% accuracy, 30PP -> 15PP
- Fly: 95% accuracy -> 100% accuracy
- Slam: 80BP -> 70BP, 75% accuracy -> 100% accuracy
- Mega Kick: 120BP -> 110BP, 75% accuracy -> 85%, 5PP -> 10PP
- Wrap: 15BP -> 30BP
- Poison Sting: 15BP -> 35BP, 30% effect chance -> 20%
- Twineedle: 25BP -> 30BP
- Submission: 80BP -> 100BP, 80% accuracy -> 90%
- Absorb: 20BP -> 30BP
- Mega Drain: 40BP -> 50BP, 20PP -> 25PP
- Fire Spin, Clamp, Whirlpool, and Sand Tomb: 35BP -> 50BP, 85% accuracy -> 95%
- Egg Bomb: 75% accuracy -> 90%
- Smog: 30BP -> 50BP, 70% accuracy -> 95%, 20PP -> 15PP, 40% effect chance -> 20%
- Spike Cannon: Normal-type -> Steel-type
- Constrict: 10BP -> 35BP
- Kinesis: 80% accuracy -> 100%
- Rock Slide: 90% accuracy -> 100%, 30% effect chance -> 10%
- Triple Kick: 10BP -> 15BP
- Sweet Kiss: 75% accuracy -> 85%
- Steel Wing: 90% accuracy -> 100%
- Iron Tail: 75% accuracy -> 85%
- Shadow Ball: 80BP -> 85BP
- Rock Smash: 40BP -> 50BP
- Dive: 80BP -> 90BP
- Luster Purge: 5PP -> 10PP
- Mist Ball: 5PP -> 10PP
- Hyper Voice: 10PP -> 15PP
- Grass Whistle: 55% accuracy -> 75%
- Shadow Punch: 60BP -> 80BP
- Bounce: 85BP -> 80BP, 85% accuracy -> 95%, 5PP -> 15PP
- Poison Tail: 50BP -> 75BP, 25PP -> 15PP
- Pluck: 60BP -> 75BP, 20PP -> 15PP
- Dragon Rush: 75% accuracy -> 90%
- Mud Bomb: 65BP -> 75BP, 85% accuracy -> 90%, 10PP -> 15PP, 30% effect chance -> 15%
- Mirror Shot: 65BP -> 75BP, 85% accuracy -> 90%, 30% effect chance -> 20%
- Rock Climb: Normal-type -> Rock-type, 90BP -> 85BP, 85% accuracy -> 90
- Rock Wrecker: 150BP -> 120BP, effect change: lower user's Special Defense and Defense by one stage, 90% accuracy -> 100
- Gunk Shot: 80% accuracy -> 85
- Chatter: 65BP -> 75BP
- Roar of Time: 90% accuracy -> 100, 150BP -> 200BP
- Magma Storm: 80% accuracy -> 85

### Miscellaneous Battle System Changes:

- HP bar is faster now (!!!)
- The data structure for Trainers has been completely overhauled to be like how it is in HeartGold-Engine -- now Trainers' Pokémon can have custom Poké Balls, Abilities, EVs, IVs, etc. (!!!)
- Ice-types receive a 50% Defense increase when under the effects of Hail (Hail has not been modernized to Snow)
- Trainer AI has been updated to fix a few bugs, such as not reading Dry Skin as a Water immunity and viewing Storm Drain and Lightning Rod as immunities now
- Trainer AI should (lol) work with all the new/changed Abilities
- Paralysis
    - Not ignorable by Magic Guard (Jirachi wins the Clefable matchup even more now)
    - Reduces speed by 50%
    - Electric-types immune
- Burn
    - 1/16 damage instead of 1/8
    - Facade is no longer weakened
- The cursor on the bottom screen during a battle is now able to be moved up from the Run button to the Fight button.

# Additional Item Locations

- Evolutionary items like the Magmarizer are purchasable at the Battle Frontier
- Evolution stone seller in Sunyshore Market
- Ability Capsule: Battle Frontier, Team Galactic HQ
- Rocky Helmet: Battle Frontier, Iron Island
- Eviolite: Battle Frontier
- Prism Scale: Battle Frontier, first time completing a Contest
- Linking Cord: Battle Frontier, Game Corner
- Nature mints: Eterna Herp Shop
- Bottle Caps: Battle Frontier (use them in the middle house in the Fight Area)
- Mental Herb: Battle Frontier
- Life Orb: Battle Frontier
- Lucky Egg: Battle Frontier
- Ability Patch: Battle Frontier

# Encounters

- The Pokédex accurately shows where Pokémon can be found
- Murkrow and Misdreavus added back to Eterna Forest at night
- Encounter Spiritomb at the Hallowed Tower immediately with an Odd Keystone
- Diamond and Pearl-exclusive Sinnoh encounters have been returned, such as Glameow and Stunky
- You can complete the Sinnoh regional Pokédex, but not the National Pokédex, through singleplayer
- Locations for the additional Pokémon in the regional Pokédex listed above
- Honey Tree encounters' levels are randomized between 10 and 55 based on the number of Badges you currently have (see ``HoneyTree_GetLevel`` for the formula) and have a chance of evolving if the generated level meets their evolution level threshold
- Other locations are searchable in this repository for brevity... 
    - Use the search feature of your code editor and search for the Pokémon's name plus "data"; e.g., "Sableyedata" will narrow the search down to Sableye's data file easily

# Extra Trainers

- Jasmine: Found in the Battleground with the other Gym Leaders after clearing Stark Mountain