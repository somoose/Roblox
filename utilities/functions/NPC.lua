local function GetClosestPlayer (Position)
	local ClosestPlayer = nil
	local MinimumDistance = math.huge

	for _, Player in pairs(Players:GetPlayers()) do
		if not Player.Character then continue end
		local Distance = (Player.Character:GetPivot().Position - Position).Magnitude
		
		if Distance < MinimumDistance then
			ClosestPlayer = Player
			MinimumDistance = Distance
		end
	end

	return ClosestPlayer
end

local function IsFacingAt (CFrame0, CFrame1)
	local Direction = (CFrame1.Position - CFrame0.Position).Unit * Vector3.new(1, 0, 1)
	
	return CFrame0.LookVector:Dot(Direction) > 0.5
end
