local function Weld (Part0, Part1)
	local Weld = Instance.new("Weld")
	Weld.C0 = Part0.CFrame:Inverse() * Part1.CFrame
	Weld.Part0 = Part0
	Weld.Part1 = Part1
	Weld.Parent = Part0
	return Weld
end

local function NewPart (Parent)
	local Part = Instance.new("Part", Parent)
	Part.Material = Enum.Material.Wood
	Part.BrickColor = BrickColor.new("Earth orange")
	Part.CustomPhysicalProperties = PhysicalProperties.new(0.45, 0, 0.1)
	Part.Massless = true
	Part.Transparency = 0.5
	return Part
end

local function MakeChest (Width, Height, Depth, WallThickness, LidThickness)
	local Model = Instance.new("Model", script)
	
	local Base = NewPart(Model)
	Base.Size = Vector3.new(Width, WallThickness, Depth, LidThickness)
	local LeftWall = NewPart(Model)
	local RightWall = NewPart(Model)
	local BackWall = NewPart(Model)
	local FrontWall = NewPart(Model)
	LeftWall.Size = Vector3.new(WallThickness, Height, Depth)
	LeftWall.CFrame = Base.CFrame * CFrame.new(-Width/2 + WallThickness/2, Height/2 + WallThickness/2, 0)
	RightWall.Size = Vector3.new(WallThickness, Height, Depth)
	RightWall.CFrame = Base.CFrame * CFrame.new(Width/2 - WallThickness/2, Height/2 + WallThickness/2, 0)
	BackWall.Size = Vector3.new(Width, Height, WallThickness)
	BackWall.CFrame = Base.CFrame * CFrame.new(0, Height/2 + WallThickness/2, -Depth/2 + WallThickness/2)
	FrontWall.Size = Vector3.new(Width, Height, WallThickness)
	FrontWall.CFrame = Base.CFrame * CFrame.new(0, Height/2 + WallThickness/2, Depth/2 - WallThickness/2)
	Weld(Base, LeftWall)
	Weld(Base, RightWall)
	Weld(Base, BackWall)
	Weld(Base, FrontWall)

	Base.CFrame = owner.Character.Head.CFrame * CFrame.new(0, 0, -Depth)

	if LidThickness then
		local Lid = NewPart()
		Lid.Size = Vector3.new(Width, LidThickness, Depth)
		Lid.CFrame = Base.CFrame * CFrame.new(0, Height + WallThickness/2, 0)
		--Weld(Base, Lid)
		local Attachment0 = Instance.new("Attachment", Lid)
		Attachment0.Visible = true
		Attachment0.CFrame = CFrame.new(0, 0, Depth/2) * CFrame.Angles(0, math.pi, 0)
		local Attachment1 = Instance.new("Attachment", BackWall)
		Attachment1.Visible = true
		Attachment1.CFrame = CFrame.new(0, Height/2 + LidThickness/2, 0)
		local HingeConstraint = Instance.new("HingeConstraint", Attachment0.Parent)
		HingeConstraint.Visible = true
		HingeConstraint.Attachment0 = Attachment0
		HingeConstraint.Attachment1 = Attachment1
		task.wait()
		Lid.Parent = Model
	end

	return Base
end

--local Base = MakeChest(5, 4, 10, 0.5)
MakeChest(5, 5, 5, 0.5, 0.5)
