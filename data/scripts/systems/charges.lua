local getitemcharge = Action()

function getitemcharge.onUse(player,fromPosition, item, itemEx, toPosition)
    local itemType = ItemType(itemEx.id)
    if player then
    local itemcharges = itemEx:getAttribute(ITEM_ATTRIBUTE_CHARGES)
    player:sendTextMessage(21, itemcharges)
    end
    return true
end

getitemcharge:id(947)
getitemcharge:register()