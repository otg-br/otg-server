local skills = {
    [33082] = {id = SKILL_SWORD, voc = {4}}, -- KNIGHT
    [33083] = {id = SKILL_AXE, voc = {4}}, -- KNIGHT
    [33084] = {id = SKILL_CLUB, voc = {4}}, -- KNIGHT
    [33085] = {id = SKILL_DISTANCE, voc = {3}, range = CONST_ANI_SIMPLEARROW}, -- PALADIN
    [33086] = {id = SKILL_MAGLEVEL, voc = {1, 2, 3, 4}, range = CONST_ANI_SMALLICE}, -- DRUID
    [33087] = {id = SKILL_MAGLEVEL, voc = {1, 2, 3, 4}, range = CONST_ANI_FIRE}, -- SORCERER
    [32124] = {id = SKILL_SWORD, voc = {4}}, -- KNIGHT (Free)
    [32125] = {id = SKILL_AXE, voc = {4}}, -- KNIGHT (Free)
    [32126] = {id = SKILL_CLUB, voc = {4}}, -- KNIGHT (Free)
    [32127] = {id = SKILL_DISTANCE, voc = {3}, range = CONST_ANI_SIMPLEARROW}, -- PALADIN (Free)
    [32128] = {id = SKILL_MAGLEVEL, voc = {1, 2, 3, 4}, range = CONST_ANI_SMALLICE}, -- DRUID (Free)
    [32129] = {id = SKILL_MAGLEVEL, voc = {1, 2, 3, 4}, range = CONST_ANI_FIRE} -- SORCERER (Free)
}

local dummies = {32142, 32143, 32144, 32145, 32146, 32147, 32148, 32149}
local house_dummies = {32143, 32144, 32145, 32146, 32147, 32148}
local isTraining = 37
local isTrainingEvent = 38
local isTrainingStorage = 12835

local function start_train(pid, start_pos, itemid, fpos, t_id)
    local player = Player(pid)
    if not player then
        return
    end

    local b_ = isInArray(house_dummies, t_id) and 1.1 or 1
    local skillRate = 1.666 -- Normal training rate
    if itemid == 32124 or itemid == 33082 then
        skillRate = Game.getSkillStage(player:getSkillLevel(SKILL_SWORD)) * skillRate
    elseif itemid == 32125 or itemid == 33083 then
        skillRate = Game.getSkillStage(player:getSkillLevel(SKILL_AXE)) * skillRate
    elseif itemid == 32126 or itemid == 33084 then
        skillRate = Game.getSkillStage(player:getSkillLevel(SKILL_CLUB)) * skillRate
    elseif itemid == 32127 or itemid == 33085 then
        skillRate = Game.getSkillStage(player:getSkillLevel(SKILL_DISTANCE)) * skillRate
    elseif itemid == 33086 or itemid == 32128 or itemid == 33087 or itemid == 32129 then
        skillRate = Game.getMagicLevelStage(player:getMagicLevel()) * skillRate * 50
    end

    local pos_n = player:getPosition()
    if start_pos:getDistance(pos_n) == 0 then
        local exercise = player:getItemById(itemid, true)
        if exercise and exercise:isItem() and exercise:hasAttribute(ITEM_ATTRIBUTE_CHARGES) then
            local charges_n = exercise:getAttribute(ITEM_ATTRIBUTE_CHARGES)
            if charges_n >= 1 then
                exercise:setAttribute(ITEM_ATTRIBUTE_CHARGES, charges_n - 1)

                local trainingValue = 0
                local voc = player:getVocation()
                if skills[itemid].id == SKILL_MAGLEVEL then
                    local gainTicks = math.max(voc:getManaGainTicks() * 3, 1)
                    trainingValue = ((skillRate / 3) * (voc:getManaGainAmount() / gainTicks)) * b_
                else
                    trainingValue = ((skillRate * (voc:getAttackSpeed() / 1000)) / 5) * b_
                end
                player:addOfflineTrainingTries(skills[itemid].id, trainingValue, true)

                fpos:sendMagicEffect(CONST_ME_HITAREA)
                if skills[itemid].range then
                    pos_n:sendDistanceEffect(fpos, skills[itemid].range)
                end

                if charges_n == 1 then
                    player:sendCancelMessage("Your training weapon has vanished.")
                    if player:getStorageValue(isTrainingEvent) > 0 then
                        stopEvent(player:getStorageValue(isTrainingEvent))
                        player:setStorageValue(isTrainingEvent, -1)
                    end
                    player:setStorageValue(isTraining, 0)
                    player:setStorageValue(isTrainingStorage, -1)
                    exercise:remove(1)
                    return true
                end

                local training = addEvent(start_train, voc:getAttackSpeed(), player:getId(), start_pos, itemid, fpos, t_id)
                player:setStorageValue(isTraining, 1)
                player:setStorageValue(isTrainingEvent, training)
                player:setStorageValue(isTrainingStorage, 1)
            else
                player:sendCancelMessage("Your training weapon has no charges left.")
            end
        else
            player:sendCancelMessage("You need a valid training weapon.")
        end
    else
        player:sendCancelMessage("Your training has stopped: You moved from the starting position.")
        if player:getStorageValue(isTrainingEvent) > 0 then
            stopEvent(player:getStorageValue(isTrainingEvent))
            player:setStorageValue(isTrainingEvent, -1)
        end
        player:setStorageValue(isTraining, 0)
        player:setStorageValue(isTrainingStorage, -1)
    end
    return true
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if not player or not target:isItem() or not isInArray(dummies, target:getId()) then
        return false
    end

    local start_pos = player:getPosition()
    local itemId = item:getId()
    if not skills[itemId] then
        player:sendCancelMessage("This item is not a training weapon.")
        return true
    end

    if skills[itemId].range == nil and start_pos:getDistance(target:getPosition()) > 1 then
        player:sendCancelMessage("Get closer to the dummy.")
        return true
    end

    if not isInArray(skills[itemId].voc, player:getVocation():getBase():getId()) then
        player:sendCancelMessage("Your vocation cannot train with this weapon.")
        return true
    end

    if player:getStorageValue(isTraining) == 1 then
        player:sendCancelMessage("You are already training.")
        return true
    end

    player:sendCancelMessage("You have started training.")
    start_train(player:getId(), start_pos, itemId, target:getPosition(), target:getId())
    return true
end