--[[
    ========================================
    TIER SYSTEM CONFIGURATION
    ========================================
    
    Developed by: Mateus Roberto (mateuskl)
    Date: 02/08/2025
    Version: v1.2
    
    This file contains all configuration tables for the Tier Ascension System
]]

TierSystem = {}

-- Ability configuration with effects and activation chances
TierSystem.abilityConfig = {
    ["hand"] = {
        name = "Onslaught",
        description = "Critical damage system like Imbuements, adds 60% extra damage",
        effect = "onslaught",
        activationChances = {
            [1] = 0.50, [2] = 1.05, [3] = 1.70, [4] = 2.45, [5] = 3.30,
            [6] = 4.25, [7] = 5.30, [8] = 6.45, [9] = 7.70, [10] = 9.05
        }
    },
    ["armor"] = {
        name = "Ruse", 
        description = "Dodge system like Charms, without restrictions",
        effect = "ruse",
        activationChances = {
            [1] = 0.50, [2] = 1.03, [3] = 1.62, [4] = 2.28, [5] = 3.00,
            [6] = 3.78, [7] = 4.62, [8] = 5.52, [9] = 6.48, [10] = 7.51
        }
    },
    ["head"] = {
        name = "Momentum",
        description = "Reduces cooldown of secondary group spells by 2 seconds when logout block is active",
        effect = "momentum",
        activationChances = {
            [1] = 2.00, [2] = 4.05, [3] = 6.20, [4] = 8.45, [5] = 10.80,
            [6] = 13.25, [7] = 15.80, [8] = 18.45, [9] = 21.20, [10] = 24.05
        }
    },
    ["legs"] = {
        name = "Transcendence",
        description = "Activates vocation's level 3 avatar for a shorter period",
        effect = "transcendence",
        activationChances = {
            [1] = 0.13, [2] = 0.27, [3] = 0.44, [4] = 0.64, [5] = 0.86,
            [6] = 1.11, [7] = 1.38, [8] = 1.68, [9] = 2.00, [10] = 2.35
        }
    },
    ["feet"] = {
        name = "Amplification",
        description = "Amplifies the effect of tiered items, increasing their activation chance",
        effect = "amplification",
        activationChances = {
            [1] = 2.50, [2] = 5.40, [3] = 9.10, [4] = 13.60, [5] = 18.90,
            [6] = 25.00, [7] = 31.90, [8] = 39.60, [9] = 48.10, [10] = 57.40
        }
    },
    ["necklace"] = {
        name = "Lucky Drop",
        description = "Increases drop rate from monsters",
        effect = "lucky_drop",
        dropBoost = {
            [1] = 5, [2] = 10, [3] = 15, [4] = 20, [5] = 25,
            [6] = 30, [7] = 35, [8] = 40, [9] = 45, [10] = 50
        }
    }
}

TierSystem.slotToAbility = {
    ["hand"] = "onslaught",
    ["armor"] = "ruse", 
    ["head"] = "momentum",
    ["legs"] = "transcendence",
    ["feet"] = "amplification",
    ["necklace"] = "lucky_drop"
}

-- Slot to constant mapping
TierSystem.slotToConstant = {
    ["hand"] = {CONST_SLOT_LEFT, CONST_SLOT_RIGHT},
    ["armor"] = {CONST_SLOT_ARMOR},
    ["head"] = {CONST_SLOT_HEAD},
    ["legs"] = {CONST_SLOT_LEGS},
    ["feet"] = {CONST_SLOT_FEET},
    ["necklace"] = {CONST_SLOT_NECKLACE}
}

