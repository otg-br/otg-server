local events = {
	'PlayerDeath',
	'AdvanceSave',
	'DropLoot',
	'DeathCounter',
	'KillCounter',
	'bless1',
	'petlogin',
	'petthink',
	'BossesKill',
	'ImpactAnalyzer',
}


local function confirmAddItem(playerid)
	local config = {
		--club, coat
		items = {{2398, 1}, {2461, 1}, {2467, 1}, {2649, 1}},
		--container rope, shovel, red apple
		container = {{2120, 1}, {2554, 1}, {2674, 2}}

	}

	local player = Player(playerid)
	if not player then return end
	
	local targetVocation = config
	if (player:getSlotItem(CONST_SLOT_LEFT)) then
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


local function onMovementRemoveProtection(cid, oldPosition, time)
	local player = Player(cid)
		if not player then
		return true
	end

	local playerPosition = player:getPosition()
	if (playerPosition.x ~= oldPosition.x or playerPosition.y ~= oldPosition.y or playerPosition.z ~= oldPosition.z) or player:getTarget() then
		player:setStorageValue(Storage.combatProtectionStorage, 0)
		return true
	end

	addEvent(onMovementRemoveProtection, 1000, cid, oldPosition, time - 1)
end

function onLogin(player)
	
	local isTrainingStorage = 12835
	if player:getStorageValue(isTrainingStorage) >= 1 then
		player:setStorageValue(isTrainingStorage, -1)
	end

	-- remover dps
	player:addOutfit(151)
	player:addOutfit(155)

	local vipMounts = {
		113, 114, 115
	}

	if player:getVipDays() > os.stime() then
		for _, mount in pairs(vipMounts) do
			if not player:hasMount(mount) then
				player:addMount(mount)
			end
		end
	end


	local vipOutfits = {
		1202, 1203, 1204, 1205, 1206, 1207
	}

	if player:getVipDays() > os.stime() then
		for _, outfit in pairs(vipOutfits) do
			-- entregando o outfit
			player:addOutfit(outfit)
			-- entregando a outfit
			player:addOutfitAddon(outfit, 0)
			player:addOutfitAddon(outfit, 1)
			player:addOutfitAddon(outfit, 2)
		end
	end

	local g = player:getGuild()
	if g then
		if player:getLevel() >= CONFIG_GUILD_LEVEL.minLevelToGetPoints then
			player:registerEvent('guildLevel')
		end
		player:registerEvent('guildLevel_e')
	end	

	local loginStr = 'Welcome to ' .. configManager.getString(configKeys.SERVER_NAME) .. '!'
	if player:getLastLoginSaved() <= 0 then
		addEvent(confirmAddItem, 2000, player:getGuid())
		loginStr = loginStr .. ' Please choose your outfit.'
		player:setBankBalance(0)

		if player:getSex() == 1 then
			player:setOutfit({lookType = 128, lookHead = 78, lookBody = 106, lookLegs = 58, lookFeet = 76})
		else
			player:setOutfit({lookType = 136, lookHead = 78, lookBody = 106, lookLegs = 58, lookFeet = 76})
		end

		player:sendTutorial(1)
	else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end

		loginStr = string.format('Your last visit was on %s.', os.sdate('%a %b %d %X %Y', player:getLastLoginSaved()))
	end
    
	AutoLootList:onLogin(player:getId())
	
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
	if Game.getBoostMonster():lower() ~= 'none' and MonsterType(Game.getBoostMonster()) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("Today's boosted creature: %s\nBoosted creatures yield more experience points, carry more loot than usual and respawn at a faster rate.", MonsterType(Game.getBoostMonster()):getName()))
	end

	if player:getClient().version == 1100 then
		player:openChannel(10) -- LOOT CHANNEL
	end

	-- exercise Weapon
	player:setStorageValue(37 , -1)
	player:setStorageValue(38 , -1)

	local playerId = player:getId()

	if (player:getGroup():getId() > 4) then
		player:setGhostMode(true)
	end

	-- Stamina
	nextUseStaminaTime[playerId] = 1

	-- EXP Stamina
	nextUseXpStamina[playerId] = 1

	--daily reward
	player:initDailyRewardSystem()


	if (player:getAccountType() == ACCOUNT_TYPE_TUTOR) then
		local msg = [[:: Tutor Rules
	������������1 *> 3 Warnings you lose the job.
	������������2 *> Without parallel conversations with players in Help, if the player starts offending, you simply mute it.
	������������3 *> Be educated with the players in Help and especially in the Private, try to help as much as possible.
	������������4 *> Always be on time, if you do not have a justification you will be removed from the staff.
	������������5 *> Help is only allowed to ask questions related to tibia.
	������������6 *> It is not allowed to divulge time up or to help in quest.
	������������7 *> You are not allowed to sell items in the Help.
	������������8 *> If the player encounters a bug, ask to go to the website to send a ticket and explain in detail.
	������������9 *> Always keep the Tutors Chat open. (required).
	������������10 *> You have finished your schedule, you have no tutor online, you communicate with some CM in-game or ts and stay in the help until someone logs in, if you can.
	������������11 *> Always keep a good Portuguese in the Help, we want tutors who support, not that they speak a satanic ritual.
	������������12 *> If you see a tutor doing something that violates the rules, take a print and send it to your superiors. "
	������������- Commands -
	������������Mute Player: / mute nick, 90. (90 seconds)
	������������Unmute Player: / unmute nick.
	������������- Commands -]]
		player:popupFYI(msg)
	end


	-- OPEN CHANNELS
	if table.contains({"Raccon", "Carlin"}, player:getTown():getName())then
		player:openChannel(7) -- help channel
		player:openChannel(3) -- world chat
		player:openChannel(5) -- advertsing main
	end

	--
	-- Rewards
	local rewards = #player:getRewardList()
	if(rewards > 0) then
		player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You have %d %s in your reward chest.", rewards, rewards > 1 and "rewards" or "reward"))
	end

	-- Update player id
	local stats = player:inBossFight()
	if stats then
		stats.playerId = player:getId()
	end

	-- Events
	for i = 1, #events do
		player:registerEvent(events[i])
		player:registerEvent("AutoLoot")
	end

    -- --Imbuements
	     	player:setStorageValue(10167, 5)
	     	player:setStorageValue(10132, 1)
			player:setStorageValue(10133, 1)
			player:setStorageValue(10134, 1)
			player:setStorageValue(10135, 1)
			player:setStorageValue(10136, 1)
			player:setStorageValue(10137, 1)
			player:setStorageValue(10138, 1)
			player:setStorageValue(10148, 1)
			player:setStorageValue(10139, 1)
			player:setStorageValue(10142, 1)
			player:setStorageValue(10146, 1)
			player:setStorageValue(10145, 1)
			player:setStorageValue(10144, 1)
			player:setStorageValue(10143, 1)
			player:setStorageValue(10151, 1)
			player:setStorageValue(10163, 1)
			player:setStorageValue(10164, 1)
			player:setStorageValue(10165, 1)
			player:setStorageValue(10166, 1)
			player:setStorageValue(10168, 1)
			player:setStorageValue(10169, 1)
			player:setStorageValue(10150, 1)
			player:setStorageValue(10152, 1)
			player:setStorageValue(10154, 1)
			player:setStorageValue(10156, 1)
			player:setStorageValue(10158, 1)
			player:setStorageValue(10160, 1)
			player:setStorageValue(10162, 1)

			
			
			
	if player:getStorageValue(Storage.combatProtectionStorage) < 1 then
		player:setStorageValue(Storage.combatProtectionStorage, 1)
		onMovementRemoveProtection(playerId, player:getPosition(), 10)
	end

	local days = math.max(0, math.ceil((player:getVipDays() - os.stime())  / 86400 ))
	if player:getVipDays() > os.stime() then
		player:setStorageValue(Storage.VipSystem, 1)
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You have %d day%s vip.", days, (days > 1 and "s" or "")))

	if player:getStorageValue(Storage.VipSystem) > -1 then
		if player:getVipDays() <= os.stime() then
			player:setStorageValue(Storage.VipSystem, -1)

			if player:getSex() == 1 then
				player:setOutfit({lookType = 128, lookAddons = 0})
			else
				player:setOutfit({lookType = 136, lookAddons = 0})
			end
			player:teleportTo(player:getTown():getTemplePosition(), true)
			player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Your vip is over."))
		end
	end

	if configManager.getDouble(configKeys.SPAWN_SPEED) > 1.0 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("All spawns are faster."))
	end

	player:updateExpState()
	player:setStorageValue(Storage.combatProtectionStorage, -1)

	return true
end
