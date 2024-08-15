local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREATTACK)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)

function onGetFormulaValues(player,level, maglevel)
	local min = (maglevel * 29.1) * (maglevel * 0.01)
	local max = (maglevel * 29.4) * (maglevel * 0.01)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")



local function RunPart(c,cid,var,dirList,dirEmitPos) -- Part
	if (Creature(cid):isCreature(cid)) then
		c:execute(cid, var)
		if (dirList ~= nil) then -- Emit distance effects
			local i = 2;
			while (i < #dirList) do
				dirEmitPos:sendDistanceEffect({x=dirEmitPos.x-dirList[i],y=dirEmitPos.y-dirList[i+1],z=dirEmitPos.z},dirList[1])
				i = i + 2
			end
		end
	end
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local startPos = creature:getPosition(cid)
	local creatureId = creature:getId()
	RunPart(combat, creatureId, var, startPos)
	addEvent(RunPart, 100 * 3, combat, creatureId, var, startPos)
	addEvent(RunPart, 100 * 6, combat, creatureId, var, startPos)
	return true
end

spell:group("attack")
spell:name("Flame Strike")
spell:words("exori flam mas")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_FLAME_STRIKE)
spell:level(120)
spell:mana(600)
spell:isPremium(false)
spell:range(5)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(1 * 1000)
spell:groupCooldown(1 * 1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
