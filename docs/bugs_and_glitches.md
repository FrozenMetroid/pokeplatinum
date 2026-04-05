# Bugs and Glitches

These are known bugs and glitches in the original Pokémon Platinum game: code that
clearly does not work as intended or that only works in limited circumstances
but has the possibility to fail or crash.

Fixes are written in the `diff` format. If you've used Git before, this should
look familiar:

```diff
this is some code
- delete red - lines
+ add green + lines
```

## Contents

- [Battle Engine](#battle-engine)
  - [Acid Rain](#acid-rain)
  - [Fire Fang Always Bypasses Wonder Guard](#fire-fang-always-bypasses-wonder-guard)
  - [Post-KO Switch-In AI Scoring Overflow](#post-ko-switch-in-ai-scoring-overflow)
  - [Using a non-Rage Move After Rage Clears Every Volatile Status Except Rage](#using-a-non-rage-move-after-rage-clears-every-volatile-status-except-rage)
- [Battle Animations](#battle-animations)
  - [Using Facade Moves the Attacker's Sprite One Pixel Up](#using-facade-moves-the-attackers-sprite-one-pixel-up)
  - [Using DynamicPunch Moves the Target's Sprite One Pixel Left](#using-dynamicpunch-moves-the-targets-sprite-one-pixel-left)
  - [Using Helping Hand Moves the Target's Sprite One Pixel Left](#using-helping-hand-moves-the-targets-sprite-one-pixel-left)
  - [Using Strength Moves the Attacker's Sprite Two Pixels Right](#using-strength-moves-the-attackers-sprite-two-pixels-right)
  - [Using Spit Up Moves the Attacker's Sprite Two Pixels Right](#using-spit-up-moves-the-attackers-sprite-two-pixels-right)
- [Wild Encounters](#wild-encounters)
  - [Fishing Encounters ignore Sticky Hold and Suction Cups](#fishing-encounters-ignore-sticky-hold-and-suction-cups)
- [Items](#items)
  - [Defog HM Uses Water Palette](#defog-hm-uses-water-palette)
- [Title Screen](#title-screen)
  - [Giratina Hover Range](#giratina-hover-range)
- [3D Rendering](#3d-rendering)
  - [Invalid VRAM Manager Type in G3DPipeline_InitEx](#invalid-vram-manager-type-in-g3dpipeline_initex)

## Battle Engine

### Acid Rain
FIXED

### Fire Fang Always Bypasses Wonder Guard
FIXED

### Post-KO Switch-In AI Scoring Overflow
FIXED

### Using a non-Rage Move After Rage Clears Every Volatile Status Except Rage
FIXED

## Battle Animations

### Using Facade Moves the Attacker's Sprite One Pixel Up
FIXED

### Using DynamicPunch Moves the Target's Sprite One Pixel Left
FIXED

### Using Helping Hand Moves the Target's Sprite One Pixel Left
FIXED

### Using Strength Moves the Attacker's Sprite Two Pixels Right
FIXED

### Using Spit Up Moves the Attacker's Sprite Two Pixels Right
FIXED

## Items

### Defog HM Uses Water Palette
FIXED

## Wild Encounters
### Fishing Encounters ignore Sticky Hold and Suction Cups
FIXED

### Surfing and Fishing Encounters ignore Magnet Pull
FIXED

## Title Screen
### Giratina Hover Range
FIXED

## 3D Rendering
### Invalid VRAM Manager Type in G3DPipeline_InitEx
FIXED
