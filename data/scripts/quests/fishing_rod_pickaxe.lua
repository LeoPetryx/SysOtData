local fishMiningQuest = Action()
local storageDoor = 85652
local templePos = Position(825, 681, 7)
local questInit = Position(841, 753, 7)
local rewards = {
	{itemId = 3483, count = 1},
    {itemId = 3456, count = 1}
}

function fishMiningQuest.onUse(player, item, fromPosition, toPosition)
    local depotChest = player:getInbox()
    local bag = Game.createItem(2854, 1) --[[@as Container]]
    for _, reward in ipairs(rewards) do
		bag:addItem(reward.itemId, reward.count)
	end
    player:setStorageValue(storageDoor, 1)
    depotChest:addItemEx(bag, INDEX_WHEREEVER, FLAG_NOLIMIT)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Items was sent to your mailbox.")
    player:teleportTo(templePos)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    return true
end

fishMiningQuest:aid(45001)
fishMiningQuest:register()

fishMiningQuest = MoveEvent()

function fishMiningQuest.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        creature:teleportTo(fromPosition, false)
        creature:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    end

    if player:getStorageValue(storageDoor) >= 1 then
        player:teleportTo(fromPosition, false)
        player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
        player:sendCancelMessage("You have already done the quest.")
        return false
    else 
    player:teleportTo(questInit)
    player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Good luck!")
    end
    return true
end

fishMiningQuest:aid(45002)
fishMiningQuest:type("stepin")
fishMiningQuest:register()