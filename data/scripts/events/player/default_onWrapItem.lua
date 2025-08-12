local event = Event()
event.onWrapItem = function(self, item)
    local topCylinder = item:getTopParent()
    if not topCylinder then
        return
    end

    local tile = Tile(topCylinder:getPosition())
    if not tile then
        return
    end

    local house = tile:getHouse()
    if not house then
        self:sendCancelMessage("You can only wrap and unwrap this item inside a house.")
        return
    end

    if house ~= self:getHouse() and not string.find(house:getAccessList(SUBOWNER_LIST):lower(), "%f[%a]" .. self:getName():lower() .. "%f[%A]") then
        self:sendCancelMessage("You cannot wrap or unwrap items from a house, which you are only guest to.")
        return
    end

    local wrapId = item:getAttribute("wrapid")
    if wrapId == 0 then
        return
    end

    local oldId = item:getId()
    item:remove(1)
    local newItem = tile:addItem(wrapId)
    if newItem then
        newItem:setAttribute("wrapid", oldId)
    end
end
event:register()