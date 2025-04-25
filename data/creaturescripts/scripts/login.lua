function onLogin(player)
	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	player:registerEvent("AutoLoot")
	return true
end
