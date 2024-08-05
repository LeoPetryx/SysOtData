

local teleportInsideCastle = MoveEvent()

function teleportInsideCastle.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local toPosition = Position(695, 761, 7)
	if not toPosition then
		return true
	end

	player:teleportTo(toPosition)
	toPosition:sendMagicEffect(CONST_ME_POFF)
	return true
end

teleportInsideCastle:type("stepin")


teleportInsideCastle:aid(65535)


teleportInsideCastle:register()
