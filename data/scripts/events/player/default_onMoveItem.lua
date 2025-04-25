-- Item IDs
local ITEM_GOLD_COIN      = 2148
local ITEM_PLATINUM_COIN  = 2152
local ITEM_CRYSTAL_COIN   = 2160

local blockTeleportTrashing = true

local STONE_SKIN_AMULET       = 2197   -- ID for Stone Skin Amulet
local ENERGY_RING             = 2167   -- ID for Energy Ring
local GOLD_POUCH              = 26377  -- ID for Gold Pouch
local ITEM_SUPPLY_STASH       = 26386
local ITEM_STORE_INBOX        = 26052  -- ID for Store Inbox
local CONTAINER_POSITION      = 65535  -- Macro for container position
local CONST_SLOT_STORE_INBOX  = 11     -- Slot index for the Store Inbox
local CONST_SLOT_NECKLACE     = 2      -- Slot index for necklace (used for SSA)
local CONST_SLOT_LEFT         = 5      -- Slot index for left hand
local CONST_SLOT_RIGHT        = 6      -- Slot index for right hand
local ITEM_REWARD_CONTAINER   = 26379  -- Adjust according to your server
local ITEM_REWARD_CHEST       = 26382  -- Adjust according to your server

local exercise_ids            = {32384, 32385, 32386, 32387, 32388, 32389}
local dummies                 = {32147, 32148, 32143, 32144, 32145, 32146}
local bathTube                = {29312, 29313}
local NOT_MOVEABLE_ACTION     = 8000

-- Global table for SSA exhaust (persists across script reloads)
if not exhaust then
    exhaust = {}
end

-- Check if a value exists in an array
function isInArray(array, value)
    if type(array) ~= "table" then
        return false
    end
    for _, v in pairs(array) do
        if v == value then
            return true
        end
    end
    return false
end

-- Safely get a container by ID
local function safeGetContainerById(player, id)
    if type(id) ~= "number" then
        return nil
    end
    local adjustedId = math.floor(id)
    if adjustedId < 0 or adjustedId >= 256 then
        return nil
    end
    local item = player:getSlotItem(adjustedId)
    if item and item:isContainer() then
        return item
    end
    return nil
end

-- Check if a container has nested containers
local function hasNestedContainer(item)
    if item:isContainer() then
        local container = item:getContainer()
        for i = 0, container:getSize() - 1 do
            local nestedItem = container:getItem(i)
            if nestedItem and nestedItem:isContainer() then
                return true
            end
        end
    end
    return false
end

