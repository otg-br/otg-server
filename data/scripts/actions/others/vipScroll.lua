local vipDaysAction = Action()
function vipDaysAction.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local days = 30  -- Fixed 30 days VIP
    
    item:remove(1)
    player:addVipDays(days)
    
    player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("You won %d days VIP, now you have %d days VIP.", days, math.max(0, math.ceil((player:getVipDays() - os.time()) / 86400))))
    return true
end
vipDaysAction:id(16101)
vipDaysAction:register()