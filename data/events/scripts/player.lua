function Player:onBrowseField(position)
    if hasEvent.onBrowseField then
        return Event.onBrowseField(self, position)
    end
    return true
end

local function getHours(seconds)
    return math.floor((seconds / 60) / 60)
end

local function getMinutes(seconds)
    return math.floor(seconds / 60)
end

local function getSeconds(seconds)
    return seconds % 60
end

local function getTime(seconds)
    local hours, minutes = getHours(seconds), getMinutes(seconds)
    if minutes > 59 then
        minutes = minutes - hours * 60
    end

    if minutes < 10 then
        minutes = "0" .. minutes
    end

    return hours .. ":" .. minutes .. "h"
end

-- Convert time to words (e.g., "2 hours 30 minutes and 45 seconds")
local function getTimeInWords(seconds)
    local hours, minutes, seconds = getHours(seconds), getMinutes(seconds), getSeconds(seconds)
    if minutes > 59 then
        minutes = minutes - hours * 60
    end

    local timeString = ''
    if hours > 0 then
        timeString = timeString .. hours .. ' hours '
    end

    timeString = timeString .. minutes .. ' minutes and ' .. seconds .. ' seconds.'
    return timeString
end

function Player:onLook(thing, position, distance)
    local description = ""
    if hasEvent.onLook then
        description = Event.onLook(self, thing, position, distance, description)
    end
    self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInBattleList(creature, distance)
    local description = ""
    if hasEvent.onLookInBattleList then
        description = Event.onLookInBattleList(self, creature, distance, description)
    end
    self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInTrade(partner, item, distance)
    local description = "You see " .. item:getDescription(distance)
    if hasEvent.onLookInTrade then
        description = Event.onLookInTrade(self, partner, item, distance, description)
    end
    self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

function Player:onLookInShop(itemType, count, description)
    local description = "You see " .. description
    if hasEvent.onLookInShop then
        description = Event.onLookInShop(self, itemType, count, description)
    end
    self:sendTextMessage(MESSAGE_INFO_DESCR, description)
end

-- Global table for item anti-spam
if not pushDelay then
    pushDelay = {}
end

-- Global table for creature anti-spam
if not creaturePushDelay then
    creaturePushDelay = {}
end

