local gem = Action()
function gem.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local voc = player:getVocation():getBaseId()
	local sto = player:getStorageValue(85701)
	
	if player:getStorageValue(85701) == 999 then
		player:sendTextMessage(MESSAGE_LOOK, "Você já atingiu a quantidade maxima dessa gema")
	else
		if voc == 1 or voc == 2 then
			player:setMaxMana(player:getBaseMaxMana() + (200 + 20*sto))
			player:say("+"..(200 + 20*sto).."", TALKTYPE_MONSTER_SAY)
		elseif voc == 3 then
			player:setMaxHealth(player:getBaseMaxHealth() + (50 + 5*sto))
			player:setMaxMana(player:getBaseMaxMana() + (50 + 5*sto))
			player:say("+"..(50 + 5*sto).."", TALKTYPE_MONSTER_SAY)
		elseif voc == 4 then
			player:setMaxHealth(player:getBaseMaxHealth() + (100 + 10*sto))
			player:setMaxMana(player:getBaseMaxMana() + 2)
			player:say("+"..(100 + 10*sto).."", TALKTYPE_MONSTER_SAY)
		end
			item:remove(1)
			player:setStorageValue(85701, sto + 1)
			sto = player:getStorageValue(85701)
			player:sendTextMessage(MESSAGE_LOOK, "Você usou ".. sto+1 .."/1000 gemas.")
			return true
	end	
	return true    
end
gem:id(34327)
gem:register()
