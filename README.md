# Pokémon Platinum

This is a personal fork of the decompilation of Pokémon Platinum. For instructions on how to set up the repository, please read [`INSTALL.md`](INSTALL.md). 

A full release will not be made given that this is a personal project for my own enjoyment; however, you are able to build the ROM and play it for yourself if you want, or use it to source ideas or features. If you do use any of my original work or are inspired by something I have done, please credit me.

You do not have my permission to release a playable patch of this fork for any reason.

Credits:
- Everyone who contributed to the decompilation, without which this fork would not exist. You all are awesome!
- Everyone who contributed to HeartGold-Engine, whose work helped me to program things such as modernized Sturdy. Special shoutout to BluRose in particular!
- RavePossum for multiple tutorials, such as showing EVs, IVs, and nature-affected stats on the summary screen

- Senate

# Features
- Faster HP Bar
- Singleplayer Wonder Trade in the Global Terminal
- Footstep sounds for walking, running, metal, grass, wood, and caves from HeartGold and Soulsilver
    Metal, Grass, and Wood metatile behavior have not been applied to any maps because of the inability to edit maps in the decomp currently
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
    Must have a Pokémon capable of using the move in your party, the associated Badge if there is one, and the HM in your Bag
- Hidden Abilities
    Use the Ability Patch or find them in the wild with Poké Radar chains!
    Not all Pokémon have their Hidden Abilities due to those Abilities not being programmed
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
    Pokémon that required holding an item to evolve while trading now simply need to hold the item and level up once
    Pokémon that evolved by trading will now evolve with a Linking Cord
- 1000 steps in Safari Zone instead of 500
- Toggleable party-wide Exp. Share
- Honey Trees only take 30 minutes to give an encounter rather than 6 hours
- A myriad of changes to the battle system, as documented below

# Battle Changes

HP bar is faster now.

The data structure for Trainers has been completely overhauled to be like how it is in HeartGold-Engine -- now Trainers' Pokémon can have custom Poké Balls, Abilities, EVs, IVs, etc.

Currently, the only modifications to stats, abilities, learnsets, etc. have been made to Pokémon within the Sinnoh regional Pokédex, which has been updated to include the following lines to round out less common types, bringing the total from 210 to 230:
- Aron
- Bagon
- Electrike
- Growlithe
- Horsea
- Sableye
- Shroomish 
- Smoochum
- Vulpix

The cursor on the bottom screen during a battle is now able to be moved up from the Run button to the Fight button.

Additional Abilities:
- Piercing Eye (CUSTOM): Lowers foes' Evasion on switch-in. 
- Artillery (CUSTOM): Raises the power of beam moves (Ice Beam, Bubble Beam, etc.)
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


    
Ability Modernizations:
- Lightning Rod
- Sturdy
- Storm Drain
- Stench
- Normalize

Ability Changes:
- Slow Start: 5 turns -> 3 turns
- Healer: Guaranteed chance to occur, no longer a 30% chance

Item Modernizations:
- Mental Herb

Move Modernizations and Changes:
- Toxic when used by a Poison-type is perfectly accurate
- Moves such as Leech Life and Hi Jump Kick have had their BPs increased to match modern standards
    Some BP increases are custom, such as Knock Off (now 30BP instead of 65BP), and Fire Spin (50BP instead of 35BP), and some are not changed at all, such as Surf and Thunderbolt
- PP has been increased when applicable for modernization, except the nerf to health-restoring moves' PP
    Ancient Power and Silver Wind's PP has been increased from 5 to 15
    Giga Drain's PP has been increased from 10 to 15
- Defog removes hazards from both sides of the field
- Growth raises Special Attack and Attack by one stage; two stages under harsh sunlight
- Air Slash: 85BP, 100% accurate, 10% flinch
- Moves that have been updated to be able to be reflected by Magic Coat and Magic Bounce:
    Disable
    Defog
    Embargo
    Encore
    Foresight
    Heal Block
    Miracle Eye
    Odor Sleuth
    Roar/Whirlwind
    Spikes (!!!)
    Spite
    Stealth Rock (!!!)
    Taunt (!!!)
    Torment
    Toxic Spikes (!!!)

Miscellaneous Battle System Changes:
- Ice-types receive a 50% Defense increase when under the effects of Hail (Hail has not been modernized to Snow)
- Trainer AI has been updated to fix a few bugs, such as not reading Dry Skin as a Water immunity and viewing Storm Drain and Lightning Rod as immunities now
- Paralysis
    Not ignorable by Magic Guard (Jirachi wins the Clefable matchup even more now)
    Reduces speed by 50%
    Electric-types immune
- Burn
    1/16 damage instead of 1/8
    Facade is no longer weakened

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
- The Pokédex accurately shows where Pokémon live
- Murkrow and Misdreavus added back to Eterna Forest at night
- Encounter Spiritomb at the Hallowed Tower immediately with an Odd Keystone
- Diamond and Pearl-exclusive Sinnoh encounters have been returned, such as Glameow and Stunky