-- Make legs invisible.
for _, BasePart in pairs(owner.Character:GetDescendants()) do
	if not BasePart:IsA("BasePart") then continue end
	if BasePart.Name:find("UpperLeg") or BasePart.Name:find("LowerLeg") or BasePart.Name:find("Foot") then
		BasePart.Transparency = 1
	end
end

-- Create parts used to indicate the position of the feet.
local function IndicatorPart ()
	local Part = Instance.new("Part", owner.Character)
	Part:SetNetworkOwner(owner)
	Part.CanCollide = false
	Part.Size = Vector3.one * 0.25
	local Highlight = Instance.new("Highlight", Part)
	local Attachment = Instance.new("Attachment", Part)
	local AlignPosition = Instance.new("AlignPosition", Part)
	AlignPosition.Attachment0 = Attachment
	AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
	AlignPosition.RigidityEnabled = true
	AlignPosition.Responsiveness = math.huge
	AlignPosition.MaxForce = Vector3.one * math.huge
	return Part
end
NewPart().Name = "LEFTFOOT"
NewPart().Name = "RIGHTFOOT"

NLS([[

local Humanoid = owner.Character.Humanoid
local LeftHip = owner.Character:FindFirstChild("LeftHip", true)
local RightHip = owner.Character:FindFirstChild("RightHip", true)
local LEFTFOOT = owner.Character.LEFTFOOT.AlignPosition
local RIGHTFOOT = owner.Character.RIGHTFOOT.AlignPosition

local RaycastParams = RaycastParams.new()
RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
RaycastParams.FilterDescendantsInstances = {owner.Character}

-- Functions for getting the hip and feet positions.
local function GetWorldCFrame (Joint)
	return Joint.Part0.CFrame * Joint.C0
end
local function GetFloorPosition (Position, LegLength, OptionalDirection)
	local Result = workspace:Raycast(Position, Vector3.yAxis * -LegLength, RaycastParams)
	if Result then
		return Result.Position
	else
		return Position + (OptionalDirection or Vector3.yAxis) * -LegLength
	end
end

local function Lerp (a, b, t) return a + (b - a) * t end

local LastLeftPosition = Vector3.zero
local LastRightPosition = Vector3.zero

local function GetFeetPositions (HeightFrequency, HeightAmplitude, t)
	local LeftHipPosition = GetWorldCFrame(LeftHip).Position
	local RightHipPosition = GetWorldCFrame(RightHip).Position
	
	local LeftFootPosition = GetFloorPosition(LeftHipPosition, 2)
	local RightFootPosition = GetFloorPosition(RightHipPosition, 2)

	local LeftHeightOffset = 0
	local RightHeightOffset = 0
	
	local Direction = Humanoid.MoveDirection
	if Direction.Magnitude > 0 and Humanoid.FloorMaterial then
		LeftHeightOffset = math.clamp(math.abs(math.sin(t * HeightFrequency) * HeightAmplitude), 0, math.abs(LeftHipPosition.Y - LeftFootPosition.Y))
		RightHeightOffset = math.clamp(math.abs(math.cos(t * HeightFrequency) * HeightAmplitude), 0, math.abs(RightHipPosition.Y - RightFootPosition.Y))
	end

	LeftFootPosition = Vector3.new(LeftFootPosition.X, Lerp(LastLeftPosition.Y, LeftFootPosition.Y + LeftHeightOffset, 0.3), LeftFootPosition.Z)
	RightFootPosition = Vector3.new(RightFootPosition.X, Lerp(LastRightPosition.Y, RightFootPosition.Y + RightHeightOffset, 0.3), RightFootPosition.Z)

	LastLeftPosition = LeftFootPosition
	LastRightPosition = RightFootPosition
	
	return LeftFootPosition, RightFootPosition
end

local IsMoving = false
local t = 0

while task.wait() do
	if Humanoid.MoveDirection.Magnitude > 0 then IsMoving = true t = t + 0.01 else IsMoving = false t = 0 end

	local LeftFloor, RightFloor = GetFeetPositions(14, 1.5, t)

	LEFTFOOT.Position = LeftFloor
	RIGHTFOOT.Position = RightFloor
end

]])
