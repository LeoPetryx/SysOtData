local internalNpcName = "The Librarian"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1065,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 10,
	{ text = "Aparentemente ninguém sabe que eu troco acessos para o Gran Castle..." },
	{ text = "Tá precisando de uma skill né? Compre exercise weapons aqui!" },
	{ text = "Eu tenho mais experiencia sobre esse mundo do que qualquer habitante dessa cidade!" },
	{ text = "O mal habita o Gran Castle, será que alguém será capaz de dete-lo?!" },
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)


npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()


	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "poção") or MsgContains(message, "pocao") or MsgContains(message, "poçao") or  MsgContains(message, "pocão") then
		if player:getStorageValue(46003) == -1 then
			player:setStorageValue(46003, 1)
			player:setStorageValue(46004, 1)
		end
		local playerMulti = player:getStorageValue(46003)
		local multiplier = 2^playerMulti
		local price = 10000
			npcHandler:say({
				"Deseja comprar uma poção por "..price*multiplier.."?",
			}, npc, creature)
			npcHandler:setTopic(playerId, 1)
	elseif (MsgContains(message, "yes") or MsgContains(message, "sim")) and npcHandler:getTopic(playerId) == 1 then
		local playerMulti = player:getStorageValue(46003)
		local playerCount = player:getStorageValue(46004)
		local multiplier = 2^playerMulti
		local price = 10000

			if player:removeMoney(price*multiplier) then
				local s = player:getStorageValue(46004)
				local inbox = player:getStoreInbox()
				local inboxItems = inbox:getItems()
				if inbox and #inboxItems < inbox:getMaxCapacity() and player:getFreeCapacity() >= ItemType(3041):getWeight() then
					local item = inbox:addItem(34327, 1)
					if item then
						item:setActionId(IMMOVABLE_ACTION_ID)
						item:setAttribute(ITEM_ATTRIBUTE_STORE, systemTime())
						item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, string.format("Essa poção aumenta por definitivo sua vitalidade máxima", configManager.getString(configKeys.SERVER_NAME)))

					else
						npcHandler:say("Você precisa de espaço livre e capacidade para receber esse item.", npc, creature)
						return
					end
						
						player:setStorageValue(46004, playerCount + 1)
						if ((s < 101 and s % 10 == 0) or (s > 101 and s % 50 == 0)) then
						player:setStorageValue(46003, playerMulti + 1)
						end
						npcHandler:say("Aqui está sua poção, você ainda pode comprar ".. 400-playerCount .." poções .", npc, creature)

				else
					npcHandler:say("Você precisa de espaço livre e capacidade para receber esse item.", npc, creature)
				end

				npcHandler:setTopic(playerId, 0)
			else
				return npcHandler:say("Você não tem esse dinheiro.", npc, creature)
			end
		end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Prazer |PLAYERNAME|, gostaria de comprar uma {poção} que aumenta definitivamente sua vitalidade?. Eu também vendo exercise weapons!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Tenho cara de parede?!")

npcHandler:setCallback(CALLBACK_SET_INTERACTION, onAddFocus)
npcHandler:setCallback(CALLBACK_REMOVE_INTERACTION, onReleaseFocus)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.currency = 16128

npcConfig.shop = {
	{ itemName = "exercise axe", clientId = 28553, buy = 5, count = 500 },
	{ itemName = "durable exercise axe", clientId = 35280, buy = 17, count = 1800 },
	{ itemName = "lasting exercise axe", clientId = 35286, buy = 140, count = 14400 },

	{ itemName = "exercise club", clientId = 28554, buy = 5, count = 500 },
	{ itemName = "durable exercise club", clientId = 35281, buy = 17, count = 1800 },
	{ itemName = "lasting exercise club", clientId = 35287, buy = 140, count = 14400 },

	{ itemName = "exercise sword", clientId = 28552, buy = 5, count = 500 },
	{ itemName = "durable exercise sword", clientId = 35279, buy = 17, count = 1800 },
	{ itemName = "lasting exercise sword", clientId = 35285, buy = 140, count = 14400 },

	{ itemName = "exercise shield", clientId = 44065, buy = 5, count = 500 },
	{ itemName = "durable exercise shield", clientId = 44066, buy = 17, count = 1800 },
	{ itemName = "lasting exercise shield", clientId = 44067, buy = 140, count = 14400 },

	{ itemName = "exercise bow", clientId = 28555, buy = 5, count = 500 },
	{ itemName = "durable exercise bow", clientId = 35282, buy = 17, count = 1800 },
	{ itemName = "lasting exercise bow", clientId = 35288, buy = 140, count = 14400 },

	{ itemName = "exercise wand", clientId = 28557, buy = 5, count = 500 },
	{ itemName = "durable exercise wand", clientId = 35284, buy = 17, count = 1800 },
	{ itemName = "lasting exercise wand", clientId = 35290, buy = 140, count = 14400 },

	{ itemName = "exercise rod", clientId = 28556, buy = 5, count = 500 },
	{ itemName = "durable exercise rod", clientId = 35283, buy = 17, count = 1800 },
	{ itemName = "lasting exercise rod", clientId = 35289, buy = 140, count = 14400 },

}


-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end


npcType:register(npcConfig)
