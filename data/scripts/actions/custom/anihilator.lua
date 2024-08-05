local playerPosition = {
	Position(907, 656, 7),
	Position(906, 656, 7),
	Position(905, 656, 7),
	Position(904, 656, 7),
}
local monsterPosition = {
	Position(902, 655, 8),
	Position(902, 657, 8),
	Position(903, 656, 8),
	Position(909, 655, 8),
	Position(909, 657, 8),
	Position(908, 656, 8),
	Position(904, 653, 8),
	Position(906, 653, 8),
	Position(905, 659, 8),
	Position(907, 659, 8),
}
local newPosition = {
	Position(907, 656, 8),
	Position(906, 656, 8),
	Position(905, 656, 8),
	Position(904, 656, 8),
}
local fromPos, toPos  = Position(902, 653, 8), Position(909, 659, 8)
local monster = "Cave Rat"
local playersTable = {}
	

--local exhaustionTime = 20 * 60 * 60
local exhaustionTime =  20 * 60 * 60

local annihilator = Action()

function hasCreatureInArea(removeCreatures)
	local fromPosition, toPosition = fromPos, toPos
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


function hasPlayerInArea(bool)
	local fromPosition, toPosition = fromPos, toPos
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
									if creature:isPlayer() then
												return true
									else return false end
								end
						end
					end
				end
			end
		end
	end
end

function playerRemove()
	local fromPosition, toPosition = fromPos, toPos
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
									if table.contains(playersTable, creature:getName()) then
										creature:teleportTo(Position(899, 656, 7))
									end
								end
						end
					end
				end
			end
		end
	end
end


function annihilator.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 8912 then
		local players = {}
		
		for _, position in ipairs(playerPosition) do

			local topPlayer = Tile(position):getTopCreature()

			if not topPlayer then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Precisa 4 pessoas para a quest.")
				return false
            elseif  not topPlayer:isPlayer() then
            	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas players podem fazer a quest.")
            	return false
            elseif topPlayer:getLevel() < 120 then
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Apenas player 140+ podem fazer a quest.")
				topPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você precisa ser level 140 para fazer a quest.")
                return false
            elseif topPlayer:getExhaustion("anihi-exhaustion") > 300 then
				local total = topPlayer:getExhaustion("anihi-exhaustion")
				local horas = math.floor(total / 3600)
				local minutos = math.floor((total - (horas * 3600)) / 60)
				local segundos = math.floor(total % 60)
				if horas < 10 then horas = "0"..horas.."" end
				if minutos < 10 then minutos = "0"..minutos.."" end
				if segundos < 10 then segundos = "0"..segundos.."" end
				local time = "".. horas ..":" .. minutos .. ":" .. segundos .. ""
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Alguém já fez a quest hoje.")
				topPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você poderá fazer novamente em: ".. time ..".")
                return false
			elseif hasPlayerInArea(true) then 
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Ainda há players fazendo a quest!")
                return false
			end
			players[#players + 1] = topPlayer
		end

		hasCreatureInArea()

		for i, targetPlayer in ipairs(players) do
			Position(playerPosition[i]):sendMagicEffect(CONST_ME_POFF)
			targetPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você tem 15 minutos para chegar a sala de recompensa!")
			targetPlayer:teleportTo(newPosition[i], false)
			targetPlayer:getPosition():sendMagicEffect(CONST_ME_ENERGYAREA)
			targetPlayer:setExhaustion("anihi-exhaustion", exhaustionTime)
			local ins = table.insert(playersTable, targetPlayer:getName())
			
		end
		addEvent(playerRemove, 15 * 60 * 1000)
		for _, monsters in ipairs(monsterPosition) do
			local creature = Game.createMonster(monster, monsters)
		end
	elseif item.itemid == 8911 then
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
	end
	return true
end

annihilator:aid(46002)
annihilator:register()
