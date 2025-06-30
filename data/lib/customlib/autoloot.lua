if not AutoLootList then
    AutoLootList = { players = {} }
end

function AutoLootList.init(self, playerId)
    local player = Player(playerId)
    if not player then
        return
    end

    if not self.players[playerId] then
        self.players[playerId] = { lootList = {} }
    end

    local resultId = db.storeQuery(string.format('SELECT `item_id` FROM `auto_loot_list` WHERE `player_id` = %d', player:getGuid()))
    if resultId then
        local itemTable = queryToTable(resultId, {'item_id:number'})
        self.players[playerId].lootList = itemTable
        result.free(resultId)
    end
end

function AutoLootList.stop(self, playerId, playerGuid)
    if self.players[playerId] then
        self.players[playerId] = nil
    end
end

function AutoLootList.countList(self, playerId)
    if self.players[playerId] then
        return #self.players[playerId].lootList
    end
    return 0
end

function AutoLootList.getItemList(self, playerId)
    local player = Player(playerId)
    if not player then
        return nil
    end

    if not self.players[playerId] then
        return nil
    end

    return self.players[playerId].lootList
end

function AutoLootList.itemInList(self, playerId, itemId)
    local player = Player(playerId)
    if not player then
        return false
    end

    if not self.players[playerId] then
        return false
    end

    local lootList = self.players[playerId].lootList
    if lootList then
        for i = 1, #lootList do
            if lootList[i].item_id == itemId then
                return true
            end
        end
    end

    return false
end

function AutoLootList.addItem(self, playerId, itemId)
    local player = Player(playerId)
    if not player then
        return false
    end

    if not self.players[playerId] then
        self:init(playerId)
        if not self.players[playerId] then
            return false
        end
    end

    if self:itemInList(playerId, itemId) then
        return false
    end

    table.insert(self.players[playerId].lootList, {item_id = itemId})

    local query = string.format("INSERT INTO `auto_loot_list` (`player_id`, `item_id`) VALUES (%d, %d)", player:getGuid(), itemId)
    local success, errorMessage = db.query(query)
    if not success then
        print(string.format("[AUTO LOOT ERROR] Failed to add item %d to auto_loot_list for player %d: %s", itemId, player:getGuid(), errorMessage or "Unknown error"))
        self:removeItem(playerId, itemId)
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "[AUTO LOOT] - Failed to save the item to your loot list due to a server error.")
        return false
    end

    return true
end

function AutoLootList.removeItem(self, playerId, itemId)
    local player = Player(playerId)
    if not player then
        return false
    end

    if not self.players[playerId] then
        self:init(playerId)
        if not self.players[playerId] then
            return false
        end
    end

    if not self:itemInList(playerId, itemId) then
        return false
    end

    local lootList = self.players[playerId].lootList
    if lootList then
        for i = 1, #lootList do
            if lootList[i].item_id == itemId then
                table.remove(lootList, i)
                break
            end
        end
    end

    local query = string.format("DELETE FROM `auto_loot_list` WHERE `player_id` = %d AND `item_id` = %d", player:getGuid(), itemId)
    local success, errorMessage = db.query(query)
    if not success then
        print(string.format("[AUTO LOOT ERROR] Failed to remove item %d from auto_loot_list for player %d: %s", itemId, player:getGuid(), errorMessage or "Unknown error"))
        table.insert(self.players[playerId].lootList, {item_id = itemId})
        player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "[AUTO LOOT] - Failed to remove the item from your loot list due to a server error.")
        return false
    end

    return true
end

function AutoLootList.getLootItem(self, playerId, position)
    local player = Player(playerId)
    if not player then
        return
    end

    if not self.players[playerId] then
        self:init(playerId)
        if not self.players[playerId] then
            return
        end
    end

    local corpse = Tile(position):getTopDownItem()
    if not corpse or not corpse:isContainer() then
        return
    end

    local strLoot = ''
    local lootList = self.players[playerId].lootList
    if lootList then
        for a = corpse:getSize() - 1, 0, -1 do
            local containerItem = corpse:getItem(a)
            if containerItem then
                local containerItemId = containerItem:getId()
                for i = 1, #lootList do
                    if lootList[i].item_id == containerItemId then
                        local itemCount = containerItem:getCount()
                        local itemName = containerItem:getName()

                        local moveItem = containerItem:moveTo(player)
                        if moveItem then
                            strLoot = string.format('%s%dx %s, ', strLoot, itemCount, itemName)
                        end
                    end
                end
            end
        end

        if strLoot ~= '' then
            strLoot = strLoot:sub(1, #strLoot-2)
            if strLoot:len() >= 250 then
                strLoot = strLoot:sub(1, 250) .. " ..."
            end
            
            player:sendTextMessage(MESSAGE_STATUS_SMALL, string.format('Collected loot: %s', strLoot))
        end
    end
end

function AutoLootList.onLogin(self, playerId) self:init(playerId) end
function AutoLootList.onLogout(self, playerId, playerGuid) self:stop(playerId, playerGuid) end
function AutoLootList.onDeath(self, playerId, playerGuid) self:stop(playerId, playerGuid) end