local waterIds = { 32414 }
local gold = 3031
local platinum = 3035
local crystal = 3043
local egg = {6541, 6542, 6543,  6544, 6545}
local castle = 22722
local major = 16129
local minor = 16128

local fishing = Action()


function fishing.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local initialPos = player:getPosition()
	local fishSkill = player:getEffectiveSkillLevel(SKILL_FISHING)
	local function fish()
		if player:getLevel() <= 29 then
		player:say("Voc� precisa do nivel 30 para pescar!", TALKTYPE_MONSTER_SAY)
			else
		if player:getItemCount(3483) > 0 then
		if player:getPosition() == initialPos then
		if not table.contains(waterIds, target.itemid) then
			return false
		end
	
		local targetId = target.itemid
	
		if targetId == 32414 then
			if fishSkill <= 20 then
				player:addSkillTries(SKILL_FISHING, 2, true)
				toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
				local rareChance = math.random(100)
				if rareChance <= 0 then
				player:addItem(crystal, math.random(0))
				elseif rareChance <= 0 then
				player:addItem(platinum, math.random(2))
				elseif rareChance <= 200 then
				player:addItem(gold, math.random(10))
				else
				end
			elseif fishSkill >= 21 and fishSkill <= 40 then
				player:addSkillTries(SKILL_FISHING, 5, true)
				toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
				local rareChance = math.random(1000)
				if rareChance <= 0 then
				player:addItem(crystal, math.random(1))
				elseif rareChance <= 10 then
				player:addItem(platinum, 1)
				elseif rareChance <= 200 then
				player:addItem(gold, math.random(20))
				else
				end
			elseif fishSkill >= 41 and fishSkill <= 60 then
				player:addSkillTries(SKILL_FISHING, 7, true)
				toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
				local rareChance = math.random(1000)
				if rareChance <= 5 then
				player:addItem(crystal, math.random(1))
				elseif rareChance <= 30 then
				player:addItem(platinum, math.random(2))
				elseif rareChance <= 100 then
				player:addItem(platinum, 1)
				else
				end
			elseif fishSkill >= 61 and fishSkill <= 80 then
				player:addSkillTries(SKILL_FISHING, 10, true)
				toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
				local rareChance = math.random(1000)
				if rareChance <= 2 then
				player:addItem(minor, 1)
				elseif rareChance <= 10 then
				player:addItem(crystal, 1)
				elseif rareChance <= 60 then
				player:addItem(platinum, math.random(2))
				elseif rareChance <= 200 then
				player:addItem(platinum, 1)
				else
				end
			elseif fishSkill >= 81 and fishSkill <= 100 then
				player:addSkillTries(SKILL_FISHING, 10, true)
				toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
				local rareChance = math.random(1000)
				if rareChance <= 2 then
				player:addItem(major, 1)
				elseif rareChance <= 5 then
				player:addItem(minor, math.random(2))
				elseif rareChance <= 20 then
				player:addItem(crystal, 1)
				elseif rareChance <= 130 then
				player:addItem(platinum, math.random(3))
			else
				player:addItem(platinum, 1)
				end
			elseif fishSkill >= 101 then
				toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
				local rareChance = math.random(1000)
				if rareChance <= 2 then
				player:addItem(castle, 1)
				elseif rareChance <= 5 then
				player:addItem(major, 1)
				elseif rareChance <= 13 then
				player:addItem(minor, math.random(2))
				elseif rareChance <= 50 then
				player:addItem(crystal, math.random(2))
				elseif rareChance <= 300 then
				player:addItem(platinum, math.random(4))
				else
				player:addItem(platinum, 1)
				end
			end
			return true
		end
	
		else
				return
			end
		end
	end
		
		return true
	end
	fish()
	return true
end

fishing:id(3483)
fishing:allowFarUse(true)
fishing:register()
