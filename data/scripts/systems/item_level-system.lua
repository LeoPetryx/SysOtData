local config = {
    maxLevel = 15, --MAX LEVEL ITEM CAN REACH
    stonesId = {["940"] = 120, ["941"] = 250, ["943"] = 400, ["944"] = 550, ["945"] = 700} -- [itemId] = chance -- CHANCE WILL DECREASE PER LEVEL, CALCULATE: CHANCE / LEVEL
}

local refiner = Action()

function refiner.onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    local itemType = ItemType(itemEx:getId())
    local slot = itemType:getWeaponType()

    if not itemEx:isItem() then
        player:sendCancelMessage("Only used on items") 
        return player:getPosition():sendMagicEffect(CONST_ME_POFF)
    end
    if not itemType:isMovable() or itemType:isContainer() then
        player:sendCancelMessage("This item can not be refined")
       return  player:getPosition():sendMagicEffect(CONST_ME_POFF)
    end
    if (itemType:getWeaponType() == 0 and itemType:getSlotPosition() == 48)  then
         player:sendCancelMessage("This item can not be refined")
        return player:getPosition():sendMagicEffect(CONST_ME_POFF)
        
    end
    
    local defense = itemType:getDefense()
    local armor = itemType:getArmor()
    local attack = itemType:getAttack()
    local currentLevel = itemEx:getAttribute(ITEM_ATTRIBUTE_ITEMLEVEL)
    local animated = player:getPosition()

    if itemEx:getAttribute(ITEM_ATTRIBUTE_ITEMLEVEL) >= config.maxLevel then
                return player:sendCancelMessage("This item has already reached maximum level")
    end
            local itemId = item:getId()
            local chance = (config.stonesId[tostring(itemId)])
            local newLevel = currentLevel + 1
            local boolMath = math.random(0, 100) <= chance/newLevel

                if slot == 0 and boolMath then
                    item:remove(1)
                    itemEx:setAttribute(ITEM_ATTRIBUTE_ITEMLEVEL, newLevel)
                    itemEx:setAttribute(ITEM_ATTRIBUTE_ARMOR, armor + newLevel)
                    itemEx:getPosition():sendMagicEffect(31)
                    player:sendTextMessage(MESSAGE_LOOK, "Your Item has been refined and reached level ".. newLevel .."!")
                elseif (slot >= 1 and slot <= 3 or slot == 5) and boolMath then
                    item:remove(1)
                    itemEx:setAttribute(ITEM_ATTRIBUTE_ITEMLEVEL, newLevel)
                    itemEx:setAttribute(ITEM_ATTRIBUTE_ATTACK, attack + newLevel)
                    toPosition:sendMagicEffect(31)
                    itemEx:getPosition():sendMagicEffect(31)
                    player:sendTextMessage(MESSAGE_LOOK, "Your Item has been refined and reached level ".. newLevel .."!")
                elseif slot == 4 and boolMath then 
                    item:remove(1) 
                    itemEx:setAttribute(ITEM_ATTRIBUTE_ITEMLEVEL, newLevel)
                    itemEx:setAttribute(ITEM_ATTRIBUTE_DEFENSE, defense + newLevel)
                    itemEx:getPosition():sendMagicEffect(31)
                    player:sendTextMessage(MESSAGE_LOOK, "Your Item has been refined and reached level ".. newLevel .."!")
                elseif slot == 6 and boolMath then
                    item:remove(1)
                    itemEx:setAttribute(ITEM_ATTRIBUTE_ITEMLEVEL, newLevel)
                    itemEx:getPosition():sendMagicEffect(31)
                    player:sendTextMessage(MESSAGE_LOOK, "Your Item has been refined and reached level ".. newLevel .."!")
                elseif slot >= 0 and slot <= 6 and not boolMath then
                    item:remove(1)
                    if currentLevel <= 0 then
                            itemEx:getPosition():sendMagicEffect(32)
                            player:sendTextMessage(MESSAGE_LOOK, "Your Item has been not refined and continues at level 0!" .. slot.."")
                            
                    else
                        itemEx:getPosition():sendMagicEffect(32)
                        player:sendTextMessage(MESSAGE_LOOK, "Your Item has been downgraded to level ".. currentLevel - 1 .."!")
                        itemEx:setAttribute(ITEM_ATTRIBUTE_ITEMLEVEL, currentLevel - 1)
                        if slot == 0 then itemEx:setAttribute(ITEM_ATTRIBUTE_ARMOR, armor + currentLevel - 1) return true end
                        if slot >= 1 and slot <= 3 then itemEx:setAttribute(ITEM_ATTRIBUTE_ATTACK, attack + currentLevel - 1) return true end
                        if slot == 4 then itemEx:setAttribute(ITEM_ATTRIBUTE_DEFENSE, defense + currentLevel - 1) return true end
                    end
                else
                    player:sendCancelMessage("This item can not be refined")
                    return player:getPosition():sendMagicEffect(CONST_ME_POFF)
                    
                end
            
return true
end

refiner:id(940, 941, 943, 944, 945)
refiner:register()

local magicCondition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_LEFT)
local onEquipWand = MoveEvent()


function onEquipWand.onEquip(player, item, position, fromPosition)
    local itemLevel = item:getAttribute(ITEM_ATTRIBUTE_ITEMLEVEL)
    if itemLevel >= 1 then
    magicCondition:setParameter(CONDITION_PARAM_SUBID, 1051)
    magicCondition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, itemLevel)
    magicCondition:setParameter(CONDITION_PARAM_TICKS, -1)
    player:addCondition(magicCondition)
    return true
    end
    return true
end

local onDeEquipWand = MoveEvent()

function onDeEquipWand.onDeEquip(player, item, position, fromPosition)
    local itemLevel = item:getAttribute(ITEM_ATTRIBUTE_ITEMLEVEL)
    if itemLevel >= 1 then
    for i = 1051, 1051 do
        player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_LEFT, i)
    end
    return true
    end

    return true
end


for wandsId = 1, 50000 do
    if ItemType(wandsId):getWeaponType() == 6 then
        onDeEquipWand:id(wandsId)
        onEquipWand:id(wandsId)
    end
end


onDeEquipWand:register()
onEquipWand:register()