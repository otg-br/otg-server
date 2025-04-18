MESSAGEDIALOG_IMBUEMENT_ERROR = 1
MESSAGEDIALOG_IMBUEMENT_ROLL_FAILED = 2
MESSAGEDIALOG_IMBUING_STATION_NOT_FOUND = 3
MESSAGEDIALOG_CLEARING_CHARM_SUCCESS = 10
MESSAGEDIALOG_CLEARING_CHARM_ERROR = 11

-- tables
Imbuements_Weapons = {
    ["armor"] = {33911, 33916, 33221, 21692, 2500, 2656, 2464, 2487, 2494, 15407, 2492, 2503, 12607, 2505, 32419, 30883, 2466, 23538, 10296, 2476, 3968, 2472, 7463, 8888, 23537, 2486, 15406, 8891, 18404}, -- ok
    ["shield"] = {33224, 2537, 2518, 15491, 2535, 2519, 25414, 2520, 15411, 2516, 32422, 32421, 30885, 2522, 2533, 21707, 2514, 10289, 2536, 6433, 6391, 7460, 2524, 15413, 2539, 25382, 21697, 3974, 10297, 12644, 10294, 2509, 2542, 2528, 2534, 2531, 15453}, -- ok
    ["boots"] = {36331, 33917, 35108, 2358, 24742, 2195, 2644, 9931, 3982, 11117, 15410, 11118, 12646, 7457, 7892, 2646, 11240, 2643, 7893, 7891, 23540, 24637, 2641, 5462, 18406, 2642, 2645, 7886, 25412, 21708, 11303}, --ok
    ["helmet"] = {33217, 2499, 2139, 3972, 2458, 2491, 2497, 2493, 2502, 12645, 32415, 7458, 2471, 10299, 20132, 10298, 2662, 10291, 2498, 24848, 5741, 25410, 2475, 11302}, --ok
    ["helmetmage"] = {33216, 10016, 2323, 11368, 8820, 10570, 9778, 30882}, -- ok
    ["bow"] = {33910, 33220, 30690, 8855, 7438, 32418, 15643, 21696, 10295, 18454, 25522, 8857, 22417, 22418, 8854}, -- ok
    ["crossbow"] = {35107, 8850, 2455, 30691, 8849, 25523, 8851, 8852, 8853, 16111, 21690, 22420, 22421}, -- ok
    ["backpack"] = {1988, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2365, 3940, 3960, 5801, 5926, 5949, 7342, 9774, 10518, 10519, 10521, 10522, 11119, 11241, 11243, 11244, 11263, 15645, 15646, 16007, 18393, 18394, 21475, 22696, 23666, 23816, 24740, 26181, 27061, 27063, 35056},
    ["wand"] = {35113, 29005, 2191, 8920, 8921, 8922}, --ok
    ["rod"] = {35114, 8910, 8911, 24839}, --ok
    ["axe"] = {35110, 30686, 2429, 3962, 7412, 30687, 18451, 8926, 2414, 11305, 7419, 2435, 7453, 2415, 2427, 7380, 8924, 7389, 15492, 7435, 2430, 7455, 7456, 2443, 25383, 7434, 6553, 8925, 2431, 2447, 22405, 22408, 22406, 22409, 2454, 15451, 11323}, --ok
    ["club"] = {33912, 33227, 35109, 7414, 7426, 2453, 7429, 2423, 7415, 2445, 15647, 7431, 7430, 23543, 30689, 2444, 2452, 20093, 7424, 30688, 25418, 18452, 8928, 7421, 7392, 15414, 7410, 7437, 7451, 2424, 2436, 7423, 12648, 7452, 8929, 22414, 22411, 22415, 22412, 2421, 2391}, --ok
    ["sword"] = {33914, 33915, 33225, 35112, 7404, 7403, 7406, 12649, 30684, 7416, 2407, 2413, 7385, 7382, 2451, 7402, 8930, 2438, 2393, 30886, 7407, 7405, 2400, 7384, 7418, 7383, 7417, 18465, 30685, 2383, 2376, 7391, 6528, 8931, 12613, 11309, 22399, 22403, 22400, 22402, 7408, 11307}, --ok
    ["spellbooks"] = {25411, 2175, 8900, 8901, 22423, 22424, 29004, 33924, 33913, 33919}, -- [ok]
    ["especial"] = {30692, 30693, 33219, 33218, 33305, 33304, 33918, 33226} -- revisar
}

