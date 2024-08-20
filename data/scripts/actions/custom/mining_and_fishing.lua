

function isFishMining(player)
	if player:getStorageValue(85651) >= 1 then return true else return false 
end end


local pets = {[1] = 6541, [2] = 6542, [3] = 6543, [4] = 6544, [5] = 6545}
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local startFishing = Action()

function startFishing.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(85652) <= 0 then
		return player:sendCancelMessage("You need to do the quest first.")
	end
	if isFishMining(player) then
		return player:sendCancelMessage("You cant do this so fast")
	end

	
	local initPosition = player:getPosition()
	local function onFishing()
		if isFishMining(player) then
			
				local fishLevel = player:getEffectiveSkillLevel(SKILL_FISHING)
				local amount = math.random(5*fishLevel, 12*fishLevel)
				local addpet = math.random(1,5)

						if item:getId() == 9306 then
							amount = amount * 2
							toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
							player:sendTextMessage(24, "".. amount .." was sent to your bank account.", player:getPosition(), amount, TEXTCOLOR_MAYABLUE)
							player:addSkillTries(SKILL_FISHING, 30, true)
							Bank.credit(player:getName(), amount)
							if math.random(1,200) <= math.max(1, fishLevel/20) then player:addItem(pets[addpet], math.random(2,5)) end
							if player:getItemCount(9306) >= 1 then addEvent(onFishing, 1000) else player:setStorageValue(85651, 0) end
						elseif item:getId() == 3483 then
							toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
							player:sendTextMessage(24, "".. amount .." was sent to your bank account.", player:getPosition(), amount, TEXTCOLOR_MAYABLUE)
							player:addSkillTries(SKILL_FISHING, 30, true)
							Bank.credit(player:getName(), amount)
							if math.random(1,200) <= math.max(1, fishLevel/20) then player:addItem(pets[addpet], math.random(1,3)) end
							if player:getItemCount(3483) >= 1 then addEvent(onFishing, 1000) else player:setStorageValue(85651, 0) end
						else
							player:setStorageValue(85651, 0)
						end
		end
	
	
end
	
	if target:getId() == 32414 then
	player:setStorageValue(85651, 1)
	onFishing()
	
	else 
		return player:sendCancelMessage("You cant do this there.")
	end
return true
end

startFishing:id(9306, 3483)
startFishing:allowFarUse(true)
startFishing:register()

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local startMining = Action()

function startMining.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(85652) <= 0 then
		return player:sendCancelMessage("You need to do the quest first.")
	end
	if isFishMining(player) then
		return player:sendCancelMessage("You cant do this so fast")
	end
	local refiners = {940, 941, 943, 944, 945, "nothing"}

	local function onMining()
		if isFishMining(player) then
						local chance = math.random(1, 500)
						local refinerId
						
				if chance >= 499 then refinerId = refiners[5] elseif chance >= 494 then refinerId = refiners[4] elseif chance >= 470 then refinerId = refiners[3] elseif chance  >= 390  then refinerId = refiners[2] elseif chance >= 250 then refinerId = refiners[1] else refinerId = refiners[6] end
				local colors = {[940]=TEXTCOLOR_LIGHTGREEN, [941]=TEXTCOLOR_DARKBROWN, [943]=TEXTCOLOR_YELLOW, [944]=TEXTCOLOR_LIGHTBLUE, [945]=TEXTCOLOR_RED, ["nothing"]=TEXTCOLOR_WHITE_EXP}
				local refiner
				local amount
				
					if item:getId() == 3456 then
						if chance >= 250 then	refiner = ItemType(refinerId):getName(); amount = 1; player:addItem(refinerId, 1) else refiner = refinerId; amount = 0; end
						toPosition:sendMagicEffect(49)
						player:sendTextMessage(24, " You receive ".. refiner .. ".", player:getPosition(), amount, colors[refinerId])
						
						if player:getItemCount(3456) >= 1 then addEvent(onMining, 1000) else player:setStorageValue(85651, 0) end
					end
	end
end
	if target:getId() == 1842 or target:getId() == 1841 or target:getId() == 1840 then
	player:setStorageValue(85651, 1)
	onMining()
	else 
		return player:sendCancelMessage("You cant do this there.")
	end
return true
end

startMining:id(3456)
startMining:register()

------------------------------------------------------------------------------------------------------------------------------------------------------------------

local stopFishMining = CreatureEvent("stopFishMiningLogout")

function stopFishMining.onLogout(player)
	player:setStorageValue(85651, 0)
	return true
end

stopFishMining:register()

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

stopFishMining = CreatureEvent("stopFishMiningLogin")

function stopFishMining.onLogin(player)
	player:setStorageValue(85651, 0)
	return true
end
stopFishMining:register()

------------------------------------------------------------------------------------------------------------------------------------------------------------------

local moveStop = MoveEvent("stepOutFishing")	

function moveStop.onStepOut(player, fromPosition)
	player:setStorageValue(85651, 0)
return true
end


local fromPos = Position(753, 633, 7)
local toPos = Position(890, 750, 7)

local fromPosition, toPosition = fromPos, toPos
for positionX = fromPosition.x, toPosition.x do
	for positionY = fromPosition.y, toPosition.y do
		for positionZ = fromPosition.z, toPosition.z do
			local room = { x = positionX, y = positionY, z = positionZ }
			local tile = Tile(room)
			moveStop:position(room)
		end
	end
end

moveStop:register()