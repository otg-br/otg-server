if not Game.getStorageValue(RELOAD_TYPE_QUESTS) or Game.getStorageValue(RELOAD_TYPE_QUESTS) ~= 1 then
	Game.setStorageValue(RELOAD_TYPE_QUESTS, 1)
	Quests = {
		
		
		
		
		[38] = {
			name = "Forgotten Knowledge", startstorageid = Storage.ForgottenKnowledge.Tomes, startstoragevalue = 1,
			missions = {
				[1] = {
					name = "Circle of the Black Sphinx", storageid = Storage.ForgottenKnowledge.LadyTenebrisKilled, startvalue = 0, endvalue = 1522018605,
					states = {
						[1] = "You defeated the rogue Lady Tenebris.",
					},
				},
				[2] = {
					name = "Bane of the Cosmic Force", storageid = Storage.ForgottenKnowledge.LloydKilled, startvalue = 0, endvalue = 1522018605,
					states = {
						[1] = "You calmed poor, misguided Lloyd. All he wanted was protection from the outside world. Luckily he seems to have learned his lesson... or has he?",
					},
				},
				[3] = {
					name = "The Desecrated Glade", storageid = Storage.ForgottenKnowledge.ThornKnightKilled, startvalue = 0, endvalue = 1522018605,
					states = {
						[1] = "You defeated the Thorn Knight and shattered the root of evil with all your might. The honour of being a guardian of the glade indeed comes with pride as well as responsibility.",
					},
				},
				[4] = {
					name = "The Unwary Mage", storageid = Storage.ForgottenKnowledge.DragonkingKilled, startvalue = 0, endvalue = 1522018605,
					states = {
						[1] = "With help of Ivalisse from the temple of the Astral Shapers in Thais and her father, you averted the Dragon King's menace deep in the Zao Muggy Plains.",
					},
				},
				[5] = {
					name = "Dragon in Distress", storageid = Storage.ForgottenKnowledge.HorrorKilled, startvalue = 0, endvalue = 1522018605,
					states = {
						[1] = "You saved the Dragon Mother's egg and she melted the ice wall that blocked your way.",
					},
				},
				[6] = {
					name = "Time is a Window", storageid = Storage.ForgottenKnowledge.TimeGuardianKilled, startvalue = 0, endvalue = 1522018605,
					states = {
						[1] = "You defeated the Time Guardian and are free to return to your own time. For some creatures in this world, it seems neither past nor future are an obstacle.",
					},
				},
				[7] = {
					name = "Final Fight", storageid = Storage.ForgottenKnowledge.LastLoreKilled, startvalue = 0, endvalue = 1522018605,
					states = {
						[1] = "Description Fault.",
					},
				},
			},
		},
		
		
		
		
	}

	print(">> Loaded ".. #Quests .." quests")
end

if not LastQuestlogUpdate then
	LastQuestlogUpdate = {}
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
					if mission then
						if mission.storageid == key and value >= mission.startvalue and value <= mission.endvalue then
							return mission.description or oldValue < mission.storageid or oldValue > mission.endvalue;
						end
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
	if quest then
		local missions = quest.missions
		if missions then
			for missionId = 1, #missions do
				if player:missionIsStarted(questId, missionId) then
					count = count + 1
				end
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
	if quest and self:getStorageValue(quest.startstorageid) ~= -1 or self:getStorageValue(quest.startstorageid) >= quest.startstoragevalue then
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
	if quest then
		local missions = quest.missions
		if missions then
			-- if(self:missionIsCompleted(questId, #missions))then
				-- return true
			-- end
			for missionId = 1, #missions do
				if not self:missionIsCompleted(questId, missionId) then
					return false
				end
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
		return evaluateText(mission.states[state], self)
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

	if remove then
		table.remove(PlayerQuestTracker[self:getGuid()], questid)
	else
		table.insert(PlayerQuestTracker[self:getGuid()], questid)
	end

end

function Player.getTrackerList(self)
	return PlayerQuestTracker[self:getGuid()]
end

function Player.sendQuestTracker(self)
	local questlist = self:getTrackerList() or {}
	local tamanho = #questlist or 0
	local msg = NetworkMessage()
	msg:addByte(0xD0)
	-- msg:addByte(tamanho > 0 and 0x01 or 0x00) -- show
	msg:addByte(0x01) -- show
		msg:addByte(0x4) -- unknow
		msg:addByte(1) -- number of quests

			msg:addU16(0x16) -- quest id
				msg:addString("quest.name") -- quest name
					msg:addString("quest.mission") -- mission name
					msg:addString("quest.description") -- description
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
			msg:addString(Quests[questId].name .. ""..(self:questIsCompleted(questId) and " (completed)" or ""))
			msg:addByte(self:questIsCompleted(questId))
		end
	end
	msg:sendToPlayer(self)
	msg:delete()
end

function Player.sendQuestLine(self, questId)
	local quest = Game.getQuest(questId)
	if quest then
		local missions = quest.missions
		local msg = NetworkMessage()
		msg:addByte(0xF1)
		msg:addU16(questId)
		msg:addByte(Game.getMissionsCount(self, questId))
		if missions then
			for missionId = 1, #missions do
				if self:missionIsStarted(questId, missionId) then
					if (self:getClient().version >= 1120)then
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
	if LastQuestlogUpdate[guid] ~= currentFrameTime and Game.isQuestStorage(key, value, oldValue) then
		LastQuestlogUpdate[guid] = currentFrameTime
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your questlog has been updated.")
	end
end
