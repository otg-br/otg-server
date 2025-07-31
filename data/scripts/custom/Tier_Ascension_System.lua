--[[
    ========================================
    TIER UPGRADE SYSTEM + ABILITIES + NECKLACE DROP BOOST
    ========================================
    
    Developed by: Mateus Roberto (mateuskl)
    Date: 30/07/2025
    Version: v1.1
    
    ========================================
    HOW IT WORKS:
    ========================================
    
    FORGE STYLE SYSTEM:
    - Uses specific items for upgrade (8302, 8303, 8304)
    - Tier system (1-10) with success chances
    - Classification system (Base → Improved → Exalted)
    - Automatic abilities by slot:
      * HAND: Onslaught (critical damage +60%)
      * ARMOR: Ruse (dodge system)
      * LEGS: Transcendence (automatic Avatar)
      * HEAD: Momentum (cooldown reduction)
      * FEET: Amplification (amplifies other abilities)
      * NECKLACE: Lucky Drop (increases drop rate)
    
    UPGRADE ITEMS:
    - 8302: Reset (removes tier and classification)
    - 8303: Tier Upgrade (increases tier 1-10)
    - 8304: Classification Upgrade (Base → Improved → Exalted)
    - 8305: Dodge Boost (+50 dodge)
    - 8306: Speed Boost (+10 speed)
    
    TRANSCENDENCE SYSTEM (LEGS):
    - Requires Tier 3+ (no classification requirement)
    - Automatic chance per attack (any type: melee, rune, spell)
    - Tier 3: 5% chance per attack
    - Avatar duration: 7 seconds fixed
    - Activates automatically when chance triggers
    
    REQUIREMENTS:
    - Item must have 'classification' in items.xml
    - Item must be in tierableItems list
    - Player must have specific upgrade item
    
    ========================================
]]


local abilityConfig = {
    ["hand"] = {
        name = "Onslaught",
        description = "Critical damage system like Imbuements, adds 60% extra damage",
        activationChances = {
            [1] = 0.50, [2] = 1.05, [3] = 1.70, [4] = 2.45, [5] = 3.30,
            [6] = 4.25, [7] = 5.30, [8] = 6.45, [9] = 7.70, [10] = 9.05
        }
    },
    ["armor"] = {
        name = "Ruse", 
        description = "Dodge system like Charms, without restrictions",
        activationChances = {
            [1] = 0.50, [2] = 1.03, [3] = 1.62, [4] = 2.28, [5] = 3.00,
            [6] = 3.78, [7] = 4.62, [8] = 5.52, [9] = 6.48, [10] = 7.51
        }
    },
    ["head"] = {
        name = "Momentum",
        description = "Reduces cooldown of secondary group spells by 2 seconds when logout block is active",
        activationChances = {
            [1] = 2.00, [2] = 4.05, [3] = 6.20, [4] = 8.45, [5] = 10.80,
            [6] = 13.25, [7] = 15.80, [8] = 18.45, [9] = 21.20, [10] = 24.05
        }
    },
    ["legs"] = {
        name = "Transcendence",
        description = "Activates vocation's level 3 avatar for a shorter period",
        activationChances = {
            [1] = 0.13, [2] = 0.27, [3] = 0.44, [4] = 0.64, [5] = 0.86,
            [6] = 1.11, [7] = 1.38, [8] = 1.68, [9] = 2.00, [10] = 2.35
        }
    },
    ["feet"] = {
        name = "Amplification",
        description = "Amplifies the effect of tiered items, increasing their activation chance",
        activationChances = {
            [1] = 2.50, [2] = 5.40, [3] = 9.10, [4] = 13.60, [5] = 18.90,
            [6] = 25.00, [7] = 31.90, [8] = 39.60, [9] = 48.10, [10] = 57.40
        }
    },
    ["necklace"] = {
        name = "Lucky Drop",
        description = "Increases drop rate from monsters",
        dropBoost = {
            [1] = 5, [2] = 10, [3] = 15, [4] = 20, [5] = 25,
            [6] = 30, [7] = 35, [8] = 40, [9] = 45, [10] = 50
        }
    }
}

