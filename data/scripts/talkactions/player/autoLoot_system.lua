local autoLootStartup = GlobalEvent("AutoLootStartup")
function autoLootStartup.onStartup()
    lootBlockListm = {}
    lootBlockListn = {}
    lastItem = {}
    autolootBP = 1
    Game.sendConsoleMessage("> Loading autoloot data from database...", CONSOLEMESSAGE_TYPE_STARTUP)
    
    local resultId = db.storeQuery('SELECT DISTINCT `player_id` FROM `auto_loot_list`')
    if resultId then
        local playersLoaded = 0
        repeat
            local playerId = result.getNumber(resultId, "player_id")
            if playerId then
                if not AutoLootList.players[playerId] then
                    AutoLootList.players[playerId] = { lootList = {} }
                end
                local itemsQuery = db.storeQuery(string.format('SELECT `item_id` FROM `auto_loot_list` WHERE `player_id` = %d', playerId))
                if itemsQuery then
                    local itemTable = queryToTable(itemsQuery, {'item_id:number'})
                    AutoLootList.players[playerId].lootList = itemTable
                    result.free(itemsQuery)
                end
                
                playersLoaded = playersLoaded + 1
            end
        until not result.next(resultId)
        result.free(resultId)
        
        Game.sendConsoleMessage(string.format("> Loaded autoloot data for %d players", playersLoaded), CONSOLEMESSAGE_TYPE_STARTUP)
    else
        Game.sendConsoleMessage("> No autoloot data found in database", CONSOLEMESSAGE_TYPE_STARTUP)
    end
    
    return true
end
autoLootStartup:register()


local config = {
    exhaustTime = 2,
    rewardBossMessage = "You cannot view the loot of Reward Chest bosses.",
    GOLD_POUCH = 26377,
    BACKPACK_ID = 2004,
    mode = configManager.getNumber(configKeys.AUTOLOOT_MODE),
    blockedIds = {2393}
}


local function sendLootMessage(player, message, messageType)
    player:openChannel(9)
    player:sendChannelMessage("", message, TALKTYPE_CHANNEL_O, 9)
end


local CONST_SLOT_BACKPACK = 3
local CONST_SLOT_FIRST = 1
local CONST_SLOT_LAST = 10


local AUTO_LOOT_COOLDOWN_STORAGE = 10001


function trim(s)
    return s:match("^%s*(.-)%s*$")
end


function isInArray(array, value)
    for _, v in ipairs(array) do
        if v == value then
            return true
        end
    end
    return false
end


local function getLootContainer(player)
    if not player then
        return nil
    end
    if config.mode == 1 then
        return player:getItemById(config.GOLD_POUCH, true)
    elseif config.mode == 2 then
        local slotBackpack = player:getSlotItem(CONST_SLOT_BACKPACK)
        if slotBackpack and slotBackpack:isContainer() and slotBackpack:getId() == config.BACKPACK_ID then
            return slotBackpack
        end
        return player:getItemById(config.BACKPACK_ID, true)
    end
    return nil
end


local function getContainerDisplayName()
    if config.mode == 1 then
        return "Gold Pouch"
    elseif config.mode == 2 then
        return "backpack (ID 2004)"
    end
    return "loot container"
end

local function getMaxListLimit(player)
    local isVip = player and (player:getVipDays() > os.time())
    if isVip then
        return configManager.getNumber(configKeys.VIP_AUTOLOOT_LIMIT)
    end
    return configManager.getNumber(configKeys.FREE_AUTOLOOT_LIMIT)
end


local system_autoloot_onKill = CreatureEvent("AutoLoot")
function system_autoloot_onKill.onKill(creature, target)
    if not target:isMonster() then
        return true
    end


    addEvent(AutoLootList.getLootItem, 100, AutoLootList, creature:getId(), target:getPosition())
    return true
end
system_autoloot_onKill:register()


