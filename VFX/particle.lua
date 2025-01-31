local Main = Instance.new("Attachment", workspace.Baseplate)
Main.Position = Vector3.new(0, -2, 0)
Main.Name = "Main"

local Light = Instance.new("ParticleEmitter")
Light.Name = "Light"
Light.Lifetime = NumberRange.new(1, 1)
Light.LockedToPart = true
Light.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.4994731, 0.7357513), NumberSequenceKeypoint.new(1, 1)})
Light.LightEmission = 1
Light.Color = ColorSequence.new(Color3.fromRGB(255, 212, 57))
Light.Speed = NumberRange.new(0.001, 0.001)
Light.Brightness = 10
Light.Size = NumberSequence.new(4.5)
Light.Rate = 2
Light.Texture = "rbxassetid://1075864321"
Light.EmissionDirection = Enum.NormalId.Front
Light.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
Light.Rotation = NumberRange.new(-360, 360)
Light.Parent = Main

local Stars = Instance.new("ParticleEmitter")
Stars.Name = "Stars"
Stars.Lifetime = NumberRange.new(1, 1)
Stars.LockedToPart = false
Stars.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.4993773, 0), NumberSequenceKeypoint.new(1, 1)})
Stars.LightEmission = 2
Stars.Color = ColorSequence.new(Color3.fromRGB(255, 212, 57))
Stars.Speed = NumberRange.new(0.001, 0.001)
Stars.Brightness = 10
Stars.Size = NumberSequence.new(2)
Stars.Rate = 4
Stars.Texture = "rbxassetid://1851669703"
Stars.EmissionDirection = Enum.NormalId.Front
Stars.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
Stars.Rotation = NumberRange.new(-360, 360)
Stars.Parent = Main