local slotToAbility = {
    ["hand"] = "onslaught",
    ["armor"] = "ruse", 
    ["head"] = "momentum",
    ["legs"] = "transcendence",
    ["feet"] = "amplification",
    ["necklace"] = "lucky_drop"
}

local function getActivationChance(abilityType, tier)
    local slot = nil
    for slotName, ability in pairs(slotToAbility) do
        if ability == abilityType then
            slot = slotName
            break
        end
    end
    
    if not slot or not abilityConfig[slot] then
        return 0
    end
    
    return abilityConfig[slot].activationChances[tier] or 0
end

local function getDropBoost(tier)
    return abilityConfig["necklace"].dropBoost[tier] or 0
end

local function isWeapon(item)
    if not item then
        return false
    end
    local attack = item:getAttack()
    return attack > 0
end

local function calculateTotalChance(player, baseChance, abilityType)
    if abilityType == "amplification" then
        return baseChance
    end
    
    local boots = player:getSlotItem(CONST_SLOT_FEET)
    if boots then
        local bootsTier = boots:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if bootsTier > 0 then
            local amplificationChance = getActivationChance("amplification", bootsTier)
            -- Amplification aumenta a chance em 50% do seu valor
            local amplificationBonus = (amplificationChance * 0.5) / 100
            baseChance = baseChance * (1 + amplificationBonus)
        end
    end
    
    return baseChance
end

local dodgeStorage = 45001
local dodgeCooldownStorage = 45002
local conditionSubId = 45083

local tierConfig = {
        maxTier = 10,
    
    classifications = {
        [0] = "Base",
        [1] = "Improved", 
        [2] = "Exalted"
    },
    
    dodgePerTier = 50,
    
    statsPerTier = {}
}

local tierableItems = {
    [2160] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2161] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2162] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2163] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2164] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2400] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2401] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2402] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2403] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    [2404] = {maxTier = 10, maxClassification = 2, slot = "hand"},
    
    [2165] = {maxTier = 10, maxClassification = 2, slot = "head"},
    [2494] = {maxTier = 10, maxClassification = 2, slot = "armor"},
    [2495] = {maxTier = 10, maxClassification = 2, slot = "legs"},
    [2168] = {maxTier = 10, maxClassification = 2, slot = "feet"},
    
    [2169] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2170] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2171] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2172] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2173] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2174] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2175] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2176] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2177] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2178] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2179] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    [2180] = {maxTier = 10, maxClassification = 1, slot = "necklace"},
    
    [2181] = {maxTier = 10, maxClassification = 1, slot = "ring"},
    [2182] = {maxTier = 10, maxClassification = 1, slot = "backpack"},
    [2183] = {maxTier = 10, maxClassification = 1, slot = "ammo"}
}

local upgradeItems = {
    [8302] = {type = "reset"},
    [8303] = {type = "tier_upgrade"},
    [8304] = {type = "classification_upgrade"},
    [8305] = {type = "stat_boost", stat = "dodge_bonus", value = 50},
    [8306] = {type = "stat_boost", stat = "speed", value = 10}
}


local function getMaxTierForItem(itemId)
    local item = tierableItems[itemId]
    return item and item.maxTier or 0
end

local function getMaxClassificationForItem(itemId)
    local item = tierableItems[itemId]
    return item and item.maxClassification or 0
end

local function getItemTier(tier)
    local itemInfo = {
        TIER0 = {chance = 80},
        TIER1 = {chance = 70},
        TIER2 = {chance = 65},
        TIER3 = {chance = 60},
        TIER4 = {chance = 50},
        TIER5 = {chance = 40},
        TIER6 = {chance = 35},
        TIER7 = {chance = 25},
        TIER8 = {chance = 15},
        TIER9 = {chance = 7},
        TIER10 = {chance = 5}
    }
    local key = "TIER" .. tier
    return itemInfo[key] or {chance = 0}
end

local function getItemClassification(itemId)
    local item = tierableItems[itemId]
    return item and item.maxClassification or 0
end

