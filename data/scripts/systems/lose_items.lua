-- local storag = 99000 --- change
-- local position = Position(825, 681, 7) -- change

-- local removeItems = CreatureEvent("removeItemsLogin")

-- function removeItems.onLogin(player)
--     if player:getStorageValue(storag) <= 0 then
--         return true
--     else
-- 	for i = CONST_SLOT_HEAD, CONST_SLOT_AMMO do
-- 		local item = player:getSlotItem(i)
-- 		if item then
-- 				item:remove()
-- 		end
-- 	end
--     player:teleportTo(position)
--     player:setStorageValue(storag, 0)
--     return true
--     end

--     return true
-- end

-- removeItems:register()

-- local removeItems = MoveEvent()


-- function removeItems.onStepIn(creature)
--     local player = creature:getPlayer()
--         if not player then
--             return true
--         end

--     player:setStorageValue(storag, 1)
--     return true
-- end

-- removeItems:type("stepin")
-- removeItems:aid(5555) -- change
-- removeItems:register()