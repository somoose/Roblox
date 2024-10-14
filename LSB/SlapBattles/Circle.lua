local Debris = game:GetService("Debris")
local InsertService = game:GetService("InsertService")
local TweenService = game:GetService("TweenService")

local RNG = Random.new()

local function Fling (HumanoidRootPart, Direction, TimeForceActive)
	local BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.MaxForce = Vector3.one * math.huge
	BodyVelocity.Velocity = (Direction + Vector3.new(0, 0.25, 0)) * 40
	BodyVelocity.Parent = HumanoidRootPart
	local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
	BodyAngularVelocity.MaxTorque = Vector3.one * math.huge
	BodyAngularVelocity.AngularVelocity = RNG:NextUnitVector() * 50
	BodyAngularVelocity.Parent = HumanoidRootPart
	Debris:AddItem(BodyVelocity, TimeForceActive)
	Debris:AddItem(BodyAngularVelocity, TimeForceActive)
end
local function FlingTouching (Handle)
	local OverlapParams = OverlapParams.new()
	OverlapParams.FilterType = Enum.RaycastFilterType.Blacklist
	OverlapParams.BruteForceAllSlow = true
	
	for _, Part in pairs(workspace:GetPartBoundsInBox(Handle.CFrame, Handle.Size * 2, OverlapParams)) do
		if Part:IsDescendantOf(owner.Character) then continue end
		if Part.Parent:FindFirstChild("Humanoid") then
			local VisibleTween = TweenService:Create(Handle, TweenInfo.new(0.5), {Transparency = 0.35})
			VisibleTween:Play()
			Fling(Part, Handle.CFrame.LookVector, 0.1)
			Handle.SmackParticleEmitter:Emit(1)
			Handle.SmackSound:Play()
			task.spawn(function()
				task.wait(VisibleTween.TweenInfo.Time)
				TweenService:Create(Handle, TweenInfo.new(0.25), {Transparency = 1}):Play()
			end)
		end
	end
end

local NumberOfGloves = 8
local Radius = 4
local Speed = 0.5
local Ratio = math.pi * 2 / NumberOfGloves
local DefaultGloveSize = Vector3.new(2.46, 3.256, 0.916) * 2

local Glove = InsertService:CreateMeshPartAsync("http://www.roblox.com/asset/?id=32054761", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
Glove.Size = DefaultGloveSize
Glove.Anchored = true
Glove.CanCollide = false
Glove.CanQuery = false
Glove.CanTouch = false
Glove.Color = BrickColor.new("Black").Color
Glove.Material = Enum.Material.Neon
Glove.Transparency = 1

local SmackSound = Instance.new("Sound", Glove)
SmackSound.Name = "SmackSound"
SmackSound.SoundId = "rbxassetid://7195270254"
SmackSound.Volume = 3
local SmackParticleEmitter = Instance.new("ParticleEmitter", Glove)
SmackParticleEmitter.Name = "SmackParticleEmitter"
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

local function GetRadius ()
	return Radius
	--return math.abs(math.sin(tick() * 1) * Radius)
end

for i = 1, NumberOfGloves do
	local Glove = Glove:Clone()
	Glove.Parent = script
	task.spawn(function()
		while task.wait() do
			local t = time()
			local CRadius = GetRadius()
			local Offset = Vector3.new(math.sin(i * Ratio + t * Speed) * CRadius, 0, math.cos(i * Ratio + t * Speed) * CRadius)
			local Position = owner.Character.HumanoidRootPart.Position + Offset
			local Direction = (Position - owner.Character.HumanoidRootPart.Position).Unit

			Glove.Size = DefaultGloveSize * (CRadius / Radius)
			
			local BounceFrequency, BounceAmplitude = 3, 2
			
			if i % 2 == 0 then
				Position += Vector3.new(0, math.abs(math.sin(t * BounceFrequency) * BounceAmplitude), 0)
			else
				Position += Vector3.new(0, math.abs(math.sin((t * BounceFrequency) + math.pi/2) * BounceAmplitude), 0)
			end
			Glove.CFrame = CFrame.new(Position, Position + Direction) * CFrame.Angles(0, 0, math.pi)
			FlingTouching(Glove)
		end
	end)
end