local equipitems = {
    ["lich shroud"] = {"armor", "spellbooks", "shield"},
    ["reap"] = {"axe", "club", "sword"},
    ["vampirism"] = {"axe", "club", "sword", "wand", "rod", "especial", "bow", "crossbow", "armor"},
    ["cloud fabric"] = {"armor", "spellbooks", "shield"},
    ["electrify"] = {"axe", "club", "sword"},
    ["swiftness"] = {"boots"},
    ["snake skin"] = {"armor", "spellbooks", "shield"},
    ["venom"] = {"axe", "club", "sword"},
    ["slash"] = {"sword", "helmet"},
    ["chop"] = {"axe", "helmet"},
    ["bash"] = {"club", "helmet"},
    ["hide dragon"] = {"armor", "spellbooks", "shield"},
    ["scorch"] = {"axe", "club", "sword"},
    ["void"] = {"axe", "club", "sword", "wand", "rod", "especial", "bow", "crossbow", "helmet", "helmetmage"},
    ["quara scale"] = {"armor", "spellbooks", "shield"},
    ["frost"] = {"axe", "club", "sword"},
    ["blockade"] = {"shield", "helmet", "spellbooks", "shield"},
    ["demon presence"] = {"armor", "spellbooks", "shield"},
    ["precision"] = {"bow", "crossbow", "helmet"},
    ["strike"] = {"axe", "club", "sword", "bow", "crossbow", "especial"},
    ["epiphany"] = {"wand", "rod", "helmetmage", "especial"},
    ["featherweight"] = {"backpack"},
}

function Player.canImbueItem(self, imbuement, item)
    local item_type = ""
    for tp, items in pairs(Imbuements_Weapons) do
        if isInArray(items, item:getId()) then
            item_type = tp
            break
        end
    end
    if item_type == "" then
        return false
    end

    local imb_name = imbuement:getName():lower()
    local equip = nil
    for ibt, types in pairs(equipitems) do
        if string.find(ibt, imb_name) then
            equip = types
            break
        end
    end
    if not equip then
        return false
    end

    local imbuable = false
    for i, p in pairs(equip) do
        if p:lower() == item_type then
            imbuable = true
            break
        end
    end
    if not imbuable then
        return false
    end

    return true
end

-- Player functions
function Player.sendImbuementResult(self, errorType, message)
    local msg = NetworkMessage()
    msg:addByte(0xED)
    msg:addByte(errorType or 0x01)
    msg:addString(message)
    msg:sendToPlayer(self)
    msg:delete()
    return
end

function Player.closeImbuementWindow(self)
    local msg = NetworkMessage()
    msg:addByte(0xEC)
    msg:sendToPlayer(self)
end

-- Items functions
function Item.getImbuementDuration(self, slot)
    local info = 0
    local binfo = tonumber(self:getCustomAttribute(IMBUEMENT_SLOT + slot))
    if binfo then
        info = bit.rshift(binfo, 8)
    end

    return info
end

function Item.getImbuement(self, slot)
    local binfo = tonumber(self:getCustomAttribute(IMBUEMENT_SLOT + slot))
    if not binfo then
        return false
    end
    local id = bit.band(binfo, 0xFF)
    if id == 0 then
        return false
    end

    local info = bit.rshift(binfo, 8)
    if info <= 0 then
        return false
    end

    return Imbuement(id)
end

function Item.addImbuement(self, slot, id, duration)
    local imbuement = Imbuement(id)
    if not imbuement then return false end
    if not duration then
        duration = imbuement:getBase().duration
    end

    local imbue = bit.bor(bit.lshift(duration, 8), id)
    self:setCustomAttribute(IMBUEMENT_SLOT + slot, imbue)
    return true
end

function Item.cleanImbuement(self, slot)
    self:setCustomAttribute(IMBUEMENT_SLOT + slot, 0)
    return true
end