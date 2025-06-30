local bossRewardSystem = {}

if not globalBosses then
    globalBosses = {}
end
local function pushSeparated(buffer, sep, ...)
    local argv = {...}
    local argc = #argv
    for k, v in ipairs(argv) do
        table.insert(buffer, v)
        if k < argc and sep then
            table.insert(buffer, sep)
        end
    end
end

local function insertItems(buffer, info, parent, items)
    local start = info.running
    for _, item in ipairs(items) do
        if item ~= nil then
            if _ ~= 1 or parent > 100 then
                table.insert(buffer, ",")
            end
            info.running = info.running + 1
            table.insert(buffer, "(")
            pushSeparated(buffer, ",", info.playerGuid, parent, info.running, item:getId(), item:getSubType(), db.escapeString(item:serializeAttributes()))
            table.insert(buffer, ")")

            if item:isContainer() then
                local size = item:getSize()
                if size > 0 then
                    local subItems = {}
                    for i = 1, size do
                        table.insert(subItems, item:getItem(i - 1))
                    end

                    insertItems(buffer, info, info.running, subItems)
                end
            end
        end
    end
    return info.running - start
end

local function insertRewardItems(playerGuid, timestamp, itemList)
    db.asyncStoreQuery('select `pid`, `sid` from `player_rewards` where player_id = ' .. playerGuid .. ' order by `sid` ASC;',
        function(query)
            local lastReward = 0
            local lastStoreId
            if(query) then
                repeat
                    local sid = result.getDataInt(query, 'sid')
                    local pid = result.getDataInt(query, 'pid')

                    if pid < 100 then
                        lastReward = pid
                    end
                    lastStoreId = sid
                until not result.next(query)
            end

            local buffer = {'INSERT INTO `player_rewards` (`player_id`, `pid`, `sid`, `itemtype`, `count`, `attributes`) VALUES'}

            local info = {
                playerGuid = playerGuid,
                running = lastStoreId or 100
            }

            local bag = Game.createItem(ITEM_REWARD_CONTAINER)
            bag:setAttribute(ITEM_ATTRIBUTE_DATE, timestamp)
            if itemList then
                for _, p in ipairs(itemList) do
                    bag:addItem(p[1], p[2])
                end
            end

            local total = insertItems(buffer, info, lastReward + 1, {bag})
            table.insert(buffer, ";")

            if total ~= 0 then
                db.query(table.concat(buffer))
            end
        end
    )
end

local function getPlayerStats(bossId, playerGuid, autocreate)
    local ret = globalBosses[bossId][playerGuid]
    if not ret and autocreate then
        ret = {
            bossId = bossId,
            damageIn = 0,
            healing = 0,
        }
        globalBosses[bossId][playerGuid] = ret
        return ret
    end
    return ret
end

local creatureDeath = CreatureEvent("BossDeath")
function creatureDeath.onDeath(creature, corpse, killer, mostDamageKiller, lastHitUnjustified, mostDamageUnjustified)
    if creature:isPlayer() then
        for bossId, tb in pairs(globalBosses) do
            for playerId, tb2 in pairs(tb) do
                if playerId == Player(creature:getId()):getGuid() then
                    globalBosses[bossId][playerId] = nil
                end
            end
        end
        return true
    end

    local monsterType = creature:getType()
    if monsterType:isRewardBoss() then
        local bossId = creature:getId()
        local timestamp = os.time()

        local totalDamageOut, totalDamageIn, totalHealing = 0.1, 0.1, 0.1

        local scores = {}
        local info = globalBosses[bossId]
        local damageMap = creature:getDamageMap()
        
        if not info then
            globalBosses[bossId] = nil
            return true
        end

        for guid, stats in pairs(info) do
            local player = Player(stats.playerId)
            local part = damageMap[stats.playerId]
            local damageOut, damageIn, healing = (stats.damageOut or 0) + (part and part.total or 0), stats.damageIn or 0, stats.healing or 0

            totalDamageOut = totalDamageOut + damageOut
            totalDamageIn = totalDamageIn + damageIn
            totalHealing = totalHealing + healing

            table.insert(scores, {
                player = player,
                guid = guid,
                damageOut = damageOut,
                damageIn = damageIn,
                healing = healing,
            })
        end

        local participants = 0
        for _, con in ipairs(scores) do
            local score = (con.damageOut / totalDamageOut) + (con.damageIn / totalDamageIn) + (con.healing / totalHealing)
            con.score = score / 3
            if score ~= 0 then
                participants = participants + 1
            end
        end
        table.sort(scores, function(a, b) return a.score > b.score end)

        local expectedScore = 1 / participants

        for _, con in ipairs(scores) do
            local reward, stamina
            if con.player then
                reward = con.player:getReward(timestamp, true)
                stamina = con.player:getStamina()
            else
                stamina = con.stamina or 0
            end

            local playerLoot
            if con.score ~= 0 then
                local lootFactor = 1
                lootFactor = lootFactor / participants ^ (1 / 3)
                lootFactor = lootFactor * (1 + lootFactor) ^ (con.score / expectedScore)
                
                playerLoot = monsterType:getBossReward(lootFactor, _ == 1)

                if con.player then
                    for _, p in ipairs(playerLoot) do
                        reward:addItem(p[1], p[2])
                    end
                end
            end

            if con.player and con.score ~= 0 then
                local killMessage = "Congratulations! You have defeated " .. creature:getName() .. "!"
                con.player:sendTextMessage(MESSAGE_EVENT_ADVANCE, killMessage)
                
                local lootMessage = {"The following items are available in your reward chest: "}
                reward:getContentDescription(lootMessage, con.player:getClient().version)
                table.insert(lootMessage, ".")
                con.player:sendTextMessage(MESSAGE_LOOT, table.concat(lootMessage))
            elseif con.score ~= 0 then
                insertRewardItems(con.guid, timestamp, playerLoot)
            end
        end

        globalBosses[bossId] = nil
    end
    return true
