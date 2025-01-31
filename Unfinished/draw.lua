local function NewPart ()
	local Part = Instance.new("Part")
	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.Locked = true
	Part.Material = Enum.Material.SmoothPlastic
	--Part.Reflectance = -100
	return Part
end

local HttpService = game:GetService("HttpService")

local MouseModule = Instance.new("StringValue", owner.PlayerGui)
MouseModule.Name = "Mouse"
MouseModule.Value = HttpService:GetAsync("https://raw.githubusercontent.com/somoose/Roblox/refs/heads/master/utilities/modules/Mouse.lua")

local Loaded = Instance.new("BoolValue", owner.PlayerGui)
Loaded.Name = "DrawRemoteLoaded"

local DrawRemote = Instance.new("RemoteEvent", owner.PlayerGui)
DrawRemote.Name = "DrawRemote"
DrawRemote.OnServerEvent:Connect(function(_, Line)
	local Bunch = {}
	local Parts = {}
	for _, t in pairs(Line) do
		local Part = NewPart()
		Part.Size = t.Size
		Part.CFrame = t.CFrame
		Part.Color = t.Color
		Part.Parent = workspace
		table.insert(Parts, Part)
	end
end)

local GS = Instance.new("RemoteFunction", owner.PlayerGui)
GS.Name = "GS"
GS.OnServerInvoke = function ()
	return script
end

NLS([[
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local ServerScript = owner.PlayerGui.GS:InvokeServer()
local DrawRemote = owner.PlayerGui.DrawRemote
local Mouse = loadstring(owner.PlayerGui.Mouse.Value)()
local Camera = workspace.CurrentCamera

local Data = {
	Thickness = 0.1,
	Color = Color3.fromRGB(255, 255, 255),
	MaxLength = 4, -- All drawn parts fall below or equal to this number in length.

	MouseButton1Down = false,
	StartMovePosition = nil,
	LastMovePosition = nil,
	Line = {}, -- Data describing the length and CFrame of each segment of the current drawn line.
	Camera = {
		Origin = nil,
		Rotation = 0,
		HeightIncrement = 4,
		Height = 4,
		Offset = Vector3.zero,
		MouseDown = false
	}
}

local function NewPart ()
	local Part = Instance.new("Part")
	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.Material = Enum.Material.ForceField
	Part.Color = Data.Color
	Part.Reflectance = -100
	return Part
end

-- Draws parts between point A and B.
local function Draw (A, B)
	local Difference = B - A
	local Direction = Difference.Unit
	local Distance = Difference.Magnitude

	local NumberOfSegments = Distance / Data.MaxLength
	local Remainder = NumberOfSegments - math.floor(NumberOfSegments)

	for i = 0, math.floor(NumberOfSegments) do
		local Start = A + Direction * (i * Data.MaxLength)
		local End = A + Direction * ((i+1) * Data.MaxLength)
		if i == math.floor(NumberOfSegments) then
			Start = A + Direction * math.floor(NumberOfSegments) * Data.MaxLength
			End = B
		end
		local Difference = End - Start
			
		local Part = NewPart()
		Part.CFrame = CFrame.new(Start + Difference/2, End)
		Part.Size = Vector3.new(Data.Thickness, 0, Difference.Magnitude * (1.1))
		Part.Parent = ServerScript
		table.insert(Data.Line, {Size = Part.Size, CFrame = Part.CFrame, Color = Part.Color, Part = Part})
	end
end

UserInputService.InputBegan:Connect(function(Input, GPE)
	if not GPE then
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Data.MouseButton1Down = true
		elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
			Data.Camera.Rotation = owner.Character.Head.Rotation.Y
			Data.Camera.MouseDown = true
			local LastMousePosition
			repeat
				local MousePosition = UserInputService:GetMouseLocation()
				if not LastMousePosition then LastMousePosition = MousePosition end
				local Delta = MousePosition - LastMousePosition
				Data.Camera.Offset = Data.Camera.Offset - Vector3.new(Delta.X, -Delta.Y, 0) * 0.1
				LastMousePosition = MousePosition
				task.wait()
			until not Data.Camera.MouseDown
		elseif Input.UserInputType == Enum.UserInputType.Keyboard then
			if Input.KeyCode == Enum.KeyCode.C then
				if Camera.CameraType == Enum.CameraType.Custom then
					Data.Camera.Origin = owner.Character.HumanoidRootPart.Position
					Data.Camera.Look = owner.Character.HumanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
					Camera.CameraType = Enum.CameraType.Scriptable
				else
					Data.Camera.Offset = Vector3.zero
					Data.Camera.Height = 4
					Data.Camera.Look = nil
					Camera.CameraType = Enum.CameraType.Custom
				end
			end
		end
	end
end)
UserInputService.InputChanged:Connect(function(Input, GPE)
	if GPE then return end
	if Input.UserInputType == Enum.UserInputType.MouseWheel then
		if Input.Position.Z > 0 then -- Up
			Data.Camera.Height = Data.Camera.Height - Data.Camera.HeightIncrement
		else
			Data.Camera.Height = Data.Camera.Height + Data.Camera.HeightIncrement
		end
	end
end)
UserInputService.InputEnded:Connect(function(Input, GPE)
	if not GPE then
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Data.MouseButton1Down = false
			Data.StartMovePosition = nil
			Data.LastMovePosition = nil
			DrawRemote:FireServer(Data.Line)
			task.spawn(function()
				local Line = table.clone(Data.Line)
				--(DELAY REMOTE CALL HAS BEEN CONFIRMED)
				for _, t in pairs(Line) do
					t.Part:Destroy()
				end
			end)
			table.clear(Data.Line)
		elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
			Data.Camera.MouseDown = false
		end
	end
end)
RunService.PostSimulation:Connect(function()
	if Data.MouseButton1Down then
		Data.StartMovePosition = Mouse.Position
		Data.LastMovePosition = Data.LastMovePosition or Data.StartMovePosition
		
		if Data.StartMovePosition ~= Data.LastMovePosition then
			Draw(Data.LastMovePosition, Data.StartMovePosition)
			Data.LastMovePosition = Data.StartMovePosition
		end
	end
	if Camera.CameraType == Enum.CameraType.Scriptable then
		local Position = Data.Camera.Origin + Vector3.new(0, Data.Camera.Height, 0)
		Camera.CFrame = CFrame.new(Position, Position + Data.Camera.Look) * CFrame.Angles(math.pi/-2, 0, 0) * CFrame.new(Data.Camera.Offset)
	end
end)
]])
