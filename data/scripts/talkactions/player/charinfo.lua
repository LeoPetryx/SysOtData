local charInfo = TalkAction("!charinfo")

function charInfo.onSay(player, words, param)

	local maxMana = player:getMaxMana()
	local mana = player:getMana()
	local maxHealth = player:getMaxHealth()
	local health = player:getHealth()

	player:sendTextMessage(MESSAGE_LOOK, ("LIFE: [%d]|[%d]\nMANA: [%d]|[%d]"):format(health, maxHealth, mana, maxMana))


	return true
end

charInfo:groupType("normal")
charInfo:register()
