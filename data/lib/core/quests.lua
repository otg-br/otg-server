if not Game.getStorageValue(RELOAD_TYPE_QUESTS) or Game.getStorageValue(RELOAD_TYPE_QUESTS) ~= 1 then
    Game.setStorageValue(RELOAD_TYPE_QUESTS, 1)
    Quests = {
        [1] = {
            name = "The Explorer Society",
            startstorageid = 60000, -- Changed from Storage.ExplorerSociety.QuestLine
            startstoragevalue = 1,
            missions = {
                [1] = {
                    name = "Joining the Explorers",
                    storageid = 60001, -- Changed from Storage.ExplorerSociety.Mission01
                    startvalue = 1,
                    endvalue = 4,
                    states = {
                        [1] = "Speak to an Explorer Society representative to begin your adventure.",
                        [2] = "Travel to a nearby location and retrieve a specific item for the representative.",
                        [3] = "Return the item to the Explorer Society representative to advance.",
                        [4] = "Quest completed! You are now a member of the Explorer Society."
                    },
                },
            },
        },
    }
    Game.sendConsoleMessage(">> Loaded " .. #Quests .. " quests", CONSOLEMESSAGE_TYPE_STARTUP)
end

if not LastQuestlogUpdate then
    LastQuestlogUpdate = {}
end

-- Helper function for table.contains
function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

-- Text functions
function evaluateText(value, player)
    if type(value) == "function" then
        return tostring(value(player))
    end
    return tostring(value)
end

-- Game functions
function Game.isValidQuest(questId)
    return (Quests and Quests[questId])
end

function Game.isValidMission(questId, missionId)
    return (Game.isValidQuest(questId) and Quests[questId].missions and Quests[questId].missions[missionId])
end

function Game.getQuest(questId)
    if Game.isValidQuest(questId) then
        return Quests[questId]
    end
    return false
end

function Game.getQuestIdByName(name)
    for questId = 1, #Quests do
        local quest = Game.getQuest(questId)
        if quest and quest.name:lower() == name:lower() then
            return questId
        end
    end
    return false
end

function Game.getMission(questId, missionId)
    if Game.isValidMission(questId, missionId) then
        return Quests[questId].missions[missionId]
    end
    return false
end

function Game.isQuestStorage(key, value, oldValue)
    for questId = 1, #Quests do
        local quest = Game.getQuest(questId)
        if quest then
            if quest.startstorageid == key and quest.startstoragevalue == value then
                return true
            end
            if quest.missions then
                for missionId = 1, #quest.missions do
                    local mission = Game.getMission(questId, missionId)
                    if mission and mission.storageid == key and value >= mission.startvalue and value <= mission.endvalue then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function Game.getQuestsCount(player)
    local count = 0
    if Quests then
        for id = 1, #Quests do
            if player:questIsStarted(id) then
                count = count + 1
            end
        end
    end
    return count
end

function Game.getMissionsCount(player, questId)
    local quest = Game.getQuest(questId)
    local count = 0
    if quest and quest.missions then
        for missionId = 1, #quest.missions do
            if player:missionIsStarted(questId, missionId) then
                count = count + 1
            end
        end
    end
    return count
end

function Game.addQuest(quest)
    local findQuest = Game.getQuestIdByName(quest.name)
    if findQuest then
        Quests[findQuest] = quest
        return findQuest
    end
    local questId = #Quests + 1
    Quests[questId] = quest
    return questId
end

-- Player functions
function Player.questIsStarted(self, questId)
    local quest = Game.getQuest(questId)
    if quest and self:getStorageValue(quest.startstorageid) >= quest.startstoragevalue then
        return true
    end
    return false
end

function Player.missionIsStarted(self, questId, missionId)
    local mission = Game.getMission(questId, missionId)
    if mission then
        local value = self:getStorageValue(mission.storageid)
        if value == -1 or value < mission.startvalue or (not mission.ignoreendvalue and value > mission.endvalue) then
            return false
        end
        return true
    end
    return false
end

function Player.questIsCompleted(self, questId)
    local quest = Game.getQuest(questId)
    if quest and quest.missions then
        for missionId = 1, #quest.missions do
            if not self:missionIsCompleted(questId, missionId) then
                return false
            end
        end
        return true
    end
    return false
end

function Player.missionIsCompleted(self, questId, missionId)
    local mission = Game.getMission(questId, missionId)
    if mission then
        local value = self:getStorageValue(mission.storageid)
        if value == -1 then
            return false
        end
        if mission.ignoreendvalue then
            return value >= mission.endvalue
        end
        return value == mission.endvalue
    end
    return false
end

function Player.getMissionName(self, questId, missionId)
    local mission = Game.getMission(questId, missionId)
    if mission then
        if self:missionIsCompleted(questId, missionId) then
            return mission.name .. " (completed)"
        end
        return mission.name
    end
    return ""
end

function Player.getMissionDescription(self, questId, missionId)
    local mission = Game.getMission(questId, missionId)
    if mission then
        if mission.description then
            return evaluateText(mission.description, self)
        end
        local value = self:getStorageValue(mission.storageid)
        local state = value
        if mission.ignoreendvalue and value > table.maxn(mission.states) then
            state = table.maxn(mission.states)
        end
        return evaluateText(mission.states[state] or "Unknown state", self)
    end
    return "An error has occurred, please contact a gamemaster."
end

if not PlayerQuestTracker then
    PlayerQuestTracker = {}
end

function Player.manageQuestTracker(self, questid, remove)
    if not PlayerQuestTracker[self:getGuid()] then
        PlayerQuestTracker[self:getGuid()] = {}
    end
    if not Game.isValidQuest(questid) then
        return
    end
    local tracker = PlayerQuestTracker[self:getGuid()]
    if remove then
        for i, id in ipairs(tracker) do
            if id == questid then
                table.remove(tracker, i)
                break
            end
        end
    else
        if not table.contains(tracker, questid) then
            table.insert(tracker, questid)
        end
    end
end

function Player.getTrackerList(self)
    return PlayerQuestTracker[self:getGuid()] or {}
end

function Player.sendQuestTracker(self)
    local questlist = self:getTrackerList()
    local msg = NetworkMessage()
    msg:addByte(0xD0)
    msg:addByte(#questlist > 0 and 0x01 or 0x00) -- Show/hide tracker
    if #questlist > 0 then
        msg:addByte(0x04) -- Unknown (client-specific)
        msg:addByte(#questlist) -- Number of quests
        for _, questId in ipairs(questlist) do
            local quest = Game.getQuest(questId)
            if quest then
                msg:addU16(questId) -- Quest ID
                msg:addString(quest.name) -- Quest name
                for missionId = 1, #quest.missions do
                    if self:missionIsStarted(questId, missionId) then
                        msg:addString(self:getMissionName(questId, missionId)) -- Mission name
                        msg:addString(self:getMissionDescription(questId, missionId)) -- Mission description
                        break -- Only send the first active mission
                    end
                end
            end
        end
    end
    msg:sendToPlayer(self)
    msg:delete()
end

function Player.sendQuestLog(self)
    local msg = NetworkMessage()
    msg:addByte(0xF0)
    msg:addU16(Game.getQuestsCount(self))
    for questId = 1, #Quests do
        if self:questIsStarted(questId) then
            msg:addU16(questId)
            msg:addString(Quests[questId].name .. (self:questIsCompleted(questId) and " (completed)" or ""))
            msg:addByte(self:questIsCompleted(questId) and 1 or 0)
        end
    end
    msg:sendToPlayer(self)
    msg:delete()
end

function Player.sendQuestLine(self, questId)
    local quest = Game.getQuest(questId)
    if quest then
        local msg = NetworkMessage()
        msg:addByte(0xF1)
        msg:addU16(questId)
        msg:addByte(Game.getMissionsCount(self, questId))
        if quest.missions then
            for missionId = 1, #quest.missions do
                if self:missionIsStarted(questId, missionId) then
                    if self:getClient().version >= 1120 then
                        msg:addU16(questId)
                    end
                    msg:addString(self:getMissionName(questId, missionId))
                    msg:addString(self:getMissionDescription(questId, missionId))
                end
            end
        end
        if self:getClient().version > 1100 then
            self:sendQuestTracker()
        end
        msg:sendToPlayer(self)
        msg:delete()
    end
end

function Player.updateStorage(self, key, value, oldValue, currentFrameTime)
    local guid = self:getGuid()
    local trainingKeys = {37, 38, 12835} -- isTraining, isTrainingEvent, isTrainingStorage
    if not table.contains(trainingKeys, key) then
        if not LastQuestlogUpdate[guid] then
            LastQuestlogUpdate[guid] = 0
        end
        if LastQuestlogUpdate[guid] ~= currentFrameTime and Game.isQuestStorage(key, value, oldValue) then
            LastQuestlogUpdate[guid] = currentFrameTime
            self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your questlog has been updated.")
        end
    end
end