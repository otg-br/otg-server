local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function creatureSayCallback(cid, type, msg)
    if(not npcHandler:isFocused(cid)) then
        return false
    end
    local player = Player(cid)

    if(msgcontains(msg, "mission")) then
        npcHandler:say("I always have tasks for interested adventurers. Are you willing to take on a mission?", cid)
        npcHandler.topic[cid] = 1

    elseif(msgcontains(msg, "yes")) then
        if(npcHandler.topic[cid] == 1) then
            npcHandler:say({
                "Excellent! Let's begin your journey as a trader. Bring me a rare deer trophy from Svargrond!",
                "Once you have it, return to me and we will continue."
            }, cid)
            npcHandler.topic[cid] = 0
        end
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
