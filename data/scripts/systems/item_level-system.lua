local config = {
    maxLevel = 15, --MAX LEVEL ITEM CAN REACH
    stonesId = {["940"] = 120, ["941"] = 200, ["943"] = 300, ["944"] = 450, ["945"] = 600} -- [itemId] = chance -- CHANCE WILL DECREASE PER LEVEL, CALCULATE: CHANCE / LEVEL
}

local wands = {

    { id =3065, name = "terra rod"},
    { id =3066, name = "snakebite rod"},
    { id =3067, name = "hailstorm rod"},
    { id =3069, name = "necrotic rod"},
    { id =3070, name = "moonlight rod"},
    { id =3071, name = "wand of inferno"},
    { id =3072, name = "wand of decay"},
    { id =3073, name = "wand of cosmic energy"},
    { id =3074, name = "wand of vortex"},
    { id =3075, name = "wand of dragonbreath"},
    { id =8082, name = "underworld rod"},
    { id =8083, name = "northwind rod"},
    { id =8084, name = "springsprout rod"},
    { id =8092, name = "wand of starstorm"},
    { id =8093, name = "wand of draconia"},
    { id =8094, name = "wand of voodoo"},
    { id =12603, name = "wand of dimensions"},
    { id =12732, name = "shimmer rod"},
    { id =12741, name = "shimmer wand"},
    { id =16096, name = "wand of defiance"},
    { id =16115, name = "wand of everblazing"},
    { id =16117, name = "muck rod"},
    { id =16118, name = "glacial rod"},
    { id =17111, name = "sorcerer and druid staff"},
    { id =21348, name = "scorcher"},
    { id =21350, name = "chiller"},
    { id =22183, name = "ogre scepta"},
    { id =22765, name = "Ferumbras' staff"},
    { id =22766, name = "Ferumbras' staff"},
    { id =25700, name = "dream blossom staff"},
    { id =25760, name = "wand of darkness"},
    { id =27457, name = "wand of destruction"},
    { id =27458, name = "rod of destruction"},
    { id =28466, name = "sorcerer test weapon TEST"},
    { id =28479, name = "wand of destruction TEST"},
    { id =28716, name = "falcon rod"},
    { id =28717, name = "falcon wand"},
    { id =28825, name = "deepling ceremonial dagger"},
    { id =28826, name = "deepling fork"},
    { id =29425, name = "energized limb"},
    { id =30399, name = "cobra wand"},
    { id =30400, name = "cobra rod"},
    { id =34090, name = "soultainter"},
    { id =34091, name = "soulhexer"},
    { id =34151, name = "lion rod"},
    { id =34152, name = "lion wand"},
    { id =35521, name = "jungle rod"},
    { id =35522, name = "jungle wand"},
    { id =36668, name = "eldritch wand"},
    { id =36669, name = "gilded eldritch wand"},
    { id =36674, name = "eldritch rod"},
    { id =36675, name = "gilded eldritch rod"},
    { id =39162, name = "naga wand"},
    { id =39163, name = "naga rod"},
    { id =43882, name = "sanguine coil"},
    { id =43883, name = "grand sanguine coil"},
    { id =43885, name = "sanguine rod"},
    { id =43886, name = "grand sanguine rod"},
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
                            player:sendTextMessage(MESSAGE_LOOK, "Your Item has been not refined and continues at level 0!")
                            
                    else
                        itemEx:getPosition():sendMagicEffect(32)
                        player:sendTextMessage(MESSAGE_LOOK, "Your Item has been downgraded to level ".. currentLevel - 1 .."!")
                        itemEx:setAttribute(ITEM_ATTRIBUTE_ITEMLEVEL, currentLevel - 1)
                        if slot == 0 then itemEx:setAttribute(ITEM_ATTRIBUTE_ARMOR, armor + currentLevel - 1) return true end
                        if ((slot >= 1 and slot <= 3) or slot == 5) then itemEx:setAttribute(ITEM_ATTRIBUTE_ATTACK, attack + currentLevel - 1) return true end
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

local magicCondition = Condition(CONDITION_ATTRIBUTES, CONDITIONID_RIGHT)
local onEquipWand = MoveEvent()


function onEquipWand.onEquip(player, item, slot, isCheck)
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

function onDeEquipWand.onDeEquip(player, item, slot, isCheck)
    local itemLevel = item:getAttribute(ITEM_ATTRIBUTE_ITEMLEVEL)
    if itemLevel >= 1 then
        player:removeCondition(CONDITION_ATTRIBUTES, CONDITIONID_RIGHT, 1051)
    return true
    end

    return true
end

for j=1,#wands do
        onEquipWand:id(wands[j].id)
        onDeEquipWand:id(wands[j].id)
end

onEquipWand:type("equip")
onDeEquipWand:type("deequip")
onDeEquipWand:register()
onEquipWand:register()