function AutoLootList.addQuickItem(self, playerId, itemId)
    local player = Player(playerId)
    if not player then
        return false
    end


    if self:itemInList(playerId, itemId) then
        sendLootMessage(player, string.format("%s is already in your auto-loot list.", ItemType(itemId):getName()), "warning")
        return false
    end


    local usedSlots = getGoldPouchUsedSlots(player)
    local maxSlots = getGoldPouchMaxSlots(player)
    local accountType = (player:getVipDays() > os.time()) and "VIP" or "Free"


    if maxSlots == 0 then
        sendLootMessage(player, string.format("You need %s to use auto-loot.", getContainerDisplayName()), "error")
        return false
    end


    local result = self:addItem(playerId, itemId)
    if result then
        local itemCount = self:countList(playerId)
        sendLootMessage(player, string.format("Added %s to auto-loot list. %s account: %d types configured, %s: %d/%d slots.", ItemType(itemId):getName(), accountType, itemCount, accountType, usedSlots, getMaxListLimit(player)), "success")
        return true
    else
        sendLootMessage(player, "Failed to add item to auto-loot list.", "error")
        return false
    end
end


local function addQuickItem(playerId, itemId, itemName)
    local player = Player(playerId)
    if not player then
        return false
    end


    local itemType = ItemType(itemId)
    if not itemType or itemType:getId() == 0 then
        return false
    end


    if isInArray(config.blockedIds, itemId) then
        sendLootMessage(player, string.format("The item %s is blocked and cannot be added to your loot list.", itemName), "error")
        return false
    end


    if AutoLootList:itemInList(playerId, itemId) then
        sendLootMessage(player, string.format("The item %s is already in your loot list.", itemName), "warning")
        return false
    end


    local usedSlots = getGoldPouchUsedSlots(player)
    local maxSlots = getGoldPouchMaxSlots(player)
    local accountType = (player:getVipDays() > os.time()) and "VIP" or "Free"


    if maxSlots == 0 then
        sendLootMessage(player, string.format("You need %s to use auto-loot.", getContainerDisplayName()), "error")
        return false
    end
    local itemAdded = AutoLootList:addItem(playerId, itemId)
    if itemAdded then
        local itemCount = AutoLootList:countList(playerId)
        sendLootMessage(player, string.format("The item %s has been added to your loot list. %s account: %d types configured, %s: %d/%d slots.", itemName, accountType, itemCount, accountType, usedSlots, getMaxListLimit(player)), "success")
        return true
    else
        sendLootMessage(player, string.format("Failed to add %s to your loot list.", itemName), "error")
        return false
    end
end


local function removeQuickItem(playerId, itemId, itemName)
    local player = Player(playerId)
    if not player then
        return false
    end


    if not AutoLootList:itemInList(playerId, itemId) then
        sendLootMessage(player, string.format("The item %s is not in your loot list.", itemName))
        return false
    end


    local itemRemoved = AutoLootList:removeItem(playerId, itemId)
    if itemRemoved then
        sendLootMessage(player, string.format("The item %s has been removed from your loot list.", itemName), "success")
    end


    return true
end


local function validateItem(itemInput)
    local itemType = ItemType(itemInput)
    local itemId = itemType:getId()
    if itemId == 0 then
        itemType = ItemType(tonumber(itemInput))
        itemId = itemType:getId()
    end


    if itemId == 0 then
        return nil, nil
    end


    local itemName = tonumber(itemInput) and itemType:getName() or itemInput
    return itemId, itemName
end


