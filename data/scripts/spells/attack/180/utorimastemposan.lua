local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_SUBID, 5403)
condition:setParameter(CONDITION_PARAM_TICKS, 10000)
condition:setParameter(CONDITION_PARAM_SKILL_DISTANCEPERCENT, 150)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_YELLOW)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if creature:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, 5403) then
		creature:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, 5403)
	end
	return combat:execute(creature, var)
end

spell:name("Magic Buff")
spell:words("utito mas tempo san")
spell:group("support", "focus")
spell:vocation("paladin;true", "royal paladin;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_BLOOD_RAGE)
spell:cooldown(1 * 1000)
spell:level(180)
spell:mana(290)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(false)
spell:needLearn(false)
spell:register()
