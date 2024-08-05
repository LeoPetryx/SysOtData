

local spell = Spell("instant")

function spell.onCastSpell(player, creature, variant)
	local position = player:getPosition()
	local level = player:getLevel()
	local magicLevel = player:getMagicLevel()
	local mana = player:getMaxMana()
	local min = (level * 1.7 + magicLevel * 3.0 + mana * 0.023)	
	local max = (level * 2.5 + magicLevel * 3.5 + mana * 0.028)

	
	position:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return player:addMana(math.random(min, max))
end

spell:name("Mana Heal")
spell:words("mas mana")
spell:group("support")
spell:vocation("druid;true", "elder druid;true", "knight;true", "elite knight;true", "paladin;true", "royal paladin;true", "sorcerer;true", "master sorcerer;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_INTENSE_HEALING)
spell:id(2)
spell:cooldown(1000)
spell:groupCooldown(1000)
spell:level(120)
spell:mana(0)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:register()
