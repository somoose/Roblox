local Debris = game:GetService("Debris")
local InsertService = game:GetService("InsertService")

local GloveMeshId = "http://www.roblox.com/asset/?id=32054761"

local RNG = Random.new()

local Tool = Instance.new("Tool", owner.Backpack)
Tool.Name = "slap"
local Stick = Instance.new("Part", Tool)
Stick.Name = "Handle"
Stick.Size = Vector3.new(0.383/2, 0.29/2, 1.657)
Stick.Color = Color3.fromRGB(0, 0, 0)
Stick.Material = Enum.Material.SmoothPlastic
Tool.Grip = CFrame.new(0, 0, Stick.Size.Z/3) * CFrame.Angles(-math.pi/2, 0, 0)
local Glove = InsertService:CreateMeshPartAsync(GloveMeshId, Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
Glove.Name = "Glove"
Glove.Size = Vector3.new(2.46, 3.256, 0.916)
Glove.Color = Color3.fromRGB(242, 243, 243)
Glove.Parent = Tool
local Weld = Instance.new("Weld", Glove)
Weld.Part0 = Glove
Weld.Part1 = Stick
Weld.C0 = CFrame.new(-Stick.Size.X, Stick.Size.Z/2.5 + Glove.Size.Y/2, 0) * CFrame.Angles(0, 0, math.pi) * CFrame.Angles(math.pi/2, 0, 0)
local SmackSound = Instance.new("Sound", Glove)
SmackSound.SoundId = "rbxassetid://7195270254"
SmackSound.Volume = 3
local SmackParticleEmitter = Instance.new("ParticleEmitter", Glove)
SmackParticleEmitter.Brightness = 5
SmackParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
SmackParticleEmitter.LightEmission = 10
SmackParticleEmitter.LightInfluence = 0
SmackParticleEmitter.Orientation = "FacingCamera"
SmackParticleEmitter.Size = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0),
	NumberSequenceKeypoint.new(0.5, 1.5),
	NumberSequenceKeypoint.new(1, 0)
})
SmackParticleEmitter.Squash = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0),
	NumberSequenceKeypoint.new(0.172, 3),
	NumberSequenceKeypoint.new(1, 0)
})
SmackParticleEmitter.Texture = "rbxassetid://5755091589"
SmackParticleEmitter.Transparency = NumberSequence.new(0)
SmackParticleEmitter.ZOffset = 0
SmackParticleEmitter.EmissionDirection = "Top"
SmackParticleEmitter.Enabled = false
SmackParticleEmitter.Lifetime = NumberRange.new(0.25, 0.25)
SmackParticleEmitter.Rate = 30
SmackParticleEmitter.Rotation = NumberRange.new(-100, 100)
SmackParticleEmitter.RotSpeed = NumberRange.new(0)
SmackParticleEmitter.Speed = NumberRange.new(5, 5)
SmackParticleEmitter.SpreadAngle = Vector2.new(0, 0)
SmackParticleEmitter.Shape = "Box"
SmackParticleEmitter.ShapeInOut = "Outward"
SmackParticleEmitter.ShapeStyle = "Volume"
SmackParticleEmitter.TimeScale = 1

local function Fling (HumanoidRootPart, Direction, TimeForceActive)
	local BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.MaxForce = Vector3.one * math.huge
	BodyVelocity.Velocity = (Direction + Vector3.new(0, 0.25, 0)) * 200
	BodyVelocity.Parent = HumanoidRootPart
	local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
	BodyAngularVelocity.MaxTorque = Vector3.one * math.huge
	BodyAngularVelocity.AngularVelocity = RNG:NextUnitVector() * 40
	BodyAngularVelocity.Parent = HumanoidRootPart
	Debris:AddItem(BodyVelocity, TimeForceActive)
	Debris:AddItem(BodyAngularVelocity, TimeForceActive)
end
local function FlingTouching (Handle)
	local OverlapParams = OverlapParams.new()
	OverlapParams.FilterType = Enum.RaycastFilterType.Blacklist
	OverlapParams.BruteForceAllSlow = true

	local Attacked = {}
	
	for _, Part in pairs(workspace:GetPartBoundsInBox(Stick.CFrame, Glove.Size * 2, OverlapParams)) do
		if Part:IsDescendantOf(owner.Character) then continue end
		if Part.Parent:FindFirstChild("Humanoid") then
			if table.find(Attacked, Part.Parent) then continue end
		end
		Fling(Part, -Stick.CFrame.UpVector, 0.1)
		SmackParticleEmitter:Emit(1)
		SmackSound:Play()
		--[[if Part.Parent:FindFirstChild("Humanoid") then
			Fling(Part.Parent.HumanoidRootPart, -Stick.CFrame.UpVector, 0.1)
			SmackParticleEmitter:Emit(1)
			SmackSound:Play()
		end]]
	end
end

Tool.Activated:Connect(function()
	FlingTouching(Glove)
end)

--[[
local Radius = 7
local Speed = 1

local function GetXZ (Angle)
	return math.sin(Angle) * Radius, math.cos(Angle) * Radius
end

local Number = 50

for i = 1, Number do
	local Part = Instance.new("Part", script)
	Part.Anchored = true
	Part.CanCollide = false
	
	task.spawn(function()
		while task.wait() do
			local X, Z = GetXZ(i * (math.pi * 2 / Number) + tick() * Speed)
			local Position = owner.Character.HumanoidRootPart.Position + Vector3.new(X, math.sin((Speed + math.pi/4) * i-1 + tick()), Z)
			local Direction = (Position - owner.Character.HumanoidRootPart.Position).Unit
			Part.CFrame = CFrame.new(Position, Position + Direction)
			FlingTouching(Part)
		end
	end)
end]]
