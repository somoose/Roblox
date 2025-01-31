local Part = Instance.new("Part", script)
Part.CFrame = owner.Character.Head.CFrame
Part.Size = Vector3.new(25, 1, 25)
Part.Material = Enum.Material.WoodPlanks
Part.BrickColor = BrickColor.new("Earth orange")

local Attachment0 = Instance.new("Attachment", Part)

local AlignPosition = Instance.new("AlignPosition", Part)
AlignPosition.Attachment0 = Attachment0
AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
AlignPosition.ForceLimitMode = Enum.ForceLimitMode.PerAxis
AlignPosition.MaxAxesForce = Vector3.new(0, math.huge, 0)
AlignPosition.Position = Vector3.new(0, 5, 0)

local AlignOrientation = Instance.new("AlignOrientation", Part)
AlignOrientation.Attachment0 = Attachment0
AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
AlignOrientation.MaxTorque = math.huge
AlignOrientation.AlignType = Enum.AlignType.PrimaryAxisParallel
AlignOrientation.PrimaryAxis = Vector3.new(1, 0, 0)
local AlignOrientation2 = AlignOrientation:Clone()
AlignOrientation2.PrimaryAxis = Vector3.new(0, 0, 1)
AlignOrientation2.Parent = Part
