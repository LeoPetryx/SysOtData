local consan = Combat()
consan:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
consan:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYDAMAGE)
consan:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SMALLHOLY)

function onGetFormulaValues(cid, skill, attack, factor)
	local min = ((attack * 0.3) * (skill * 0.06)) * (((skill * 1.6) + attack) * 0.02)
	local max = ((attack * 0.3) * (skill * 0.06)) * (((skill * 1.6) + attack) * 0.021)
	return -min*3, -max*3
end

consan:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

local spell = Spell("instant")

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



function spell.onCastSpell(creature, var)
	local startPos = creature:getPosition(cid)
	local creatureId = creature:getId()
	RunPart(consan, creatureId, var, startPos)
	addEvent(RunPart, 100 * 3, consan, creatureId, var, startPos)
	addEvent(RunPart, 100 * 6, consan, creatureId, var, startPos)
	return true
end

spell:group("attack")
spell:id(111)
spell:name("Holy Divine Missile")
spell:words("exori con")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_DIVINE_MISSILE)
spell:level(160)
spell:mana(350)
spell:isPremium(false)
spell:range(5)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(1 * 1000)
spell:groupCooldown(1 * 1000)
spell:needLearn(false)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
