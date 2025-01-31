local RunService = game:GetService("RunService")

local Part = Instance.new("Part", script)
Part.Name = "Display"
Part.Massless = true
Part.CanCollide = false
Part.CanQuery = true
Part.Size = Vector3.new(20, 12, 0.07)
Part.Transparency = 0
Part.Color = Color3.fromRGB()
Part.Material = Enum.Material.SmoothPlastic

local Weld = Instance.new("Weld", Part)
Weld.Part0 = Part
Weld.Part1 = owner.Character.HumanoidRootPart
Weld.C1 = CFrame.new(0, Part.Size.Y/2, -6) * CFrame.Angles(math.pi/-16, 0, 0)

local SurfaceGui = Instance.new("SurfaceGui", Part)
SurfaceGui.Face = Enum.NormalId.Back

local Back = Instance.new("ImageLabel", SurfaceGui)
Back.Name = "Back"
Back.Size = UDim2.fromScale(1, 1)
Back.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Back.Image = "http://www.roblox.com/asset/?id=17478165539"

local Mouse = Instance.new("ImageLabel", Back)
Mouse.Name = "Mouse"
Mouse.Size = UDim2.fromOffset(75, 75)
Mouse.BackgroundTransparency = 1
Mouse.Image = "http://www.roblox.com/asset/?id=14814473817"
Mouse.AnchorPoint = Vector2.one / 2

local UpdateEvent = Instance.new("UnreliableRemoteEvent", SurfaceGui)
UpdateEvent.Name = "UpdateEvent"
UpdateEvent.OnServerEvent:Connect(function(_, Instance, Properties)
	for Property, Value in pairs(Properties) do
		Instance[Property] = Value
	end
end)

local GetServerScript = Instance.new("RemoteFunction", owner.PlayerGui)
GetServerScript.Name = "GetServerScript"
GetServerScript.OnServerInvoke = function ()
	return script
end

NLS([[
local ServerScript = owner.PlayerGui.GetServerScript:InvokeServer()
owner.PlayerGui.GetServerScript:Destroy()

local SurfaceGui = ServerScript.Display.SurfaceGui
local Part = SurfaceGui.Parent
local Back = SurfaceGui.Back
local MouseLabel = Back.Mouse
local UpdateEvent = SurfaceGui.UpdateEvent

local Mouse = owner:GetMouse()

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

RunService.PostSimulation:Connect(function()
	if Mouse.Target == Part then
		local Corner = Part.CFrame * CFrame.new(-Part.Size.X/2, Part.Size.Y/2, 0)
		local Offset = Corner:PointToObjectSpace(Mouse.Hit.Position)
		UpdateEvent:FireServer(
			MouseLabel,
			{
				Position = UDim2.fromScale(Offset.X/Part.Size.X, -Offset.Y/Part.Size.Y)
			}
		)
		MouseLabel.Position = UDim2.fromScale(Offset.X/Part.Size.X, -Offset.Y/Part.Size.Y)
	end
end)

UserInputService.InputBegan:Connect(function(Input, GPE)
	if GPE then return end
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		
	end
end)
]], owner.PlayerGui)
