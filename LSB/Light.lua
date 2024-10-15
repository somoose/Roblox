local Part = Instance.new("Part", script)
Part.BottomSurface = Enum.SurfaceType.Smooth
Part.Transparency = -1
Part.TopSurface = Enum.SurfaceType.Smooth
Part.Color = Color3.fromRGB(253, 255, 126)
Part.Material = Enum.Material.ForceField
Part.Size = Vector3.new(0.5451899170875549, 0.5451899170875549, 0.5451899170875549) / 2
Part.CFrame = CFrame.new(-218, 3.5000040531158447, -641.7726440429688)
Part.CastShadow = false
Part.CanCollide = false
Part.Shape = Enum.PartType.Ball

local Main = Instance.new("Attachment")
Main.Name = "Main"
Main.Parent = Part

local Light = Instance.new("ParticleEmitter")
Light.Name = "Light"
Light.LightInfluence = 0
Light.Lifetime = NumberRange.new(1, 1)
Light.LockedToPart = true
Light.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.4994731, 0.7357513), NumberSequenceKeypoint.new(1, 1)})
Light.LightEmission = 3
Light.Color = ColorSequence.new(Color3.fromRGB(255, 212, 57))
Light.Speed = NumberRange.new(0.001, 0.001)
Light.Brightness = 5
Light.Size = NumberSequence.new(2)
Light.Rate = 4
Light.Texture = "rbxassetid://1075864321"
Light.EmissionDirection = Enum.NormalId.Front
Light.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
Light.Rotation = NumberRange.new(-360, 360)
Light.Parent = Main

local Stars = Instance.new("ParticleEmitter")
Stars.Name = "Stars"
Stars.Lifetime = NumberRange.new(1, 1)
Stars.LockedToPart = true
Stars.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.4993773, 0), NumberSequenceKeypoint.new(1, 1)})
Stars.LightEmission = 2
Stars.Color = ColorSequence.new(Color3.fromRGB(255, 212, 57))
Stars.Speed = NumberRange.new(0.001, 0.001)
Stars.Brightness = 10
Stars.Size = NumberSequence.new(1)
Stars.Rate = 5
Stars.Texture = "rbxassetid://1851669703"
Stars.EmissionDirection = Enum.NormalId.Front
Stars.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
Stars.Rotation = NumberRange.new(-360, 360)
Stars.Drag = 10
Stars.Parent = Main

local PointLight = Instance.new("PointLight", Main)
PointLight.Color = Color3.fromRGB(255, 212, 57)
PointLight.Range = 12
PointLight.Brightness = 0.5

local Offset = Vector3.new(3, 2.5, 0)
local function GetPosition ()
	return (owner.Character.HumanoidRootPart.CFrame * CFrame.new(Offset)).Position
end
Part.Position = GetPosition()

local AlignPosition = Instance.new("AlignPosition", Part)
AlignPosition.Attachment0, AlignPosition.Attachment1 = Main
AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
AlignPosition.MaxForce = 600

while task.wait() do
	if owner.Character:FindFirstChild("HumanoidRootPart") then
		local CurrentPosition = Part.Position
		local NextPosition = GetPosition()
		local Distance = (NextPosition - CurrentPosition).Magnitude
		AlignPosition.MaxForce = math.clamp((Distance <= 0 and 1 or Distance) * 100, 100, math.huge)
		AlignPosition.Position = NextPosition
		if Distance > 50 then
			Part.Position = Part.Position:Lerp(NextPosition, 0.1)
		end
	end
end
