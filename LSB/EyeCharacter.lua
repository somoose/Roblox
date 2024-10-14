local function NewArm (NumberOfSegments, SegmentLength)
	local Arm = {}
	local Model = Instance.new("Model", script)
	local Humanoid = Instance.new("Humanoid", Model)
	Humanoid.DisplayName = owner.DisplayName
	local PreviousPart
	for i = 1, NumberOfSegments do
		local Thickness = i/NumberOfSegments/0.5
		local Segment = Instance.new("Part", Model)
		Segment.Name = i
		Segment:SetNetworkOwner(owner)
		Segment.Anchored = false
		Segment.CanCollide = true
		Segment.Size = Vector3.new(Thickness, Thickness, SegmentLength)
		if i == NumberOfSegments then
			Segment.Name = "HumanoidRootPart"

			local SpecialMesh = Instance.new("SpecialMesh", Segment)
			SpecialMesh.MeshId = "http://www.roblox.com/asset/?id=1185246"
			SpecialMesh.TextureId = "http://www.roblox.com/asset/?id=5013397"
			SpecialMesh.Scale = Vector3.one * 6
			--SpecialMesh.Offset = Vector3.new(0, 0, SpecialMesh.Scale.Z/2)
		else
			
			Segment.Color = Color3.fromRGB(200, 0, 0)
		end
		Segment.Material = Enum.Material.Metal
		Arm[i] = Segment
		
		local Attachment0 = Instance.new("Attachment", Segment)
		local AlignPosition = Instance.new("AlignPosition", Segment)
		AlignPosition.Attachment0 = Attachment0
		AlignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
		AlignPosition.Responsiveness = 100
		AlignPosition.RigidityEnabled = true
		local AlignOrientation = Instance.new("AlignOrientation", Segment)
		AlignOrientation.Attachment0 = Attachment0
		AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
		AlignOrientation.Responsiveness = 100
		AlignOrientation.RigidityEnabled = true

		if PreviousPart then
			local NoCollisionConstraint = Instance.new("NoCollisionConstraint", Segment)
			NoCollisionConstraint.Part0 = Segment
			NoCollisionConstraint.Part1 = PreviousPart
		end

		PreviousPart = Segment
	end
	return Arm, Model
end

local Arm, Model = NewArm(50, 0.5)
owner.Character = Model

local GetArm = Instance.new("RemoteFunction", Model)
GetArm.Name = "GetArm"
GetArm.OnServerInvoke = function ()
	return Arm
end

NLS([[
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local W = false
local A = false
local S = false
local D = false

UIS.InputBegan:Connect(function(Input, GPE)
	if GPE then return end
	if Input.KeyCode == Enum.KeyCode.W then
		W = true
	elseif Input.KeyCode == Enum.KeyCode.A then
		A = true
	elseif Input.KeyCode == Enum.KeyCode.S then
		S = true
	elseif Input.KeyCode == Enum.KeyCode.D then
		D = true
	end
end)
UIS.InputEnded:Connect(function(Input, GPE)
	if GPE then return end
	if Input.KeyCode == Enum.KeyCode.W then
		W = false
	elseif Input.KeyCode == Enum.KeyCode.A then
		A = false
	elseif Input.KeyCode == Enum.KeyCode.S then
		S = false
	elseif Input.KeyCode == Enum.KeyCode.D then
		D = false
	end
end)

local Camera = workspace.CurrentCamera
local Player = game.Players.LocalPlayer
local Character = Player.Character
local Camera = workspace.CurrentCamera
Camera.CameraSubject = Character.HumanoidRootPart
local Arm = Character.GetArm:InvokeServer()

local CFrames = {}
for i = 1, #Arm do
	CFrames[i] = CFrame.new()
end
local function GetEnd (Index, End)
	return (CFrames[Index] * CFrame.new(0, 0, Arm[Index].Size.Z/2 * End)).Position
end
local function MoveSegment (Index, Position)
	CFrames[Index] = CFrame.new(GetEnd(Index, 1), Position)
	CFrames[Index] = CFrames[Index] * CFrame.new(0, 0, -(GetEnd(Index, -1) - Position).Magnitude)
end
local function MoveArm (Position)
	MoveSegment(#Arm, Position)
	for i = #Arm - 1, 1, -1 do
		MoveSegment(i, GetEnd(i+1, 1))
	end
end
local function UpdateArm ()
	for i = 1, #Arm do
		local Segment = Arm[i]
		local NextCFrame = CFrames[i]

		Segment.CFrame = NextCFrame
		Segment.AlignPosition.Position = NextCFrame.Position
		Segment.AlignOrientation.CFrame = NextCFrame
	end
end
local function GetCurrentPosition ()
	return GetEnd(#Arm, -1)
end

MoveArm(Vector3.new(0, 10, 0))

RunService.PostSimulation:Connect(function()
	local CurrentPosition = GetCurrentPosition()
	local Direction = Vector3.zero
	if W then
		Direction = Direction + Camera.CFrame.LookVector
	end
	if A then
		Direction = Direction - Camera.CFrame.RightVector
	end
	if S then
		Direction = Direction - Camera.CFrame.LookVector
	end
	if D then
		Direction = Direction + Camera.CFrame.RightVector
	end
	Direction = (Direction.Magnitude > 0 and Direction.Unit or Direction)
	MoveArm(CurrentPosition + Direction * (Character.Humanoid.WalkSpeed * (0.4 / 16)))
	UpdateArm()
end)
]])
