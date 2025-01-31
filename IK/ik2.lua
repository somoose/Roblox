-- Make legs invisible.
for _, BasePart in pairs(owner.Character:GetDescendants()) do
	if not BasePart:IsA("BasePart") then continue end
	if BasePart.Name:find("UpperLeg") or BasePart.Name:find("LowerLeg") or BasePart.Name:find("Foot") then
		BasePart.Transparency = 0
	end
end

-- Create parts used to indicate the position of the feet.
local function IndicatorPart (Name)
	local Part = Instance.new("Part", owner.Character)
	Part.Name = Name
	Part:SetNetworkOwner(owner)
	Part.CanCollide = false
	Part.Size = Vector3.one * 0.5
	Part.Transparency = 1
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
local LEFTFOOT = IndicatorPart("LEFTFOOT")
local RIGHTFOOT = IndicatorPart("RIGHTFOOT")
IndicatorPart("ROOT")

local Humanoid = owner.Character.Humanoid
local LeftIKControl = Instance.new("IKControl", Humanoid)
LeftIKControl.ChainRoot = owner.Character.LeftUpperLeg
LeftIKControl.EndEffector = owner.Character.LeftFoot
LeftIKControl.Target = LEFTFOOT
local RightIKControl = Instance.new("IKControl", Humanoid)
RightIKControl.ChainRoot = owner.Character.RightUpperLeg
RightIKControl.EndEffector = owner.Character.RightFoot
RightIKControl.Target = RIGHTFOOT

NLS([[

local RunService = game:GetService("RunService")

local Humanoid = owner.Character.Humanoid
local LeftHip = owner.Character:FindFirstChild("LeftHip", true)
local RightHip = owner.Character:FindFirstChild("RightHip", true)
local Root = owner.Character:FindFirstChild("Root", true)
local LEFTFOOT = owner.Character.LEFTFOOT.AlignPosition
local RIGHTFOOT = owner.Character.RIGHTFOOT.AlignPosition
local ROOT = owner.Character.ROOT.AlignPosition

local RaycastParams = RaycastParams.new()
RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
RaycastParams.FilterDescendantsInstances = {owner.Character}

local function GetWorldCFrame (Joint)
	return Joint.Part0.CFrame * Joint.C0
end
local function GetStepDirection ()
	return -Vector3.yAxis:Lerp(-Humanoid.MoveDirection, 0.55)
end
local function Cast (Joint, Direction)
	local Origin = GetWorldCFrame(Joint).Position
	local Result = workspace:Raycast(Origin, Direction, RaycastParams)
	if Result then
		return Result.Position
	end
end
local Feet = {
	Left = Cast(LeftHip, -Vector3.yAxis * 1e5),
	Right = Cast(RightHip, -Vector3.yAxis * 1e5)
}
local function IsOffBalance ()
	local CentreOfBalance = owner.Character.HumanoidRootPart.Position * Vector3.new(1, 0, 1)
	local CentreOfFeet = (Feet.Left + Feet.Right)/2 * Vector3.new(1, 0, 1)
	local Difference = CentreOfBalance - CentreOfFeet
	if Difference.Magnitude > 0 then
		return true
	end
end
local function GetFurthestFoot ()
	local Position = ROOT.Position
	local FurthestFoot = nil
	local MaxDistance = -1
	for Foot, FootPosition in pairs(Feet) do
		local Distance = (FootPosition - Position).Magnitude
		if Distance > MaxDistance then
			MaxDistance = Distance
			FurthestFoot = Foot
		end
	end
	return FurthestFoot
end
local function UpdateFeet ()
	if IsOffBalance() then
		local FurthestFoot = GetFurthestFoot()
		local Hip = (FurthestFoot == "Left" and LeftHip or RightHip)
		local StepPosition = Cast(Root, GetStepDirection() * 1e5)
		if StepPosition then
			Feet[FurthestFoot] = StepPosition
		end
	end
end
local function UpdateIndicators ()
	UpdateFeet()
	if Feet.Left then
		LEFTFOOT.Position = Feet.Left
	end
	if Feet.Right then
		RIGHTFOOT.Position = Feet.Right
	end
	ROOT.Position = owner.Character.HumanoidRootPart.Position
end

RunService.PostSimulation:Connect(UpdateIndicators)
]])
