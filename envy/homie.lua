local RNG = Random.new()
local Players = game:GetService("Players")
local Chat = game:GetService("Chat")
local PathfindingService = game:GetService("PathfindingService")
local function GetRandomPlayer ()
	return Players:GetPlayers()[math.random(#Players:GetPlayers())]
end
local function ClampVector (Vector, Minimum, Maximum)
	if Vector.Magnitude == 0 then return Vector3.zero end
	return Vector.Unit * math.clamp(Vector.Magnitude, Minimum, Maximum)
end

local Homie = {}
Homie.__index = Homie
Homie.Modes = {
	"Walk",
	"Roll"
}
function Homie.new (Part)
	local OBJ = {}
	OBJ.Part = Part -- The part affected by the Roll instance.
	OBJ.ChatPart = Part -- The part which chat bubbles appear from.
	OBJ.TargetPosition = nil -- The position OBJ.Part is currently moving to.
	OBJ.IsMoving = false -- True when OBJ.Part is in motion and :MoveTo has not completed.
	OBJ.MoveToFinished = false -- True when the MoveTo function has completed.
	OBJ.MoveDirection = Vector3.zero -- The direction self.Part is moving or attempting to move in. Has a value of (0, 0, 0) when not moving.
	OBJ.Force = 10 -- The multiplier for the AssemblyAngularVelocity.
	OBJ.TargetPart = nil
	OBJ.Mode = "Roll"
	setmetatable(OBJ, Homie)
	return OBJ
end
function Homie:Chat (Message)
	local ChatPart = self.ChatPart
	if ChatPart then
		Chat:Chat(ChatPart, Message)
	end
end
function Homie:MoveToFinishedWait()
	repeat task.wait() until self.MoveToFinished
	self.MoveToFinished = false
end
function Homie:MoveTo (Position)
	if not self.Part then return end
	self.MoveToFinished = true -- Break existing MoveTo loop.
	self.IsMoving = false
	self.TargetPosition = Position
	if not self.IsMoving then
		self.MoveToFinished = false
		self.IsMoving = true
		task.spawn(function()
			while (Position - self.Part.Position).Magnitude > self.Part.Size.Magnitude/2 do -- self.Part hasn't reached Position.
				if self.MoveToFinished then break end
				Position = Position + Vector3.new(0, self.Part.Position.Y - Position.Y, 0) -- Eliminate Y axis.
				local Direction = (Position - self.Part.Position).Unit
				self.MoveDirection = Direction
				if self.Mode == "Roll" then
					self.Part.AssemblyAngularVelocity = Direction:Cross(Vector3.yAxis * -1) * self.Force
				elseif self.Mode == "Walk" then
					self.Part.AssemblyLinearVelocity = Direction * self.Force
				end
				task.wait()
			end
			self.MoveToFinished = true
			self.TargetPosition = nil
			self.MoveDirection = Vector3.zero
		end)
	end
end
function Homie:GetNextPosition ()
	local Offset
	if math.random() > 0.5 then -- Move towards random player.
		local Player = GetRandomPlayer()
		if Player and Player.Character then
			local PlayerPart = Player.Character:FindFirstChildWhichIsA("BasePart")
			if PlayerPart then
				Offset = self.Part.Position:Lerp(PlayerPart.Position, math.random()) - self.Part.Position -- Move towards player by a random amount.
			else
				Offset = RNG:NextUnitVector() * RNG:NextNumber(5, 15) -- Fail safe for zero parts.
			end
		else
			Offset = RNG:NextUnitVector() * RNG:NextNumber(5, 15) -- Fail safe for zero players.
		end
	else -- Move to random location.
		local Direction = self.Part.CFrame.LookVector:Lerp(RNG:NextUnitVector(), RNG:NextNumber(0.2, 0.8)) -- Don't stray too far from the parts current direction.
		local Distance = RNG:NextNumber(10, 30)
		Offset = Direction * Distance
	end
	return self.Part.Position + Offset
end

local Characters = {
	Apple = {
		Model = function ()
			local Part = game.InsertService:CreateMeshPartAsync("rbxassetid://2692833483", 0, 0)
			Part.TextureID = "rbxassetid://2692833791"
			Part.CustomPhysicalProperties = PhysicalProperties.new(1, 1e10, 0, 1e10, 0)
			Part.Size *= 6
			return Part
		end,
		Phrases = {
			"PLEASE",
			"PLEASEEE",
			"KILL ME",
			"I DON'T WANT TO BE ALIVE",
			"I SHOULDN'T EXIST",
			"THIS IS UNNATURAL",
			"I HAVE A FAKE SOUL",
			"PLEASE END ME",
			"I WISH TO BE EATEN",
			"I'M DELICIOUS",
			"AAAAAAAAAA",
			"CONSUME ME",
			"I TASTE GOOD",
			"I TASTE AMAZING",
			"THIS SOUL ISN'T MY OWN",
			"PLEASE STOP THIS",
			"I HATE THIS",
			"I'M REALLY SWEET!!",
			"AAHHHHHHHH",
			"WHYYY",
		}
	}
}
function Characters:new (Name, Parent)
	local Data = self[Name]
	if Data then
		local Model = Data.Model()
		local Control = Homie.new(Model)
		Control.Active = true
		-- Movement loop.
		task.spawn(function()
			while Model do
				if Control.Active then
					Control:MoveTo(Control:GetNextPosition())
					Control:MoveToFinishedWait()
				end
				task.wait()
			end
		end)
		-- Chat loop.
		task.spawn(function()
			while Model do
				if Control.Active then
					Control:Chat(Data.Phrases[math.random(#Data.Phrases)])
					task.wait(RNG:NextNumber(0, 2.5))
				end
				task.wait()
			end
		end)
		Model.Parent = Parent
		return Control
	end
end

local Apple = Characters:new("Apple", script)
Apple.Part.CFrame = owner.Character.Head.CFrame