-- Tierable items configuration (removed maxClassification as it's in items.xml)
TierSystem.tierableItems = {
    -- Hand items (weapons) - Axes
    [2386] = {slot = "hand", tierMax = 1},  -- Axe
    [2378] = {slot = "hand", tierMax = 1},  -- Battle Axe
    [2387] = {slot = "hand", tierMax = 1},  -- Double Axe
    [2380] = {slot = "hand", tierMax = 1},  -- Hand Axe
    [2428] = {slot = "hand", tierMax = 1},  -- Orcish Axe
    [2429] = {slot = "hand", tierMax = 1},  -- Barbarian Axe
    [8601] = {slot = "hand", tierMax = 1},  -- Steel Axe
    [33779] = {slot = "hand", tierMax = 1}, -- Golden Axe
    
    -- Classification 2 Axes
    [7436] = {slot = "hand", tierMax = 2},  -- Angelic Axe
    [30686] = {slot = "hand", tierMax = 2}, -- Axe of Destruction
    [3962] = {slot = "hand", tierMax = 2},  -- Beastslayer Axe
    [7412] = {slot = "hand", tierMax = 2},  -- Butcher's Axe
    [22404] = {slot = "hand", tierMax = 2}, -- Crude Umbral Axe
    [18451] = {slot = "hand", tierMax = 2}, -- Crystalline Axe
    [2440] = {slot = "hand", tierMax = 2},  -- Daramian Waraxe
    [2441] = {slot = "hand", tierMax = 4},  -- Daramian Axe (Classification 4)
    [15404] = {slot = "hand", tierMax = 2}, -- Deepling Axe
    [23547] = {slot = "hand", tierMax = 2}, -- Execowtioner Axe
    [2432] = {slot = "hand", tierMax = 2},  -- Fire Axe
    [7454] = {slot = "hand", tierMax = 2},  -- Glorious Axe
    [2430] = {slot = "hand", tierMax = 2},  -- Knight Axe
    [7456] = {slot = "hand", tierMax = 2},  -- Noble Axe
    [7411] = {slot = "hand", tierMax = 2},  -- Ornamented Axe
    [7434] = {slot = "hand", tierMax = 2},  -- Royal Axe
    [6553] = {slot = "hand", tierMax = 2},  -- Ruthless Axe
    [15451] = {slot = "hand", tierMax = 2}, -- Warrior's Axe
    [2454] = {slot = "hand", tierMax = 2},  -- War Axe
    [7388] = {slot = "hand", tierMax = 2},  -- Vile Axe
    [2431] = {slot = "hand", tierMax = 2},  -- Stonecutter Axe
    [7413] = {slot = "hand", tierMax = 2},  -- Titan Axe
    [15454] = {slot = "hand", tierMax = 2}, -- Guardian Axe
    
    -- Classification 3 Axes
    [8926] = {slot = "hand", tierMax = 3},  -- Demonwing Axe
    [2415] = {slot = "hand", tierMax = 3},  -- Great Axe
    [8924] = {slot = "hand", tierMax = 3},  -- Hellforged Axe
    [37342] = {slot = "hand", tierMax = 3}, -- Phantasmal Axe
    [2443] = {slot = "hand", tierMax = 3},  -- Ravager's Axe
    [7420] = {slot = "hand", tierMax = 3},  -- Reaper's Axe
    [2447] = {slot = "hand", tierMax = 3},  -- Twin Axe
    [22405] = {slot = "hand", tierMax = 3}, -- Umbral Axe
    
    -- Classification 4 Axes
    [35110] = {slot = "hand", tierMax = 4}, -- Cobra Axe
    [33226] = {slot = "hand", tierMax = 4}, -- Falcon Battleaxe
    [7455] = {slot = "hand", tierMax = 4},  -- Mythril Axe
    [8925] = {slot = "hand", tierMax = 4},  -- Solar Axe
    [22406] = {slot = "hand", tierMax = 4}, -- Umbral Master Axe
    
    -- Special case: Glooth Axe (Classification 0)
    [23551] = {slot = "hand", tierMax = 0}, -- Glooth Axe
    
    -- Club/Mace items - Classification 1
    [2417] = {slot = "hand", tierMax = 1},  -- Battle Hammer
    [2420] = {slot = "hand", tierMax = 1},  -- Bone Club
    [2421] = {slot = "hand", tierMax = 1},  -- Brutetamer's Staff
    [2422] = {slot = "hand", tierMax = 1},  -- Clerical Mace
    [2423] = {slot = "hand", tierMax = 1},  -- Club
    [2424] = {slot = "hand", tierMax = 1},  -- Crowbar
    [2425] = {slot = "hand", tierMax = 1},  -- Daramian Mace
    [2426] = {slot = "hand", tierMax = 1},  -- Iron Hammer
    [2427] = {slot = "hand", tierMax = 1},  -- Life Preserver
    [2433] = {slot = "hand", tierMax = 1},  -- Mace
    [2434] = {slot = "hand", tierMax = 1},  -- Mammoth Whopper
    [2435] = {slot = "hand", tierMax = 1},  -- Morning Star
    [2436] = {slot = "hand", tierMax = 1},  -- Scythe
    [2437] = {slot = "hand", tierMax = 1},  -- Spiky Club
    [2438] = {slot = "hand", tierMax = 1},  -- Studded Club
    [2439] = {slot = "hand", tierMax = 1},  -- Swampling Club
    [2442] = {slot = "hand", tierMax = 1},  -- Taurus Mace
    [2444] = {slot = "hand", tierMax = 1},  -- War Hammer
    
    -- Club/Mace items - Classification 2
    [7414] = {slot = "hand", tierMax = 2},  -- Abyss Hammer
    [7415] = {slot = "hand", tierMax = 2},  -- Amber Staff
    [7416] = {slot = "hand", tierMax = 2},  -- Arcane Staff
    [7417] = {slot = "hand", tierMax = 2},  -- Banana Staff
    [7418] = {slot = "hand", tierMax = 2},  -- Blessed Sceptre
    [7419] = {slot = "hand", tierMax = 2},  -- Bonebreaker
    [7421] = {slot = "hand", tierMax = 2},  -- Chaos Mace
    [7422] = {slot = "hand", tierMax = 2},  -- Club of the Fury
    [7423] = {slot = "hand", tierMax = 2},  -- Cranial Basher
    [22407] = {slot = "hand", tierMax = 2}, -- Crude Umbral Hammer
    [22408] = {slot = "hand", tierMax = 2}, -- Crude Umbral Mace
    [7424] = {slot = "hand", tierMax = 2},  -- Crystal Mace
    [15405] = {slot = "hand", tierMax = 2}, -- Deepling Squelcher
    [15406] = {slot = "hand", tierMax = 2}, -- Deepling Staff
    [7425] = {slot = "hand", tierMax = 2},  -- Diamond Sceptre
    [7426] = {slot = "hand", tierMax = 2},  -- Dragon Hammer
    [7427] = {slot = "hand", tierMax = 2},  -- Dragonbone Staff
    [7428] = {slot = "hand", tierMax = 2},  -- Furry Club
    [7429] = {slot = "hand", tierMax = 2},  -- Giant Smithhammer
    [23552] = {slot = "hand", tierMax = 2}, -- Glooth Whip
    [7430] = {slot = "hand", tierMax = 2},  -- Glutton's Mace
    [30687] = {slot = "hand", tierMax = 2}, -- Hammer of Destruction
    [7431] = {slot = "hand", tierMax = 2},  -- Hammer of Wrath
    [7432] = {slot = "hand", tierMax = 2},  -- Heavy Mace
    [7433] = {slot = "hand", tierMax = 2},  -- Jade Hammer
    [7435] = {slot = "hand", tierMax = 2},  -- Lunar Staff
    [30688] = {slot = "hand", tierMax = 2}, -- Mace of Destruction
    [7437] = {slot = "hand", tierMax = 2},  -- Metal Bat
    [7438] = {slot = "hand", tierMax = 2},  -- Mooh'tant Cudgel
    [7439] = {slot = "hand", tierMax = 2},  -- Mycological Mace
    [7440] = {slot = "hand", tierMax = 2},  -- Northern Star
    [7441] = {slot = "hand", tierMax = 2},  -- Ogre Klubba
    [7442] = {slot = "hand", tierMax = 2},  -- Onyx Flail
    [7443] = {slot = "hand", tierMax = 2},  -- Orcish Maul
    [7444] = {slot = "hand", tierMax = 2},  -- Ornate Mace
    [7445] = {slot = "hand", tierMax = 2},  -- Sapphire Hammer
    [7446] = {slot = "hand", tierMax = 2},  -- Shadow Sceptre
    [7447] = {slot = "hand", tierMax = 2},  -- Skull Staff
    [7448] = {slot = "hand", tierMax = 2},  -- Spiked Squelcher
    [7449] = {slot = "hand", tierMax = 2},  -- Stale Bread of Ancientness
    
    -- Club/Mace items - Classification 3
    [7450] = {slot = "hand", tierMax = 3},  -- Demonbone
    [7451] = {slot = "hand", tierMax = 3},  -- Energized Demonbone
    [7452] = {slot = "hand", tierMax = 3},  -- Maimer
    [7453] = {slot = "hand", tierMax = 3},  -- Mortal Mace
    [7457] = {slot = "hand", tierMax = 3},  -- Obsidian Truncheon
    [7458] = {slot = "hand", tierMax = 3},  -- Queen's Sceptre
    [7459] = {slot = "hand", tierMax = 3},  -- Resizer
    [7460] = {slot = "hand", tierMax = 3},  -- Rotten Demonbone
    [7461] = {slot = "hand", tierMax = 3},  -- Silver Mace
    [7462] = {slot = "hand", tierMax = 3},  -- Skullcrusher
    [7463] = {slot = "hand", tierMax = 3},  -- Snake God's Sceptre
    [7464] = {slot = "hand", tierMax = 3},  -- Sulphurous Demonbone
    [7465] = {slot = "hand", tierMax = 3},  -- The Stomper
    [22409] = {slot = "hand", tierMax = 3}, -- Umbral Hammer
    [22410] = {slot = "hand", tierMax = 3}, -- Umbral Mace
    [7466] = {slot = "hand", tierMax = 3},  -- Unliving Demonbone
    
    -- Club/Mace items - Classification 4
    [7467] = {slot = "hand", tierMax = 4},  -- Cobra Club
    [7468] = {slot = "hand", tierMax = 4},  -- Dark Trinity Mace
    [33227] = {slot = "hand", tierMax = 4}, -- Falcon Mace
    [7469] = {slot = "hand", tierMax = 4},  -- Hammer of Prophecy
    [7470] = {slot = "hand", tierMax = 4},  -- Jungle Flail
    [7471] = {slot = "hand", tierMax = 4},  -- Lich Staff
    [7472] = {slot = "hand", tierMax = 4},  -- Lion Hammer
    [7473] = {slot = "hand", tierMax = 4},  -- Naga Club
    [7474] = {slot = "hand", tierMax = 4},  -- One Hit Wonder
    [7475] = {slot = "hand", tierMax = 4},  -- Soulcrusher
    [7476] = {slot = "hand", tierMax = 4},  -- Soulmaimer
    [7477] = {slot = "hand", tierMax = 4},  -- Thunder Hammer
    [22411] = {slot = "hand", tierMax = 4}, -- Umbral Master Hammer
    [22412] = {slot = "hand", tierMax = 4}, -- Umbral Master Mace
    
    -- Wand items - Classification 1
    [2190] = {slot = "hand", tierMax = 1},  -- Wand of Cosmic Energy
    [2191] = {slot = "hand", tierMax = 1},  -- Wand of Decay
    [2192] = {slot = "hand", tierMax = 1},  -- Wand of Draconia
    [2193] = {slot = "hand", tierMax = 1},  -- Wand of Dragonbreath
    [2194] = {slot = "hand", tierMax = 1},  -- Wand of Inferno
    [2195] = {slot = "hand", tierMax = 1},  -- Wand of Starstorm
    [2196] = {slot = "hand", tierMax = 1},  -- Wand of Voodoo
    [2197] = {slot = "hand", tierMax = 1},  -- Wand of Vortex
    
    -- Wand items - Classification 2
    [7478] = {slot = "hand", tierMax = 2},  -- Dream Blossom Staff
    [7479] = {slot = "hand", tierMax = 2},  -- Wand of Defiance
    [30689] = {slot = "hand", tierMax = 2}, -- Wand of Destruction
    [7480] = {slot = "hand", tierMax = 2},  -- Wand of Everblazing
    
    -- Wand items - Classification 3
    [15407] = {slot = "hand", tierMax = 3}, -- Deepling Ceremonial Dagger
    [15408] = {slot = "hand", tierMax = 3}, -- Deepling Fork
    [7481] = {slot = "hand", tierMax = 3},  -- Energized Limb
    
    -- Wand items - Classification 4
    [7482] = {slot = "hand", tierMax = 4},  -- Amber Wand
    [7483] = {slot = "hand", tierMax = 4},  -- Cobra Wand
    [33228] = {slot = "hand", tierMax = 4}, -- Falcon Wand
    [7484] = {slot = "hand", tierMax = 4},  -- Jungle Wand
    [7485] = {slot = "hand", tierMax = 4},  -- Lion Wand
    [7486] = {slot = "hand", tierMax = 4},  -- Naga Wand
    [7487] = {slot = "hand", tierMax = 4},  -- Soultainter
    [7488] = {slot = "hand", tierMax = 4},  -- Wand of Dimensions
    
    -- Throwing items - Classification 0
    [2110] = {slot = "hand", tierMax = 0},  -- Snowball
    [6278] = {slot = "hand", tierMax = 0},  -- Throwing Cake
    [7364] = {slot = "hand", tierMax = 0},  -- Assassin Star
    [7365] = {slot = "hand", tierMax = 0},  -- Leaf Star
    [2399] = {slot = "hand", tierMax = 0},  -- Throwing Star
    [7366] = {slot = "hand", tierMax = 0},  -- Viper Star
    [7367] = {slot = "hand", tierMax = 0},  -- Royal Star
    [1294] = {slot = "hand", tierMax = 0},  -- Small Stone
    [2410] = {slot = "hand", tierMax = 0},  -- Throwing Knife
    
    -- Spear items - Classification 0
    [7368] = {slot = "hand", tierMax = 0},  -- Enchanted Spear
    [2389] = {slot = "hand", tierMax = 0},  -- Spear
    [3967] = {slot = "hand", tierMax = 0},  -- Hunting Spear
    [7378] = {slot = "hand", tierMax = 0},  -- Royal Spear
    [23553] = {slot = "hand", tierMax = 0}, -- Glooth Spear
    
    -- Crossbow items - Classification 1
    [2455] = {slot = "hand", tierMax = 1},  -- Crossbow
    
    -- Crossbow items - Classification 2
    [5803] = {slot = "hand", tierMax = 2},  -- Arbalest
    [30690] = {slot = "hand", tierMax = 2}, -- Crossbow of Destruction
    [22413] = {slot = "hand", tierMax = 2}, -- Crude Umbral Crossbow
    [5804] = {slot = "hand", tierMax = 2},  -- Crystal Crossbow
    [5805] = {slot = "hand", tierMax = 2},  -- Modified Crossbow
    [5806] = {slot = "hand", tierMax = 2},  -- Ornate Crossbow
    [5807] = {slot = "hand", tierMax = 2},  -- Rift Crossbow
    [5808] = {slot = "hand", tierMax = 2},  -- The Ironworker
    
    -- Crossbow items - Classification 3
    [5809] = {slot = "hand", tierMax = 3},  -- Royal Crossbow
    [5810] = {slot = "hand", tierMax = 3},  -- Thorn Spitter
    [22414] = {slot = "hand", tierMax = 3}, -- Umbral Crossbow
    
    -- Crossbow items - Classification 4
    [5811] = {slot = "hand", tierMax = 4},  -- Amber Crossbow
    [5812] = {slot = "hand", tierMax = 4},  -- Cobra Crossbow
    [5813] = {slot = "hand", tierMax = 4},  -- Naga Crossbow
    [5814] = {slot = "hand", tierMax = 4},  -- Soulpiercer
    [5815] = {slot = "hand", tierMax = 4},  -- The Devileye
    [5816] = {slot = "hand", tierMax = 4},  -- Triple Bolt Crossbow
    [22415] = {slot = "hand", tierMax = 4}, -- Umbral Master Crossbow
    
    -- Bow items - Classification 2
    [21696] = {slot = "hand", tierMax = 2}, -- Icicle Bow
    [10295] = {slot = "hand", tierMax = 2}, -- Musician's Bow
    [18454] = {slot = "hand", tierMax = 2}, -- Mycological Bow
    [25522] = {slot = "hand", tierMax = 2}, -- Rift Bow
    [8857] = {slot = "hand", tierMax = 2},  -- Silkweaver Bow
    
    -- Bow items - Classification 3
    [33910] = {slot = "hand", tierMax = 3}, -- Living Vine Bow
    [22417] = {slot = "hand", tierMax = 3}, -- Umbral Bow
    [8854] = {slot = "hand", tierMax = 3},  -- Warsinger Bow
    
    -- Bow items - Classification 4
    [39554] = {slot = "hand", tierMax = 4}, -- Lion Longbow
    [22416] = {slot = "hand", tierMax = 4}, -- Umbral Master Bow
    [8856] = {slot = "hand", tierMax = 4},  -- Yol's Bow
    
    -- Sword items - Classification 1
    [2376] = {slot = "hand", tierMax = 1},  -- Bone Sword
    [2411] = {slot = "hand", tierMax = 1},  -- Broadsword
    [2412] = {slot = "hand", tierMax = 1},  -- Carlin Sword
    [2413] = {slot = "hand", tierMax = 1},  -- Combat Knife
    [2414] = {slot = "hand", tierMax = 1},  -- Crimson Sword
    [2415] = {slot = "hand", tierMax = 1},  -- Crimson Sword (Rashid)
    [2449] = {slot = "hand", tierMax = 1},  -- Crystal Sword
    [2377] = {slot = "hand", tierMax = 1},  -- Dagger
    [2442] = {slot = "hand", tierMax = 1},  -- Heavy Machete
    [2443] = {slot = "hand", tierMax = 1},  -- Ink Sword
    [2444] = {slot = "hand", tierMax = 1},  -- Jagged Sword
    [2445] = {slot = "hand", tierMax = 1},  -- Katana
    [2390] = {slot = "hand", tierMax = 1},  -- Longsword
    [2391] = {slot = "hand", tierMax = 1},  -- Machete
    [2392] = {slot = "hand", tierMax = 1},  -- Poison Dagger
    [2393] = {slot = "hand", tierMax = 1},  -- Rapier
    [2394] = {slot = "hand", tierMax = 1},  -- Ratana
    [2395] = {slot = "hand", tierMax = 1},  -- Ritual Bone Knife
    [2396] = {slot = "hand", tierMax = 1},  -- Sabre
    [2397] = {slot = "hand", tierMax = 1},  -- Scimitar
    [2398] = {slot = "hand", tierMax = 1},  -- Serpent Sword
    [2407] = {slot = "hand", tierMax = 1},  -- Short Sword
    [2408] = {slot = "hand", tierMax = 1},  -- Silver Dagger
    [2409] = {slot = "hand", tierMax = 1},  -- Spike Sword
    [2416] = {slot = "hand", tierMax = 1},  -- Templar Scytheblade
    [2417] = {slot = "hand", tierMax = 1},  -- Twin Hooks
    [2418] = {slot = "hand", tierMax = 1},  -- Two Handed Sword
    
    -- Sword items - Classification 2
    [7404] = {slot = "hand", tierMax = 2},  -- Assassin Dagger
    [7405] = {slot = "hand", tierMax = 2},  -- Berserker
    [7406] = {slot = "hand", tierMax = 2},  -- Blacksteel Sword
    [7407] = {slot = "hand", tierMax = 2},  -- Blade of Corruption
    [7408] = {slot = "hand", tierMax = 2},  -- Blade of Destruction
    [7409] = {slot = "hand", tierMax = 2},  -- Bloody Edge
    [7410] = {slot = "hand", tierMax = 2},  -- Bright Sword
    [7411] = {slot = "hand", tierMax = 2},  -- Cowtana
    [22418] = {slot = "hand", tierMax = 2}, -- Crude Umbral Blade
    [22419] = {slot = "hand", tierMax = 2}, -- Crude Umbral Slayer
    [7412] = {slot = "hand", tierMax = 2},  -- Crystalline Sword
    [7413] = {slot = "hand", tierMax = 2},  -- Demonrage Sword
    [7414] = {slot = "hand", tierMax = 2},  -- Dragon Slayer
    [7415] = {slot = "hand", tierMax = 2},  -- Epee
    [7416] = {slot = "hand", tierMax = 2},  -- Fire Sword
    [7417] = {slot = "hand", tierMax = 2},  -- Giant Sword
    [7418] = {slot = "hand", tierMax = 2},  -- Haunted Blade
    [7419] = {slot = "hand", tierMax = 2},  -- Incredible Mumpiz Slayer
    [7420] = {slot = "hand", tierMax = 2},  -- Knife
    [7421] = {slot = "hand", tierMax = 2},  -- Magic Sword
    [7422] = {slot = "hand", tierMax = 2},  -- Mercenary Sword
    [7423] = {slot = "hand", tierMax = 2},  -- Mystic Blade
    [7424] = {slot = "hand", tierMax = 2},  -- Nightmare Blade
    [7425] = {slot = "hand", tierMax = 2},  -- Poet's Fencing Quill
    [7426] = {slot = "hand", tierMax = 2},  -- Pointed Rabbitslayer
    [7427] = {slot = "hand", tierMax = 2},  -- Relic Sword
    [7428] = {slot = "hand", tierMax = 2},  -- Runed Sword
    [7429] = {slot = "hand", tierMax = 2},  -- Shiny Blade
    [7430] = {slot = "hand", tierMax = 2},  -- Slayer of Destruction
    [7431] = {slot = "hand", tierMax = 2},  -- Tagralt Blade
    [7432] = {slot = "hand", tierMax = 2},  -- Thaian Sword
    [7433] = {slot = "hand", tierMax = 2},  -- The Avenger
    [7434] = {slot = "hand", tierMax = 2},  -- The Justice Seeker
    [7435] = {slot = "hand", tierMax = 2},  -- Twiceslicer
    [7436] = {slot = "hand", tierMax = 2},  -- Wyvern Fang
    [7437] = {slot = "hand", tierMax = 2},  -- Zaoan Sword
    
    -- Sword items - Classification 3
    [7438] = {slot = "hand", tierMax = 3},  -- Djinn Blade
    [7439] = {slot = "hand", tierMax = 3},  -- Emerald Sword
    [7440] = {slot = "hand", tierMax = 3},  -- Gnome Sword
    [7441] = {slot = "hand", tierMax = 3},  -- Havoc Blade
    [7442] = {slot = "hand", tierMax = 3},  -- Pharaoh Sword
    [7443] = {slot = "hand", tierMax = 3},  -- Ron the Ripper's Sabre
    [7444] = {slot = "hand", tierMax = 3},  -- Summerblade
    [7445] = {slot = "hand", tierMax = 3},  -- The Calamity
    [22420] = {slot = "hand", tierMax = 3}, -- Umbral Blade
    [22421] = {slot = "hand", tierMax = 3}, -- Umbral Slayer
    [7446] = {slot = "hand", tierMax = 3},  -- Winterblade
    
    -- Sword items - Classification 4
    [7447] = {slot = "hand", tierMax = 4},  -- Amber Sabre
    [7448] = {slot = "hand", tierMax = 4},  -- Amber Slayer
    [7449] = {slot = "hand", tierMax = 4},  -- Cobra Sword
    [7450] = {slot = "hand", tierMax = 4},  -- Draining Inferniarch Blade
    [7451] = {slot = "hand", tierMax = 4},  -- Draining Inferniarch Slayer
    [7452] = {slot = "hand", tierMax = 4},  -- Eldritch Claymore
    [33229] = {slot = "hand", tierMax = 4}, -- Falcon Longsword
    [7453] = {slot = "hand", tierMax = 4},  -- Gilded Eldritch Claymore
    [7454] = {slot = "hand", tierMax = 4},  -- Grand Sanguine Blade
    [7455] = {slot = "hand", tierMax = 4},  -- Grand Sanguine Razor
    [7456] = {slot = "hand", tierMax = 4},  -- Impaler of the Igniter
    [7457] = {slot = "hand", tierMax = 4},  -- Inferniarch Blade
    [7458] = {slot = "hand", tierMax = 4},  -- Inferniarch Slayer
    [7459] = {slot = "hand", tierMax = 4},  -- Lion Longsword
    [7460] = {slot = "hand", tierMax = 4},  -- Magic Longsword
    [7461] = {slot = "hand", tierMax = 4},  -- Naga Sword
    [7462] = {slot = "hand", tierMax = 4},  -- Sanguine Blade
    [7463] = {slot = "hand", tierMax = 4},  -- Sanguine Razor
    [7464] = {slot = "hand", tierMax = 4},  -- Siphoning Inferniarch Blade
    [7465] = {slot = "hand", tierMax = 4},  -- Siphoning Inferniarch Slayer
    [7466] = {slot = "hand", tierMax = 4},  -- Soulcutter
    [7467] = {slot = "hand", tierMax = 4},  -- Soulshredder
    [7468] = {slot = "hand", tierMax = 4},  -- The Epiphany
    [22422] = {slot = "hand", tierMax = 4}, -- Umbral Master Slayer
    [22423] = {slot = "hand", tierMax = 4}, -- Umbral Masterblade
    [7469] = {slot = "hand", tierMax = 4},  -- Warlord Sword
    
    -- Rod items - Classification 1
    [2182] = {slot = "hand", tierMax = 1},  -- Hailstorm Rod
    [2183] = {slot = "hand", tierMax = 1},  -- Moonlight Rod
    [2184] = {slot = "hand", tierMax = 1},  -- Necrotic Rod
    [2185] = {slot = "hand", tierMax = 1},  -- Northwind Rod
    [2186] = {slot = "hand", tierMax = 1},  -- Snakebite Rod
    [2187] = {slot = "hand", tierMax = 1},  -- Springsprout Rod
    [2188] = {slot = "hand", tierMax = 1},  -- Terra Rod
    [2189] = {slot = "hand", tierMax = 1},  -- Underworld Rod
    
    -- Rod items - Classification 2
    [7478] = {slot = "hand", tierMax = 2},  -- Dream Blossom Staff
    [7479] = {slot = "hand", tierMax = 2},  -- Glacial Rod
    [7480] = {slot = "hand", tierMax = 2},  -- Muck Rod
    [7481] = {slot = "hand", tierMax = 2},  -- Ogre Scepta
    [30689] = {slot = "hand", tierMax = 2}, -- Rod of Destruction
    
    -- Rod items - Classification 3
    [15407] = {slot = "hand", tierMax = 3}, -- Deepling Ceremonial Dagger
    [15408] = {slot = "hand", tierMax = 3}, -- Deepling Fork
    [7481] = {slot = "hand", tierMax = 3},  -- Energized Limb
    
    -- Rod items - Classification 4
    [7482] = {slot = "hand", tierMax = 4},  -- Amber Rod
    [7483] = {slot = "hand", tierMax = 4},  -- Cobra Rod
    [7484] = {slot = "hand", tierMax = 4},  -- Draining Inferniarch Rod
    [7485] = {slot = "hand", tierMax = 4},  -- Eldritch Rod
    [33228] = {slot = "hand", tierMax = 4}, -- Falcon Rod
    [7486] = {slot = "hand", tierMax = 4},  -- Gilded Eldritch Rod
    [7487] = {slot = "hand", tierMax = 4},  -- Grand Sanguine Rod
    [7488] = {slot = "hand", tierMax = 4},  -- Inferniarch Rod
    [7489] = {slot = "hand", tierMax = 4},  -- Jungle Rod
    [7490] = {slot = "hand", tierMax = 4},  -- Lion Rod
    [7491] = {slot = "hand", tierMax = 4},  -- Naga Rod
    [7492] = {slot = "hand", tierMax = 4},  -- Rending Inferniarch Rod
    [7493] = {slot = "hand", tierMax = 4},  -- Sanguine Rod
    [7494] = {slot = "hand", tierMax = 4},  -- Siphoning Inferniarch Rod
    [7495] = {slot = "hand", tierMax = 4},  -- Soulhexer
       
           -- Helmet items - Classification 1
    [5917] = {slot = "head", tierMax = 1},  -- Bandana
    [2460] = {slot = "head", tierMax = 1},  -- Brass Helmet
    [2458] = {slot = "head", tierMax = 1},  -- Chain Helmet
    [2490] = {slot = "head", tierMax = 1},  -- Dark Helmet
    [2459] = {slot = "head", tierMax = 1},  -- Iron Helmet
       
               -- Helmet items - Classification 4
    [48396] = {slot = "head", tierMax = 4}, -- Alicorn Headguard
    [2499] = {slot = "head", tierMax = 4},  -- Amazon Helmet
    
    -- Armor items - Classification 1
    [2465] = {slot = "armor", tierMax = 1},  -- Brass Armor
    [2464] = {slot = "armor", tierMax = 1},  -- Chain Armor
    [2467] = {slot = "armor", tierMax = 1},  -- Leather Armor
    [2463] = {slot = "armor", tierMax = 1},  -- Plate Armor
    [2483] = {slot = "armor", tierMax = 1},  -- Scale Armor
    [2656] = {slot = "armor", tierMax = 2},  -- Blue Robe
    
    -- Armor items - Classification 2
    [2466] = {slot = "armor", tierMax = 2},  -- Golden Armor
    [2494] = {slot = "armor", tierMax = 2},  -- Demon Armor
    
    -- Armor items - Classification 3
    [2505] = {slot = "armor", tierMax = 3},  -- Elven Mail
    
    -- Armor items - Classification 4
    [2500] = {slot = "armor", tierMax = 4},  -- Amazon Armor
    
    -- Legs items - Classification 1
    [2648] = {slot = "legs", tierMax = 1},  -- Chain Legs
    [2647] = {slot = "legs", tierMax = 1},  -- Plate Legs
    [2478] = {slot = "legs", tierMax = 1},  -- Brass Legs
    [2649] = {slot = "legs", tierMax = 1},  -- Leather Legs
    
    -- Legs items - Classification 2
    [18400] = {slot = "legs", tierMax = 2}, -- Gill Legs
    [9928] = {slot = "legs", tierMax = 2},  -- Leaf Legs
    [18405] = {slot = "legs", tierMax = 2}, -- Prismatic Legs
    [2477] = {slot = "legs", tierMax = 2},  -- Knight Legs
    [43000] = {slot = "legs", tierMax = 4}, -- Green Demon Legs
    [2495] = {slot = "legs", tierMax = 2},  -- Demon Legs
    [7894] = {slot = "legs", tierMax = 2},  -- Magma Legs
    [2469] = {slot = "legs", tierMax = 2},  -- Dragon Scale Legs
    [15412] = {slot = "legs", tierMax = 2}, -- Ornate Legs
    [11304] = {slot = "legs", tierMax = 2}, -- Zaoan Legs
    [2488] = {slot = "legs", tierMax = 2},  -- Crown Legs
    [2470] = {slot = "legs", tierMax = 2},  -- Golden Legs
    [7895] = {slot = "legs", tierMax = 2},  -- Lightning Legs
    
    -- Legs items - Classification 3
    [2507] = {slot = "legs", tierMax = 3},  -- Elven Legs
    [30884] = {slot = "legs", tierMax = 3}, -- Gnome Legs
    
    -- Legs items - Classification 4
    [43000] = {slot = "legs", tierMax = 4}, -- Green Demon Legs
    
    -- Feet items - Classification 0
    [25429] = {slot = "feet", tierMax = 0}, -- Boots of Homecoming
    [36824] = {slot = "feet", tierMax = 0}, -- Traditional Leather Shoes
    [10021] = {slot = "feet", tierMax = 0}, -- Worn Soft Boots
    [6132] = {slot = "feet", tierMax = 0},  -- Pair of Soft Boots
    [10022] = {slot = "feet", tierMax = 0}, -- Worn Firewalker Boots
    [26132] = {slot = "feet", tierMax = 0}, -- Void Boots
    [9932] = {slot = "feet", tierMax = 0},  -- Firewalker Boots
    
    -- Feet items - Classification 1
    [27077] = {slot = "feet", tierMax = 1}, -- Filthy Bunnyslippers
    [2642] = {slot = "feet", tierMax = 1},  -- Sandals
    [5462] = {slot = "feet", tierMax = 1},  -- Pirate Boots
    [2643] = {slot = "feet", tierMax = 1},  -- Leather Boots
    [9931] = {slot = "feet", tierMax = 1},  -- Coconut Shoes
    
    -- Feet items - Classification 2
    [34912] = {slot = "feet", tierMax = 2}, -- Yetislippers
    [12646] = {slot = "feet", tierMax = 2}, -- Draken Boots
    [3982] = {slot = "feet", tierMax = 2},  -- Crocodile Boots
    [7892] = {slot = "feet", tierMax = 2},  -- Glacier Shoes
    [23540] = {slot = "feet", tierMax = 2}, -- Metal Spats
    [7457] = {slot = "feet", tierMax = 2},  -- Fur Boots
    [18406] = {slot = "feet", tierMax = 2}, -- Prismatic Boots
    [24637] = {slot = "feet", tierMax = 2}, -- Oriental Shoes
    [7886] = {slot = "feet", tierMax = 2},  -- Terra Boots
    [24742] = {slot = "feet", tierMax = 2}, -- Badger Boots
    [7893] = {slot = "feet", tierMax = 2},  -- Lightning Boots
    [11303] = {slot = "feet", tierMax = 2}, -- Zaoan Shoes
    [2195] = {slot = "feet", tierMax = 2},  -- Boots of Haste
    [7891] = {slot = "feet", tierMax = 2},  -- Magma Boots
    [11240] = {slot = "feet", tierMax = 2}, -- Guardian Boots
    [2645] = {slot = "feet", tierMax = 2},  -- Steel Boots
    
    -- Feet items - Classification 3
    [36331] = {slot = "feet", tierMax = 3}, -- Winged Boots
    [15410] = {slot = "feet", tierMax = 3}, -- Depth Calcei
    [33917] = {slot = "feet", tierMax = 3}, -- Pair of Dreamwalkers
    [37345] = {slot = "feet", tierMax = 3}, -- Pair of Nightmare Boots
    [2646] = {slot = "feet", tierMax = 3},  -- Golden Boots
    
    -- Feet items - Classification 4
    [35108] = {slot = "feet", tierMax = 4}, -- Cobra Boots
    [11117] = {slot = "feet", tierMax = 4}, -- Crystal Boots
    [21708] = {slot = "feet", tierMax = 4}, -- Vampire Silk Slippers
    [43003] = {slot = "feet", tierMax = 4}, -- Green Demon Slippers
    [11118] = {slot = "feet", tierMax = 4}, -- Dragon Scale Boots
    [2644] = {slot = "feet", tierMax = 4},  -- Bunnyslippers
    [25412] = {slot = "feet", tierMax = 4}, -- Treader of Torment
    [2641] = {slot = "feet", tierMax = 4},  -- Patched Boots
    
    -- Original items (keeping for compatibility)
    [2160] = {slot = "hand", tierMax = 10},
    [2161] = {slot = "hand", tierMax = 10},
    [2162] = {slot = "hand", tierMax = 10},
    [2163] = {slot = "hand", tierMax = 10},
    [2164] = {slot = "hand", tierMax = 10},
    [2400] = {slot = "hand", tierMax = 10},
    [2401] = {slot = "hand", tierMax = 10},
    [2402] = {slot = "hand", tierMax = 10},
    [2403] = {slot = "hand", tierMax = 10},
    [2404] = {slot = "hand", tierMax = 10},
    
    -- Armor items
    [2165] = {slot = "head", tierMax = 10},
    [2494] = {slot = "armor", tierMax = 10},
    [2495] = {slot = "legs", tierMax = 10},
    [2168] = {slot = "feet", tierMax = 10},
    
    -- Necklace items
    [2169] = {slot = "necklace", tierMax = 10},
    
    -- Other items
    [2493] = {slot = "head", tierMax = 10},
    [2182] = {slot = "backpack", tierMax = 10},
    [2183] = {slot = "ammo", tierMax = 10}
}

-- Upgrade items configuration
TierSystem.upgradeItems = {
    [8302] = {type = "reset"},
    [8303] = {type = "tier_upgrade"},
    [8304] = {type = "classification_upgrade"},
    [8305] = {type = "stat_boost", stat = "dodge_bonus", value = 50},
    [8306] = {type = "stat_boost", stat = "speed", value = 10}
}

-- Tier configuration
TierSystem.tierConfig = {
    maxTier = 10,
    
    classifications = {
        [0] = "Base",
        [1] = "Improved", 
        [2] = "Exalted"
    },
    
    dodgePerTier = 50,
    
    statsPerTier = {}
}

-- Tier upgrade chances
TierSystem.tierUpgradeChances = {
    [0] = 80, [1] = 70, [2] = 65, [3] = 60, [4] = 50,
    [5] = 40, [6] = 35, [7] = 25, [8] = 15, [9] = 7, [10] = 5
}

-- Avatar outfits for transcendence
TierSystem.avatarOutfits = {
    ["knight"] = { lookType = 1823 },
    ["paladin"] = { lookType = 1824 },
    ["sorcerer"] = { lookType = 1825 },
    ["druid"] = { lookType = 1826 }
}

-- Avatar durations (7 seconds fixed for all tiers)
TierSystem.avatarDuration = 7000

-- Storage IDs
TierSystem.storageIds = {
    dodgeStorage = 45001,
    dodgeCooldownStorage = 45002,
    conditionSubId = 45083
}

-- Conditions mapping
TierSystem.conditions = {
    ["life increase"] = {CONDITION_PARAM_STAT_MAXHITPOINTS},
    ["mana increase"] = {CONDITION_PARAM_STAT_MAXMANAPOINTS},
    ["speed"] = {CONDITION_PARAM_SPEED},
    ["magic"] = {CONDITION_PARAM_STAT_MAGICPOINTS},
    ["melee"] = {CONDITION_PARAM_SKILL_MELEE},
    ["distance"] = {CONDITION_PARAM_SKILL_DISTANCE},
    ["shield"] = {CONDITION_PARAM_SKILL_SHIELD},
    ["critical hit chance"] = {CONDITION_PARAM_SPECIALSKILL_CRITICALHITCHANCE},
    ["critical hit damage"] = {CONDITION_PARAM_SPECIALSKILL_CRITICALHITAMOUNT},
    ["life leech chance"] = {CONDITION_PARAM_SPECIALSKILL_LIFELEECHCHANCE},
    ["life leech amount"] = {CONDITION_PARAM_SPECIALSKILL_LIFELEECHAMOUNT},
    ["mana leech chance"] = {CONDITION_PARAM_SPECIALSKILL_MANALEECHCHANCE},
    ["mana leech amount"] = {CONDITION_PARAM_SPECIALSKILL_MANALEECHAMOUNT}
}

TierSystem.getActivationChance = function(abilityType, tier)
    local slot = nil
    for slotName, ability in pairs(TierSystem.slotToAbility) do
        if ability == abilityType then
            slot = slotName
            break
        end
    end
    
    if not slot or not TierSystem.abilityConfig[slot] then
        return 0
    end
    
    return TierSystem.abilityConfig[slot].activationChances[tier] or 0
end

TierSystem.getDropBoost = function(tier)
    return TierSystem.abilityConfig["necklace"].dropBoost[tier] or 0
end

TierSystem.getMaxTierForItem = function(itemId)
    local item = TierSystem.tierableItems[itemId]
    return item and item.tierMax or 0
end

TierSystem.getItemSlot = function(itemId)
    local item = TierSystem.tierableItems[itemId]
    return item and item.slot or nil
end

TierSystem.getClassificationName = function(classification)
    return TierSystem.tierConfig.classifications[classification] or "Base"
end

TierSystem.calculateUpgradeChance = function(currentTier)
    return TierSystem.tierUpgradeChances[currentTier] or 0
end

TierSystem.isItemTierable = function(item)
    if not item:isItem() then
        return false
    end
    local itemId = item:getId()
    return TierSystem.tierableItems[itemId] ~= nil
end

return TierSystem 