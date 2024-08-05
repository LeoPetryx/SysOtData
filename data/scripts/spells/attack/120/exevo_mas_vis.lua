local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_PURPLEENERGY)
combat:setArea(createCombatArea({
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
{0,0,1,0,0,0,0,1,0,0,0,0,1,0,0},
{0,0,0,1,0,0,0,1,0,0,0,1,0,0,0},
{0,0,0,0,1,0,1,1,1,0,1,0,0,0,0},
{0,0,0,0,0,1,0,1,0,1,0,0,0,0,0},
{0,0,0,0,1,0,1,1,1,0,1,0,0,0,0},
{0,0,1,1,1,1,1,3,1,1,1,1,1,0,0},
{0,0,0,0,1,0,1,1,1,0,1,0,0,0,0},
{0,0,0,0,0,1,0,1,0,1,0,0,0,0,0},
{0,0,0,0,1,0,1,1,1,0,1,0,0,0,0},
{0,0,0,1,0,0,0,1,0,0,0,1,0,0,0},
{0,0,1,0,0,0,0,1,0,0,0,0,1,0,0},
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}

	}))

function onGetFormulaValues(player, level, maglevel)
	local min = (level * 1.8) + (maglevel * 14.1)
	local max = (level * 2.4) + (maglevel * 16.4)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(120)
spell:name("Energy Explosion")
spell:words("exevo mas vis")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_ELECTRIFY)
spell:level(120)
spell:mana(600)
spell:isPremium(false)
spell:needDirection(false)
spell:cooldown(1 * 1000)
spell:groupCooldown(1 * 1000)
spell:needLearn(false)
spell:vocation("druid;true", "elder druid;true")
spell:register()