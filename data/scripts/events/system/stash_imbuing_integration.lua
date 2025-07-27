-- Stash Integration with Imbuing Shrines
-- This script allows imbuing shrines to automatically withdraw materials from stash

local STASH_IMBUING_INTEGRATION = true

-- Function to check if player has materials in stash for imbuement
function Player.hasStashMaterialsForImbuement(self, imbuement)
    if not STASH_IMBUING_INTEGRATION then
        return false
    end
    
    local items = imbuement:getItems()
    for _, itemData in pairs(items) do
        local itemId = itemData.itemid
        local requiredCount = itemData.count
        
        local stashCount = self:getStashItemCount(itemId)
        if stashCount < requiredCount then
            return false
        end
    end
    
    return true
end

-- Function to withdraw materials from stash for imbuement
function Player.withdrawStashMaterialsForImbuement(self, imbuement)
    if not STASH_IMBUING_INTEGRATION then
        return false
    end
    
    local items = imbuement:getItems()
    local withdrawnItems = {}
    
    for _, itemData in pairs(items) do
        local itemId = itemData.itemid
        local requiredCount = itemData.count
        
        local stashCount = self:getStashItemCount(itemId)
        if stashCount >= requiredCount then
            -- Withdraw from stash
            if self:withdrawItem(itemId, requiredCount) then
                -- Add to player inventory
                self:addItemFromStash(itemId, requiredCount)
                table.insert(withdrawnItems, {
                    itemId = itemId,
                    count = requiredCount,
                    name = ItemType(itemId):getName()
                })
            end
        end
    end
    
    if #withdrawnItems > 0 then
        local message = "Materials withdrawn from stash: "
        for i, item in ipairs(withdrawnItems) do
            message = message .. item.count .. "x " .. item.name
            if i < #withdrawnItems then
                message = message .. ", "
            end
        end
        self:sendTextMessage(MESSAGE_STATUS_DEFAULT, message)
        return true
    end
    
    return false
end

-- Event for stash imbuing integration
local eventStashImbuing = Event()
eventStashImbuing.onMoveItem = function(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
    if not STASH_IMBUING_INTEGRATION then
        return true
    end
    
    -- Check if the destination is an imbuing shrine
    local tile = Tile(toPosition)
    if tile then
        local items = tile:getItems()
        for _, tileItem in ipairs(items) do
            -- Check if it's an imbuing shrine (you may need to adjust the ID)
            if tileItem:getId() == 32147 then -- Adjust this ID to your imbuing shrine ID
                -- Check if player has materials in stash for any imbuement
                local imbuements = g_imbuements:getImbuements(self, item)
                
                for _, imbuement in ipairs(imbuements) do
                    -- Check if player has materials in stash
                    if self:hasStashMaterialsForImbuement(imbuement) then
                        -- Ask player if they want to use stash materials
                        local message = "You have materials for '" .. imbuement:getName() .. "' in your stash. Use them?"
                        self:sendTextMessage(MESSAGE_STATUS_DEFAULT, message)
                        
                        -- In a real implementation, you would show a dialog here
                        -- For now, we'll automatically use stash materials
                        if self:withdrawStashMaterialsForImbuement(imbuement) then
                            self:sendTextMessage(MESSAGE_STATUS_DEFAULT, "Materials withdrawn from stash for imbuement.")
                        end
                    end
                end
                break
            end
        end
    end
    
    return true
end

-- Register the event for stash imbuing integration
eventStashImbuing:register() 