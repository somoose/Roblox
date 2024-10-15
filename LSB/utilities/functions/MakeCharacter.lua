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

return MakeCharacter 
