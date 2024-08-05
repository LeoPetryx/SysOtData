local config = {
    actionId = 46009,  -- ActionID da alavanca
    requiredItemId = 37317, 
    positions = {
        {x = 909, y = 586, z = 7}, -- Posição inicial
        {x = 910, y = 586, z = 7},
        {x = 911, y = 586, z = 7},
        {x = 912, y = 586, z = 7},
        {x = 913, y = 586, z = 7}, -- Posição final (centro)
        {x = 914, y = 586, z = 7},
        {x = 915, y = 586, z = 7},
        {x = 916, y = 586, z = 7},
        {x = 917, y = 586, z = 7}  -- Posição Final
    },
    items = {
        {id = 37317, count = 2, chance = 100, raro = true},
        {id = 34109, count = 1, chance = 90, raro = true},
        {id = 39546, count = 1, chance = 80, raro = true},
		{id = 22118, count = 100, chance = 70, raro = true},
		{id = 9803, count = 1, chance = 60, raro = true},
		{id = 37061, count = 1, chance = 50, raro = true},
        {id = 3043, count = 100, chance = 1000},
        {id = 3587, count = 20, chance = 700},
        {id = 37110, count = 1, chance = 550},
        {id = 645, count = 1, chance = 450},
        {id = 3423, count = 1, chance = 350},
        {id = 6529, count = 1, chance = 250},
        {id = 3363, count = 1, chance = 150},
        {id = 34326, count = 1, chance = 10, raro = true}
    }
}

local isRouletteRunning = false

local function addItemToPlayer(player, item)
    player:addItem(item.id, item.count)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Legal! Ganhou um " .. ItemType(item.id):getName() .. "!")
    player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
    if item.raro then
        Game.broadcastMessage(player:getName() .. " ganhou um item raro: " .. ItemType(item.id):getName() .. " na roleta!", MESSAGE_EVENT_ADVANCE)
    end
end

local function getRandomItem(item)
    local totalWeight = 0
    for _, item in ipairs(config.items) do
        totalWeight = totalWeight + item.chance
    end

    local randomWeight = math.random(0, 1000)
    local cumulativeWeight = 0
    for _, item in ipairs(config.items) do
        cumulativeWeight = cumulativeWeight + item.chance
        if randomWeight < cumulativeWeight then
            return item
        end
    end
end

local function moveItems()
    for i = #config.positions, 2, -1 do
        local tile = Tile(config.positions[i - 1])
        local item = tile and tile:getTopDownItem()
        if item then
            item:moveTo(config.positions[i])
            Position(config.positions[i]):sendMagicEffect(CONST_ME_MAGIC_GREEN)
        end
    end
end

local function clearItems()
    for _, pos in ipairs(config.positions) do
        local tile = Tile(Position(pos))
        if tile then
            local item = tile:getTopDownItem()
            while item do
                item:remove()
                item = tile:getTopDownItem()
            end
        end
    end
end

local function createItemWithEffect(position, item)
    Game.createItem(item.id, item.count, Position(position))
    Position(position):sendMagicEffect(CONST_ME_MAGIC_BLUE)
end

local function getItemConfigById(itemId)
    for _, item in ipairs(config.items) do
        if item.id == itemId then
            return item
        end
    end
    return nil
end

local function rouletteAction(player)
    isRouletteRunning = true
    local steps = 30 + math.random(5, 10)  -- Número de passos que a roleta dará antes de parar
    local interval = 100  -- Intervalo

    local currentItem = getRandomItem()
    createItemWithEffect(config.positions[1], currentItem)

    for i = 1, steps do
        addEvent(function()
            moveItems()
            if i == steps then
                local winningItem = Tile(Position(config.positions[5])):getTopDownItem()
                if winningItem then
                    clearItems()
                    for _, pos in ipairs(config.positions) do
                        createItemWithEffect(pos, {id = winningItem:getId(), count = winningItem:getCount()})
                    end
                    local itemConfig = getItemConfigById(winningItem:getId())
                    addItemToPlayer(player, itemConfig)
                end
                isRouletteRunning = false
            else
                local lastPositionTile = Tile(Position(config.positions[#config.positions]))
                if lastPositionTile then
                    local lastItem = lastPositionTile:getTopDownItem()
                    if lastItem then
                        lastItem:remove()
                        Position(config.positions[#config.positions]):sendMagicEffect(CONST_ME_POFF)
                    end
                end
                currentItem = getRandomItem()
                createItemWithEffect(config.positions[1], currentItem)
            end
        end, i * interval)

        -- Aumentar o intervalo para simular a desaceleração
        interval = interval + 5
    end
end

local rouletteLever = Action()

function rouletteLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if isRouletteRunning then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Roleta funcionando. Por favor, espere.")
        return false
    end

    if item.actionid == config.actionId then
        if player:removeItem(config.requiredItemId, 1) then
            clearItems()
            rouletteAction(player)
            return true
        else
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Precisa de um item especial para acionar a roleta.")
            return false
        end
    end
    return false
end

rouletteLever:aid(config.actionId)
rouletteLever:register()