local function showMonsterLootModal(playerId, monsterName)
    local player = Player(playerId)
    if not player then
        return false
    end


    local monsterType = MonsterType(monsterName)
    if not monsterType then
        sendLootMessage(player, "This monster does not exist or is not on the map.")
        return false
    end


    if monsterType:isRewardBoss() then
        sendLootMessage(player, config.rewardBossMessage)
        return false
    end


    local formattedMonsterName = monsterName:lower()
    local window = ModalWindow {
        title = string.format("Loot of the Monster %s", formattedMonsterName),
        message = "Add or remove items from this monster to your auto-loot list.",
    }


    local windowCount = 0
    local uniqueItems = {}
    local monsterLoot = monsterType:getLoot()
    if monsterLoot then
        if #monsterLoot == 0 then
            sendLootMessage(player, "This monster has no available loot.")
            return false
        end
        
        for _, v in pairs(monsterLoot) do
            if windowCount < 255 then
                local itemId = v.itemId
                if not isInArray(uniqueItems, itemId) and not isInArray(config.blockedIds, itemId) then
                    local itemType = ItemType(itemId)
                    if itemType then
                        local itemName = itemType:getName()


                        local itemStatus = AutoLootList:itemInList(playerId, itemId) and ' - Added!' or ''
                        local choice = window:addChoice(itemName .. itemStatus)
                        windowCount = windowCount + 1


                        choice.itemId = itemId
                        choice.itemName = itemName
                        table.insert(uniqueItems, itemId)
                    end
                end
            end
        end
    end


    if windowCount >= 255 then
        sendLootMessage(player, "Warning: Some items may not be displayed due to modal window limitations.")
    end
    window:addButton("Remove",
        function(button, choice)
            if player and choice then
                removeQuickItem(player:getId(), choice.itemId, choice.itemName)
                showMonsterLootModal(playerId, formattedMonsterName)
            end
        end
    )


    window:addButton("Add",
        function(button, choice)
            if player and choice then
                addQuickItem(player:getId(), choice.itemId, choice.itemName)
                showMonsterLootModal(playerId, formattedMonsterName)
            end
        end
    )
    window:setDefaultEnterButton("Add")


    window:addButton("Close")
    window:setDefaultEscapeButton("Close")
    window:sendToPlayer(player)
end


local function openLootListModal(playerId)
    local player = Player(playerId)
    if not player then
        return false
    end


    local window = ModalWindow {
        title = "Your Auto-Loot List",
        message = "This is your auto-loot list!\nWhen these items drop, clicking on the monster's corpse will collect them to your Gold Pouch.",
    }


    local lootList = AutoLootList:getItemList(playerId)
    for _, loot in pairs(lootList) do
        local itemType = ItemType(loot.item_id)
        if itemType then
            local itemName = itemType:getName()
            local choice = window:addChoice(itemName .. " (Inventory)")


            choice.itemId = itemType:getId()
            choice.itemName = itemName
        end
    end


    window:addButton("Remove",
        function(button, choice)
            if player and choice then
                removeQuickItem(playerId, choice.itemId, choice.itemName)
                openLootListModal(playerId)
            end
        end
    )


    window:addButton("Close")
    window:setDefaultEscapeButton("Close")
    window:sendToPlayer(player)
end


function getGoldPouchUsedSlots(player)
    local container = getLootContainer(player)
    if not container then
        return 0
    end
    -- Use the real container size rather than first-page capacity.
    return container:getSize()
end


function getGoldPouchMaxSlots(player)
    local container = getLootContainer(player)


    if not container then
        return 0
    end


    return container:getCapacity()
end


function canStackInGoldPouch(player, itemId, count)
    local container = getLootContainer(player)


    if not container then
        return false, 1
    end


    local itemType = ItemType(itemId)
    if not itemType:isStackable() then
        return false, count
    end


    local maxStack = 100


    for i = 0, container:getSize() - 1 do
        local item = container:getItem(i)
        if item and item:getId() == itemId then
            local currentCount = item:getCount()


            if currentCount + count <= maxStack then
                return true, 0
            else
                local remainingCount = count - (maxStack - currentCount)
                local newSlots = math.ceil(remainingCount / maxStack)
                return false, newSlots
            end
        end
    end


    local slotsNeeded = math.ceil(count / maxStack)
    return false, slotsNeeded
end


local function moveToGoldPouch(player, item)
    if not player or not item then
        return false
    end
    local targetContainer = getLootContainer(player)
    if not targetContainer then
        sendLootMessage(player, string.format("You need %s to use auto-loot.", getContainerDisplayName()))
        return false
    end
    return item:moveTo(targetContainer)
end


