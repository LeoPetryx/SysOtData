local petsTable = {
    name = {"Holy Pet", "Fire Pet", "Ice Pet", "Terra Pet", "Energy Pet"},
    ltype = {152, 149, 251, 144, 145},
    lbody = {79, 94, 88, 120, 109},
    attacktype = {COMBAT_HOLYDAMAGE, COMBAT_FIREDAMAGE, COMBAT_ICEDAMAGE, COMBAT_EARTHDAMAGE, COMBAT_ENERGYDAMAGE},
    attackeffect = {CONST_ANI_SMALLHOLY, CONST_ANI_FIRE, CONST_ANI_SMALLICE, CONST_ANI_SMALLEARTH, CONST_ANI_ENERGY},

    itemId = {[6541]=1, [6542]=2, [6543]=3, [6544]=4, [6545]=5},
}

for i = 1, 5 do
        local mType = Game.createMonsterType(petsTable.name[i])
        local monster = {}
        
        monster.description = string.format("a %s", petsTable.name[i]:lower())
        monster.outfit = {
            lookType = petsTable.ltype[i],
            lookHead = petsTable.lbody[i],
            lookBody = petsTable.lbody[i],
            lookLegs = petsTable.lbody[i],
            lookFeet = petsTable.lbody[i],
            lookAddons = 3,
            lookMount = 0,
        }

        monster.health = 7000
        monster.maxHealth = 7000
        monster.race = "blood"
        monster.corpse = 0
        monster.speed = 500
        monster.manaCost = 450
        
        monster.changeTarget = {
            interval = 4000,
            chance = 0,
        }
        
        monster.strategiesTarget = {
            nearest = 70,
            health = 20,
            damage = 10,
        }
        
        monster.flags = {
            summonable = true,
            attackable = false,
            hostile = true,
            convinceable = false,
            pushable = true,
            illusionable = true,
            canPushItems = true,
            canPushCreatures = true,
            staticAttackChance = 90,
            targetDistance = 1,
            runHealth = 0,
            healthHidden = false,
            isBlockable = false,
            canWalkOnEnergy = true,
            canWalkOnFire = true,
            canWalkOnPoison = true,
            pet = true,
        }
        
        monster.attacks = {
            { name = "combat", interval = 1000, chance = 100, type = petsTable.attacktype[i], minDamage = -150, maxDamage = -300, range = 7, shootEffect = petsTable.attackeffect[i], target = true },
        }
        
        mType:register(monster)        
end

local summonPets = Action()

function summonPets.onUse(player, item, fromPosition, toPosition)
    local position = player:getPosition()
    if #player:getSummons() >= 1 then
        return player:sendCancelMessage("You alredy have a pet summon.")
    end
    local i = petsTable.itemId[item:getId()]

    item:remove(1)
    summon = Game.createMonster(petsTable.name[i], position, true, false, player)
    return true
end

summonPets:id(6541,6542,6543,6544,6545)
summonPets:register()