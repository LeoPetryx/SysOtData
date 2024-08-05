local Invasao = {
	nameEvent = "Mercenarios", -- manter o '%s'
    fromPos = Position(753, 633, 7),
    toPos = Position(890, 750, 7),
    monster = {"Mercenario", "Mercenaria"},
    mcount = math.random(40, 60), -- quantidade que vai ser invocada
	mensagem = "Mercenarios em Carlin!", -- aviso da invasao
	minBtwResp = 60 - 1, -- Tempo entre respawn em minutos, vai remover os monstros 1 minuto antes do proximo respawn caso nao seja morto
    hours = {"01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00","00:00"},
}


local cacheMonsters = {}

local format = string.format
local insert = table.insert
local random = math.random
local mtime = nil
local remove = table.remove
mtime = systemTime
local mob = nil


local function getRandomTile()
	local from, to = Invasao.fromPos, Invasao.toPos
	local tile = Tile(random(from.x, to.x), random(from.y, to.y), from.z)
	local timeNow = mtime()
	while not tile or not tile:isWalkable() do
		if mtime() - timeNow > 100 then return end
		tile = Tile(random(from.x, to.x), random(from.y, to.y), from.z)
	end
	return tile
end

function Invasao:hasCreatureInArea(removeCreatures)
	local fromPosition, toPosition = Invasao.fromPos, Invasao.toPos
	for positionX = fromPosition.x, toPosition.x do
		for positionY = fromPosition.y, toPosition.y do
			for positionZ = fromPosition.z, toPosition.z do
				local room = { x = positionX, y = positionY, z = positionZ }
				local tile = Tile(room)
				if tile then
					local creatures = tile:getCreatures()
					if creatures and #creatures > 0 then
						for _, creatureUid in pairs(creatures) do
								local creature = Creature(creatureUid)
								if creature  then
									if creature:isMonster() then
											if table.contains(self.monster, creature:getName()) then
												creature:remove()
											end
									end
								end
						end
					end
				end
			end
		end
	end
end

function Invasao:clear()
	cacheMonsters = {}
	Invasao:hasCreatureInArea()
	return true
end

function Invasao:init()

    while #cacheMonsters < (math.floor(Invasao.mcount)) do
        insert(cacheMonsters, "mob")
    end


    for _, mob in ipairs(cacheMonsters) do
        local tile = getRandomTile()
        if not tile then return false end
        local pos = tile:getPosition()
		local monsterTable = #self.monster
		local randomMonster = random(1, monsterTable)
        local monster = Game.createMonster(self.monster[randomMonster], pos)
    end

    Game.broadcastMessage(Invasao.mensagem, MESSAGE_GAME_HIGHLIGHT)
    addEvent(self.clear, (self.minBtwResp) * 60 * 1000, self)

end

for _, hour in ipairs(Invasao.hours) do
	local initEvent = GlobalEvent(format("".. Invasao.nameEvent .."%s", hour))

	function initEvent.onTime(interval)
		Invasao:init()
		return true
	end

	initEvent:time(hour)
	initEvent:register()
end

