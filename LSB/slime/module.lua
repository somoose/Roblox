local TweenService = game:GetService("TweenService")

local SlimeModule = {}
SlimeModule.Colors = {
	BrickColor.new("Forest green"),
	BrickColor.new("Deep blue"),
	BrickColor.new("Carnation pink"),
	BrickColor.new("Really red"),
	BrickColor.new("Bright purple"),
	BrickColor.new("Cool yellow"),
}
SlimeModule.ApplyAppearance = function (Slime, Scale)
	local Head = Slime.Head
	
	Head.Size = type(Scale) == "number" and Vector3.one * Scale or Scale
	Head.Material = Enum.Material.SmoothPlastic
	Head.BrickColor = SlimeModule.Colors[math.random(#SlimeModule.Colors)]
	Head.Transparency = 0.5
	
	local Face = Instance.new("Decal", Head)
	Face.Transparency = 0.8
	Face.Texture = "rbxassetid://296233945"
end
SlimeModule.new = function (Parent)
	local Model = Instance.new("Model")
	Model.Name = "Slime"
	
	local Humanoid = Instance.new("Humanoid", Model)
	Humanoid.DisplayName = "Slime"
	
	local Head = Instance.new("Part", Model)
	Head.Name = "Head"
	Head.CustomPhysicalProperties = PhysicalProperties.new(Head.AssemblyMass, 5, 0, 5, 4)
	
	local SlimeJumpSound = Instance.new("Sound", Head)
	SlimeJumpSound.Name = "SlimeJumpSound"
	SlimeJumpSound.SoundId = "rbxassetid://836796971"
	SlimeJumpSound.Volume = 2

	local Attachment = Instance.new("Attachment", Head)

	local AlignOrientation = Instance.new("AlignOrientation", Head)
	AlignOrientation.Attachment0 = Attachment
	AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
	AlignOrientation.RigidityEnabled = true
	AlignOrientation.Responsiveness = math.huge
	AlignOrientation.MaxTorque = math.huge
	AlignOrientation.MaxAngularVelocity = math.huge
	
	Model.Parent = Parent
	
	return Model
end
SlimeModule.ClampVector = function (Vector, Max)
	if Vector.Magnitude == 0 then return Vector3.zero end
	return Vector.Unit * math.min(Vector.Magnitude, Max)
end
SlimeModule.MoveTo = function (Slime, Position)
	local Head = Slime.Head
	local AlignOrientation = Head.AlignOrientation
	local SlimeJumpSound = Head.SlimeJumpSound
	
	local CompressTime = 0.3
	local Info = TweenInfo.new(CompressTime, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
	
	local DefaultSize = Head.Size
	local Squish = DefaultSize.Y
	
	local Difference = Position - Head.Position
	Difference = Vector3.new(Difference.X, 0, Difference.Z)
	
	AlignOrientation.CFrame = CFrame.new(Position, Position + Difference)
	
	local Range = DefaultSize.Magnitude * 15
	
	local MovementVelocity = SlimeModule.ClampVector(Difference * 2, Range)
	local JumpVelocity = Vector3.new(0, Range, 0)
	
	TweenService:Create(Head, Info, {
		Size = DefaultSize - Vector3.new(-Squish/3, Squish/1.25, -Squish/3)
	}):Play()
	
	task.wait(Info.Time * 1.5)
	
	Head.AssemblyLinearVelocity = Head.AssemblyLinearVelocity + JumpVelocity
	
	SlimeJumpSound:Play()
	
	TweenService:Create(Head, Info, {
		Size = DefaultSize + Vector3.new(-Squish/2, Squish * 2.5, -Squish/2)
	}):Play()
	
	task.wait(Info.Time/2)
	
	Head.AssemblyLinearVelocity = Head.AssemblyLinearVelocity + MovementVelocity
	
	task.wait(Info.Time/2)
	
	TweenService:Create(Head, Info, {
		Size = DefaultSize
	}):Play()
	
	task.wait(Info.Time)
end

return SlimeModule
