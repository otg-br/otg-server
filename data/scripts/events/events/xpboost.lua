local XP_CONFIG = {
    [7919] = {
        name = "Double XP",
        message = "Double XP active! +100% experience.",
        storage = 800002,
        dailyStorage = 800003,
        multiplier = 2.0,
        duration = 3600, -- 1 hour
        description = "Double XP (100% bonus)"
    },
    [5074] = {
        name = "50% XP Boost",
        message = "50% XP Boost active! +50% experience.",
        storage = 800004,
        dailyStorage = 800005,
        multiplier = 1.5,
        duration = 7200, -- 2 hours
        description = "50% XP Boost (2 hours)"
    }
}

local function activateXPBonus(player, item)
    local itemId = item:getId()
    local itemConfig = XP_CONFIG[itemId]
    
    if not itemConfig then
        return false
    end
    
    local staminaHours = player:getStamina() / 60 
    local storageValue = player:getStorageValue(itemConfig.storage)
    local dailyUseValue = player:getStorageValue(itemConfig.dailyStorage)
    local currentTime = os.time()
    local currentDay = os.date("%Y-%m-%d", currentTime)

    if dailyUseValue > 0 then
        local lastUseDay = os.date("%Y-%m-%d", dailyUseValue)
        if lastUseDay == currentDay then
            player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You already used " .. itemConfig.name .. " today! Come back tomorrow.")
            return false
        end
    end

    if staminaHours < 14 then
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You need at least 14 hours of stamina to activate " .. itemConfig.name .. ".")
        return false
    end

    if storageValue <= currentTime then
        if itemId == 7919 then -- Double XP
            local current50XP = player:getStorageValue(800004)
            if current50XP > currentTime then
                player:setStorageValue(800004, 0)
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "50% XP Boost has been cancelled.")
            end
        elseif itemId == 5074 then -- 50% XP Boost
            local currentDoubleXP = player:getStorageValue(800002)
            if currentDoubleXP > currentTime then
                player:setStorageValue(800002, 0)
                player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Double XP has been cancelled.")
            end
        end
        
        local expirationTime = currentTime + itemConfig.duration
        player:setStorageValue(itemConfig.storage, expirationTime)
        player:setStorageValue(itemConfig.dailyStorage, currentTime) -- Mark as used today
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You received " .. itemConfig.name .. " for hunting!")
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    else
        local timeLeft = storageValue - currentTime
        local hoursLeft = math.floor(timeLeft / 3600)
        local minutesLeft = math.floor((timeLeft % 3600) / 60)
        local secondsLeft = timeLeft % 60

        local timeLeftMessage = "You already have " .. itemConfig.name .. " active. Time remaining: " ..
            string.format("%02d", hoursLeft) .. " hour(s), " ..
            string.format("%02d", minutesLeft) .. " minute(s) and " ..
            string.format("%02d", secondsLeft) .. " second(s) until expiration."
        
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, timeLeftMessage)
    end

    return true
end

local xpBonusAction = Action()
function xpBonusAction.onUse(player, item, fromPosition, target, toPosition)
    return activateXPBonus(player, item)
end

for itemId, _ in pairs(XP_CONFIG) do
    xpBonusAction:id(itemId)
end
xpBonusAction:register()

local xp = Event()
xp.onGainExperience = function(self, source, exp, rawExp)
    -- Check if source exists and is a monster (only apply XP boost for monster kills)
    if not source or not source:isMonster() then
        return exp
    end

    local storageValue = self:getStorageValue(800002) -- Double XP storage
    local storageValue50 = self:getStorageValue(800004) -- 50% XP storage
    local currentTime = os.time()
    
    if storageValue > currentTime then
        exp = exp * 2.0
        self:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Double XP active! +100% experience.")
    elseif storageValue50 > currentTime then
        exp = exp * 1.5
        self:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "50% XP Boost active! +50% experience.")
    end
    
    return exp
end
xp:register()




