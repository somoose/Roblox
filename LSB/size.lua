function GetPlayerFromTruncatedName (Name)
	if not Name then return end
	
	for _, Player in pairs(game.Players:GetPlayers()) do
		if Player.Name:lower():sub(1, #Name) == Name:lower() then return Player end
		if Player.DisplayName:lower():sub(1, #Name) == Name:lower() then return Player end
	end
end

local ARGS = {...}

local Scale = tonumber(ARGS[1])
local Target = (ARGS[2] == nil or ARGS[2] == "") and owner.Character or GetPlayerFromTruncatedName(ARGS[2]).Character

Target:ScaleTo(Scale)
