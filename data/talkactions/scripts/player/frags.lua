function onSay(player, word, param)
	local fragTime = configManager.getNumber(configKeys.FRAG_TIME)
	local killsToRedDay = 5
	local killsToRedWeek = 15
	local killsToRedMonth = 30

	local resultId = db.storeQuery("SELECT `player_id`, `time` FROM `player_kills` WHERE `player_id` = " .. player:getGuid())
	local now = os.time()
	local dayFrags, weekFrags, monthFrags = 0, 0, 0
	local allFrags = 0
	if resultId then
		repeat
			local killTime = result.getNumber(resultId, "time")
			allFrags = allFrags + 1
			if now - killTime <= 24*60*60 then
				dayFrags = dayFrags + 1
			end
			if now - killTime <= 7*24*60*60 then
				weekFrags = weekFrags + 1
			end
			if now - killTime <= 30*24*60*60 then
				monthFrags = monthFrags + 1
			end
		until not result.next(resultId)
		result.free(resultId)
	end

	local kills = player:getKills()
	if kills then
		for _, kill in pairs(kills) do
			allFrags = allFrags + 1
			local killTime = kill.time
			if killTime then
				if now - killTime <= 24*60*60 then
					dayFrags = dayFrags + 1
				end
				if now - killTime <= 7*24*60*60 then
					weekFrags = weekFrags + 1
				end
				if now - killTime <= 30*24*60*60 then
					monthFrags = monthFrags + 1
				end
			end
		end
	end

	if allFrags <= 0 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, string.format(
			"You do not have any unjustified kills.\nRed skull: %d (day), %d (week), %d (month).",
			killsToRedDay, killsToRedWeek, killsToRedMonth))
		return false
	end

	local skullTime = player:getSkullTime()
	local fragTimeLeft = ""
	if skullTime > 0 then
		local remainingSeconds = math.floor(skullTime % fragTime)
		local hours = math.floor(remainingSeconds / 3600)
		local minutes = math.floor((remainingSeconds % 3600) / 60)
		local seconds = remainingSeconds % 60
		fragTimeLeft = "The next frag will expire in: "
		if hours ~= 0 then
			fragTimeLeft = fragTimeLeft .. hours .. (hours == 1 and " hour, " or " hours, ")
		end
		if hours ~= 0 or minutes ~= 0 then
			fragTimeLeft = fragTimeLeft .. minutes .. (minutes == 1 and " minute and " or " minutes and ")
		end
		fragTimeLeft = fragTimeLeft .. seconds .. (seconds == 1 and " second." or " seconds.")
	end

	local msg = string.format(
		"You have %d unjustified kills.\nUnjustified points gained during the last 24 hours: %d/%d (%d kills left).\nUnjustified points gained during the last 7 days: %d/%d (%d kills left).\nUnjustified points gained during the last 30 days: %d/%d (%d kills left).\n%s",
		allFrags,
		dayFrags, killsToRedDay, math.max(0, killsToRedDay - dayFrags),
		weekFrags, killsToRedWeek, math.max(0, killsToRedWeek - weekFrags),
		monthFrags, killsToRedMonth, math.max(0, killsToRedMonth - monthFrags),
		fragTimeLeft
	)
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, msg)
	return false
end