function AutoLootList.getLootItem(self, playerId, position)
    local player = Player(playerId)
    if not player then
        return false
    end


    player:openChannel(9)


    local itemCount = self:countList(playerId)


    local tile = Tile(position)
    if not tile then
        return false
    end


    local corpse = tile:getTopDownItem()
    if not corpse or not corpse:isContainer() then
        return false
    end


    local usedSlots = getGoldPouchUsedSlots(player)
    local maxSlots = getGoldPouchMaxSlots(player)
    local availableSlots = maxSlots - usedSlots
    local accountType = (player:getVipDays() > os.time()) and "VIP" or "Free"


    local items = {}
    for i = 0, corpse:getSize() - 1 do
        local item = corpse:getItem(i)
        if item then
            table.insert(items, item)
        end
    end


    local itemsCollected = 0
    local slotsUsedThisSession = 0
    local bankDeposited = 0


    local function isCoin(itemId)
        return itemId == ITEM_GOLD_COIN or itemId == ITEM_PLATINUM_COIN or itemId == ITEM_CRYSTAL_COIN
    end


    local function getCoinValue(itemId)
        if itemId == ITEM_GOLD_COIN then return 1 end
        if itemId == ITEM_PLATINUM_COIN then return 100 end
        if itemId == ITEM_CRYSTAL_COIN then return 10000 end
        return 0
    end
    
    for _, item in ipairs(items) do
        local itemId = item:getId()
        local itemCountStack = item:getCount()


        if isCoin(itemId) then
            local depositAmount = itemCountStack * getCoinValue(itemId)
            if depositAmount > 0 then
                player:setBankBalance(player:getBankBalance() + depositAmount)
                db.query(string.format("UPDATE `players` SET `balance` = `balance` + %d WHERE `id` = %d", depositAmount, player:getGuid()))
                bankDeposited = bankDeposited + depositAmount
                itemsCollected = itemsCollected + 1
                item:remove()
            end
        elseif self:itemInList(playerId, itemId) then
            local canStack, slotsNeeded = canStackInGoldPouch(player, item:getId(), item:getCount())
            
            if maxSlots == 0 then
                sendLootMessage(player, string.format("You need %s to collect non-coin items.", getContainerDisplayName()), "warning")
            elseif slotsUsedThisSession + slotsNeeded > availableSlots then
                local currentUsed = usedSlots + slotsUsedThisSession
                sendLootMessage(player, string.format("Collection stopped: Not enough space in your %s. %s: %d/%d slots used.", getContainerDisplayName(), accountType, currentUsed, getMaxListLimit(player)), "warning")
                break
            end


            local itemWeight = ItemType(item:getId()):getWeight() * item:getCount()
            if player:getFreeCapacity() < itemWeight then
                sendLootMessage(player, string.format("Not enough capacity to collect %s (need %d oz).", item:getName(), itemWeight), "warning")
                break
            end


            local itemMoved = moveToGoldPouch(player, item)
            
            if itemMoved then
                itemsCollected = itemsCollected + 1
                slotsUsedThisSession = slotsUsedThisSession + slotsNeeded
                local currentUsed = usedSlots + slotsUsedThisSession
                
                local stackInfo = ""
                if canStack and slotsNeeded == 0 then
                    stackInfo = " (stacked)"
                elseif ItemType(item:getId()):isStackable() then
                    stackInfo = string.format(" (%d slots)", slotsNeeded)
                end
                
                sendLootMessage(player, string.format("Collected %dx %s%s (%s: %d/%d slots)", item:getCount(), item:getName(), stackInfo, accountType, currentUsed, getMaxListLimit(player)), "collected")
            else
                sendLootMessage(player, string.format("Could not collect %s: No space in your loot container.", item:getName()), "error")
            end
        end
    end


    if itemsCollected > 0 then
        local finalUsed = usedSlots + slotsUsedThisSession
        local summary = string.format("Auto-loot session complete: %d items collected, %d slots used.", itemsCollected, slotsUsedThisSession)
        if bankDeposited > 0 then
            summary = summary .. string.format(" Deposited %d gold to bank.", bankDeposited)
        end
        if maxSlots > 0 then
            summary = summary .. string.format(" %s: %d/%d slots.", accountType, finalUsed, getMaxListLimit(player))
        end
        sendLootMessage(player, summary, "info")


        player:openChannel(9)
    end


    return true
end


