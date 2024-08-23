function GetPlayerFromPlayers (Username)
	if not Username then return end
	
	for _, Player in pairs(game.Players:GetPlayers()) do
		if Player.Name:lower():sub(1, #Username) == Username:lower() then return Player end
		if Player.DisplayName:lower():sub(1, #Username) == Username:lower() then return Player end
	end
end

local args = {...}

for _, arg in pairs(args) do
	local Target = GetPlayerFromPlayers(arg).Character
	Target:PivotTo(owner.Character:GetPivot())
end
