local RNG = Random.new()
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserService = game:GetService("UserService")

local function MakeCharacter (ID)
	local Model = Players:CreateHumanoidModelFromUserId(ID)
	Model.Humanoid.DisplayName = UserService:GetUserInfosByUserIdsAsync({ID})[1].DisplayName
	local NewAnimateScript
	if Model.Humanoid.RigType == Enum.HumanoidRigType.R6 then
		NewAnimateScript = NS(HttpService:GetAsync("https://raw.githubusercontent.com/somoose/Roblox/refs/heads/master/Animate/R6.lua"), Model)
	else
		NewAnimateScript = NS(HttpService:GetAsync("https://raw.githubusercontent.com/somoose/Roblox/refs/heads/master/Animate/R15.lua"), Model)
	end
	for _, Animate in pairs(Model.Animate:GetChildren()) do
		Animate:Clone().Parent = NewAnimateScript
	end
	Model.Animate:Destroy()
	NewAnimateScript.Name = "Animate"
	return Model
end

local Character = MakeCharacter(Players:GetUserIdFromNameAsync("E7LK"))
Character:PivotTo(owner.Character:GetPivot() * CFrame.new(0, 2, 0))
Character.Parent = script

local function GetClosestForwardPosition (Model)
	local Params = RaycastParams.new()
	Params.FilterDescendantsInstances = {Model}
	local Result = workspace:Raycast(Model.HumanoidRootPart.Position, Model.HumanoidRootPart.CFrame.LookVector * 1e4, Params)
	if Result then
		return Result.Position
	end
end

local function GetRandomPlayer ()
	return Players:GetPlayers()[math.random(#Players:GetPlayers())]
end

local function InitRandomNPCMovement (Model)
	task.spawn(function()
		while true do
			local Position
			local RandomPlayer = GetRandomPlayer()

			if math.random() > 0.2 then
				Position = Model.HumanoidRootPart.Position:Lerp(RandomPlayer.Character.HumanoidRootPart.Position, math.random())
			else
				local t = RNG:NextNumber(0.2, 0.8)
				local Direction = RNG:NextUnitVector():Lerp(Model.HumanoidRootPart.CFrame.LookVector, t)
				local Distance = RNG:NextNumber(20, 30)
				Position = Model.HumanoidRootPart.Position + Direction * Distance
			end

			Model.Humanoid:MoveTo(Position)
			Model.Humanoid.MoveToFinished:Wait()
			if math.random() > 0.7 then
				task.wait(RNG:NextNumber(0.5, 2))
			end
		end
	end)
end

InitRandomNPCMovement(Character)
