function Monster:onDropLoot(corpse)
    if hasEvent.onDropLoot then
        Event.onDropLoot(self, corpse)
    end
end

function Monster:onSpawn(position, startup, artificial)
    if hasEvent.onSpawn then
        return Event.onSpawn(self, position, startup, artificial)
    else
        if not self:getType():canSpawn(position) then
            return false
        end

        if self:getType():isRewardBoss() then
            self:setReward(true)
        end

        if not startup then
            local spec = Game.getSpectators(position, false, false)
            for _, pid in pairs(spec) do
                local monster = Monster(pid)
                if monster and not monster:getType():canSpawn(position) then
                    monster:remove()
                end
            end
        end

        return true
    end
end