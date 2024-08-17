-- 	Midas Touch -- Click on models and parts to turn them into gold coins.
-- The amount of gold coins generated is relative to the parts mass.

-- Press and hold the left control key to enable clicking.
-- Press and hold the left alt key to ignore parents.

print("Press and hold the left control key to enable clicking.")
print("Press and hold the left alt key to ignore parents.")

local args = {...} -- lsb r/ args
local CoinScale = tonumber((args[1] == nil or "") and 1 or args[1]) -- The size of the coins. 1 by default.
local Time = tonumber((args[2] == nil or "") and 1 or args[2]) -- The amount of time it takes for tweens to finish. 1 by default.
local ClearAutomatically = not (args[3] == "false") -- Coins disappear shortly after being generated. True by default.

print("") -- newline in output
print("Coin Scale: " .. CoinScale)
print("Tween Time: " .. Time)
print("Clear Automatically: " .. tostring(ClearAutomatically))

local Coins = {} -- List of all coins.

local Prefix = "midas"
local Commands = {
	{
		Code = "clear",
		Description = "Destroys all coins.",
		Function = function ()
			for _, Coin in pairs(Coins) do
				Coin:Destroy()
			end
		end
	},
	{
		Code = "bring",
		Description = "Brings all coins to the character.",
		Function = function ()
			for i, Coin in pairs(Coins) do
				Coin.CFrame = owner.Character.HumanoidRootPart.CFrame * CFrame.new(0, i * Coin.Size.X/2, -2) * CFrame.Angles(0, 0, math.rad(90))
			end
		end
	}
}

print("") -- newline in output
print("Commands: ( Prefix: '" .. Prefix .. "/' )")
print(Commands)

owner.Chatted:Connect(function(Message)
	local Sections = Message:split("/")
	
	if Sections[1]:lower() == Prefix then
		for _, Command in pairs(Commands) do
			if Sections[2]:lower() == Command.Code then
				Command.Function()
			end
		end
	end
end)

local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")

function HasProperty (Instance, Property) local s = pcall(function() return Instance[Property] end) return s end

local RNG = Random.new()

function MakeIntoCoin (BasePart)
	CollectionService:AddTag(BasePart, "COIN")
	
	BasePart.Material = Enum.Material.Metal
	if HasProperty(BasePart, "Shape") then BasePart.Shape = Enum.PartType.Cylinder end
	BasePart.Parent = script
	
	for _, Descendant in pairs(BasePart:GetDescendants()) do
		if Descendant:IsA("Mesh") or Descendant:IsA("SpecialMesh") or Descendant:IsA("Decal") or Descendant:IsA("Script") then
			Descendant:Destroy()
		end
	end
	
	TweenService:Create(BasePart, TweenInfo.new(Time, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
		{
			Transparency = 0,
			Reflectance = 0.25,
			Color = Color3.fromRGB(255, 204, 0),
			Size = Vector3.new(0.15, 0.6, 0.6) * CoinScale
		}
	):Play()
	
	task.wait(Time)
	
	BasePart.AssemblyLinearVelocity = Vector3.zero
	BasePart.AssemblyAngularVelocity = Vector3.zero
	
	if ClearAutomatically then
		task.spawn(function()
			task.wait(5)
			
			TweenService:Create(BasePart, TweenInfo.new(1, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut), {Transparency = 1}):Play()
			
			task.wait(1)
			
			BasePart:Destroy()
		end)
	end
	
	table.insert(Coins, BasePart)
end

function MidasTouch (BasePart)
	local NumberOfCoins = math.clamp(math.round(BasePart.Mass * 1.5), 0, 10)
	
	BasePart.Parent = script
	
	BasePart.Anchored = false
	BasePart.CanCollide = true
	BasePart.CanQuery = false
	
	BasePart:BreakJoints()
	
	TweenService:Create(BasePart, TweenInfo.new(Time, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
		{
			Transparency = 1,
			Reflectance = 1,
			Orientation = BasePart.Orientation + RNG:NextUnitVector() * 130,
			Size = Vector3.zero
		}
	):Play()
	
	task.wait(Time)
	
	if NumberOfCoins < 1 then BasePart:Destroy() return end
	
	local BaseParts = {}
	
	for i = 1, NumberOfCoins do
		if i == 1 then table.insert(BaseParts, BasePart) end
		local Clone = BasePart:Clone() Clone.Parent = script table.insert(BaseParts, Clone)
	end
	
	for _, BasePart in pairs(BaseParts) do
		task.spawn(MakeIntoCoin, BasePart)
	end
end

local ClickRemote = Instance.new("RemoteEvent", owner.PlayerGui)
ClickRemote.Name = "ClickRemote"

ClickRemote.OnServerEvent:Connect(function(_, Target)
	if Target:IsA("BasePart") then
		MidasTouch(Target)
	else
		for _, Part in pairs(Target:GetDescendants()) do
			if Part:IsA("BasePart") then
				task.spawn(MidasTouch, Part)
			end
		end
	end
end)

NLS([[
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Mouse = owner:GetMouse()

local Target = nil
local ContrlDown = false
local LeftAlt = false

UserInputService.InputBegan:Connect(function(Input, GPE)
	if not GPE then
		if Input.UserInputType == Enum.UserInputType.Keyboard then
			if Input.KeyCode == Enum.KeyCode.LeftControl then
				LeftControl = true
			elseif Input.KeyCode == Enum.KeyCode.LeftAlt then
				LeftAlt = true
			end
		end
	end
end)

UserInputService.InputEnded:Connect(function(Input, GPE)
	if not GPE then
		if Input.UserInputType == Enum.UserInputType.Keyboard then
			if Input.KeyCode == Enum.KeyCode.LeftControl then
				LeftControl = false
			elseif Input.KeyCode == Enum.KeyCode.LeftAlt then
				LeftAlt = false
			end
		end
	end
end)

local ClickRemote = owner.PlayerGui:WaitForChild("ClickRemote")

local Highlight = Instance.new("Highlight")
Highlight.FillTransparency = 0.5
Highlight.FillColor = Color3.fromRGB(255, 254, 50)
Highlight.OutlineColor = Color3.fromRGB(255, 204, 0)

Mouse.Button1Down:Connect(function()
	if Target and LeftControl then
		ClickRemote:FireServer(Target)
	end
end)

RunService.PostSimulation:Connect(function()
	local MouseTarget = Mouse.Target
	
	if LeftControl then
		if MouseTarget then
			if MouseTarget:GetFullName() ~= "Workspace.Base" and not CollectionService:HasTag(MouseTarget, "COIN") then
				if LeftAlt then
					if MouseTarget then
						Target = MouseTarget
					end
				else
					Target = MouseTarget:FindFirstAncestorOfClass("Model") or MouseTarget
				end
			else
				Target = nil
			end
		else
			Target = nil
		end
		
		Highlight.Parent = Target
	else
		Highlight.Parent = nil
	end
end)
]], owner.PlayerGui)
