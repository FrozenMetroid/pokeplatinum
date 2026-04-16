# Pokémon Platinum

This is a personal fork of the decompilation of Pokémon Platinum. For instructions on how to set up the repository, please read [`INSTALL.md`](INSTALL.md). 

A full release will not be made given that this is a personal project for my own enjoyment; however, you are able to build the ROM and play it for yourself if you want, or use it to source ideas or features. If you do use any of my original work or are inspired by something I have done, please credit me.

You do not have my permission to release a playable patch of this fork for any reason.

Credits:
- Everyone who contributed to the decompilation, without which this fork would not exist. You all are awesome!
- Everyone who contributed to HeartGold-Engine, whose work helped me to program things such as modernized Sturdy. Special shoutout to BluRose in particular!
- RavePossum for multiple tutorials

- Senate

# Features
- Footstep sounds for walking, running, metal, grass, wood, and caves from HeartGold and Soulsilver
    Metal, Grass, and Wood metatile behavior have not been applied to any maps because of the inability to edit maps in the decomp currently
- Multiple Premier Balls when buying Poké Balls of any type
- Shiny Charm
- Critical Captures and Catching Charm
- Oval Charm
- Debug/testing code for nearly perfect wild encounters and perfect starters
- Lowercase Pokémon names
- A myriad of changes to the battle system, as documented below
- Redone encounters and Trainers (WIP)
- Some Pokémon have moves defined to be learned whenever they evolve, e.g. Close Combat on Infernape
- Infinite TMs and forgettable HMs
- Use HMs without teaching the move
    Must have a Pokémon capable of using the move in your party, the associated Badge if there is one, and the HM in your Bag
- Ability Capsule
- Nature mints
- Rocky Helmet
- Eviolite
- Bottle Caps
- Linking Cord
- Prism Scale
- Show EVs and IVs on the Summary Screen
- Reduced BP prices at the Battle Frontier shops for less grinding
- Pokémon that require trading to evolve can now evolve in singleplayer
    Pokémon that required holding an item to evolve while trading now simply need to hold the item and level up once
    Pokémon that evolved by trading will now evolve with a Linking Cord
- 1000 steps in Safari Zone instead of 500

# Battle Changes

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
    Hoothoot and Noctowl
- Artillery (CUSTOM): Raises the power of beam moves (Ice Beam, Bubble Beam, etc.)
    Octillery
- Supreme Overlord (Supreme Lord in-game): Raises the power of a move by 10% for each fainted ally
    Honchkrow (overlord of Murkrow in the Pokédex)
- Sharpness: Raises the power of slicing moves (Leaf Blade, Night Slash, etc.)
    Absol and Gallade
- Strong Jaw: Raises the power of biting moves (Crunch, Fire Fang, etc.)
    Carnivine
- Rocky Payload: Raises the power of Rock-type moves
    Rhyperior (inspired by it shooting Geodude out of its arms)
- Prankster: Gives priority to status moves (Sand-Attack, Growl, etc.)
    Murkrow and Sableye

Ability Modernizations:
- Lightning Rod
- Sturdy
- Storm Drain
- Stench

Move Modernizations and Changes:
- Toxic when used by a Poison-type is perfectly accurate
- Moves such as Leech Life and Hi Jump Kick have had their BPs increased to match modern standards
    Some BP increases are custom, such as Knock Off (now 30BP instead of 65BP), and Fire Spin (50BP instead of 35BP), and some are not changed at all, such as Surf and Thunderbolt
- PP has been increased when applicable for modernization, except the nerf to health-restoring moves' PP
    Ancient Power and Silver Wind's PP has been increased from 5 to 15
    Giga Drain's PP has been increased from 10 to 15
- Defog removes hazards from both sides of the field

Miscellaneous Battle System Changes:
- Ice-types receive a 50% Defense increase when under the effects of Hail (Hail has not been modernized to Snow)
- Trainer AI has been updated to fix a few bugs, such as not reading Dry Skin as a Water immunity and viewing Storm Drain and Lightning Rod as immunities now

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