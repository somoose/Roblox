local Players = game:GetService"Players"
local RunService = game:GetService"RunService"
local TweenService = game:GetService"TweenService"
local Debris = game:GetService"Debris"

local Player = owner

local Tool = Instance.new"Tool"
Tool.Name = "Bin"
Tool.CanBeDropped = false
Tool.Parent = Player.Backpack

local PlaceRemote = Instance.new"RemoteEvent"
PlaceRemote.Name = "PlaceRemote"
PlaceRemote.Parent = Tool

local Handle = Instance.new"Part"
Handle.Name = "Handle"
Handle.Massless = true
Handle.Size = Vector3.new(2, 2.5, 2)
Handle.Reflectance = 0.05
Handle.Material = Enum.Material.Metal
Handle.Color = Color3.fromRGB(100, 100, 100)
Handle.Parent = Tool

local CrumpleSound = Instance.new"Sound"
CrumpleSound.Volume = 7.5
CrumpleSound.Pitch = 0.8
CrumpleSound.SoundId = "rbxassetid://9125723588"
CrumpleSound.Parent = Handle

local BillBoard = Instance.new"BillboardGui"
BillBoard.Size = UDim2.fromScale(2, 6)
BillBoard.StudsOffset = Vector3.new(0, BillBoard.Size.Y.Scale / 1.25, 0)
BillBoard.Parent = Handle

local PrintFrame = Instance.new"Frame"
PrintFrame.Size = UDim2.fromScale(1, 1)
PrintFrame.Transparency = 1
PrintFrame.Parent = BillBoard

local UIList = Instance.new"UIListLayout"
UIList.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIList.Parent = PrintFrame

function PrintBinned (Name)
	local String = "Binned " .. Name

	local TextBox = Instance.new"TextBox"
	TextBox.Text = ""
	TextBox.Size = UDim2.fromScale(1, 0.1)
	TextBox.BackgroundTransparency = 1
	TextBox.TextColor3 = Color3.fromRGB(216, 216, 216)
	TextBox.TextSize = 20
	TextBox.Font = Enum.Font.Code
	TextBox.Parent = PrintFrame

	for i = 1, #String do task.wait(0.025)
		TextBox.Text = String:sub(1, i)
	end

	task.wait(0.75)

	for i = 1, #String do task.wait(0.025)
		TextBox.Text = String:sub(1, #String - i)
	end

	TextBox:Destroy()
end

Tool.Grip = CFrame.new(0, Handle.Size.Y/3, Handle.Size.Z/2)
local Default = Tool.Grip

local BinMesh = Instance.new"SpecialMesh"
BinMesh.Scale = Vector3.one * 0.85
BinMesh.MeshId = "rbxassetid://8351096407"
BinMesh.Parent = Handle

local ProximityPrompt = Instance.new"ProximityPrompt"
ProximityPrompt.HoldDuration = 0.75
ProximityPrompt.ActionText = "Bin Item"
ProximityPrompt.Parent = Handle

local Idle = true

task.spawn(function()
	local x = 0

	while true do RunService.Heartbeat:Wait()
		if Idle then
			for i = 1, 100 do task.wait()
				x = x + 1

				Tool.Grip = Default * CFrame.Angles(
					math.sin(x/18) * 0.08,
					math.cos(x/36) * 0.08,
					0
				)
			end
		end
	end
end)

ProximityPrompt.Triggered:Connect(function(Player)
	local Character = Player.Character

	if Character then
		local Throwaway = Character:FindFirstChildOfClass"Tool"

		if Throwaway and Throwaway ~= Tool then
			local PreviousName = Throwaway.Name
			Throwaway.Name = "[REDACTED]"
			CrumpleSound:Play()
			local s, e = pcall(function()
				Debris:AddItem(Throwaway, 0)
			end)
			PrintBinned(PreviousName)
		end
	end
end)

local CurrentPlacementWeld

PlaceRemote.OnServerEvent:Connect(function(_, Target, Hit, Normal)
	Tool.Parent = workspace

	local Destination = CFrame.lookAt(Hit.Position, Hit.Position + Normal) * CFrame.new(0, 0, -Handle.Size.Y/2) * CFrame.Angles(math.rad(270), 0, 0)

	local Weld = Instance.new"Weld"
	Weld.Part0, Weld.Part1 = Handle, Target
	Weld.C0, Weld.C1 = Destination:Inverse(), Target.CFrame:Inverse()
	Weld.Parent = Handle

	CurrentPlacementWeld = Weld
end)

local LocalCode = [[
	local Player = game.Players.LocalPlayer
	local Mouse = Player:GetMouse()
	local Character = Player.Character

	local Tool = Character:FindFirstChild"Bin" or Player.Backpack:FindFirstChild"Bin"
	local PlaceRemote = Tool:WaitForChild"PlaceRemote"
	local Handle = Tool.Handle

	Tool.Activated:Connect(function()
		if Mouse.Target then
			local Target = Mouse.Target
			local Hit = Mouse.Hit
			local Normal = Target.CFrame:VectorToWorldSpace(
				Vector3.FromNormalId(Mouse.TargetSurface)
			)

			PlaceRemote:FireServer(Target, Hit, Normal)
		end
	end)
]]

local LastParent
local LastLocalScript = NLS(LocalCode, Player.PlayerGui)
LastLocalScript.Name = "RubbishBinLocal"

Tool:GetPropertyChangedSignal"Parent":Connect(function()
	LastParent = Tool.Parent
end)

Tool.Equipped:Connect(function()
	if CurrentPlacementWeld then
		CurrentPlacementWeld:Destroy()
	end
	
	if LastParent and not LastParent:IsA"Backpack" then
		local NewPlayer = Players:GetPlayerFromCharacter(Tool.Parent)
		
		if not NewPlayer.PlayerGui:FindFirstChild"RubbishBinLocal" then
			local LastLocalScript = NLS(LocalCode, NewPlayer.PlayerGui)
			LastLocalScript.Name = "RubbishBinLocal"
		end
	end
end)
