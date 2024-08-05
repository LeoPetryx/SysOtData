local playersTable = {}
local rooms = {
	{fromPos = Position(1100, 725, 0), toPos = Position(1217, 800, 2), pzPos = Position(1140, 764, 0)},
	{fromPos = Position(1100, 725, 3), toPos = Position(1217, 800, 5), pzPos = Position(1140, 764, 3)},
	{fromPos = Position(1100, 725, 6), toPos = Position(1217, 800, 8), pzPos = Position(1140, 764, 6)},
	{fromPos = Position(1100, 725, 9), toPos = Position(1217, 800, 11), pzPos = Position(1140, 764, 9)},
	{fromPos = Position(1100, 725, 12), toPos = Position(1217, 800, 14), pzPos = Position(1140, 764, 12)},
	
}
	

--local exhaustionTime = 20 * 60 * 60
local exhaustionTime =  20 * 60 * 60

local huntCoin = Action()


function hasPlayerInArea(fromPos, toPos, isPlayer)
	local fromPosition, toPosition = fromPos, toPos
	local hasPlayer = false
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
										hasPlayer = true
									end
								end
						end
					end
				end
			end
		end
	end
	return hasPlayer
end

function playerRemove(fromPos, toPos)
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
										creature:teleportTo(Position(825, 681, 7))
										creature:getPosition():sendMagicEffect(CONST_ME_ENERGYAREA)
									end
								end
						end
					end
				end
			end
		end
	end
end

function getTime(time)
	local horas = math.floor(time / 3600)
	local minutos = math.floor((time - (horas * 3600)) / 60)
	local segundos = math.floor(time % 60)
	if horas < 10 then horas = "0"..horas.."" end
	if minutos < 10 then minutos = "0"..minutos.."" end
	if segundos < 10 then segundos = "0"..segundos.."" end
	time = "".. horas ..":" .. minutos .. ":" .. segundos .. ""
	return time
end

function huntCoin.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getExhaustion("no-estress-exhaustion") > 0 then
		return player:sendTextMessage(21, "Você deve esperar"..player:getExhaustion("no-estress-exhaustion").." segundos para tentar novamente.")
	else
		if Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
			if player:getExhaustion("hunts-exhaustion") > 0 then
				player:setExhaustion("no-estress-exhaustion", 15)
				return player:sendTextMessage(21, "Você ainda deve esperar ".. getTime(player:getExhaustion("hunts-exhaustion")) .." para entrar novamente.")
			else
				for _, roomsCount in ipairs(rooms) do
					local isPlayer = hasPlayerInArea(roomsCount.fromPos, roomsCount.toPos)
					if isPlayer == false then
						item:remove(1)
						player:teleportTo(roomsCount.pzPos)
						player:getPosition():sendMagicEffect(CONST_ME_ENERGYAREA)
						player:setExhaustion("hunts-exhaustion", exhaustionTime)
						player:setExhaustion("no-estress-exhaustion", 15)
						local ins = table.insert(playersTable, player:getName())	
						addEvent(playerRemove, 2 * 60 * 60 * 1000, roomsCount.fromPos, roomsCount.toPos)
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Você tem duas horas para caçar nessa hunt, você não poderá deslogar e se morrer não poderá retornar!")
						return false
					end
				end
			end
		else 
			return player:sendTextMessage(21, "Você deve estar em uma protection zone para usar este item.")
		end
	end
		player:setExhaustion("no-estress-exhaustion", 15)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "O servidor disponibiliza ".. #rooms .." salas dessa hunt, todas estão ocupadas no momento")
end

huntCoin:id(37317)
huntCoin:register()
