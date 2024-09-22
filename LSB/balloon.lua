local TweenService = game:GetService("TweenService")

local BALLOON = {}

BALLOON.Force = 1.2
BALLOON.Size = 3
BALLOON.DefaultSize = Vector3.new(1, 1.15, 1)
BALLOON.Transparency = 0.5
BALLOON.Reflectance = 0.3
BALLOON.RopeLength = 4
BALLOON.Color = function () return BrickColor.random() end
BALLOON.Material = Enum.Material.SmoothPlastic

BALLOON.CreateBalloon = function (Part, MouseCFrame)
	if not Part then return end
	if Part == workspace.Base then return end

	local BalloonSize = BALLOON.DefaultSize * BALLOON.Size
	
	local Balloon = Instance.new("Part", script)
	Balloon.Size = Vector3.zero
	Balloon.CFrame = MouseCFrame
	Balloon.CanCollide = true
	Balloon.CanQuery = false
	Balloon.Massless = true
	Balloon.BrickColor = BALLOON.Color()
	Balloon.Material = BALLOON.Material
	Balloon.Transparency = BALLOON.Transparency
	Balloon.Reflectance = BALLOON.Reflectance

	local BodyForce = Instance.new("BodyForce", Balloon)

	local function SetBodyForce ()
		local ScaleFactor = 0.9

		if Balloon.Size == BalloonSize then
			ScaleFactor = BALLOON.Force
		end
		
		BodyForce.Force = Vector3.new(0, Balloon.Mass * workspace.Gravity * ScaleFactor, 0)
	end

	SetBodyForce()

	Balloon:GetPropertyChangedSignal("Size"):Connect(SetBodyForce)

	local Mesh = Instance.new("SpecialMesh", Balloon)
	Mesh.MeshType = Enum.MeshType.Sphere

	local Constraint = BALLOON.Attach("RopeConstraint", Balloon, Part, CFrame.new(0, -BalloonSize.Y/2, 0), CFrame.new(Part.CFrame:PointToObjectSpace(MouseCFrame.Position)))
	Constraint.Attachment1.Visible = true

	local InflateTween = TweenService:Create(Balloon, TweenInfo.new(0.5), {Size = BalloonSize})
	InflateTween:Play()

	local InflationSound = Instance.new("Sound", Balloon)
	InflationSound.SoundId = "rbxassetid://134057288"
	InflationSound:Play()

	return Balloon
end

BALLOON.Attach = function (ConstraintType, Part0, Part1, C0, C1)
	local Attachment0 = Instance.new("Attachment", Part0)
	Attachment0.CFrame = C0
	
	local Attachment1 = Instance.new("Attachment", Part1)
	Attachment1.CFrame = C1
	
	local Constraint = Instance.new(ConstraintType, Part0)
	Constraint.Attachment0 = Attachment0
	Constraint.Attachment1 = Attachment1
	Constraint.Visible = true
	if ConstraintType == "RopeConstraint" then
		Constraint.Length = BALLOON.RopeLength
	end

	return Constraint
end

local Tool = Instance.new("Tool", owner.Backpack)
Tool.Name = "Balloon"

local Handle = Instance.new("Part", Tool)
Handle.Name = "Handle"
Handle.Size = Vector3.one
Handle.Transparency = 1

local HandleAttachment = Instance.new("Attachment", Handle)
HandleAttachment.Visible = true

local ClickRemoteEvent = Instance.new("RemoteEvent", Tool)
ClickRemoteEvent.Name = "ClickRemoteEvent"
ClickRemoteEvent.OnServerEvent:Connect(function(_, Part, MousePosition)
	BALLOON.CreateBalloon(Part, MousePosition)
end)

NLS([[
local Players = game:GetService("Players")

local Tool = script.Parent
local ClickRemoteEvent = Tool.ClickRemoteEvent

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

Tool.Activated:Connect(function()
	ClickRemoteEvent:FireServer(Mouse.Target, Mouse.Hit)
end)
]], Tool)