local function getItemSlot(itemId)
    local item = tierableItems[itemId]
    return item and item.slot or nil
end

local function getClassificationName(classification)
    return tierConfig.classifications[classification] or "Base"
end

local function isItemTierable(item)
    if not item:isItem() then
        return false
    end
    local itemId = item:getId()
    
    if not tierableItems[itemId] then
        return false
    end
    
    local itemType = item:getType()
    local xmlClassification = itemType.classification or 0
    
    return true
end

local function calculateUpgradeChance(currentTier)
    local tierInfo = getItemTier(currentTier)
    return tierInfo.chance or 0
end

local function getItemCustomAttribute(item, attributeName)
    if not item or not item:isItem() then
        return 0
    end
    return item:getCustomAttribute(attributeName) or 0
end

local function setItemCustomAttribute(item, attributeName, value)
    if not item or not item:isItem() then
        return false
    end
    item:setCustomAttribute(attributeName, value)
    return true
end

local function removeItemCustomAttribute(item, attributeName)
    if not item or not item:isItem() then
        return false
    end
    item:removeCustomAttribute(attributeName)
    return true
end


local function updateDodgeStorage(playerId)
    local player = Player(playerId)
    if not player then
        return
    end
    
    local storageValue = 0
    local slotItem = player:getSlotItem(CONST_SLOT_ARMOR)
    
    if slotItem then
        local tier = slotItem:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            local activationChance = abilityConfig["armor"].activationChances[tier] or 0
            storageValue = math.floor(activationChance * 100)
        end
    end
    
    player:setStorageValue(dodgeStorage, storageValue)
end


