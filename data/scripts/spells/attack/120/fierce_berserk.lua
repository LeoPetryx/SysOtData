local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setParameter(COMBAT_PARAM_USECHARGES, 1)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	
	local min = ((attack * 6.5) * (skill * 0.0225)) * ((skill + (attack * 1.9)) * 0.02)
	local max = ((attack * 6.5) * (skill * 0.0225)) * ((skill + (attack * 1.9)) * 0.02)
	-- ((skill * 0.8) + (attack * 0.2) + (attack * 0.3)) * (attack * 0.3)
	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
end


combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack")
spell:id(105)
spell:name("Fierce Berserk")
spell:words("exori gran")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_FIERCE_BERSERK)
spell:level(90)
spell:mana(200)
spell:isPremium(false)
spell:needWeapon(true)
spell:cooldown(1 * 1000)
spell:groupCooldown(1 * 1000)
spell:needLearn(false)
spell:vocation("knight;true", "elite knight;true")
spell:register()