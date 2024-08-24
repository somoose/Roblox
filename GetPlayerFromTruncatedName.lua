function GetPlayerFromTruncatedName (Name)
	if not Name then return end
	
	for _, Player in pairs(game.Players:GetPlayers()) do
		if Player.Name:lower():sub(1, #Name) == Name:lower() then return Player end
		if Player.DisplayName:lower():sub(1, #Name) == Name:lower() then return Player end
	end
end