local conditions = {
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

local function updateStatBonus(playerId)
    local player = Player(playerId)
    if not player then
        return
    end
    
    if player:getCondition(CONDITION_ATTRIBUTES, conditionSubId) then
        player:removeCondition(CONDITION_ATTRIBUTES, conditionSubId)
    end
    if player:getCondition(CONDITION_HASTE, conditionSubId) then
        player:removeCondition(CONDITION_HASTE, conditionSubId)
    end
end


local equipEvent = MoveEvent()
function equipEvent.onEquip(player, item, slot, isCheck)
    if not isCheck then
        local tier = item:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            local slotName = getItemSlot(item:getId())
            if slotName == "armor" then
                local activationChance = abilityConfig["armor"].activationChances[tier] or 0
                local currentValue = player:getStorageValue(dodgeStorage) or 0
                local newValue = currentValue + math.floor(activationChance * 100)
                player:setStorageValue(dodgeStorage, newValue)
            end
        end
        addEvent(updateStatBonus, 100, player:getId())
    end
    return true
end
equipEvent:register()

local deEquipEvent = MoveEvent()
function deEquipEvent.onDeEquip(player, item, slot, isCheck)
    if not isCheck then
        local slotName = getItemSlot(item:getId())
        if slotName == "armor" then
            local tier = item:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
            local activationChance = abilityConfig["armor"].activationChances[tier] or 0
            local currentValue = player:getStorageValue(dodgeStorage) or 0
            local newValue = currentValue - math.floor(activationChance * 100)
            player:setStorageValue(dodgeStorage, newValue)
        end
        addEvent(updateStatBonus, 100, player:getId())
    end
    return true
end
deEquipEvent:register()


local dodgeHealthChange = CreatureEvent("onHealthChange_dodgeChance")
function dodgeHealthChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local storageValue = creature:getStorageValue(dodgeStorage) or 0
    local rand = math.random(10000)
    if storageValue > 0 and rand <= storageValue then
        primaryDamage = 0
        secondaryDamage = 0
        creature:getPosition():sendMagicEffect(CONST_ME_DODGE)
        creature:say("Dodged!", TALKTYPE_MONSTER_SAY)
    end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
dodgeHealthChange:register()

local dodgeManaChange = CreatureEvent("onManaChange_dodgeChance")
function dodgeManaChange.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local storageValue = creature:getStorageValue(dodgeStorage) or 0
    local rand = math.random(10000)
    if storageValue > 0 and rand <= storageValue then
        primaryDamage = 0
        secondaryDamage = 0
        creature:getPosition():sendMagicEffect(CONST_ME_DODGE)
        creature:say("Dodged!", TALKTYPE_MONSTER_SAY)
    end
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
dodgeManaChange:register()


local Onslaught1 = CreatureEvent("Onslaught1")
function Onslaught1.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature or not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local player = attacker:getPlayer()
    local leftWeapon = player:getSlotItem(CONST_SLOT_LEFT)
    local rightWeapon = player:getSlotItem(CONST_SLOT_RIGHT)
    
    local weapon = leftWeapon or rightWeapon
    if not weapon then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    if not isWeapon(weapon) then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local tier = weapon:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    if tier == 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local activationChance = abilityConfig["hand"].activationChances[tier] or 0
    if activationChance > 0 and math.random(100) <= (activationChance * 100) then
        local damageBoost = math.floor(primaryDamage * 0.60)
        primaryDamage = primaryDamage + damageBoost
        creature:getPosition():sendMagicEffect(CONST_ME_FATAL)
        player:say("Onslaught!", TALKTYPE_MONSTER_SAY)
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
Onslaught1:register()

local Onslaught2 = CreatureEvent("Onslaught2")
function Onslaught2.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature or not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local player = attacker:getPlayer()
    local leftWeapon = player:getSlotItem(CONST_SLOT_LEFT)
    local rightWeapon = player:getSlotItem(CONST_SLOT_RIGHT)
    
    local weapon = leftWeapon or rightWeapon
    if not weapon then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    if not isWeapon(weapon) then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local tier = weapon:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    if tier == 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end

    local activationChance = abilityConfig["hand"].activationChances[tier] or 0
    if activationChance > 0 and math.random(100) <= (activationChance * 100) then
        local damageBoost = math.floor(primaryDamage * 0.60)
        primaryDamage = primaryDamage + damageBoost
        creature:getPosition():sendMagicEffect(CONST_ME_FATAL)
        player:say("Onslaught!", TALKTYPE_MONSTER_SAY)
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
Onslaught2:register()

local momentumHealthChange = CreatureEvent("onHealthChange_momentum")
function momentumHealthChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    if primaryDamage > 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local helmet = creature:getSlotItem(CONST_SLOT_HEAD)
    if helmet then
        local tier = helmet:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            handleMomentum(creature)
        end
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
momentumHealthChange:register()

local momentumManaChange = CreatureEvent("onManaChange_momentum")
function momentumManaChange.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    if primaryDamage > 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local helmet = creature:getSlotItem(CONST_SLOT_HEAD)
    if helmet then
        local tier = helmet:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            handleMomentum(creature)
        end
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
momentumManaChange:register()

local avatarOutfits = {
    ["knight"] = { lookType = 1823 },
    ["paladin"] = { lookType = 1824 },
    ["sorcerer"] = { lookType = 1825 },
    ["druid"] = { lookType = 1826 }
}

local avatarDurations = {
    [1] = 5000, [2] = 6000, [3] = 7000, [4] = 8000, [5] = 9000,
    [6] = 10000, [7] = 11000, [8] = 12000, [9] = 13000, [10] = 14000
}

local function handleMomentum(player)
    local helmet = player:getSlotItem(CONST_SLOT_HEAD)
    if not helmet then
        return false
    end

    local tier = helmet:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    if tier == 0 then
        return false
    end

    local activationChance = abilityConfig["head"].activationChances[tier] or 0
    if math.random(100) <= (activationChance * 100) then
        local hasteCondition = Condition(CONDITION_HASTE)
        hasteCondition:setParameter(CONDITION_PARAM_TICKS, 5000)
        hasteCondition:setParameter(CONDITION_PARAM_SPEED, 50)
        player:addCondition(hasteCondition)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:say("Momentum!", TALKTYPE_MONSTER_SAY)
        return true
    end

    return false
end

local function handleTranscendence(player)
    local legs = player:getSlotItem(CONST_SLOT_LEGS)
    if not legs then
        return false
    end
    
    local tier = legs:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    
    -- Só funciona se tier for 3 ou mais
    if tier < 3 then
        return false
    end
    
    if player:getCondition(CONDITION_OUTFIT) then
        return false
    end
    
    -- Chance baseada no tier (Tier 3 = 5%)
    local chance = 0
    if tier == 3 then
        chance = 5.0
    elseif tier == 4 then
        chance = 8.0
    elseif tier == 5 then
        chance = 12.0
    elseif tier == 6 then
        chance = 16.0
    elseif tier == 7 then
        chance = 20.0
    elseif tier == 8 then
        chance = 25.0
    elseif tier == 9 then
        chance = 30.0
    elseif tier == 10 then
        chance = 35.0
    end
    
    if math.random(100) <= chance then
        local vocation = player:getVocation():getName():lower()
        local outfit = avatarOutfits[vocation] or avatarOutfits["knight"]
        local duration = 7000 -- 7 segundos fixo
        
        local conditionOutfit = Condition(CONDITION_OUTFIT)
        conditionOutfit:setOutfit(outfit)
        conditionOutfit:setParameter(CONDITION_PARAM_TICKS, duration)
        player:addCondition(conditionOutfit)
        
        local conditionBuffs = Condition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT)
        conditionBuffs:setParameter(CONDITION_PARAM_TICKS, duration)
        conditionBuffs:setParameter(CONDITION_PARAM_STAT_PERCENTDAMAGE, 85)
        conditionBuffs:setParameter(CONDITION_PARAM_SPECIALSKILL_CRITICALHITPERCENT, 100)
        conditionBuffs:setParameter(CONDITION_PARAM_SPECIALSKILL_CRITICALHITAMOUNT, 1500)
        player:addCondition(conditionBuffs)
        
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
        player:say("Transcendence!", TALKTYPE_MONSTER_SAY)
        
        return true
    end
    
    return false
