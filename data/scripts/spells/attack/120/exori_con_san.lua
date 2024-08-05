local consan = Combat()
consan:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
consan:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
consan:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)

function onGetFormulaValues(cid, maglevel, skill, attack, factor)
	local level = cid:getLevel()
	local min = (skill * 4.8 ) + (attack * 5.4)
	local max = (skill * 5.5 ) + (attack * 6.2)
	return -min, -max
end

consan:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")


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
	RunPart(consan, creatureId, var, startPos)
	addEvent(RunPart, 200 * 9, consan, creatureId, var, startPos)
	addEvent(RunPart, 200 * 8, consan, creatureId, var, startPos)
	addEvent(RunPart, 200 * 7, consan, creatureId, var, startPos)
	addEvent(RunPart, 200 * 6, consan, creatureId, var, startPos)
	addEvent(RunPart, 200 * 5, consan, creatureId, var, startPos)
	addEvent(RunPart, 200 * 4, consan, creatureId, var, startPos)
	addEvent(RunPart, 200 * 3, consan, creatureId, var, startPos)
	addEvent(RunPart, 200 * 2, consan, creatureId, var, startPos)
	addEvent(RunPart, 200 * 1, consan, creatureId, var, startPos)
	return true
end

spell:group("attack")
spell:id(122)
spell:name("Divine Missile")
spell:words("exori con san")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_MISSILE)
spell:level(120)
spell:mana(200)
spell:isPremium(false)
spell:range(4)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(1 * 1000)
spell:groupCooldown(1 * 1000)
spell:needLearn(false)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
