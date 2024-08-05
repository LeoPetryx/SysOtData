local Spells = TalkAction("!spells")
 
function Spells.onSay(player, words, param)
    if player then
        local text = 'Custom Spells List: \n\n'
        text = text .. 'Utani Mega Hur [LvL - 150] ALL\n'
        text = text .. 'Exevo Massive Santera [LvL - 500] RP\n'
        text = text .. 'Exevo Massive Death [LvL - 500] Mage\n'
        text = text .. 'Exori Max Heart [LvL - 500] EK \n'
        player:showTextDialog(3101, text)
    end
    return false
end
Spells:groupType("normal") 
Spells:register()