end

local function tryActivateTranscendence(player)
    local legs = player:getSlotItem(CONST_SLOT_LEGS)
    if not legs then
        return false
    end
    
    local tier = legs:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    
    if tier < 3 then
        return false
    end
    
    return handleTranscendence(player)
end

local function handleAmplification(player)
    local boots = player:getSlotItem(CONST_SLOT_FEET)
    if not boots then
        return false
    end

    local tier = boots:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    if tier == 0 then
        return false
    end

    local activationChance = abilityConfig["feet"].activationChances[tier] or 0
    if math.random(100) <= (activationChance * 100) then
        local condition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT)
        condition:setParameter(CONDITION_PARAM_TICKS, 10000)
        condition:setParameter(CONDITION_PARAM_SPECIALSKILL_CRITICALHITCHANCE, 25)
        condition:setParameter(CONDITION_PARAM_SPECIALSKILL_CRITICALHITAMOUNT, 500)
        player:addCondition(condition)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        player:say("Amplification!", TALKTYPE_MONSTER_SAY)
        return true
    end

    return false
end

local transcendenceHealthChange = CreatureEvent("onHealthChange_transcendence")
function transcendenceHealthChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    if primaryDamage > 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local legs = creature:getSlotItem(CONST_SLOT_LEGS)
    if legs then
        local tier = legs:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            handleTranscendence(creature)
        end
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
transcendenceHealthChange:register()

local transcendenceManaChange = CreatureEvent("onManaChange_transcendence")
function transcendenceManaChange.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    if primaryDamage > 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local legs = creature:getSlotItem(CONST_SLOT_LEGS)
    if legs then
        local tier = legs:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            handleTranscendence(creature)
        end
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
transcendenceManaChange:register()

local transcendenceAttackEvent = CreatureEvent("onHealthChange_transcendence_attack")
function transcendenceAttackEvent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    tryActivateTranscendence(attacker)
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
transcendenceAttackEvent:register()

local transcendenceManaAttackEvent = CreatureEvent("onManaChange_transcendence_attack")
function transcendenceManaAttackEvent.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not attacker or not attacker:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    tryActivateTranscendence(attacker)
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
transcendenceManaAttackEvent:register()