end
creatureDeath:register()

local creatureThink = CreatureEvent("BossThink")
function creatureThink.onThink(creature, interval)
    local bossId = creature:getId()
    local info = globalBosses[bossId]
    if not info then
        if creature:getType():isRewardBoss() then
            globalBosses[bossId] = {}
            info = globalBosses[bossId]
        else
            return true
        end
    end
    
    for _, player in pairs(info) do
        player.active = false
    end
    
    local targets = creature:getTargetList()
    for _, target in ipairs(targets) do
        if target:isPlayer() then
            local stats = getPlayerStats(bossId, target:getGuid(), true)
            stats.playerId = target:getId()
            stats.active = true
        end
    end
    
    return true
end
creatureThink:register()

local healthChange = CreatureEvent("BossHealthChange")
function healthChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if attacker and attacker:isPlayer() and creature and creature:isMonster() then
        local monsterType = creature:getType()
        if monsterType:isRewardBoss() then
            local bossId = creature:getId()
            
            if not globalBosses[bossId] then
                globalBosses[bossId] = {}
            end
            
            local playerGuid = attacker:getGuid()
            local stats = getPlayerStats(bossId, playerGuid, true)
            stats.playerId = attacker:getId()
            stats.active = true
            stats.bossId = bossId
            
            return primaryDamage, primaryType, secondaryDamage, secondaryType
        end
    end
    
    if creature and creature:isPlayer() then
        local stats = creature:inBossFight()
        
        if stats then
            local creatureId, attackerId = creature:getId(), attacker:getId()
            stats.playerId = creatureId

            if primaryType == COMBAT_HEALING and attacker:isPlayer() and attackerId ~= creatureId then
                local healerStats = getPlayerStats(stats.bossId, attacker:getGuid(), true)
                healerStats.active = true
                healerStats.playerId = attackerId
                healerStats.healing = healerStats.healing + primaryDamage
            elseif stats.bossId == attackerId then
                stats.damageIn = stats.damageIn + primaryDamage
            end
        end
    end
    
    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
healthChange:register()

local playerLogin = CreatureEvent("BossLogin")
function playerLogin.onLogin(player)
    player:registerEvent("BossDeath")
    player:registerEvent("BossHealthChange")
    return true
end
playerLogin:register()

local startupEvent = GlobalEvent("BossSystemStartup")
function startupEvent.onStartup()
    if not globalBosses then
        globalBosses = {}
    end
    
    for _, creature in ipairs(Game.getMonsters()) do
        creature:registerEvent("BossHealthChange")
        
        if creature:getType():isRewardBoss() then
            creature:registerEvent("BossThink")
        end
    end
    
    for _, player in ipairs(Game.getPlayers()) do
        player:registerEvent("BossDeath")
        player:registerEvent("BossHealthChange")
    end
    
    print(">> Boss Reward System loaded successfully!")
    return true
end
startupEvent:register()

local ec = Event()
ec.onSpawn = function(creature, position, startup, artificial)
    if creature:isMonster() then
        creature:registerEvent("BossHealthChange")
        
        if creature:getType():isRewardBoss() then
            creature:registerEvent("BossThink")
        end
    end
    return true
end
ec:register()

return bossRewardSystem