local system_autoloot_talk = TalkAction("!autoloot", "/autoloot")
function system_autoloot_talk.onSay(player, words, param, type)
    if type ~= TALKTYPE_SAY and type ~= TALKTYPE_WHISPER and type ~= TALKTYPE_YELL then
        return false
    end
    
    if player:getStorageValue(AUTO_LOOT_COOLDOWN_STORAGE) > os.time() then
        player:sendCancelMessage(string.format("You are on cooldown. Please wait %d seconds to use the command again.", config.exhaustTime))
        return false
    end


    player:setStorageValue(AUTO_LOOT_COOLDOWN_STORAGE, os.time() + config.exhaustTime)
    
    local split = param:split(",")
    local action = split[1] and trim(split[1]) or ""
    local playerId = player:getId()


    if action == "add" then
        if not split[2] then
            sendLootMessage(player, "Usage: !autoloot add, itemName")
            return false
        end


        local itemInput = trim(split[2])
        local itemId, itemName = validateItem(itemInput)
        if not itemId then
            sendLootMessage(player, "No item exists with that name.")
            return false
        end


        addQuickItem(player:getId(), itemId, itemName)
    elseif action == "remove" then
        if not split[2] then
            sendLootMessage(player, "Usage: !autoloot remove, itemName")
            return false
        end


        local itemInput = trim(split[2])
        local itemId, itemName = validateItem(itemInput)
        if not itemId then
            sendLootMessage(player, "No item exists with that name.")
            return false
        end


        if not AutoLootList:itemInList(playerId, itemId) then
            sendLootMessage(player, string.format("The item %s is not in your loot list.", itemName))
            return false
        end


        removeQuickItem(player:getId(), itemId, itemName)
    elseif action == "list" or action == "show" then
        local count = AutoLootList:countList(playerId)
        if count == 0 then
            sendLootMessage(player, "Your loot list is empty.")
            return false
        end


        local itemList = AutoLootList:getItemList(playerId)
        local accountType = (player:getVipDays() > os.time()) and "VIP_AUTOLOOT_LIMIT" or "Free"
        local maxItems = (player:getVipDays() > os.time()) and configManager.getNumber(configKeys.VIP_AUTOLOOT_LIMIT) or configManager.getNumber(configKeys.FREE_AUTOLOOT_LIMIT)
        
        sendLootMessage(player, string.format("=== AUTO LOOT LIST (%s: %d/%d) ===", accountType, count, maxItems))
        
        if itemList then
            for i, item in ipairs(itemList) do
                local itemType = ItemType(item.item_id)
                if itemType then
                    sendLootMessage(player, string.format("%d. %s (ID: %d)", i, itemType:getName(), item.item_id))
                end
            end
        end
        
        sendLootMessage(player, "Use !autoloot remove, item name to remove items")
        openLootListModal(playerId)
    elseif action == "clear" then
        local count = AutoLootList:countList(playerId)
        if count == 0 then
            sendLootMessage(player, "Your loot list is already empty.")
            return false
        end
        
        AutoLootList:clearList(playerId)
        sendLootMessage(player, string.format("Your auto-loot list has been cleared. %d items removed.", count), "success")
    elseif action ~= "" then
        local monsterName = action
        showMonsterLootModal(player:getId(), monsterName)
    elseif action == "help" then
        local usedSlots = getGoldPouchUsedSlots(player)
        local maxSlots = getGoldPouchMaxSlots(player)
        local accountType = (player:getVipDays() > os.time()) and "VIP" or "Free"
        local itemCount = AutoLootList:countList(playerId)
        
        local statusText = ""
        if maxSlots == 0 then
            statusText = string.format("- Account type: %s\n- Loot container: Not found (need %s)\n- Configured items: %d types\n- VIP auto-loot list limit: %d types\n- Free auto-loot list limit: %d types", accountType, getContainerDisplayName(), itemCount, configManager.getNumber(configKeys.VIP_AUTOLOOT_LIMIT), configManager.getNumber(configKeys.FREE_AUTOLOOT_LIMIT))
        else
            statusText = string.format("- Account type: %s\n- Loot container (%s) slots: %d/%d used\n- Configured items: %d types\n- VIP auto-loot list limit: %d types\n- Free auto-loot list limit: %d types", accountType, getContainerDisplayName(), usedSlots, maxSlots, itemCount, configManager.getNumber(configKeys.VIP_AUTOLOOT_LIMIT), configManager.getNumber(configKeys.FREE_AUTOLOOT_LIMIT))
        end


        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format("=== AUTO LOOT SYSTEM HELP ===\n\nCurrent Status:\n%s\n\nCommands:\n!autoloot add, item name - Add item to auto-loot list\n!autoloot remove, item name - Remove item from auto-loot list\n!autoloot list - Show your auto-loot list\n!autoloot clear - Clear your auto-loot list\n!autoloot monster, monster name - Show monster loot\n\nItems will be automatically moved to your loot container (%s) when collected.\nStackable items (like rubies) will stack together, saving space!", statusText, getContainerDisplayName()))
    else
        if param and param:trim() ~= "" then
            local usedSlots = getGoldPouchUsedSlots(player)
            local maxSlots = getGoldPouchMaxSlots(player)
            local accountType = (player:getVipDays() > os.time()) and "VIP" or "Free"
            local itemCount = AutoLootList:countList(playerId)
            
            sendLootMessage(player, "=== AUTO LOOT SYSTEM ===")
            
            if maxSlots == 0 then
                sendLootMessage(player, string.format("Status: %s account - Loot container: Not found (need %s)", accountType, getContainerDisplayName()))
                sendLootMessage(player, string.format("Configured items: %d types", itemCount))
                sendLootMessage(player, string.format("You need %s to use auto-loot!", getContainerDisplayName()))
            else
                sendLootMessage(player, string.format("Status: %s account - %s: %d/%d slots", accountType, accountType, usedSlots, getMaxListLimit(player)))
                sendLootMessage(player, string.format("Configured items: %d types", itemCount))
            end
            
            sendLootMessage(player, "Commands:")        
            sendLootMessage(player, "!autoloot add, item name - Add item to auto-loot list")
            sendLootMessage(player, "!autoloot remove, item name - Remove item from auto-loot list")
            sendLootMessage(player, "!autoloot list - Show your auto-loot list")
            sendLootMessage(player, "!autoloot clear - Clear your auto-loot list")
            sendLootMessage(player, string.format("Items will be moved to your loot container (%s).", getContainerDisplayName()))
            sendLootMessage(player, string.format("Limits: VIP players (%d slots), Free players (%d slots)", configManager.getNumber(configKeys.VIP_AUTOLOOT_LIMIT), configManager.getNumber(configKeys.FREE_AUTOLOOT_LIMIT)))
        else
            if param == "" or not param then
                sendLootMessage(player, "Use !autoloot help for commands.")
            end
        end
        return false
    end


    return false
