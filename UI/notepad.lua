local Tool = Instance.new("Tool", owner.Backpack)
local Handle = Instance.new("Part", Tool)
Handle.Name = "Handle"
Handle.Size = Vector3.new(1.25, 2, 0)
Handle.Material = Enum.Material.SmoothPlastic
Handle.Color = Color3.fromRGB(40, 40, 40)
Tool.Grip = CFrame.new(Handle.Size.X/2, -Handle.Size.Y/2.5, Handle.Size.Z/2) * CFrame.Angles(math.rad(15), 0, 0)

local SurfaceGui = Instance.new("SurfaceGui", Handle)
SurfaceGui.Face = Enum.NormalId.Back
local TextLabel = Instance.new("TextLabel", SurfaceGui)
TextLabel.AnchorPoint = Vector2.one / 2
TextLabel.Size = UDim2.new(1, -30, 1, -5)
TextLabel.Position = UDim2.fromScale(0.5, 0.5)
TextLabel.BackgroundTransparency = 1
TextLabel.BorderSizePixel = 0
TextLabel.TextScaled = false
TextLabel.TextSize = 100
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.TextYAlignment = Enum.TextYAlignment.Top
TextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
TextLabel.Font = Enum.Font.Nunito
TextLabel.TextTransparency = 0
TextLabel.TextStrokeTransparency = 1
TextLabel.Text = ""

local UpdateTextRemote = Instance.new("RemoteEvent", SurfaceGui)
UpdateTextRemote.Name = "UpdateTextRemote"
UpdateTextRemote.OnServerEvent:Connect(function(_, Text)
	TextLabel.Text = Text
end)

NLS([[
local Properties = {
	"AnchorPoint",
	"Size",
	"Position",
	"BackgroundTransparency",
	"BorderSizePixel",
	"TextScaled",
	"TextSize",
	"TextWrapped",
	"TextXAlignment",
	"TextYAlignment",
	"TextColor3",
	"Font",
	"TextTransparency",
	"TextStrokeTransparency",
	"Text"
}

local UIS = game:GetService("UserInputService")

local Handle = script.Parent.Handle
local SurfaceGui = Handle.SurfaceGui
local TextLabel = SurfaceGui:FindFirstChildOfClass("TextLabel")
local UpdateTextRemote = SurfaceGui.UpdateTextRemote

local TextBox = Instance.new("TextBox", SurfaceGui)
TextBox.PlaceholderText = ""
TextBox.ClearTextOnFocus = false

if TextLabel then
	for _, Property in pairs(Properties) do
		TextBox[Property] = TextLabel[Property]
	end
	TextLabel:Destroy()
else
	error"No TextLabel found"
end

UIS.InputBegan:Connect(function(Input, GPE)
	if GPE then return end
	if Input.KeyCode == Enum.KeyCode.R then
		TextBox:CaptureFocus()
		TextBox:GetPropertyChangedSignal("Text"):Wait()
		TextBox.Text = TextBox.Text:sub(0, #TextBox.Text - 1)
	end
end)

TextBox:GetPropertyChangedSignal("Text"):Connect(function()
	UpdateTextRemote:FireServer(TextBox.Text)
end)
]], Tool)
