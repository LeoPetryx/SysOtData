local waterIds = { 8870, 8871, 8872, 8873 }
local nvOne = 3031
local nvTwo = 3035
local nvThree = 3043
local nvFour = {6541, 6542, 6543,  6544, 6545}
local castle = 22722
local major = 16129
local minor = 16128

local elementals = {
	chances = {
		{ from = 0, to = 500, itemId = 3026 }, -- white pearl
		{ from = 501, to = 801, itemId = 3029 }, -- small sapphire
		{ from = 802, to = 1002, itemId = 3032 }, -- small emerald
		{ from = 1003, to = 1053, itemId = 281 }, -- giant shimmering pearl (green)
		{ from = 1054, to = 1104, itemId = 282 }, -- giant shimmering pearl (brown)
		{ from = 1105, to = 1115, itemId = 9303 }, -- leviathan's amulet
	},
}

local useWorms = false

local function refreeIceHole(position)
	local iceHole = Tile(position):getItemById(7237)
	if iceHole then
		iceHole:transform(7200)
	end
end

local fishing = Action()


function fishing.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(85601) == 1 then
		return
	else
	player:setStorageValue(85601, 1)
	local initialPos = player:getPosition()
	local function fish()
		if player:getLevel() <= 29 then
			player:say("Você precisa do nivel 30 para minerar com esse item!", TALKTYPE_MONSTER_SAY)
				else
		if player:getStorageValue(85600) == 1 then
		if player:getItemCount(4845) > 0 then
		if player:getPosition() == initialPos then
		if not table.contains(waterIds, target.itemid) then
			return false
		end
	
		local targetId = target.itemid
	
		if targetId == 8870 or 8871 or 8872 or 8873 then
				toPosition:sendMagicEffect(CONST_ME_HITAREA)
				local rareChance = math.random(2000)
				if rareChance == 1998 then
				player:addItem(castle, 1)
				player:say("OH MY CASTLE!", TALKTYPE_MONSTER_SAY)
				elseif rareChance <= 5 then
				player:addItem(major, 1)
				player:say("very rare!", TALKTYPE_MONSTER_SAY)
				elseif rareChance <= 13 then
				player:addItem(minor, math.random(2))
				player:say("rare!", TALKTYPE_MONSTER_SAY)
				elseif rareChance <= 100 then
				player:addItem(nvFour, 1)
				player:say("Nice!", TALKTYPE_MONSTER_SAY)
				elseif rareChance <= 250 then
				player:addItem(nvThree, 1)
				player:say("good!", TALKTYPE_MONSTER_SAY)
				elseif rareChance <= 700 then
				player:addItem(nvTwo, 1)
				player:say("normal...", TALKTYPE_MONSTER_SAY)
				else
				player:addItem(nvOne, 1)
				player:say("eew!", TALKTYPE_MONSTER_SAY)
			end
			addEvent(fish, 1000)
			return true
		end
	
		else
			player:setStorageValue(85601, 0)
			end
		end
		else
			return
		end
	end
		
		return true
	end
	addEvent(fish, 0)
end
	return true
end

fishing:id(4845)
fishing:allowFarUse(false)
fishing:register()