-- Anti-spam system for moving items
local function antiPush(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    if toPosition.x == CONTAINER_POSITION then
        return true
    end

    local tile = Tile(toPosition)
    if not tile then
        self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        return false
    end

    local playerId = self:getId()
    if not pushDelay[playerId] then
        pushDelay[playerId] = {items = 0, time = 0}
    end

    pushDelay[playerId].items = pushDelay[playerId].items + 1

    local currentTime = os.mtime()
    if pushDelay[playerId].time == 0 then
        pushDelay[playerId].time = currentTime
    elseif pushDelay[playerId].time == currentTime then
        pushDelay[playerId].items = pushDelay[playerId].items + 1
    elseif currentTime > pushDelay[playerId].time then
        pushDelay[playerId].time = 0
        pushDelay[playerId].items = 0
    end

    local maxItemsPerSeconds = configManager.getNumber("maxItemsPerSeconds") or 1
    local exhaustTime = configManager.getNumber("exhaustTime") or 2000

    if pushDelay[playerId].items > maxItemsPerSeconds then
        pushDelay[playerId].time = currentTime + exhaustTime
    end

    if pushDelay[playerId].time > currentTime then
        self:sendCancelMessage("You can't move that item so fast.")
        return false
    end

    return true
end

-- Anti-spam system for pushing creatures
local function antiCreaturePush(self, creature, fromPosition, toPosition)
    local playerId = self:getId()
    if not creaturePushDelay[playerId] then
        creaturePushDelay[playerId] = {pushes = 0, time = 0}
    end

    creaturePushDelay[playerId].pushes = creaturePushDelay[playerId].pushes + 1

    local currentTime = os.mtime()
    if creaturePushDelay[playerId].time == 0 then
        creaturePushDelay[playerId].time = currentTime
    elseif creaturePushDelay[playerId].time == currentTime then
        creaturePushDelay[playerId].pushes = creaturePushDelay[playerId].pushes + 1
    elseif currentTime > creaturePushDelay[playerId].time then
        creaturePushDelay[playerId].time = 0
        creaturePushDelay[playerId].pushes = 0
    end

    local maxCreaturePushesPerSeconds = configManager.getNumber("maxCreaturePushesPerSeconds") or 1
    local creatureExhaustTime = configManager.getNumber("creatureExhaustTime") or 2000

    if creaturePushDelay[playerId].pushes > maxCreaturePushesPerSeconds then
        creaturePushDelay[playerId].time = currentTime + creatureExhaustTime
    end

    if creaturePushDelay[playerId].time > currentTime then
        self:sendCancelMessage("You can't push that creature so fast.")
        return false
    end

    return true
end

function Player:onMoveItem(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    if not antiPush(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder) then
        return false
    end

    if hasEvent.onMoveItem then
        return Event.onMoveItem(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    end

    return true
end

function Player:onItemMoved(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    if hasEvent.onItemMoved then
        Event.onItemMoved(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    end

    -- Loot Analyser only for version 11.x+
    local tile = Tile(fromCylinder:getPosition())
    if tile then
        local corpse = tile:getTopDownItem()
        if corpse then
            local itemType = corpse:getType()
            if itemType:isCorpse() and toPosition.x == CONTAINER_POSITION then
                self:sendLootStats(item)
            end
        end
    end

    local containerIdTo = toPosition.y - 64
    if containerIdTo >= 0 then
        local containerTo = self:getContainerById(containerIdTo)
        if containerTo and isDepot(containerTo:getId()) then
            self:onManageLocker(item, false)
        elseif containerTo and containerTo:getTopParent() and containerTo:getTopParent():getId() == self:getId() then
            local fromContainerId = fromPosition.y - 64
            if fromContainerId >= 0 and isDepot(fromContainerId) then
                self:onManageLocker(item, true)
            end
        end
    end
end

local trainingStorage = 12835

function Player:onMoveCreature(creature, fromPosition, toPosition)
    if not antiCreaturePush(self, creature, fromPosition, toPosition) then
        return false
    end

    if hasEvent.onMoveCreature then
        return Event.onMoveCreature(self, creature, fromPosition, toPosition)
    end

    -- Block pushing players in training (except for GMs)
    if self:getGroup():getId() < 4 then
        if creature:isPlayer() and creature:getStorageValue(trainingStorage) > 0 then
            self:sendCancelMessage("You cannot push a player while they are training.")
            return false
        end
    end

    return true
end

-- Check if a report already exists
local function hasPendingReport(name, targetName, reportType)
    local file = io.open(string.format("data/reports/players/%s-%s-%d.txt", name, targetName, reportType), "r")
    if file then
        io.close(file)
        return true
    else
        return false
    end
end

function Player:onReportRuleViolation(targetName, reportType, reportReason, comment, translation)
    if hasEvent.onReportRuleViolation then
        Event.onReportRuleViolation(self, targetName, reportType, reportReason, comment, translation)
    end
    return true
end

function Player:onReportBug(message, position, category)
    if hasEvent.onReportBug then
        return Event.onReportBug(self, message, position, category)
    end
    return true
end

function Player:onTurn(direction)
    if hasEvent.onTurn then
        return Event.onTurn(self, direction)
    end
    
    if self:getGroup():getId() >= 5 and self:getDirection() == direction then
        local nextPosition = self:getPosition()
        nextPosition:getNextPosition(direction)
        self:teleportTo(nextPosition, true)
    end

    return true
end

function Player:onTradeRequest(target, item)
    if hasEvent.onTradeRequest then
        return Event.onTradeRequest(self, target, item)
    end
    
    self:closeImbuementWindow(target)
    if isInArray(exercise_ids, item.itemid) then
        return false
    end

    return true
end

function Player:onTradeAccept(target, item, targetItem)
    if hasEvent.onTradeAccept then
        return Event.onTradeAccept(self, target, item, targetItem)
    end
    
    self:closeImbuementWindow(target)
    return true
end

function Player:onTradeCompleted(target, item, targetItem, isSuccess)
    if hasEvent.onTradeCompleted then
        Event.onTradeCompleted(self, target, item, targetItem, isSuccess)
    end
end

local soulCondition = Condition(CONDITION_SOUL, CONDITIONID_DEFAULT)
soulCondition:setTicks(4 * 60 * 1000)
soulCondition:setParameter(CONDITION_PARAM_SOULGAIN, 1)

-- Manage stamina consumption
local function useStamina(player)
    local staminaMinutes = player:getStamina()
    if staminaMinutes == 0 then
        return
    end

    local playerId = player:getId()
    if not nextUseStaminaTime[playerId] then
        nextUseStaminaTime[playerId] = 0
    end

    local currentTime = os.time()
    local timePassed = currentTime - nextUseStaminaTime[playerId]
    if timePassed <= 0 then
        return
    end

    if timePassed > 60 then
        if staminaMinutes > 2 then
            staminaMinutes = staminaMinutes - 2
        else
            staminaMinutes = 0
        end
        nextUseStaminaTime[playerId] = currentTime + 120
    else
        staminaMinutes = staminaMinutes - 1
        nextUseStaminaTime[playerId] = currentTime + 60
    end
    player:setStamina(staminaMinutes)
end

-- Manage stamina consumption for XP boost
local function useStaminaXp(player)
    local staminaMinutes = player:getExpBoostStamina() / 60
    if staminaMinutes == 0 then
        return
    end

    local playerId = player:getId()
    local currentTime = os.time()
    local timePassed = currentTime - nextUseXpStamina[playerId]
    if timePassed <= 0 then
        return
    end

    if timePassed > 60 then
        if staminaMinutes > 2 then
            staminaMinutes = staminaMinutes - 2
        else
            staminaMinutes = 0
        end
        nextUseXpStamina[playerId] = currentTime + 120
    else
        staminaMinutes = staminaMinutes - 1
        nextUseXpStamina[playerId] = currentTime + 60
    end
    player:setExpBoostStamina(staminaMinutes * 60)
end

function Player:onGainExperience(source, exp, rawExp)
    if not source or source:isPlayer() then
        if self:getClient().version <= 1100 then
            self:addExpTicks(exp)
        end
        return exp
    end
    
    -- Boost Creature
    local extraXp = 0
    local initialExp = exp
    for _, boosted in ipairs(boostCreature) do
        if source:getName():lower() == boosted.name then
            local extraPercent = boosted.exp
            extraXp = exp * extraPercent / 100
            self:sendTextMessage(MESSAGE_STATUS_DEFAULT, string.format("[Boosted Creature] You gained %d extra experience from a %s.", extraXp, boosted.category))
            break
        end
    end
    exp = exp + extraXp
    
    -- Guild Level System
    if self:getGuild() then
        local rewards = getReward(self:getId()) or {}
        for i = 1, #rewards do
            if rewards[i].type == GUILD_LEVEL_BONUS_EXP then
                exp = exp + (exp * rewards[i].quantity)
                break
            end
        end
    end
    
    -- Soul Regeneration
    local vocation = self:getVocation()
    if self:getSoul() < vocation:getMaxSoul() and exp >= self:getLevel() then
        soulCondition:setParameter(CONDITION_PARAM_SOULTICKS, vocation:getSoulGainTicks() * 1000)
        self:addCondition(soulCondition)
    end
    
    -- Experience Stage Multiplier
    exp = Game.getExperienceStage(self:getLevel()) * exp
    
    -- Call Party:onShareExperience directly
    local party = self:getParty()
    if party then
        exp = party:onShareExperience(exp)
    end
    
    -- Store Bonus and multipliers
    self:updateExpState()
    useStaminaXp(self)
    local grindingBoost = (self:getGrindingXpBoost() > 0) and (exp * 0.5) or 0
    local xpBoost = (self:getStoreXpBoost() > 0) and (exp * 0.5) or 0
    local staminaMultiplier = 1
    local isPremium = configManager.getBoolean(configKeys.FREE_PREMIUM) or self:isPremium()
    local staminaMinutes = self:getStamina()
    
    if configManager.getBoolean(configKeys.STAMINA_SYSTEM) then
        useStamina(self)
        if staminaMinutes > 2400 and isPremium then
            staminaMultiplier = 1.5
        elseif staminaMinutes <= 840 then
            staminaMultiplier = 0.5
        end
    end
    
    local multiplier = (self:getPremiumDays() > os.time()) and 1.10 or 1
    exp = multiplier * exp
    exp = exp + grindingBoost
    exp = exp + xpBoost
    exp = exp * staminaMultiplier
    
    if self:getClient().version <= 1100 then
        self:addExpTicks(exp)
    end
    
    return hasEvent.onGainExperience and Event.onGainExperience(self, source, exp, rawExp) or exp
end

function Player:onLoseExperience(exp)
    local onLoseExperience = EventCallback.onLoseExperience
    return hasEvent.onLoseExperience and Event.onLoseExperience(self, exp) or exp
end

function Player:onGainSkillTries(skill, tries)
    if APPLY_SKILL_MULTIPLIER == false then
        return hasEvent.onGainSkillTries and Event.onGainSkillTries(self, skill, tries) or tries
    end

    if skill == SKILL_MAGLEVEL then
        tries = tries * configManager.getNumber(configKeys.RATE_MAGIC)
        return hasEvent.onGainSkillTries and Event.onGainSkillTries(self, skill, tries) or tries
    end
    tries = tries * configManager.getNumber(configKeys.RATE_SKILL)
    return hasEvent.onGainSkillTries and Event.onGainSkillTries(self, skill, tries) or tries
end

function Player:onRemoveCount(item)
    self:sendWaste(item:getId())
end

function Player:onRequestQuestLog()
    self:sendQuestLog()
end

function Player:onRequestQuestLine(questId)
    self:sendQuestLine(questId)
end

function Player:onStorageUpdate(key, value, oldValue, currentFrameTime)
    self:updateStorage(key, value, oldValue, currentFrameTime)
end

function Player:canBeAppliedImbuement(imbuement, item)
    if hasEvent.canBeAppliedImbuement and not Event.canBeAppliedImbuement(self, imbuement, item) then
        return false
    end
    return true
end

function Player:onApplyImbuement(imbuement, item, slot, protectionCharm)
    if hasEvent.onApplyImbuement and not Event.onApplyImbuement(self, imbuement, item, slot, protectionCharm) then
        return false
    end
    return true
end

function Player:clearImbuement(item, slot)
    if hasEvent.clearImbuement and not Event.clearImbuement(self, item, slot) then
        return false
    end
    return true
end

function Player:onCombat(target, item, primaryDamage, primaryType, secondaryDamage, secondaryType)
    if hasEvent.onCombat then
        return Event.onCombat(self, target, item, primaryDamage, primaryType, secondaryDamage, secondaryType)
    end
end

function Player:onWrapItem(item)
    local topCylinder = item:getTopParent()
    if not topCylinder then
        return
    end

    local tile = Tile(topCylinder:getPosition())
    if not tile then
        return
    end

    local house = tile:getHouse()
    if not house then
        self:sendCancelMessage("You can only wrap and unwrap this item inside a house.")
        return
    end

    if house ~= self:getHouse() and not string.find(house:getAccessList(SUBOWNER_LIST):lower(), "%f[%a]" .. self:getName():lower() .. "%f[%A]") then
        self:sendCancelMessage("You cannot wrap or unwrap items from a house, which you are only guest to.")
        return
    end

    local wrapId = item:getAttribute("wrapid")
    if wrapId == 0 then
        return
    end

    if not hasEvent.onWrapItem or Event.onWrapItem(self, item) then
        local oldId = item:getId()
        item:remove(1)
        local item = tile:addItem(wrapId)
        if item then
            item:setAttribute("wrapid", oldId)
        end
    end
end