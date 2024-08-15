

local spell = Spell("instant")



function spell.onCastSpell(player, creature, variant)
	local position = player:getPosition()
	local level = player:getLevel()
	local magicLevel = player:getMagicLevel()
	local mana = player:getMaxMana()
	local health = player:getMaxHealth()
	local min = (level * 1.9 + magicLevel * 3.4 + mana * 0.026)	
	local max = (level * 2.1 + magicLevel * 3.5 + mana * 0.028)
	local minHealth = (level * 1.9 + magicLevel * 3.4 + health * 0.026)
	local maxHealth = (level * 2.1 + magicLevel * 3.5 + health * 0.028)

	
	position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:addHealth(math.random(minHealth, maxHealth))
	player:addMana(math.random(min, max))
	return true
end

spell:name("Intense Recovery")
spell:words("utura gran")
spell:group("support")
spell:vocation("druid;true", "elder druid;true", "knight;true", "elite knight;true", "paladin;true", "royal paladin;true", "sorcerer;true", "master sorcerer;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_INTENSE_HEALING)
spell:id(160)
spell:cooldown(1* 1000)
spell:groupCooldown(1 * 1000)
spell:level(120)
spell:mana(0)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:register()