end
system_autoloot_talk:separator(" ")
system_autoloot_talk:register()


local autoLootLogin = CreatureEvent("AutoLootLogin")
function autoLootLogin.onLogin(player)
    player:registerEvent("AutoLoot")
    
    local playerId = player:getId()
    if not AutoLootList.players[playerId] then
        AutoLootList:init(playerId)
    end
    
    return true
end
autoLootLogin:type("login")
autoLootLogin:register()


local autoLootKill = CreatureEvent("AutoLoot")
function autoLootKill.onKill(creature, target)
    return true
end
autoLootKill:type("kill")
autoLootKill:register()


local moveItemEvent = Event()
moveItemEvent.onMoveItem = function(player, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    if not player or not item or not toCylinder then
        return true
    end
    
    if not toCylinder.getId or not player.getId or not item.getId then
        return true
    end
    
    if toCylinder:getId() == config.GOLD_POUCH then
        if AutoLootList and AutoLootList:itemInList(player:getId(), item:getId()) then
            return true
        end
        
        local coinIds = {ITEM_GOLD_COIN, ITEM_PLATINUM_COIN, ITEM_CRYSTAL_COIN}
        for _, coinId in ipairs(coinIds) do
            if item:getId() == coinId then
                return true
            end
        end
        
        player:sendCancelMessage("You can only move money or auto-loot items to this container.")
        return false
    end
    
    return true
end
moveItemEvent:register()
