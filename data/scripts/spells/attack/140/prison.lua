local wildsorc = Combat()
wildsorc:setParameter(COMBAT_PARAM_CREATEITEM, 2130)
wildsorc:setArea(createCombatArea({
{0,1,0},
{1,2,1},
{0,1,0},
}))

local magicsorc = Combat()
magicsorc:setParameter(COMBAT_PARAM_CREATEITEM, 2128)
magicsorc:setArea(createCombatArea({
{1,0,1},
{0,2,0},
{1,0,1},
}))

local wildpaladin = Combat()
wildpaladin:setParameter(COMBAT_PARAM_CREATEITEM, 2130)
wildpaladin:setArea(createCombatArea({
{1,0,1},
{0,2,0},
{1,0,1},
}))

local magicpaladin = Combat()
magicpaladin:setParameter(COMBAT_PARAM_CREATEITEM, 2128)
magicpaladin:setArea(createCombatArea({
{0,1,0},
{1,2,1},
{0,1,0},
}))

local wilddruid = Combat()
wilddruid:setParameter(COMBAT_PARAM_CREATEITEM, 2130)
wilddruid:setArea(createCombatArea({
{1,1,1},
{1,2,1},
{1,1,1},
}))

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local voc = creature:getVocation():getBaseId()
	if voc == 1 then
		magicsorc:execute(creature, var)
		wildsorc:execute(creature, var)
	elseif voc == 2 then
		wilddruid:execute(creature, var)
	elseif voc == 3 then
		magicpaladin:execute(creature, var)
		wildpaladin:execute(creature, var)
	end
	return true
end



spell:group("attack")
spell:id(105)
spell:name("Magic Prison")
spell:words("magic prison")
spell:level(90)
spell:mana(340)
spell:isPremium(true)
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_ELECTRIFY)
spell:needWeapon(false)
spell:cooldown(6 * 1000)
spell:groupCooldown(1 * 1000)
spell:needLearn(false)
spell:needTarget(true)
spell:vocation("druid;true", "elder druid;true", "paladin;true", "royal paladin;true", "sorcerer;true", "master sorcerer;true")
spell:register()