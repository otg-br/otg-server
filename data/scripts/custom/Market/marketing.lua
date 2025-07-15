local marketing_area = {
	{["init"] = {x = 85, y = 110, z = 7}, ["end"] = {x = 104, y = 128, z = 7}}, -- Ankrahmun
	{["init"] = {x = 33204, y = 32454, z = 9}, ["end"] = {x = 33224, y = 32467, z = 9}}, -- Darashia
	{["init"] = {x = 33158, y = 31801, z = 11}, ["end"] = {x = 33178, y = 31815, z = 11}}, -- Edron
	{["init"] = {x = 32618, y = 32736, z = 8}, ["end"] = {x = 32636, y = 32748, z = 8}}, -- Port Hope
	{["init"] = {x = 32324, y = 31774, z = 9}, ["end"] = {x = 32345, y = 31786, z = 9}}, -- Carlin
	{["init"] = {x = 32343, y = 32217, z = 4}, ["end"] = {x = 32355, y = 32232, z = 4}}, -- Thais
	{["init"] = {x = 32677, y = 31682, z = 2}, ["end"] = {x = 32683, y = 31690, z = 2}}, -- Ab
	{["init"] = {x = 32677, y = 31682, z = 1}, ["end"] = {x = 32683, y = 31690, z = 1}}, -- Ab
	-- Adicionar área que inclui PZ (Thais Temple)
	{["init"] = {x = 32360, y = 32210, z = 7}, ["end"] = {x = 32370, y = 32220, z = 7}}, -- Thais Temple PZ
}

local marketMaxItems = 40

local subItems = 	{2316, 2266, 2291, 2290, 2310, 2261, 2277, 2279, 2262, 2292, 2313, 2301, 2303, 				-- Runas
					2302, 2305, 2304, 2311, 2265, 2287, 2293, 2273, 2285, 2289, 2286, 2308, 2268, 2273, 		-- Runas
					2671, 2666, 2672, 5109, 2789, 2667,															-- Foods
					1294, 2389, 2399, 2410, 2543, 2544, 2545, 2546, 5493, 5494}									-- Municoes
													
local subItemsRestritive = true

-- ADD TO DATABASE

local globalEvent = GlobalEvent("MarketingTables")
function globalEvent.onStartup()

	local columns_marketing_infos = [[(
		`player_id` int NOT NULL DEFAULT '0',
		`player_name` varchar(32) NOT NULL,
		`uid` int unsigned NOT NULL DEFAULT '0',
		`subitem` varchar(32) NOT NULL,
		`itemtype` smallint unsigned NOT NULL DEFAULT '0',
		`count` smallint NOT NULL DEFAULT '0',
		`price` bigint NOT NULL DEFAULT '0',
		`rarity` smallint NOT NULL DEFAULT '0',
		`attributes` blob NOT NULL,
		`completed` varchar(32) NOT NULL DEFAULT 'false',
		FOREIGN KEY (`player_id`) REFERENCES `players`(`id`) ON DELETE CASCADE
	)]]
	if not db.tableExists("player_marketing") then
		db.query("CREATE TABLE `player_marketing` "..columns_marketing_infos.."")
	end

	local columns_marketing_reward_infos = [[(
		`player_name` varchar(32) NOT NULL,
		`uid` int unsigned NOT NULL DEFAULT '0',
		`reward` bigint NOT NULL DEFAULT '0',
		`completed` varchar(32) NOT NULL DEFAULT 'false'
	)]]
	if not db.tableExists("player_marketing_reward") then
		db.query("CREATE TABLE `player_marketing_reward` "..columns_marketing_reward_infos.."")
	end

	Game.loadMarketing()

	return true
end
globalEvent:register()

creatureEvent = CreatureEvent("MarketingLogin")
function creatureEvent.onLogin(player)
	player:registerEvent("MarketingInfo")

	local marketPos = nil
	for _, market in pairs(Game.getMonsters()) do
		if market:getName() == player:getName() then
			market:remove()
			marketPos = market:getPosition()
		end
	end

	if marketPos then
		player:teleportTo(player:getPosition())
	end

	local resultReward = db.storeQuery("SELECT * FROM `player_marketing_reward` WHERE `player_name` = "..db.escapeString(player:getName()).." AND `completed` = "..db.escapeString("false").."")
	if (resultReward) then
		repeat
		local reward = result.getNumber(resultReward, "reward")
		if reward then
			player:addMoney(reward)
		end
		until not result.next(resultReward)
		result.free(resultReward)
		db.query("UPDATE `player_marketing_reward` set `completed` = true WHERE `player_name` = "..db.escapeString(player:getName()).." AND `completed` = "..db.escapeString("false").."")
	end

	for _, pid in pairs(Game.getPlayers()) do
		local finish = json.encode({action = "Finish", market = player:getName()})
		pid:sendExtendedOpcode(96, finish)
	end

	return true
end

creatureEvent:register()

