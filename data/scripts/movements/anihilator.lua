local anihilator = MoveEvent()


function anihilator.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local position = Position(920, 658, 8)
	player:teleportTo(position)
	position:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

anihilator:type("stepin")
anihilator:aid(46001)
anihilator:register()
