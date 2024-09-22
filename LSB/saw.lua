local LSB_PARAMS = {...}
for i = 1, tonumber(LSB_PARAMS[1]) or 1 do
local function GetClosestPlayer (Position)
	local ClosestPlayer = nil
	local MinimumDistance = math.huge

	for _, Player in pairs(game.Players:GetPlayers()) do
		if not Player.Character then continue end
		local Distance = (Player.Character:GetPivot().Position - Position).Magnitude
		
		if Distance < MinimumDistance then
			ClosestPlayer = Player
			MinimumDistance = Distance
		end
	end

	return ClosestPlayer
end

local function RollAt (Part, Location, Force)
	local Direction = (Location - Part.Position).Unit
	Part.AssemblyAngularVelocity = Direction:Cross(Vector3.new(0, -1, 0)) * Force
end

local SawMeshId = "rbxassetid://6832869058"

local Saw = game.InsertService:CreateMeshPartAsync(SawMeshId, Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
Saw.Material = Enum.Material.Metal
Saw.BrickColor = BrickColor.new("Dark grey")
Saw.CustomPhysicalProperties = PhysicalProperties.new(math.huge, 1, 0)
Saw.PivotOffset = CFrame.Angles(math.pi/2, 0, 0)
Saw.Size *= 0.1
Saw.CFrame = owner.Character.Head.CFrame * CFrame.new(0, 0, Saw.Size.Z/1.5)
Saw.Parent = script

task.spawn(function()
	while true do
		local ClosestPlayer = GetClosestPlayer(Saw.Position)

		if ClosestPlayer then
			local Character = ClosestPlayer.Character
			local CharacterSize = Character:GetExtentsSize()
			
			local T = time()
			local Frequency = 5
			local Amplitude = CharacterSize.X
			
			RollAt(
				Saw,
				Character:GetPivot().Position + Vector3.new(math.sin(T * Frequency) * Amplitude, 0, math.cos(T * Frequency) * Amplitude),
				60
			)
		end
		
		task.wait()
	end
end)
end
