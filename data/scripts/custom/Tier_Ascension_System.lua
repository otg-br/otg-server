
dofile('data/lib/core/tier_ability_config.lua')
print(">> Tier Ascension System Loaded")

--[[
    ========================================
    TIER UPGRADE SYSTEM + ABILITIES + NECKLACE DROP BOOST
    ========================================
]]

--[[
    Developed by: Mateus Roberto (mateuskl)
    Date: 30/07/2025
    Version: v1.2
    
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
    
    REFACTORED SYSTEM:
    - Unified onHealthChange and onManaChange functions
    - Configuration moved to lib/core/tier_ability_config.lua
    - Reduced code duplication
    - Better maintainability
    
    ========================================
]]

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
            local amplificationChance = TierSystem.getActivationChance("amplification", bootsTier)
            -- Amplification aumenta a chance em 50% do seu valor
            local amplificationBonus = (amplificationChance * 0.5) / 100
            baseChance = baseChance * (1 + amplificationBonus)
        end
    end
    
    return baseChance
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
            local activationChance = TierSystem.abilityConfig["armor"].activationChances[tier] or 0
            storageValue = math.floor(activationChance * 100)
        end
    end
    
    player:setStorageValue(TierSystem.storageIds.dodgeStorage, storageValue)
end

local function updateStatBonus(playerId)
    local player = Player(playerId)
    if not player then
        return
    end
    
    if player:getCondition(CONDITION_ATTRIBUTES, TierSystem.storageIds.conditionSubId) then
        player:removeCondition(CONDITION_ATTRIBUTES, TierSystem.storageIds.conditionSubId)
    end
    if player:getCondition(CONDITION_HASTE, TierSystem.storageIds.conditionSubId) then
        player:removeCondition(CONDITION_HASTE, TierSystem.storageIds.conditionSubId)
    end
end

local function applyAbilityEffect(player, slot, abilityEffect, tier)
    if abilityEffect == "onslaught" then
        return true
    elseif abilityEffect == "ruse" then
        return true
    elseif abilityEffect == "momentum" then
        local helmet = player:getSlotItem(CONST_SLOT_HEAD)
        if not helmet then
            return false
        end

        local tier = helmet:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier == 0 then
            return false
        end

        if getTilePzInfo(player:getPosition()) then
            local currentReduction = player:getHelmetCooldownReduction()
            if currentReduction > 0 then
                player:setHelmetCooldownReduction(0)
            end
            return false
        end

        local currentReduction = player:getHelmetCooldownReduction()
        if currentReduction > 0 then
            return false
        end

        local cooldownReduction = 2000
        player:setHelmetCooldownReduction(cooldownReduction)
        
        player:getPosition():sendMagicEffect(232) -- Efeito momentum
        return true
        
    elseif abilityEffect == "transcendence" then
        -- Transcendence effect
        local legs = player:getSlotItem(CONST_SLOT_LEGS)
        if not legs then
            return false
        end
        
        local tier = legs:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        
        if tier < 3 then
            return false
        end
        
        if player:getCondition(CONDITION_OUTFIT) then
            return false
        end
        
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
            local outfit = TierSystem.avatarOutfits[vocation] or TierSystem.avatarOutfits["knight"]
            local duration = TierSystem.avatarDuration
            
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
        
    elseif abilityEffect == "amplification" then
        -- Amplification effect
        local boots = player:getSlotItem(CONST_SLOT_FEET)
        if not boots then
            return false
        end

        local tier = boots:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier == 0 then
            return false
        end

        local activationChance = TierSystem.abilityConfig["feet"].activationChances[tier] or 0
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
    
    return false
end

local function processAbilities(player, isAttacker)
    local slots = {"hand", "head", "legs", "feet"}
    
    for _, slotName in pairs(slots) do
        local slotConstants = TierSystem.slotToConstant[slotName]
        if slotConstants then
            for _, slotConst in ipairs(slotConstants) do
                local item = player:getSlotItem(slotConst)
                if item then
                    local tier = item:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
                    if tier > 0 then
                        local ability = TierSystem.abilityConfig[slotName]
                        if ability then
                            local activationChance = ability.activationChances[tier] or 0
                            if activationChance > 0 and math.random(100) <= (activationChance * 100) then
                                applyAbilityEffect(player, slotName, ability.effect, tier)
                            end
                        end
                    end
                end
            end
        end
    end
