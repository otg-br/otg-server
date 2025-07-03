-- VIP Days Action Revscript
local vipDaysAction = Action()
function vipDaysAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local days = 30  -- Fixed 30 days VIP
    local currentTime = os.time()
    local currentPremium = player:getPremiumEndsAt()
    local newTime = 0
    
    if currentPremium > currentTime then
        newTime = currentPremium + (days * 24 * 60 * 60)
    else
        newTime = currentTime + (days * 24 * 60 * 60)
    end
    
    item:remove(1)
    player:setPremiumEndsAt(newTime)
    
    -- Calculate total days remaining
    local totalDaysLeft = math.ceil((newTime - currentTime) / (24 * 60 * 60))
    player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You received %d days of VIP time. You now have %d days of VIP remaining.", days, totalDaysLeft))
    return true
end
vipDaysAction:id(16101)
vipDaysAction:register()