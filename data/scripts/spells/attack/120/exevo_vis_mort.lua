local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setArea(createCombatArea(AREA_BEAM7, AREADIAGONAL_BEAM7))

function onGetFormulaValues(player, level, maglevel)
	local min = (maglevel * 42.3) * (maglevel * 0.01)
	local max = (maglevel * 42.8) * (maglevel * 0.01)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(120)
spell:name("Mort Explosion")
spell:words("exevo vis mort")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_DEATH_STRIKE)
spell:level(120)
spell:mana(600)
spell:isPremium(false)
spell:needDirection(true)
spell:cooldown(1 * 1000)
spell:groupCooldown(1 * 1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()