-- Anti-spam system for pushing items to tiles
local function antiPush(player, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    -- Ignore if the destination is a container
    if toPosition.x == CONTAINER_POSITION then
        return true
    end

    -- Check if toPosition is valid
    local tile = Tile(toPosition)
    if not tile then
        player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        return false
    end

    -- Read the maximum items per tile from config.lua
    local maxItemsPerTile = configManager.getNumber("maxItemsPerTile") or 20

    -- Check the item limit per tile (considering the number of items being moved)
    if (tile:getItemCount() + count) > maxItemsPerTile then
        player:sendCancelMessage("You can't push more items to this position.")
        return false
    end
    return true
end

-- Main event: onMoveItem
local event = Event()
event.onMoveItem = function(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    -- Validate the item
    if not item or not item:isItem() then
        self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        return false
    end

    -- 1) Exercise Weapons
    if isInArray(exercise_ids, item:getId()) then
        self:sendCancelMessage("You cannot move this item outside this container.")
        return false
    end

    -- 2) Dummies
    if isInArray(dummies, item:getId()) then
        if not Tile(toPosition):getHouse() then
            self:sendCancelMessage("You cannot move this item outside the house.")
            return false
        end
    end

    -- 3) Moving bathtub
    if isInArray(bathTube, item:getId()) then
        local fromTile = Tile(fromPosition)
        local toTile = Tile(toPosition)
        if fromTile then
            if fromTile:getTopCreature() then
                self:sendCancelMessage("You cannot move this item with someone inside.")
                return false
            elseif toTile and toTile:getTopCreature() then
                self:sendCancelMessage("You cannot move this item over someone.")
                return false
            end
        end
    end

    -- 4) SSA exhaust (Stone Skin Amulet)
    if toPosition.x == CONTAINER_POSITION and toPosition.y == CONST_SLOT_NECKLACE and item:getId() == STONE_SKIN_AMULET then
        local playerId = self:getId()
        if exhaust[playerId] then
            self:sendCancelMessage(RETURNVALUE_YOUAREEXHAUSTED)
            return false
        else
            exhaust[playerId] = true
            local ssaExhaustTime = configManager.getNumber("ssaExhaustTime") or 2000
            addEvent(function(playerIdParam)
                exhaust[playerIdParam] = nil
            end, ssaExhaustTime, playerId)
            return true
        end
    end

    -- 5) Prevent moving items from Store Inbox or Supply Stash into certain slots
    local containerIdFrom = fromPosition.y - 64
    local containerFrom = self:getContainerById(containerIdFrom)
    if containerFrom then
        if (containerFrom:getId() == ITEM_STORE_INBOX or containerFrom:getId() == ITEM_SUPPLY_STASH) and 
           (toPosition.y >= 1 and toPosition.y <= 11 and toPosition.y ~= 3) then
            self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
            return false
        end
    end

    -- Helper function to get the parent container
    local function getContainerParent(item)
        local parent = item:getParent()
        if parent and parent:isItem() then
            local peekNextParent = parent:getParent()
            if peekNextParent and peekNextParent.itemid == 1 then
                return parent
            end
        end
        return false
    end

    local containerTo = self:getContainerById(toPosition.y - 64)
    if containerTo then
        if containerTo:getId() == ITEM_STORE_INBOX or containerTo:getId() == ITEM_SUPPLY_STASH then
            self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
            return false
        end

        -- Gold Pouch handling
        if containerTo:getId() == GOLD_POUCH then
            -- Only coins can be moved
            if not (item:getId() == ITEM_CRYSTAL_COIN or
                    item:getId() == ITEM_PLATINUM_COIN or
                    item:getId() == ITEM_GOLD_COIN) then
                self:sendCancelMessage("You can only move money to this container.")
                return false
            end

            -- Convert coins into bank balance
            local worth = {
                [ITEM_GOLD_COIN]     = 1,
                [ITEM_PLATINUM_COIN] = 100,
                [ITEM_CRYSTAL_COIN]  = 10000,
            }
            local goldValue = worth[item:getId()]
            if goldValue then
                local newBalance = self:getBankBalance() + (goldValue * item:getCount())
                if item:remove() then
                    self:setBankBalance(newBalance)
                    self:sendTextMessage(MESSAGE_STATUS_DEFAULT, string.format("Your new bank balance is %d gps.", newBalance))
                    return true
                else
                    self:sendCancelMessage("Failed to process the transaction.")
                    return false
                end
            end
        end

        -- Check if the target container is inside the Store Inbox
        local parentContainer = getContainerParent(containerTo)
        if parentContainer and parentContainer:getId() == ITEM_STORE_INBOX then
            self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
            return false
        end

        -- Prevent moving items into corpses
        local itemType = ItemType(containerTo:getId())
        if itemType:isCorpse() then
            return false
        end
    end

    -- 6) Do not allow moving the Gold Pouch itself
    if item:getId() == GOLD_POUCH then
        self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        return false
    end

    -- 7) Do not allow moving items with actionID = 8000
    if item:getActionId() == NOT_MOVEABLE_ACTION then
        self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        return false
    end

    -- 8) Check two-handed weapons logic
    if toPosition.x == CONTAINER_POSITION then
        if item:getTopParent() == self and bit.band(toPosition.y, 0x40) == 0 then
            local itemType = ItemType(item:getId())
            local moveItem

            -- If the item is two-handed and being placed in the left hand slot
            if bit.band(itemType:getSlotPosition(), SLOTP_TWO_HAND) ~= 0 and toPosition.y == CONST_SLOT_LEFT then
                moveItem = self:getSlotItem(CONST_SLOT_RIGHT)
                if moveItem and itemType:getWeaponType() == WEAPON_DISTANCE and ItemType(moveItem:getId()):getWeaponType() == WEAPON_QUIVER then
                    return true
                end
            -- If the item is a shield in the right hand, check left hand for two-handed
            elseif itemType:getWeaponType() == WEAPON_SHIELD and toPosition.y == CONST_SLOT_RIGHT then
                moveItem = self:getSlotItem(CONST_SLOT_LEFT)
                if moveItem and bit.band(ItemType(moveItem:getId()):getSlotPosition(), SLOTP_TWO_HAND) == 0 then
                    return true
                end
            end

            if moveItem then
                local parent = item:getParent()
                if parent:getSize() >= parent:getCapacity() then
                    self:sendTextMessage(MESSAGE_STATUS_SMALL, Game.getReturnMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM))
                    return false
                else
                    local moved = moveItem:moveTo(parent)
                    if not moved then
                        self:sendCancelMessage(RETURNVALUE_CONTAINERNOTENOUGHROOM)
                        return false
                    end
                    return true
                end
            end
        end
    end

    -- 9) Reward System checks
    if toPosition.x == CONTAINER_POSITION then
        local containerId = toPosition.y - 64
        local container = self:getContainerById(containerId)
        if container then
            -- Do not allow inserting items into the Reward Container or Reward Chest
            local itemId = container:getId()
            if itemId == ITEM_REWARD_CONTAINER or itemId == ITEM_REWARD_CHEST then
                self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
                return false
            end

            -- Do not allow inserting items into a boss corpse if its corpseowner == 2^31 - 1
            local tileCheck = Tile(container:getPosition())
            for _, corpseItem in ipairs(tileCheck:getItems() or {}) do
                if ItemType(corpseItem:getId()):isCorpse() and corpseItem:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == 2147483647 and corpseItem:getName() == container:getName() then
                    self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
                    return false
                end
            end
        end
    end

    -- 10) Do not allow moving a boss corpse
    if ItemType(item:getId()):isCorpse() and item:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER) == 2147483647 then
        self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        return false
    end

    -- 11) Block throwing items on a Reward Chest
    local tile = Tile(toPosition)
    if tile and tile:getItemById(ITEM_REWARD_CHEST) then
        self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        self:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    -- 12) Block throwing items on top of teleports
    if blockTeleportTrashing and toPosition.x ~= CONTAINER_POSITION then
        local thing = Tile(toPosition):getItemByType(ITEM_TYPE_TELEPORT)
        if thing then
            self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
            self:getPosition():sendMagicEffect(CONST_ME_POFF)
            return false
        end
    end

    -- 13) Block throwing items on trapdoors
    if tile and tile:getItemById(370) then -- Trapdoor
        self:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
        self:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    -- 14) Check anti-push limit
    if not antiPush(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder) then
        return false
    end

    return true
end
event:register()