creatureEvent = CreatureEvent("MarketingInfo")
function creatureEvent.onExtendedOpcode(player, opcode, buffer)
	local buffer_status, buffer_decode = pcall(function() return json.decode(buffer) end)
	if opcode == 96 then

		if buffer_decode.action == "Refresh" then

			-- if buffer_decode.market == player:getName() then
			-- 	if player:getStorageValue(175420) < os.time() then
			-- 		player:popupFYI("You need to purchase the Pack in the Store \n             to activate your Market.")
			-- 		return
			-- 	end
			-- end

			local refresh = json.encode({action = "Refresh", market = buffer_decode.market, data = Game.getMarketingOffers(buffer_decode.market)})
			player:sendExtendedOpcode(96, refresh)

			local coins = json.encode({action = "coins", data = {gold = player:getMoney()}})
			player:sendExtendedOpcode(96, coins)

		elseif buffer_decode.action == "Add" then

			if player:getSlotItem(3) then
				local item = player:getSlotItem(3):getItems()[buffer_decode.data.pos+1]
				if item then
					if item:getId() == Game.getItemTypeByClientId(buffer_decode.data.id):getId() then
						if item:getCharges() > 1 and item:getCharges() == buffer_decode.data.quant or item:getCount() == buffer_decode.data.quant then
							local inMarketArea = false
							for _, area in pairs(marketing_area) do
								if player:getPosition().x >= area["init"].x and player:getPosition().x <= area["end"].x
								and player:getPosition().y >= area["init"].y and player:getPosition().y <= area["end"].y
								and player:getPosition().z >= area["init"].z and player:getPosition().z <= area["end"].z then
									inMarketArea = true
									break
								end
							end
							if inMarketArea then
								if ItemType(item:getId()):isContainer() then
									if #item:getItems() > 0 then
										local lastID = item:getItems()[1]:getId()
										for _, eachItem in pairs(item:getItems()) do
											if not table.contains(subItems, eachItem:getId()) then
												local msg = json.encode({action = "msg", data = {msg = "It is not permitted to sell backpacks \n      with this type of item inside."}})
												player:sendExtendedOpcode(96, msg)

												return false
											end

											if subItemsRestritive then
												if eachItem:getId() ~= lastID then
													local msg = json.encode({action = "msg", data = {msg = "You can only put one type \n of item in your backpack."}})
													player:sendExtendedOpcode(96, msg)

													return false
												end
											end
										end
									end
								end

								if #Game.getMarketingOffers(player:getName()) >= marketMaxItems then
									local msg = json.encode({action = "msg", data = {msg = "The maximum number of items that can \n  be put up for sale in the Market is "..marketMaxItems.."."}})
									player:sendExtendedOpcode(96, msg)
									return
								end

								-- if player:getStorageValue(175420) < os.time() then
								-- 	local msg = json.encode({action = "msg", data = {msg = "You need to purchase the Pack in the Store \n             to activate your Market."}})
								-- 	player:sendExtendedOpcode(96, msg)
								-- 	return false
								-- end

								if not item:getCustomAttribute("uid") then
									uid = 65536
									local resultUID = db.storeQuery("SELECT * FROM `player_marketing` ORDER BY `uid` DESC LIMIT 1")
									if resultUID then
										uid = (result.getNumber(resultUID, "uid")+1 > uid and result.getNumber(resultUID, "uid")+1 or uid)
										result.free(resultUID)
									end
									item:setCustomAttribute("uid", uid)
								end

								Game.addMarketingOffer(player:getName(), item:getCustomAttribute("uid"), item, buffer_decode.data.price, buffer_decode.data.rarity)

								for _, pid in pairs(Game.getPlayers()) do
									local refresh = json.encode({action = "Refresh", market = buffer_decode.market, data = Game.getMarketingOffers(player:getName())})
									pid:sendExtendedOpcode(96, refresh)
								end
							else
								local msg = json.encode({action = "msg", data = {msg = "You must be within the permitted areas \n   of the Market to add/remove items."}})
								player:sendExtendedOpcode(96, msg)
							end
						else
							local msg = json.encode({action = "msg", data = {msg = "Select an item inside your main backpack \n                  and dont move it."}})
							player:sendExtendedOpcode(96, msg)
						end
					else
						local msg = json.encode({action = "msg", data = {msg = "Select an item inside your main backpack \n                  and dont move it."}})
						player:sendExtendedOpcode(96, msg)
					end
				else
					local msg = json.encode({action = "msg", data = {msg = "The item must be inside your main backpack."}})
					player:sendExtendedOpcode(96, msg)
				end
			end

		elseif buffer_decode.action == "Remove" then

			if not Game.removeMarketingOffer(player:getName(), buffer_decode.data.uid) then
				local msg = json.encode({action = "msg", data = {msg = "You do not have enough CAP \n        to receive this item."}})
				player:sendExtendedOpcode(96, msg)
				return false
			end

			for _, pid in pairs(Game.getPlayers()) do
				local refresh = json.encode({action = "Refresh", market = buffer_decode.market, data = Game.getMarketingOffers(player:getName())})
				pid:sendExtendedOpcode(96, refresh)
			end

		elseif buffer_decode.action == "Buy" then

			local player_market = Player(buffer_decode.market)
			if not player_market then
				local priceAmount = 0
				for x, offer in pairs(Game.getMarketingOffers(buffer_decode.market)) do
					if offer.uid == buffer_decode.data.uid then
						priceAmount = offer.price*buffer_decode.data.quant
					end
				end
				if player:getMoney() >= priceAmount then
					if not Game.buyMarketingOffer(player, buffer_decode.market, buffer_decode.data.uid, buffer_decode.data.quant) then
						local msg = json.encode({action = "msg", data = {msg = "You do not have enough CAP \n        to receive this item."}})
						player:sendExtendedOpcode(96, msg)
						return false
					end

					player:removeMoney(priceAmount)

					for _, pid in pairs(Game.getPlayers()) do
						local refresh = json.encode({action = "Refresh", market = buffer_decode.market, data = Game.getMarketingOffers(buffer_decode.market)})
						pid:sendExtendedOpcode(96, refresh)
					end

					local coins = json.encode({action = "coins", data = {gold = player:getMoney()}})
					player:sendExtendedOpcode(96, coins)
				else
					local msg = json.encode({action = "msg", data = {msg = "You do not have all the gold coins \n        to purchase this item."}})
					player:sendExtendedOpcode(96, msg)
				end
			end

		elseif buffer_decode.action == "Start" then

			local function formatMarketDescription(description)
				if #description > 40 then
					description = description:sub(1, 40) -- Return the string up to the character limit
				end

				local result = ""
				if #description > 20 then
					for i = 1, #description, 20 do
						result = ""..result..""..description:sub(i, i + 20 - 1).."\n"
					end
				else
					result = description
				end

				return result
			end

				-- Permitir criação do Market em qualquer lugar (incluindo PZ)
				local inMarketArea = true
				
				local randomPos = {
					{x = player:getPosition().x-1, y = player:getPosition().y-1, z = player:getPosition().z},
					{x = player:getPosition().x-1, y = player:getPosition().y, z = player:getPosition().z},
					{x = player:getPosition().x-1, y = player:getPosition().y+1, z = player:getPosition().z},
					{x = player:getPosition().x, y = player:getPosition().y-1, z = player:getPosition().z},
					{x = player:getPosition().x, y = player:getPosition().y, z = player:getPosition().z},
					{x = player:getPosition().x, y = player:getPosition().y+1, z = player:getPosition().z},
					{x = player:getPosition().x+1, y = player:getPosition().y-1, z = player:getPosition().z},
					{x = player:getPosition().x+1, y = player:getPosition().y, z = player:getPosition().z},
					{x = player:getPosition().x+1, y = player:getPosition().y+1, z = player:getPosition().z}
				}
				
				local checkCreature = false
				for _, pos in pairs(randomPos) do
					local tile = Tile(pos)
					if tile then
						if tile:getBottomCreature() then
							if tile:getBottomCreature():getId() ~= player:getId() then
								checkCreature = true
							end
						end
					end
				end

				if checkCreature then
					local msg = json.encode({action = "msg", data = {msg = "You need space around you \n     to open your Market."}})
					player:sendExtendedOpcode(96, msg)
					return false
				end


				local market = Game.createMonster("Market", player:getPosition(), true, true)
				if market then
					market:rename(player:getName())
					market:teleportTo(player:getPosition())
					market:setMarketDescription(formatMarketDescription(buffer_decode.description))
					player:remove()
				else
					-- Tentar criar em uma posição diferente se falhar
					local altPos = Position(player:getPosition().x + 1, player:getPosition().y, player:getPosition().z)
					local marketAlt = Game.createMonster("Market", altPos, true, true)
					if marketAlt then
						marketAlt:remove()
					end
				end

		elseif buffer_decode.action == "Open" then

			local datted = {}
			for _, item in pairs(Game.getMarketingSubOffers(buffer_decode.data.market, buffer_decode.data.uid)) do
				table.insert(datted, {uid = 0, name = item:getName(), id = ItemType(item:getId()):getClientId(), quant = item:getCount(), price = 0, rarity = 0, look = "You see "..item:getDescription(0)..""})
			end

			if #datted <= 0 then
				return false
			end

			local refresh = json.encode({action = "Refresh", market = buffer_decode.market, data = datted, oppened = true})
			player:sendExtendedOpcode(96, refresh)

		elseif buffer_decode.action == "RefreshPos" then

			local refreshpos = json.encode({action = "marketpos", marketpos = marketing_area})
			player:sendExtendedOpcode(96, refreshpos)

		end

	end

	return true
end
creatureEvent:register()

local event = EventCallback
event.onMoveItem = function(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)

	if self:isPlayer() then

		local inMarketArea = false
		for _, area in pairs(marketing_area) do
			if self:getPosition().x >= area["init"].x and self:getPosition().x <= area["end"].x
			and self:getPosition().y >= area["init"].y and self:getPosition().y <= area["end"].y
			and self:getPosition().z >= area["init"].z and self:getPosition().z <= area["end"].z then
				inMarketArea = true
				break
			end
		end
		if inMarketArea then
			if self:getSlotItem(3) then
				if item == self:getSlotItem(3) then
					return RETURNVALUE_NOTPOSSIBLE
				end
			end
		end

	end

	return RETURNVALUE_NOERROR
end
event:register()