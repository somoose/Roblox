local TweenService = game:GetService"TweenService"

local Player = owner
local Character = Player.Character

local Time = 1

local StartingColor = Color3.fromRGB(255, 255, 255)
local EndColor = Color3.fromRGB(0, 0, 0)

local Side = 3
local HeightMin, HeightMax = 3, 5

function Snap (BasePart)
	task.spawn(function()
		local PRNG = Random.new()
		
		BasePart.Anchored = true
		BasePart.CanCollide = false
		BasePart.Material = Enum.Material.Neon
		
		local Position = BasePart.Position + Vector3.new(
			PRNG:NextNumber(-Side, Side), 
			PRNG:NextNumber(HeightMin, HeightMax),
			PRNG:NextNumber(-Side, Side)
		)
		local Orientation = PRNG:NextUnitVector() * 360

		TweenService:Create(BasePart, TweenInfo.new(0.15, Enum.EasingStyle.Bounce, 2),
			{
				Color = StartingColor
			}
		):Play()

		task.wait(0.15)
		
		TweenService:Create(BasePart, TweenInfo.new(Time, 0, 2),
			{
				Color = EndColor,
				Transparency = 1,
				Position = Position,
				Size = Vector3.zero,
				Orientation = Orientation,
			}
		):Play()
		
		task.wait(Time)
		
		BasePart:Destroy()
	end)
end

local ClickRemote = Instance.new("RemoteEvent", Character)
ClickRemote.Name = "ClickRemote"

ClickRemote.OnServerEvent:Connect(function(_, Target)
	if Target then
		local Model = Target:FindFirstAncestorOfClass"Model"
		
		if Model then
			local Humanoid = Model:FindFirstChildOfClass"Humanoid"
			
			for _, BasePart in pairs(Model:GetDescendants()) do
				if BasePart:IsA"BasePart" then
					Snap(BasePart)
				elseif BasePart:IsA"Clothing" or 
					BasePart:IsA"ShirtGraphic" or 
					BasePart:IsA"BodyColors" then BasePart:Destroy()
				end
				
				if Humanoid and Humanoid.RigType == Enum.HumanoidRigType.R6 and BasePart:IsA"SpecialMesh" then
					BasePart:Destroy()
				end
			end
		else
			Snap(Target)
		end
	end
end)

NLS([[
local Player = owner
local Mouse = Player:GetMouse()

local Character = Player.Character
local ClickRemote = Character:WaitForChild"ClickRemote"

Mouse.Button1Down:Connect(function()
	ClickRemote:FireServer(Mouse.Target)
end)
]], Player.PlayerGui)
