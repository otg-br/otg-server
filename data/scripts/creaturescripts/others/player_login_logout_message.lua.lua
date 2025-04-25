local loginMessage = CreatureEvent("loginMessage")

-- Training storage definition
local isTrainingStorage = 12835

-- Function to add initial items for new players
local function confirmAddItem(playerid)
    local config = {
        -- club, coat, boots, gloves
        items = {{2398, 1}, {2461, 1}, {2467, 1}, {2649, 1}},
        -- container: rope, shovel, red apple
        container = {{2120, 1}, {2554, 1}, {2674, 2}}
    }

    local player = Player(playerid)
    if not player then return end

    local targetVocation = config
    if player:getSlotItem(CONST_SLOT_LEFT) then
        return true
    end

    for i = 1, #targetVocation.items do
        player:addItem(targetVocation.items[i][1], targetVocation.items[i][2])
    end

    local backpack = player:getVocation():getId() == 0 and player:addItem(1987) or player:addItem(1988)
    if not backpack then
        return true
    end

    for i = 1, #targetVocation.container do
        backpack:addItem(targetVocation.container[i][1], targetVocation.container[i][2])
    end

    return true
end

function loginMessage.onLogin(player)
    -- Log to console
    print(string.format("[LOGIN] Player %s has logged in.", player:getName()))

    -- Check training storage
    if player:getStorageValue(isTrainingStorage) >= 1 then
        player:setStorageValue(isTrainingStorage, -1)
    end

    -- Check guild and register events
    local g = player:getGuild()
    if g then
        if player:getLevel() >= CONFIG_GUILD_LEVEL.minLevelToGetPoints then
            player:registerEvent('guildLevel')
        end
        player:registerEvent('guildLevel_e')
    end

    -- Welcome message
    local serverName = configManager.getString(configKeys.SERVER_NAME)
    local loginStr = "Welcome to " .. serverName .. "!"
    if player:getLastLoginSaved() <= 0 then
        addEvent(confirmAddItem, 2000, player:getGuid())
        loginStr = loginStr .. " Please choose your outfit."
        player:setBankBalance(0)

        if player:getSex() == 1 then
            player:setOutfit({lookType = 128, lookHead = 78, lookBody = 106, lookLegs = 58, lookFeet = 76})
        else
            player:setOutfit({lookType = 136, lookHead = 78, lookBody = 106, lookLegs = 58, lookFeet = 76})
        end

        player:sendTutorial(1)
    else
        loginStr = string.format("Your last visit was on %s.", os.sdate("%a %b %d %X %Y", player:getLastLoginSaved()))
        player:sendTextMessage(MESSAGE_EVENT_ORANGE, "Welcome to " .. serverName .. "!")
    end

    player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)

    -- Promotion handling
    local vocation = player:getVocation()
    local promotion = vocation:getPromotion()
    if player:isPremium() then
        local value = player:getStorageValue(PlayerStorageKeys.promotion)
        if value == 1 then
            player:setVocation(promotion)
        end
    elseif not promotion then
        player:setVocation(vocation:getDemotion())
    end

    -- Display Bank Balance
    local balance = player:getBankBalance()
    if balance > 0 then
        local formattedBalance = type(formatNumber) == "function" and formatNumber(balance) or tostring(balance)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "Your Bank Balance is: $" .. formattedBalance .. " gold coins.")
    end

    -- Inbox Notification
    local inboxItems = player:getInbox():getItemHoldingCount()
    if inboxItems > 0 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format(
            "Check your inbox, you have %d item%s.", inboxItems, inboxItems > 1 and "s" or ""
        ))
    end

    -- Boosted Creatures
    local boostMessages = {}
    for _, boosted in ipairs(boostCreature) do
        local categoryMessage
        if boosted.category == "normal" then
            categoryMessage = "Monster (weak)"
        elseif boosted.category == "second" then
            categoryMessage = "Monster (medium)"
        elseif boosted.category == "third" then
            categoryMessage = "Monster (strong)"
        elseif boosted.category == "boss" then
            categoryMessage = "Boss"
        end
        table.insert(boostMessages, string.format("%s: %s [+%d%% exp, +%d%% loot]", 
            categoryMessage, boosted.name, boosted.exp, boosted.loot))
    end

    if #boostMessages > 0 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The following creatures are boosted:\n" ..
            table.concat(boostMessages, "\n") ..
            "\nBoosted monsters grant more loot, experience, and spawn faster.")
    end

    -- Open chat channels
    if player:getClient().version == 1100 then
        player:openChannel(10) -- LOOT CHANNEL
    end

    if player:getGroup():getId() > 5 then
        player:openChannel(3) -- world chat
        player:openChannel(6) -- advertising rook main
    else
        player:openChannel(3) -- world chat
        player:openChannel(5) -- advertising main
    end

    -- Exercise Weapon storages
    player:setStorageValue(37, -1)
    player:setStorageValue(38, -1)

    -- Stamina and XP Stamina
    local playerId = player:getId()
    nextUseStaminaTime[playerId] = 1
    nextUseXpStamina[playerId] = 1

    -- Daily Reward System
    player:initDailyRewardSystem()

    -- Tutor Rules Popup
    if player:getAccountType() == ACCOUNT_TYPE_TUTOR then
        local msg = [[:: Tutor Rules
        1 *> 3 Warnings and you lose the job.
        2 *> No parallel conversations with players in Help; if a player starts offending, simply mute them.
        3 *> Be polite with players in Help and especially in Private, try to assist as much as possible.
        4 *> Always be on time; if you do not have a justification, you will be removed from the staff.
        5 *> Help is only allowed for questions related to Tibia.
        6 *> It is not allowed to disclose time up or assist in quests.
        7 *> You are not allowed to sell items in Help.
        8 *> If a player encounters a bug, ask them to go to the website to submit a ticket and explain in detail.
        9 *> Always keep the Tutors Chat open (required).
        10 *> If you finish your schedule and there is no tutor online, communicate with a CM in-game or on TS and stay in Help until someone logs in, if possible.
        11 *> Always maintain proper English in Help; we want tutors who support, not ones who sound like they are performing a satanic ritual.
        12 *> If you see a tutor violating the rules, take a screenshot and send it to your superiors.
        - Commands -
        Mute Player: /mute nick, 90 (90 seconds)
        Unmute Player: /unmute nick
        - Commands -]]
        player:popupFYI(msg)
    end

    -- GM Time Information
    if player:getGroup():getId() > 5 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "Current server time: " .. os.date("%d.%m.%Y - %X") .. "\nTime with dump: " .. os.sdate("%d.%m.%Y - %X", os.stime()))
    end

    -- Ghost Mode for High-Level Staff
    if player:getGroup():getId() > 4 then
        player:setGhostMode(true)
    end

    -- Rewards Notification
    local rewards = #player:getRewardList()
    if rewards > 0 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You have %d %s in your reward chest.", rewards, rewards > 1 and "rewards" or "reward"))
    end

    -- Update player id in boss fight stats
    local stats = player:inBossFight()
    if stats then
        stats.playerId = player:getId()
    end

    -- Spawn Speed Notification
    if configManager.getDouble(configKeys.SPAWN_SPEED) > 1.0 then
        player:sendTextMessage(MESSAGE_INFO_DESCR, "All spawns are faster.")
    end

    -- AutoLootList
    AutoLootList:onLogin(player:getId())

    return true
end
loginMessage:register()

local logoutMessage = CreatureEvent("logoutMessage")
function logoutMessage.onLogout(player)
    -- Log to console
    print(string.format("[LOGOUT] Player %s has logged out.", player:getName()))

    -- Clear stamina cooldown entry if it exists
    if nextUseStaminaTime and nextUseStaminaTime[player:getId()] then
        nextUseStaminaTime[player:getId()] = nil
    end

    return true
end
logoutMessage:register()