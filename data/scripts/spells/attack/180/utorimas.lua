local condition = Condition(CONDITION_ATTRIBUTES)
condition:setParameter(CONDITION_PARAM_SUBID, 5401)
condition:setParameter(CONDITION_PARAM_TICKS, 10000)
condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTSPERCENT, 150)
condition:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
combat:addCondition(condition)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if creature:getCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, 5401) then
		creature:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_COMBAT, 5401)
	end
	return combat:execute(creature, var)
end

spell:name("Magic Buff")
spell:words("utito mas")
spell:group("support", "focus")
spell:vocation("druid;true", "elder druid;true", "sorcerer;true", "master sorcerer;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_BLOOD_RAGE)
spell:cooldown(1 * 1000)
spell:level(180)
spell:mana(290)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:isPremium(false)
spell:needLearn(false)
spell:register()