end

local function onHealthOrManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin, isMana)
    local player = isMana and attacker or creature
    
    if not isMana and creature:isPlayer() then
        local storageValue = creature:getStorageValue(TierSystem.storageIds.dodgeStorage) or 0
        local rand = math.random(10000)
        if storageValue > 0 and rand <= storageValue then
            primaryDamage = 0
            secondaryDamage = 0
            creature:getPosition():sendMagicEffect(249) -- Efeito dodge
            return primaryDamage, primaryType, secondaryDamage, secondaryType
        end
    end
    
    if attacker and attacker:isPlayer() then
        local leftWeapon = attacker:getSlotItem(CONST_SLOT_LEFT)
        local rightWeapon = attacker:getSlotItem(CONST_SLOT_RIGHT)
        
        local weapon = leftWeapon or rightWeapon
        if weapon and isWeapon(weapon) then
            local tier = weapon:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
            if tier > 0 then
                local activationChance = TierSystem.abilityConfig["hand"].activationChances[tier] or 0
                if activationChance > 0 and math.random(100) <= (activationChance * 100) then
                    local damageBoost = math.floor(primaryDamage * 0.60)
                    primaryDamage = primaryDamage + damageBoost
                    creature:getPosition():sendMagicEffect(230) -- Efeito fatal
                    attacker:say("Onslaught!", TALKTYPE_MONSTER_SAY)
                end
            end
        end
    end
    
    if player and player:isPlayer() then
        processAbilities(player, isMana)
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end

local healthChangeEvent = CreatureEvent("onHealthChange_unified")
function healthChangeEvent.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    return onHealthOrManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin, false)
end
healthChangeEvent:register()

local manaChangeEvent = CreatureEvent("onManaChange_unified")
function manaChangeEvent.onManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    return onHealthOrManaChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin, true)
end
manaChangeEvent:register()

local equipEvent = MoveEvent()
function equipEvent.onEquip(player, item, slot, isCheck)
    if not isCheck then
        local tier = item:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
        if tier > 0 then
            local slotName = TierSystem.getItemSlot(item:getId())
            if slotName == "armor" then
                local activationChance = TierSystem.abilityConfig["armor"].activationChances[tier] or 0
                local currentValue = player:getStorageValue(TierSystem.storageIds.dodgeStorage) or 0
                local newValue = currentValue + math.floor(activationChance * 100)
                player:setStorageValue(TierSystem.storageIds.dodgeStorage, newValue)
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
        local slotName = TierSystem.getItemSlot(item:getId())
        if slotName == "armor" then
            local tier = item:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
            local activationChance = TierSystem.abilityConfig["armor"].activationChances[tier] or 0
            local currentValue = player:getStorageValue(TierSystem.storageIds.dodgeStorage) or 0
            local newValue = currentValue - math.floor(activationChance * 100)
            player:setStorageValue(TierSystem.storageIds.dodgeStorage, newValue)
        end
        addEvent(updateStatBonus, 100, player:getId())
    end
    return true