local amplificationHealthChange = CreatureEvent("onHealthChange_amplification")
function amplificationHealthChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    if primaryDamage > 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local boots = creature:getSlotItem(CONST_SLOT_FEET)
    if boots then
        local tier = boots:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            handleAmplification(creature)
        end
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
amplificationHealthChange:register()

local amplificationManaChange = CreatureEvent("onManaChange_amplification")
function amplificationManaChange.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if not creature:isPlayer() then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    if primaryDamage > 0 then
        return primaryDamage, primaryType, secondaryDamage, secondaryType
    end
    
    local boots = creature:getSlotItem(CONST_SLOT_FEET)
    if boots then
        local tier = boots:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            handleAmplification(creature)
        end
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
amplificationManaChange:register()

local NecklaceDropBoost = Event()
NecklaceDropBoost.onDropLoot = function(self, corpse)
    local mType = self:getType()
    if configManager.getNumber(configKeys.RATE_LOOT) == 0 then
        return
    end
    
    local player = Player(corpse:getCorpseOwner())
    if not player then
        return false
    end
    
    if player:getStamina() > 840 then
        local necklace = player:getSlotItem(CONST_SLOT_NECKLACE)
        if necklace then
            local tier = necklace:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
            if tier > 0 then
                local dropBoost = getDropBoost(tier)
                if dropBoost > 0 then
                    player:sendTextMessage(MESSAGE_STATUS_DEFAULT, 
                        string.format("[Lucky Necklace] You have a tier %d necklace with +%d%% Drop Boost!", 
                        tier, dropBoost))
                    
                    corpse:getPosition():sendMagicEffect(CONST_ME_TUTORIALARROW)
                    corpse:getPosition():sendMagicEffect(CONST_ME_TUTORIALSQUARE)
                    
                    local rate = dropBoost / 10 * configManager.getNumber(configKeys.RATE_LOOT)
                    local monsterLoot = mType:getLoot()
                    
                    for i = 1, #monsterLoot do
                        local item = monsterLoot[i]
                        if math.random(100) <= rate then
                            local count = item.maxCount > 1 and math.random(item.maxCount) or 1
                            corpse:addItem(item.itemId, count)
                        end
                    end
                end
            end
        end
    end
    
    return true
