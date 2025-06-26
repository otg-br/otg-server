function Item.getType(self)
	return ItemType(self:getId())
end

function Item.isContainer(self)
	return false
end

function Item.isCreature(self)
	return false
end

function Item.isPlayer(self)
	return false
end

function Item.isTeleport(self)
	return false
end

function Item.isTile(self)
	return false
end

function Item.setDescription(self, description)
	if description ~= '' then
		self:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, description)
	else
		self:removeAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
	end
end

function Item.setText(self, text)
	if text ~= '' then
		self:setAttribute(ITEM_ATTRIBUTE_TEXT, text)
	else
		self:removeAttribute(ITEM_ATTRIBUTE_TEXT)
	end
end
--[[
function Item.setUniqueId(self, uniqueId, force)
	if type(uniqueId) ~= 'number' or uniqueId < 0 or uniqueId > 65535 then
		return false
	end

	self:setAttribute(ITEM_ATTRIBUTE_UNIQUEID, uniqueId, force and true or false)
end
]]

function Item.getNameLoot(self, version)
	local subType = self:getSubType()
	local s = ""
	local name = self:getName()
	local it = ItemType(self:getId())
	if (#name ~= 0) then
		if tonumber(version) >= 1200 then
			s = string.format("{%d|", it:getClientId())
		end
		if (it:isStackable() and subType > 1) then
			s = string.format("%s%d %s", s, subType, self:getPluralName())
		else
			local article = self:getArticle()
			s = string.format("%s%s%s", s, (#article ~= 0 and article.." " or ''), name)
		end
		if tonumber(version) >= 1200 then
			s = string.format("%s}", s)
		end
	else
		s = string.format("an item of type ", self:getId())
	end
	return s
end

-- Métodos para obter atributos do item
function Item.getArmor(self)
	local armor = self:getAttribute(ITEM_ATTRIBUTE_ARMOR)
	if armor ~= 0 then
		return armor
	end
	return self:getType():getArmor()
end

function Item.getAttack(self)
	local attack = self:getAttribute(ITEM_ATTRIBUTE_ATTACK)
	if attack ~= 0 then
		return attack
	end
	return self:getType():getAttack()
end

function Item.getDefense(self)
	local defense = self:getAttribute(ITEM_ATTRIBUTE_DEFENSE)
	if defense ~= 0 then
		return defense
	end
	return self:getType():getDefense()
end
