local ARGS = {...}
local TypeDelay = tonumber(ARGS[1]) or 0.05

local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")

local BillboardGui = Instance.new("BillboardGui", owner.Character.Head)
BillboardGui.Size = UDim2.fromScale(16, 1)
BillboardGui.StudsOffset = Vector3.new(0, 4, 0)

local TextLabel = Instance.new("TextLabel", BillboardGui)
TextLabel.Size = UDim2.fromScale(1, 1)
TextLabel.BackgroundTransparency = 1
TextLabel.TextStrokeTransparency = 0
TextLabel.TextScaled = true
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Font = Enum.Font.Code
TextLabel.Text = ""

local Gradients = {
	Butterfly = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(159, 25, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 78, 8)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 192, 3))
	},
	
	Rainbow = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),    -- Red
		ColorSequenceKeypoint.new(0.14, Color3.fromRGB(255, 127, 0)), -- Orange
		ColorSequenceKeypoint.new(0.28, Color3.fromRGB(255, 255, 0)), -- Yellow
		ColorSequenceKeypoint.new(0.42, Color3.fromRGB(0, 255, 0)),   -- Green
		ColorSequenceKeypoint.new(0.57, Color3.fromRGB(0, 0, 255)),   -- Blue
		ColorSequenceKeypoint.new(0.71, Color3.fromRGB(75, 0, 130)), -- Indigo
		ColorSequenceKeypoint.new(0.85, Color3.fromRGB(148, 0, 211)), -- Violet
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))       -- Red (loop back)
	}
}

local UIGradient = Instance.new("UIGradient", TextLabel)
UIGradient.Color = Gradients.Rainbow

local TypeAudio = Instance.new("Sound", owner.Character.Head)
TypeAudio.SoundId = "rbxassetid://9119713951"
repeat task.wait() until TypeAudio.TimeLength > 0
TypeAudio.PlaybackSpeed = TypeAudio.TimeLength / TypeDelay

function TypeMessage (Message)
	if Message:sub(1, 3):lower() == "/e " then
		Message = Message:sub(4, #Message)
	end
	
	for i = 1, #Message do
		TypeAudio:Play()
		TextLabel.Text = Message:sub(1, i)
		TypeAudio.Ended:Wait()
	end
end

owner.Chatted:Connect(TypeMessage)

local OriginalYOffset = BillboardGui.StudsOffset.Y

RunService.PostSimulation:Connect(function()
	BillboardGui.StudsOffset = Vector3.new(
		BillboardGui.StudsOffset.X,
		OriginalYOffset + math.sin(tick() * 2)/3,
		BillboardGui.StudsOffset.Z
	)
	TextLabel.Rotation = math.sin(tick()) * 1.5
end)
