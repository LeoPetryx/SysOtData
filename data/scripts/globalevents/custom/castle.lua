local elfCastle = {
    removePlayer = Position(696, 765, 7),
    fromWallPos = Position(694, 762, 7),
    toWallPos = Position(698, 762, 7),
    wallId = 20240,
    timeToClose = 5,
    	-- Calendary
	days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday"},
	hours = {"12:30", "19:30", "22:30", "23:30"},
    weekendDays = {"Saturday", "Sunday"},
	weekendHours = {"04:30", "07:30", "10:30", "13:30", "16:30", "19:30", "22:30", "01:30"},
}

function elfCastle:close()
    local fromPosition, toPosition = self.fromWallPos, self.toWallPos
    for positionX = fromPosition.x, toPosition.x do
		for positionY = fromPosition.y, toPosition.y do
			for positionZ = fromPosition.z, toPosition.z do
                local room = { x = positionX, y = positionY, z = positionZ }
                local wallPosition = Position(room)
				local tile = Tile(room)
                local creatures = tile:getCreatures()
                if creatures and #creatures > 0 then
                    for _, creatureUid in pairs(creatures) do
                            local creature = Creature(creatureUid)
                            if creature then
                                creature:teleportTo(self.removePlayer)
                                creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
                            end
                    end
                end

                    tile:addItem(self.wallId, 1)
                    tile:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			end
		end
	end
return true
end

function elfCastle:broadcast()
    Game.broadcastMessage("Elf Castle: The gates have closed!", MESSAGE_GAME_HIGHLIGHT)
end

function elfCastle:start()
    local fromPosition, toPosition = self.fromWallPos, self.toWallPos
	for positionX = fromPosition.x, toPosition.x do
		for positionY = fromPosition.y, toPosition.y do
			for positionZ = fromPosition.z, toPosition.z do
				local room = { x = positionX, y = positionY, z = positionZ }
				local tile = Tile(room)
				local wall = tile:getItemById(self.wallId)
                tile:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
                wall:remove()
                addEvent(self.close, self.timeToClose * 60 * 1000, self)
                addEvent(self.broadcast, self.timeToClose * 60 * 1000, self)
			end
		end
	end
    Game.broadcastMessage("Elf Castle: The gates have opened and will close in "..tostring(self.timeToClose).." minutes, help defeat the enemies and conquer the Castle!", MESSAGE_GAME_HIGHLIGHT)
return true
end



for _, hour in ipairs(elfCastle.weekendHours) do
	local initEvent = GlobalEvent(string.format("ElfCastleInit%s", hour))

	function initEvent.onTime(interval)
		local day = os.date("%A")
		if not table.contains(ZombieEvent.weekendDays, day) then return true end
		elfCastle:start()
		return true
	end

	initEvent:time(hour)
	initEvent:register()
end