end
NecklaceDropBoost:register(-1)

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not isItemTierable(target) then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Este item não pode receber upgrades de tier.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF, player)
        return true
    end
    
    local upgradeItem = upgradeItems[item:getId()]
    if not upgradeItem then
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Item de upgrade inválido.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF, player)
        return true
    end
  
    local itemId = target:getId()
    local maxTier = getMaxTierForItem(itemId)
    local maxClassification = getMaxClassificationForItem(itemId)
    local currentTier = target:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    local currentClassification = target:getAttribute(ITEM_ATTRIBUTE_CLASSIFICATION) or 0
    
    if upgradeItem.type == "reset" then
        if currentTier == 0 and currentClassification == 0 then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Este item não possui tier ou classificação para resetar.")
            target:getPosition():sendMagicEffect(CONST_ME_POFF, player)
            return true
        end
        
        for statName, _ in pairs(conditions) do
            target:removeCustomAttribute(statName)
        end
        target:removeAttribute(ITEM_ATTRIBUTE_TIER)
        target:removeAttribute(ITEM_ATTRIBUTE_CLASSIFICATION)
        target:removeCustomAttribute("dodge_bonus")
        
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE, player)
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Tier e classificação resetados com sucesso!")
        item:remove(1)
        
        if toPosition.x == CONTAINER_POSITION and toPosition.y <= 10 then
            addEvent(updateDodgeStorage, 100, player:getId())
            addEvent(updateStatBonus, 100, player:getId())
        end
        return true
    end
  
    if upgradeItem.type == "tier_upgrade" then
        local itemType = target:getType()
        local xmlClassification = itemType.classification or 0
        
        if currentTier >= maxTier then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Este item já atingiu o tier máximo (" .. maxTier .. ").")
            target:getPosition():sendMagicEffect(CONST_ME_POFF, player)
            return true
        end
        
        local successChance = calculateUpgradeChance(currentTier)
        
        local rand = math.random(100)
        
        if rand <= successChance then
            target:setAttribute(ITEM_ATTRIBUTE_TIER, currentTier + 1)
            target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN, player)
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Upgrade bem-sucedido! Tier aumentado para " .. (currentTier + 1) .. "!")
        else
            target:getPosition():sendMagicEffect(CONST_ME_POFF, player)
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Upgrade falhou! Chance era de " .. successChance .. "%")
        end
        
        item:remove(1)
        
        if toPosition.x == CONTAINER_POSITION and toPosition.y <= 10 then
            addEvent(updateDodgeStorage, 100, player:getId())
            addEvent(updateStatBonus, 100, player:getId())
        end
        return true
    end
  
    if upgradeItem.type == "classification_upgrade" then
        local itemType = target:getType()
        local xmlClassification = itemType.classification or 0
        
        if currentClassification >= maxClassification then
            player:sendTextMessage(MESSAGE_STATUS_SMALL, "Este item já está na classificação máxima (" .. getClassificationName(maxClassification) .. ").")
            target:getPosition():sendMagicEffect(CONST_ME_POFF, player)
            return true
        end
        
        target:setAttribute(ITEM_ATTRIBUTE_CLASSIFICATION, currentClassification + 1)
        target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN, player)
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Upgrade de classificação realizado! Nova classificação: " .. getClassificationName(currentClassification + 1))
        
        item:remove(1)
        return true
    end
    
    if upgradeItem.type == "stat_boost" then
        local currentStat = target:getCustomAttribute(upgradeItem.stat) or 0
        target:setCustomAttribute(upgradeItem.stat, currentStat + upgradeItem.value)
  
    target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN, player)
        player:sendTextMessage(MESSAGE_STATUS_SMALL, "Stat " .. upgradeItem.stat .. " aumentado!")
    item:remove(1)
  
    if toPosition.x == CONTAINER_POSITION and toPosition.y <= 10 then
            addEvent(updateStatBonus, 100, player:getId())
        end
        return true
    end
    
    return true
end

for itemId, _ in pairs(upgradeItems) do
    action:id(itemId)
end
action:register()

local loginEvent = CreatureEvent("onLogin_updateTierSystem")
function loginEvent.onLogin(player)
    player:registerEvent("onHealthChange_dodgeChance")
    player:registerEvent("onManaChange_dodgeChance")
    player:registerEvent("Onslaught1")
    player:registerEvent("Onslaught2")
    player:registerEvent("onHealthChange_momentum")
    player:registerEvent("onManaChange_momentum")
    player:registerEvent("onHealthChange_amplification")
    player:registerEvent("onManaChange_amplification")
    player:registerEvent("onHealthChange_transcendence_attack")
    player:registerEvent("onManaChange_transcendence_attack")
    
    for slot = 1, 10 do
        local slotItem = player:getSlotItem(slot)
        if slotItem then
            local tier = slotItem:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
            if tier > 0 then
                local slotName = getItemSlot(slotItem:getId())
                if slotName == "armor" then
                    -- Armor is handled by updateDodgeStorage
                end
            end
        end
    end
    
    addEvent(updateDodgeStorage, 100, player:getId())
    addEvent(updateStatBonus, 100, player:getId())
    return true
end
loginEvent:register()

local ec = Event()
ec.onMoveItem = function(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    if not (toPosition.x == CONTAINER_POSITION and toPosition.y <= 10 or fromPosition.x == CONTAINER_POSITION and fromPosition.y <= 10) then
        return RETURNVALUE_NOERROR
    end
    addEvent(updateDodgeStorage, 100, self:getId())
    addEvent(updateStatBonus, 100, self:getId())
    return RETURNVALUE_NOERROR
end
ec:register()

local onSpawn = Event()
function onSpawn.onSpawn(creature, position, startup, artificial)
    if creature:isMonster() then
        creature:registerEvent("Onslaught1")
        creature:registerEvent("onHealthChange_transcendence_attack")
    end
    return true
end
onSpawn:register(-666)