end
deEquipEvent:register()

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
                local dropBoost = TierSystem.getDropBoost(tier)
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
    if not TierSystem.isItemTierable(target) then
        player:sendTextMessage(MESSAGE_EVENT_ORANGE, "This item cannot receive tier upgrades.")
        player:getPosition():sendMagicEffect(285) -- Efeito falha
        return true
    end
    
    local upgradeItem = TierSystem.upgradeItems[item:getId()]
    if not upgradeItem then
        player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Invalid upgrade item.")
        player:getPosition():sendMagicEffect(285) -- Efeito falha
        return true
    end
  
    local itemId = target:getId()
    local maxTier = TierSystem.getMaxTierForItem(itemId)
    local currentTier = target:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
    local currentClassification = target:getAttribute(ITEM_ATTRIBUTE_CLASSIFICATION) or 0
    
    if upgradeItem.type == "reset" then
        if currentTier == 0 and currentClassification == 0 then
            player:sendTextMessage(MESSAGE_EVENT_ORANGE, "This item does not have a tier or classification to reset.")
            target:getPosition():sendMagicEffect(285) -- Efeito falha
            return true
        end
        
        for statName, _ in pairs(TierSystem.conditions) do
            target:removeCustomAttribute(statName)
        end
        target:removeAttribute(ITEM_ATTRIBUTE_TIER)
        target:removeAttribute(ITEM_ATTRIBUTE_CLASSIFICATION)
        target:removeCustomAttribute("dodge_bonus")
        
        target:getPosition():sendMagicEffect(252) -- Efeito sucesso
        player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Tier and classification reset successfully!")
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
        
        local ammoSlotItem = player:getSlotItem(CONST_SLOT_AMMO)
        if not ammoSlotItem or ammoSlotItem:getId() ~= target:getId() then
            player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Place the item you want to upgrade in the ammo slot first.")
            target:getPosition():sendMagicEffect(285) -- Efeito falha
            return true
        end
        
        if currentTier >= maxTier then
            player:sendTextMessage(MESSAGE_EVENT_ORANGE, "This item has already reached the maximum tier (" .. maxTier .. ").")
            target:getPosition():sendMagicEffect(285) -- Efeito falha
            return true
        end
        
        local requiredItemId = target:getId()
        local requiredTier = currentTier
        local foundRequiredItem = false
        
        local function searchInContainer(container)
            if not container then return false end
            for j = 0, container:getSize() - 1 do
                local containerItem = container:getItem(j)
                if containerItem and containerItem:getId() == requiredItemId then
                    local itemTier = containerItem:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
                    if itemTier == requiredTier then
                        containerItem:remove(1)
                        return true
                    end
                end
            end
            return false
        end
        
        for slot = 1, 10 do
            local container = player:getSlotItem(slot)
            if container and container:isContainer() then
                if searchInContainer(container) then
                    foundRequiredItem = true
                    break
                end
            end
        end
        
        if not foundRequiredItem then
            player:sendTextMessage(MESSAGE_EVENT_ORANGE, "You need an item of the same material and tier " .. requiredTier .. " in your backpack to perform this upgrade.")
            target:getPosition():sendMagicEffect(285) -- Efeito falha
            return true
        end
        
        local successChance = TierSystem.calculateUpgradeChance(currentTier)
        
        local rand = math.random(100)
        
        if rand <= successChance then
            target:setAttribute(ITEM_ATTRIBUTE_TIER, currentTier + 1)
            target:getPosition():sendMagicEffect(252) -- Efeito sucesso
            player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Upgrade successful! Tier increased to " .. (currentTier + 1) .. "!")
        else
            target:getPosition():sendMagicEffect(285) -- Efeito falha
            player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Upgrade failed! Chance was " .. successChance .. "%")
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
        
        if currentClassification >= 2 then
            player:sendTextMessage(MESSAGE_EVENT_ORANGE, "This item is already at the maximum classification (Exalted).")
            target:getPosition():sendMagicEffect(285) -- Efeito falha
            return true
        end
        
        target:setAttribute(ITEM_ATTRIBUTE_CLASSIFICATION, currentClassification + 1)
        target:getPosition():sendMagicEffect(252) -- Efeito sucesso
        player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Classification upgrade successful! New classification: " .. TierSystem.getClassificationName(currentClassification + 1))
        
        item:remove(1)
        return true
    end
    
    if upgradeItem.type == "stat_boost" then
        local currentStat = target:getCustomAttribute(upgradeItem.stat) or 0
        target:setCustomAttribute(upgradeItem.stat, currentStat + upgradeItem.value)
  
        target:getPosition():sendMagicEffect(252) -- Efeito sucesso
        player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Stat " .. upgradeItem.stat .. " increased!")
        item:remove(1)
  
        if toPosition.x == CONTAINER_POSITION and toPosition.y <= 10 then
            addEvent(updateStatBonus, 100, player:getId())
        end
        return true
    end
    
    return true
end

for itemId, _ in pairs(TierSystem.upgradeItems) do
    action:id(itemId)
end
action:register()

local loginEvent = CreatureEvent("onLogin_updateTierSystem")
function loginEvent.onLogin(player)
    player:registerEvent("onHealthChange_unified")
    player:registerEvent("onManaChange_unified")
    
    for slot = 1, 10 do
        local slotItem = player:getSlotItem(slot)
        if slotItem then
            local tier = slotItem:getAttribute(ITEM_ATTRIBUTE_TIER) or 0
            if tier > 0 then
                local slotName = TierSystem.getItemSlot(slotItem:getId())
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
        creature:registerEvent("onHealthChange_unified")
    end
    return true
end
onSpawn:register(-666)