# Pokémon Platinum, Senate's Version

This is a personal fork of the decompilation of Pokémon Platinum to make my ideal version of Pokémon Platinum. I have included my own balancing ideas, as well as many features as documented below to improve my experience with Platinum. I hope you enjoy it!

For instructions on how to set up the repository if you're interested in modifying it for yourself, please read [`INSTALL.md`](INSTALL.md) for the installation steps for PokePlatinum.

You are able to build the ROM and modify it for yourself if you want, or use it to source ideas or features for your own projects. If you do use any of my original work or are inspired by something I have done, *please credit me*.

**You do not have my permission to release a patch of this fork for any reason**. 

The only official patch of this fork will be found in the [Legacy Edition Discord](https://discord.gg/EyU36eAJ5). I am **NOT** affiliated with any other source -- if you have downloaded this code and/or a patch of this project from anywhere other than my official fork or the Legacy server, you have been scammed and you are supporting the wrong people!

*No monetary support has ever been accepted, nor will it ever be accepted, for any of my work on any ROMhacking project.*

Credits:
- Everyone who contributed to the decompilation, without which this fork would not exist. You all are awesome!
- Everyone who contributed to HeartGold-Engine, whose work helped me to program things such as modernized Sturdy, restoring items at the end of a battle, and so much more. Special shoutout to BluRose in particular!
- RavePossum for multiple tutorials, such as showing EVs, IVs, and nature-affected stats on the summary screen, for the decomp
- Keyswim for arranging the Battle! Johto Gym Leader theme for Jasmine's fight in the Battleground
- Alphamy Cadilius for his framework for the HM system rework for our other project, Legacy, that was largely ported here

Thank you!

# Features

- Singleplayer Wonder Trade in the Global Terminal (!!!)
- Toggleable party-wide Exp. Share (!!!)
- Infinite TMs and forgettable HMs (!!!)
- Use HMs without teaching the move (!!!)
    - Must have a Pokémon capable of using the move in your party, the associated Badge if there is one, and the HM in your Bag
- Faster HP bar (!!!)
- The data structure for Trainers has been completely overhauled to be like how it is in HeartGold-Engine (!!!)
    - Trainers' Pokémon can have custom Poké Balls, Abilities, EVs, IVs, etc.
- Most if not all Pokémon sprites in battle have been updated to use HeartGold/SoulSilver's and/or my own edits (e.g. improving Hoenn palettes)
- Move reminder is accessible from the party menu outside of special situations
- Footstep sounds for walking, running, metal, grass, wood, and caves from HeartGold and Soulsilver
    - Metal has not been used yet
- Multiple Premier Balls when buying Poké Balls of any type
- Shiny Charm
- Critical Capture
- Catching Charm
- Oval Charm
- Lowercase Pokémon names
- Some Pokémon have moves defined to be learned whenever they evolve, e.g. Close Combat on Infernape
- Hidden Abilities
    - Use the Ability Patch or find them in the wild with Poké Radar chains!
    - Not all Pokémon have their Hidden Abilities due to those Abilities not being programmed (e.g. Infiltrator is missing)
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
- Some different Pokémon encounters and/or levels of wild Pokémon
- Pokémon that require trading to evolve can now evolve in singleplayer
    - Pokémon that required holding an item to evolve while trading now simply need to hold the item and level up once
    - Pokémon that evolved by trading without a held item will now evolve with a Linking Cord
- 1000 steps in Safari Zone instead of 500
- Honey Trees only take 30 minutes to give an encounter rather than 6 hours
- Additional Pokémon included in Sinnoh's regional Pokédex to increase encounter variety and type representation, as well as to add to certain Trainer classes that were lacking fitting options:
    - Aron (Oreburgh Mine, Iron Island)
    - Bagon (Route 210)
    - Electrike (Route 212)
    - Growlithe (Route 204, north)
    - Horsea (Route 219)
    - Koffing (Fuego Ironworks)
    - Ledyba (Routes 203 and northern 205 during the morning)
    - Makuhita (Ravaged Path, Victory Road)
    - Mareep (Route 209)
    - Mankey (Uncommon Honey Trees, northern Route 210)
    - Miltank (Route 210)
    - Sableye (Wayward Cave)
    - Shroomish (Eterna Forest)
    - Skarmory (Iron Island)
    - Smoochum (Route 216)
    - Spinarak (Route 203 and northern 205 at night)
    - Tauros (Route 210)
    - Vulpix (Route 209 at night)
- Most Gym Leader sprites, as well as some regular Trainers' sprites, have been improved
- If your lead Pokémon has the Ability Harvest, an additional Berry will be harvested when harvesting Berries in the overworld
- Change your Pokémon's Poké Ball in Bebe's house in Hearthome City
- Reset your Pokémon's EVs in the middle house of the Fight Area by talking to the man in the top right corner
- You immediately have the Running Shoes
- Debug/testing code for nearly perfect wild encounters and perfect starters (see ``testing.h`` for the config to enable these features if you are modifying this repository)
- A myriad of changes to the battle system, as documented below

# Battle Changes

### Pokémon

All Pokémon have received changes to any combination of their learnsets, Abilities, and/or stats.
 - For brevity, use the search feature of your code editor and search for the Pokémon's name plus "data"; e.g., "Sableyedata" will narrow the search down to Sableye's data file easily

Wild and Wonder Trade Pokémon will have randomly generated movesets based on what they can learn in the level-up learnset at the generated level, with the latter also having a chance for TM and Egg moves.

### Additional Abilities:

- Piercing Eye (CUSTOM): Lowers foes' Evasion on switch-in. 
- Artillery (CUSTOM): Raises the power of beam moves (Ice Beam, Bubble Beam, etc.)
- Acid Maw (CUSTOM): Biting moves apply the effect of Gastro Acid on hit
- Matriarch (CUSTOM): Underlings heal the Pokémon for 1/8 of its maximum health at the end of the turn if it has taken damage
- Mimesis (CUSTOM): The user copies and uses sound moves, such as Hyper Voice, similarly to the Ability Dancer
- Heat Sink (CUSTOM): This Pokémon draws in all Fire-type moves to raise Sp. Attack, like Storm Drain and Lightning Rod
- Celestial Body (CUSTOM): This Pokémon applies Gravity upon switching in
- Supreme Overlord ("Supreme Lord" in-game): Raises the power of a move by 10% for each fainted ally
- Sharpness: Raises the power of slicing moves (Leaf Blade, Night Slash, etc.)
- Strong Jaw: Raises the power of biting moves (Crunch, Fire Fang, etc.)
- Rocky Payload: Raises the power of Rock-type moves
- Prankster: Gives priority to status moves (Sand-Attack, Growl, etc.)
- Friend Guard: Reduces damage done to allies by 25%
- Justified: Raises Attack if hit by a Dark-type move
- Earth Eater: Restores HP if hit by a Ground-type move
- Healer: An ally Pokémon's status condition (Burn, Poison, etc.) is healed at the end of the turn
- Analytic: Raises the power of moves by 30% if the user moves last
- Cursed Body: 30% chance to disable an offensive move used on the Pokémon
- Regenerator: Restores 30% of max HP when switching out
- Moxie: Raises Attack stage for any Pokémon that is knocked out
- Rattled: Raises Speed stage if hit by a Dark, Ghost, or Bug-type move
- Sap Sipper: Raises Attack if it would be hit by a Grass-type move and is immune
- Magic Bounce: Reflects status moves back at the user
- Heavy Metal: Doubles weight (unused)
- Light Metal: Halves weight
- Pickpocket: This Pokémon will steal the attacker's item if they have one and if this Pokémon does not already have an item
- Telepathy: Allies are unable to damage this Pokémon
- Galvanize: Normal-type moves become Electric-type
- Fluffy: Reduces damage done by moves that make contact by 50%; Fire-type moves deal 2x damage to this Pokémon
- Defiant: Raises Attack if any stat is lowered
- Competitive: Raises Sp. Attack if any stat is lowered
- Sheer Force: Removes additional effects from most moves, as well as Life Orb and Shell Bell, to increase move power
- Overcoat: Protected from the damaging effects of Hail and Sandstorm
- Queenly Majesty: Moves with increased priority cannot be used against this Pokémon
- Propeller Tail: This Pokémon's moves cannot be redirected by the likes of Follow Me, Storm Drain, Lightning Rod, etc.
- Sand Force: Rock, Ground, and Steel-type moves have a 30% increase in power during Sandstorms
- Flare Boost: Boosts special damage by 50% when the Pokémon is burned
- Toxic Boost: Boosts physical damage by 50% when the Pokémon is poisoned
- Sand Rush: Speed is increased by 50% during Sandstorms
- Slush Rush: Speed is increased by 50% during Hailstorms
- Unnerve: Opposing Pokémon cannot eat their Berries
- Big Pecks: The Pokémon's Defense stat cannot be lowered
- Poison Touch: Moves used by this Pokémon that make contact have a 30% chance to poison the target
- Wonder Skin: Makes status moves more likely to miss
- Harvest: 50% chance (or 100% chance in harsh sunlight) to restore a Berry that was consumed in battle
- Neutralizing Gas: Other Pokémon's Abilities, besides a few exclusions, are suppressed
- Weak Armor: When hit by a physical move, this Pokémon's Defense stat lowers by one stage and its Speed stat rises by two stages
- Wind Rider: When hit by a wind move, the Pokémon's Attack stat rises by one stage and the Pokémon receives 0 damage from the move
- Corrosion: This Pokémon can apply the poison status to Steel and Poison-type Pokémon
- Merciless: This Pokémon will land critical hits if the target is poisoned
- Protean: This Pokémon changes its type to the type of whatever move it uses
- Tough Claws: Moves used by this Pokémon that make contact deal 30% more damage
- Bulletproof: This Pokémon is completely protected from some ball and bomb moves, such as Shadow Ball
- Multiscale: This Pokémon receives 50% less damage if it is at max HP

### Ability Modernizations:

- Lightning Rod
- Sturdy
- Storm Drain
- Stench
- Normalize
- Plus
- Minus

### Other Ability Changes:

- Slow Start: 5 turns -> 3 turns
- Healer: Guaranteed chance to occur, no longer a 30% chance
- Damp: Applies a new field condition that dampens the battlefield to reduce Fire-type damage by 50%; the effect is removed when all Pokémon with Damp are switched or knocked out
- Overgrow, Torrent, Blaze, and Swarm all give a 20% increase to Grass, Water, Fire, and Bug-type moves, respectively, at any HP

### Battle Item Modernizations:

- Mental Herb

### Move Modernizations and Changes:

- Toxic when used by a Poison-type is perfectly accurate
- Moves such as Leech Life and Hi Jump Kick have had their BPs increased to match modern standards
    - Some BP increases are custom, such as Knock Off (now 30BP instead of 65BP), and Fire Spin (50BP instead of 35BP), and some are not changed at all, such as Surf and Thunderbolt
- PP has been increased when applicable for modernization, except the nerf to health-restoring moves' PP
- Defog removes hazards from both sides of the field
- Growth raises Special Attack and Attack by one stage; two stages under harsh sunlight
- Razor Wind will deal double damage when Tailwind is in effect on the user's side of the field
    - It will also only take one turn to use Razor Wind if Tailwind is in effect on the user's side of the field
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
- Air Slash: 75BP -> 85BP, 100% accurate, 30% flinch -> 10% flinch
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
- Dragon Rush: 75% accuracy -> 90%
- Mud Bomb: 65BP -> 75BP, 85% accuracy -> 90%, 10PP -> 15PP, 30% effect chance -> 15%
- Mirror Shot: 65BP -> 75BP, 85% accuracy -> 90%, 30% effect chance -> 20%
- Rock Climb: Normal-type -> Rock-type, 90BP -> 85BP, 85% accuracy -> 90
- Rock Wrecker: 150BP -> 120BP, effect change: lower user's Special Defense and Defense by one stage, 90% accuracy -> 100
- Gunk Shot: 80% accuracy -> 85
- Chatter: 65BP -> 75BP
- Roar of Time: 90% accuracy -> 100, 150BP -> 200BP
- Magma Storm: 80% accuracy -> 85
- Giga Drain: 65BP -> 75BPP, 10PP -> 15PP
- Ancient Power: 5PP -> 15PP
- Ominous Wind: 5PP -> 15PP
- Silver Wind: 5PP -> 15PP
- Aerial Ace: 60BP -> 75BP
- Bubble: 20BP -> 30BP

### Miscellaneous Battle System Changes:

- Trainers' Pokémon with forms have the correct stats
    - Previously, Pokémon with forms that have different stats, such as Wormadam, always used the stats of the base form
- Ice-types receive a 50% Defense increase when under the effects of Hail (Hail has not been modernized to Snow)
- Trainer AI has been updated to fix a few bugs, such as not reading Dry Skin as a Water immunity and viewing Storm Drain and Lightning Rod as immunities now
- Trainer AI should (lol) work with all the new/changed Abilities
- Paralysis
    - Not ignorable by Magic Guard
    - Reduces speed by 50%
    - Electric-types immune
- Burn
    - 1/16 damage instead of 1/8
    - Facade is no longer weakened
- The cursor on the bottom screen during a battle is now able to be moved up from the Run button to the Fight button.
- Return single-use items, excluding Berries, to the Pokémon at the end of a battle
- Items collected from wild Pokémon at the end of a battle will be put into the Bag
- Trainers will withold their Supreme Overlord Pokémon until all other fainted teammates are defeated
- Tailwind has been modernized to last 4 turns (effectively 3 turns)

# Additional Item Locations

- Evolutionary items like the Magmarizer are purchasable at the Battle Frontier
- Evolution stone seller in Sunyshore Market
- Ability Capsule: Team Galactic HQ, Poké Mart after 2 Badges
- Rocky Helmet: Battle Frontier, Iron Island
- Eviolite: Battle Frontier
- Prism Scale: Battle Frontier, first time completing a Contest
- Linking Cord: Battle Frontier, Game Corner
- Nature mints: Eterna Herp Shop
- Bottle Caps: Battle Frontier, rare Pickup (use them in the middle house in the Fight Area)
- Gold Bottle Caps: Battle Frontier (use them in the middle house in the Fight Area)
- Mental Herb: Battle Frontier
- Life Orb: Battle Frontier
- Lucky Egg: Battle Frontier
- Ability Patch: Battle Frontier
- Poké Mart items' required Badges changed and some additional items added, such as the aformentioned Ability Capsule, Ethers, etc.
    - Check out ``PokeMartCommonItems`` in ``mart_items.h`` for the list
- Pickup Table:
    - Replaced TMs Focus Punch, Rest, and Earthquake with Lucky Egg, PP Max, and Bottle Cap respectively since TMs are infinite now

# Encounters

- The Pokédex accurately shows where Pokémon can be found
- Diamond and Pearl-exclusive Sinnoh encounters have been added back, such as Glameow and Stunky
- You can complete the Sinnoh regional Pokédex, but not the National Pokédex, through singleplayer, unless if you get lucky with Wonder Trading
- Locations for the additional Pokémon in the regional Pokédex listed above
- Honey Tree encounters' levels are randomized between 10 and 55 based on the number of Badges you currently have (see ``HoneyTree_GetLevel`` for the formula) and have a chance of evolving if the generated level meets their evolution level threshold
- Other wild Pokémon locations are searchable in this repository for brevity...
- Legendaries/Mythicals & Special Encounters:
    - Regi Trio (Regirock, Regice, Registeel)
        - Once you have the National Pokédex, you can encounter these Titans in their caves from vanilla Platinum
        - They are now level 60 rather than level 30
    - Shaymin
        - Beat the Elite Four and the Cynthia's rematch teams for the first time to receive Oak's Letter from the Mom after walking downstairs in your in-game house
    - Manaphy
        - After visiting the Pokémon Mansion and speaking with Backlot to cause 5 or more special Pokémon to appear in the Trophy Garden (requires National Pokédex), he will gift you a Manaphy Egg. This effectively takes 5 days.
    - Darkrai
        - Receive the Member Card from Cynthia in the Villa after ordering the piano decoration
            - For the piano to show up in the list of available furniture, you must defeat the Elite Four and Cynthia's rematch teams once instead of entering the Hall of Fame 10 times like vanilla Platinum
        - Darkrai is now level 75 rather than level 50
    - Arceus
        - You must collect all 16 Plates scattered throughout Sinnoh (all found in their vanilla Platinum locations); plates obtained through the Grand Underground or through trading will not count. Additionally, you must have caught Dialga, Palkia, and Giratina. Once those requirements are met, you must speak with the elder in the large house in Celestic Town to receive the Azure Flute, which can then be brought to Spear Pillar to start the Hall of Origin event
    - Rotom
        - Rotom can still be encountered at night in the Old Chateau after gaining HM01 Cut and the Forest Badge
        - Rotom's forms will be unlocked with the Secret Key that you obtain from Charon during the events of the story in Galactic HQ
    - Spiritomb
        - Encounter Spiritomb at the Hallowed Tower on Route 209 immediately with an Odd Keystone


# Extra Trainers

- Jasmine: Found in the Battleground with the other Gym Leaders after clearing Stark Mountain

# Miscellaneous Changes

- Earthquake TM in Wayward Cave requires Strength now that TMs are infinite
    - Gible is still accessible at the same point in progression as vanilla Platinum
- Exp. Share moved to Oreburgh City Poké Center; must have seen 20 species in the Pokédex to receive it, which is possible before Roark
- Pressing Down while at the top of a waterfall will allow you to immediately descend it without confirming if you have a Pokémon that can learn Waterfall, you have the Beacon Badge, and HM07
- Pokémon that evolve through friendship/happiness will do so at 160 rather than 220, like modern games
- NPC-traded Pokémon, including Wonder Trade Pokémon, can evolve if their evolution requirements are met (yes, including Haunter in Snowpoint)
    - NPC-trade Pokémon now have defined levels rather than using the level of the Pokémon you sent:
        - Kazza the Abra in Oreburgh City: level 10
        - Charap the Chatot in Eterna City: level 18
        - Gaspar the Haunter in Snowpoint City: level 40
        - Foppa the Magikarp on Route 226: level 35, perfect IVs