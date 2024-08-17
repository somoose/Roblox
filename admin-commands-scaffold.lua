local Players = game:GetService("Players")


local Admins = {}


local Functions = {}


local MAINPREFIX = ":"
local MAINSEPARATOR = " "
local Commands = {
	Command = { -- The index is the code of the command i.e. :code
		Prefix = MAINPREFIX,
		Separator = MAINSEPARATOR,

		Function = function (Player, a, b, c) end,
	},
}


Players.PlayerAdded:Connect(function(Player)
	if table.find(Admins, Player.UserId) then
		Player.Chatted:Connect(function(Message)
			for Code, Command in pairs(Commands) do
				if Message:sub(1, 1):lower() == Command.Prefix then
					local Sections = Message:sub(2, #Message):split(Command.Separator)
					if Sections[1]:lower() == Code:lower() then
						table.remove(Sections, 1)
						Command.Function(Player, table.unpack(Sections))
					end
				end
			end
		end)
	end
end)
