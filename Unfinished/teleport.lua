-- Make teleport to the player that the tool user is most facing towards.

local TeleportSound = Instance.new("Sound", owner.Character)
TeleportSound.SoundId = "rbxassetid://4562690876"
TeleportSound.Volume = 3
TeleportSound.PlaybackSpeed = 3

local Target

local RNG = Random.new()
local Radius = 7

local function Teleport (Character, Position, Direction, Distance)
	TeleportSound:Pause()
	TeleportSound:Play()
	Character:PivotTo(CFrame.new(Position + Direction * Distance, Position))
end

local function GetRandomDirection ()
	return RNG:NextUnitVector().Unit * Vector3.new(1, 0, 1)
end

local function GetRandomPlayer ()
	local Players = game.Players:GetPlayers()
	table.remove(Players, table.find(Players, owner))
	return Players[math.random(#Players)]
end

local Tool = Instance.new("Tool", owner.Backpack)
Tool.RequiresHandle = false

local Activated = false

Tool.Activated:Connect(function()
	Activated = true
	repeat
		Target = GetRandomPlayer().Character
		Teleport(owner.Character, Target.HumanoidRootPart.Position, GetRandomDirection(), Radius)
		task.wait(0.1)
	until not Activated
end)

Tool.Deactivated:Connect(function()
	Activated = false
end)

Tool.Unequipped:Connect(function()
	Activated = false
end)
