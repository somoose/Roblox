FORCE = 1.25

game.Players.E7LK.Chatted:Connect(function(Message)
	if Message:sub(1, 3):lower() == "set" then
		FORCE = tonumber(Message:sub(5, #Message))
	end
end)

function CreateBalloon (Target, Position, Offset, BalloonSize)
	BalloonSize = BalloonSize or 1

	local Balloon = Instance.new("Part", workspace)
	Balloon.BrickColor = BrickColor.random()
	Balloon.Transparency = 0.3
	Balloon.Reflectance = 0.4
	Balloon.Material = Enum.Material.Plastic
	Balloon.Size = Vector3.new(1, 1.15, 1) * BalloonSize
	Balloon.CanCollide = false
	Balloon.Position = Position
	
	Balloon.TopSurface = Enum.SurfaceType.Smooth
	Balloon.BottomSurface = Enum.SurfaceType.Smooth
	
	local Mesh = Instance.new("SpecialMesh", Balloon)
	Mesh.MeshType = Enum.MeshType.Sphere
	
	local Attachment0 = Instance.new("Attachment", Balloon)
	Attachment0.Position = Vector3.new(0, -(Balloon.Size.Y/2), 0)
	local Attachment1 = Instance.new("Attachment", Target)
	Attachment1.Position = Offset
	
	local RopeConstraint = Instance.new("RopeConstraint", Balloon)
	RopeConstraint.Length = 1.5 * BalloonSize
	RopeConstraint.Visible = true
	RopeConstraint.Attachment0 = Attachment0
	RopeConstraint.Attachment1 = Attachment1
	
	local BodyForce = Instance.new("BodyForce", Balloon)
	BodyForce.Force = Vector3.new(0, (Balloon:GetMass() * workspace.Gravity * FORCE), 0)
	
	return Balloon
end

local Tool = Instance.new("Tool", game.Players.E7LK.Backpack)
Tool.Name = "balloonifier"

local Handle = Instance.new("Part", Tool)
Handle.Name = "Handle"
Handle.Size = Vector3.one

local RemoteEvent = Instance.new("RemoteEvent", Tool)

RemoteEvent.OnServerEvent:Connect(function(lp, Position, Target, Offset)
	CreateBalloon(Target, Position, Offset, math.random(2, 4))
end)


NLS([[
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local Tool = script.Parent
local RemoteEvent = Tool:FindFirstChildOfClass("RemoteEvent")

Tool.Activated:Connect(function()
	RemoteEvent:FireServer(Mouse.Hit.Position, Mouse.Target, Mouse.Hit.Position - Mouse.Target.Position)
end)
]]).Parent = Tool
