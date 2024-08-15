local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_STUN)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_WEAPONTYPE)

function onGetFormulaValues(player, skill, attack, factor)
	local level = player:getLevel()
	
	local min = ((attack * 6.5) * (skill * 0.0225)) * ((skill + (attack * 1.9)) * 0.019)
	local max = ((attack * 6.5) * (skill * 0.0225)) * ((skill + (attack * 1.9)) * 0.019)
	-- ((skill * 0.8) + (attack * 0.2) + (attack * 0.3)) * (attack * 0.3)
	return -min * 1.1, -max * 1.1 -- TODO : Use New Real Formula instead of an %
end


combat:setCallback(CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

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
	RunPart(combat, creatureId, var, startPos)
	addEvent(RunPart, 100 * 3, combat, creatureId, var, startPos)
	addEvent(RunPart, 100 * 6, combat, creatureId, var, startPos)
	return true
end

spell:group("attack")
spell:name("Strong Physical")
spell:words("exori slices")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_BRUTAL_STRIKE)
spell:level(160)
spell:mana(200)
spell:isPremium(false)
spell:range(3)
spell:needTarget(true)
spell:blockWalls(true)
spell:cooldown(1 * 1000)
spell:groupCooldown(1 * 1000)
spell:needLearn(false)
spell:vocation("knight;true", "elite knight;true")
spell:register()
