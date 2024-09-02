local HttpService = game:GetService("HttpService")
local SlimeModule = loadstring(HttpService:GetAsync("https://raw.githubusercontent.com/somoose/Roblox/master/LSB/slime/module.lua"))()

local Slime = SlimeModule.new(workspace)
Slime:SetAttribute("Moving", false)
Slime.Head.CFrame = owner.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -Slime.Head.Size.Z/2 - owner.Character:GetExtentsSize().Z/2)

SlimeModule.ApplyAppearance(Slime, owner.Character:GetExtentsSize().Magnitude / 3)

owner.Character = Slime
owner.Character.Humanoid.DisplayName = owner.DisplayName

local MoveRemote = Instance.new("RemoteEvent", owner.Character)
MoveRemote.Name = "MoveRemote"

local MoveDebounce = false

MoveRemote.OnServerEvent:Connect(function(_, Destination)
	if not Slime:GetAttribute("Moving") then
		Slime:SetAttribute("Moving", true)
		
		SlimeModule.MoveTo(owner.Character, Destination)
		
		repeat task.wait() until owner.Character.Head.AssemblyLinearVelocity.Magnitude < 1
		
		Slime:SetAttribute("Moving", false)
	end
end)

NLS([[
local MoveRemote = owner.Character:WaitForChild("MoveRemote")

local Camera = workspace.CurrentCamera
Camera.CameraSubject = script.Parent.Head

local UserInputService = game:GetService("UserInputService")

local WDown = false
local ADown = false
local SDown = false
local DDOWN = false

UserInputService.InputBegan:Connect(function(Input, GPE)
	if not GPE then
		if Input.UserInputType == Enum.UserInputType.Keyboard then
			if Input.KeyCode == Enum.KeyCode.W then
				WDown = true
			elseif Input.KeyCode == Enum.KeyCode.A then
				ADown = true
			elseif Input.KeyCode == Enum.KeyCode.S then
				SDown = true
			elseif Input.KeyCode == Enum.KeyCode.D then
				DDOWN = true
			end
		end
	end
end)

UserInputService.InputEnded:Connect(function(Input, GPE)
	if not GPE then
		if Input.UserInputType == Enum.UserInputType.Keyboard then
			if Input.KeyCode == Enum.KeyCode.W then
				WDown = false
			elseif Input.KeyCode == Enum.KeyCode.A then
				ADown = false
			elseif Input.KeyCode == Enum.KeyCode.S then
				SDown = false
			elseif Input.KeyCode == Enum.KeyCode.D then
				DDOWN = false
			end
		end
	end
end)

while true do
	local Destination = owner.Character.Head.Position
	
	if WDown then
		Destination = Destination + Camera.CFrame.LookVector * owner.Character.Head.Size.Magnitude * 3
	end
	if ADown then
		Destination = Destination - Camera.CFrame.RightVector * owner.Character.Head.Size.Magnitude * 3
	end
	if SDown then
		Destination = Destination - Camera.CFrame.LookVector * owner.Character.Head.Size.Magnitude * 3
	end
	if DDOWN then
		Destination = Destination + Camera.CFrame.RightVector * owner.Character.Head.Size.Magnitude * 3
	end
	
	if owner.Character.Head.Position ~= Destination and not owner.Character:GetAttribute("Moving") then
		owner.Character:SetAttribute("Moving", true)
		MoveRemote:FireServer(Destination)
	end
	
	task.wait()
end
]], owner.Character)
