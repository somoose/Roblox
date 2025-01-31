local RNG = Random.new()
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local Chat = game:GetService("Chat")

local TargetPart = Instance.new("Part", script)
TargetPart.Anchored = true
TargetPart.CanCollide = false
TargetPart.Transparency = 0
TargetPart.Size = Vector3.one
TargetPart.Material = Enum.Material.SmoothPlastic
TargetPart.Color = Color3.fromRGB(255, 0, 0)
local Attachment1 = Instance.new("Attachment", TargetPart)
local function MoveTargetPart (Position)
	TweenService:Create(TargetPart, TweenInfo.new(0.5), {Position = Position}):Play()
end
local function GetRandomPlayer ()
	return Players:GetPlayers()[math.random(#Players:GetPlayers())]
end
function ClampVector (Vector, Minimum, Maximum)
	if Vector.Magnitude == 0 then return Vector3.zero end
	return Vector.Unit * math.clamp(Vector.Magnitude, Minimum, Maximum)
end

local BLOCK = {}
BLOCK.__index = BLOCK
BLOCK.Phrases = {
	"I WANT NUM NUMS",
	"IM HUNGRY",
	"GIVE ME FOOD",
	"I WANT FLESH",
	"HELP",
	"HELPPP ME!!",
	"IM SO HUNGRY",
	"SOMEONE PLEASE HELP",
	"OH MY GOD",
	"skibidi",
	"sigma",
	"rizz",
	"AAAAAAAAAAAAAA",
	"WHAT THE HECK"
}
function BLOCK:GetRandomPhrase ()
	return self.Phrases[math.random(#self.Phrases)]
end
local Spike = Instance.new("Part")
Spike.Material = Enum.Material.WoodPlanks
Spike.BrickColor = BrickColor.new("Earth orange")
Spike.Size = Vector3.new(0.5, 0.5, 5)
local Weld = Instance.new("Weld", Spike)
Weld.Part0 = Spike
function BLOCK.new (Parent)
	local Part = Instance.new("Part")
	Part.Material = Enum.Material.WoodPlanks
	Part.BrickColor = BrickColor.new("Earth orange")
	Part.Size = Vector3.one * 1
	Part.CustomPhysicalProperties = PhysicalProperties.new(0, 50, 0)
	Part.Parent = Parent

	local Attachment0 = Instance.new("Attachment", Part)
	local Beam = Instance.new("Beam", Part)
	Beam.Width0 = 0.5
	Beam.Width1 = 0.5
	Beam.TextureMode = Enum.TextureMode.Wrap
	Beam.Texture = "http://www.roblox.com/asset/?id=277037193"
	Beam.FaceCamera = true
	Beam.Attachment0, Beam.Attachment1 = Attachment0, Attachment1

	local SpikeForward = Spike:Clone()
	SpikeForward.Weld.Part1 = Part
	SpikeForward.Parent = Part
	local SpikeLeft = Spike:Clone()
	SpikeLeft.Weld.Part1 = Part
	SpikeLeft.Weld.C0 *= CFrame.Angles(0, math.pi/2, 0)
	SpikeLeft.Parent = Part
	local SpikeUp = Spike:Clone()
	SpikeUp.Weld.Part1 = Part
	SpikeUp.Weld.C0 *= CFrame.Angles(math.pi/2, 0, 0)
	SpikeUp.Parent = Part
	
	local OBJ = setmetatable({}, BLOCK)
	OBJ.Part = Part

	return OBJ
end
function BLOCK:MoveToFinishedWait ()
	repeat task.wait()
	until self.MoveToFinished
	self.MoveToFinished = false
end
BLOCK.MoveToFinished = false
function BLOCK:MoveTo (Position)
	local Part = self.Part
	task.spawn(function()
		while (Position - Part.Position).Magnitude > Part.Size.Magnitude do
			-- Update target position to be on the same height as Part.
			Position = Position + Vector3.new(0, Part.Position.Y - Position.Y, 0)
			local Direction = (Position - Part.Position).Unit
			Part.AssemblyAngularVelocity = Direction:Cross(Vector3.yAxis * -1) * 6
			task.wait()
		end
		self.MoveToFinished = true
	end)
end
function BLOCK:Chat (Message)
	local Part = self.Part
	Chat:Chat(Part, Message)
end
function BLOCK:EnableNPCMovement ()
	local Part = self.Part
	task.spawn(function()
		while true do
			if Paused then task.wait() continue end
			local Offset
			local Position
			if math.random() > 0.5 then -- Move towards random player. (if one is available)
				local Player = GetRandomPlayer()
				if Player and Player.Character then
					local PlayerPart = Player.Character:FindFirstChildWhichIsA("BasePart")
					if PlayerPart then
						Offset = Part.Position:Lerp(PlayerPart.Position, math.random()) - Part.Position -- Move random amount towards player.
					else
						Offset = RNG:NextUnitVector() * RNG:NextNumber(5, 15) -- Fail safe for zero parts.
					end
				else
					Offset = RNG:NextUnitVector() * RNG:NextNumber(5, 15) -- Fail safe for zero players.
				end
			else -- Move to random location.
				local Direction = Part.CFrame.LookVector:Lerp(RNG:NextUnitVector(), RNG:NextNumber(0.2, 0.8)) -- Don't stray too far from the parts current direction.
				local Distance = RNG:NextNumber(10, 30)
				Offset = Direction * Distance
			end
			Position = Part.Position + ClampVector(Offset, 0, 50)
			Position = Position + Vector3.new(0, -Position.Y, 0)
			MoveTargetPart(Position)

			self:MoveTo(Position)
			self:MoveToFinishedWait()

			if math.random() > 0.8 then -- Random delay between movements for realism.
				task.wait(RNG:NextNumber(0.1, 2))
			end
		end
	end)
end
function BLOCK:EnableNPCChat ()
	local Part = self.Part
	task.spawn(function()
		while true do
			if math.random() > 0.9 then
				self:Chat(self:GetRandomPhrase())
			end
			task.wait(RNG:NextNumber(0.1, 0.6))
		end
	end)
end

task.spawn(function()
local b = BLOCK.new(script)
b.Part.CFrame = owner.Character.Head.CFrame
b:Chat("3")
task.wait(1)
b:Chat("2")
task.wait(1)
b:Chat("1")
task.wait(1)
b:Chat("REEEEEEEEEEEEEEEEEEE")
b:EnableNPCMovement()
b:EnableNPCChat()
end)

