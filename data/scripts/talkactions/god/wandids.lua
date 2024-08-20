
-- Insipired in Marcosvf132 hexmonsters script


local hexmonster = TalkAction("/wandids")


function hexmonster.onSay(player, words, param)
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end

	local file = io.open("data/wandids.txt", "wb")
	if file then
			for i=1,50000 do
				if ItemType(i):getWeaponType() == 6 then
					local id = i
					local name = ItemType(i):getName()

				return_hex = "\n{ id ="..i..", name = \"" ..name.."\"},"
				file:write("items = {\n"..return_hex.."\n}")
			end
		end
		player:sendCancelMessage("Data file has been succesfully created.")
		io.close(file)
	end
	return true
end

hexmonster:separator(" ")
hexmonster:groupType("god")
hexmonster:register()