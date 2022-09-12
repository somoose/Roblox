-- Made by E7LK 🤭💋

-- Services
local M = game:GetService"MarketplaceService"
local P = game:GetService"Players"
local RS = game:GetService"RunService"
local TS = game:GetService"TweenService"
local HT = game:GetService"HttpService"

-- Physical Variables
local x, y, z = 12, 4.5, 0
local yOffset, zOffset = 1, 5
local physicalTransparency = 1;

-- Ui Variables
local textSize = 30
local font = Enum.Font.Highway
local textColor = Color3.fromRGB(255, 255, 255)
local backgroundColor = Color3.fromRGB(0, 0, 0)
local inputTransparency, outputTransparency = 0, 1
local canvasSize = Vector2.new(1400, 600)
local openingText = [[Console loaded 🤭💋]]

-- Casual Variables
local player = owner;
local character = player.Character
local rootpart = character.HumanoidRootPart;

-- Other Variables
local base = "rbxassetid://"
local rand = math.random
local dApi = "https://api.dictionaryapi.dev/api/v2/entries/en/"

-- Functions
function getPlr (text)
	for _, player in pairs(P:GetPlayers()) do
		if player.Name:lower():sub(1, #text) == text:lower() or player.Character.Humanoid.DisplayName:lower():sub(1, #text) == text:lower() then
			return player
		end
	end
end

function getChar (text)
	for _, character in pairs(workspace:GetChildren()) do
		if character:FindFirstChild("Humanoid") then
			if character.Name:lower():sub(1, #text) == text:lower() or character.Humanoid.DisplayName:lower():sub(1, #text) == text:lower() then
				return character
			end
		end
	end
end

function snap (character)
	for _, part in pairs(character:GetChildren()) do
		coroutine.wrap(function()
			local hum = character.Humanoid
			hum.Health = 0
			hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
			if part:IsA("BasePart") then
				part.Material = Enum.Material.Neon
				part.BrickColor = BrickColor.White()
				part.Anchored = true
				part.CanCollide = false
				TS:Create(part, TweenInfo.new(2.5), {Orientation = Vector3.new(rand(-360, 360), rand(-360, 360), rand(-360, 360)), Position = part.Position + Vector3.new(rand(-3, 3), rand(-3, 3), rand(-3, 3)), Transparency = 1}):Play()
				task.wait(2.8)
				part:Destroy()
			end
		end)()
	end
end

function rainbowText (str)
	local f = math.floor
	local n = #str
	local B = ""

	for i = 1, n do
		if str:sub(i,i)~=" " then
			local color = Color3.fromHSV(i/n,1,1)
			local r,g,b = f(color.R*255),f(color.G*255),f(color.B*255)
			B..="<font face='Code' color='rgb("..r..","..g..","..b..")'>"..str:sub(i,i).."</font>"
		else
			B..=" "
		end
	end

	return B
end

function color (str, rgb)
	local f = math.floor
	local r,g,b = f(rgb.R*255), f(rgb.G*255), f(rgb.B*255)
	return [[<font color="rgb(]]..r..","..g..","..b..[[)">]]..str.."</font>"
end

----------------------------------------------

local screen = Instance.new("Part", character)
screen.Name = "Screen"
screen.CanCollide = false
screen.Massless = true
screen.Color = backgroundColor
screen.Transparency = physicalTransparency
screen.CFrame = rootpart.CFrame + rootpart.CFrame.UpVector * yOffset + rootpart.CFrame.LookVector * zOffset
screen.Size = Vector3.new(x, y, z)
screen:SetNetworkOwner(player)

local partp = Instance.new("Part", character)
partp.Anchored = true
partp.Size = Vector3.one / 10
partp.Transparency = 1
partp.CanQuery = false
partp.CanCollide = false
partp.Massless = true
partp.CanTouch = false

local att0, att1 = Instance.new("Attachment", screen), Instance.new("Attachment", partp)
local att2, att3 = Instance.new("Attachment", screen), Instance.new("Attachment", rootpart)
att2.Orientation = Vector3.new(-15, 0, 3)

local alignp = Instance.new("AlignPosition", screen)
alignp.RigidityEnabled = true
alignp.Responsiveness *= 20
alignp.MaxVelocity = 9e15
alignp.MaxForce = 9e15
alignp.Attachment0 = att0
alignp.Attachment1 = att1

local aligno = Instance.new("AlignOrientation", screen)
aligno.Attachment0 = att2
aligno.Attachment1 = att3

TS:Create(att2, TweenInfo.new(2.725, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Orientation = Vector3.new(att2.Orientation.X, att2.Orientation.Y, -att2.Orientation.Z)}):Play()

RS.Stepped:Connect(function(delta)
	partp.Position = rootpart.Position + rootpart.CFrame.UpVector * yOffset + rootpart.CFrame.LookVector * zOffset
end)

local sound = Instance.new("Sound", screen)
sound.Volume = 1
sound.Looped = true

local surfaceGui = Instance.new("SurfaceGui", screen)
surfaceGui.CanvasSize = canvasSize
surfaceGui.Face = Enum.NormalId.Back

local textBox = Instance.new("TextBox", surfaceGui)
textBox.Text = ""
textBox.TextWrapped = true
textBox.RichText = true
textBox.Font = font
textBox.BackgroundColor3 = backgroundColor
textBox.TextColor3 = textColor
textBox.BorderSizePixel = 0
textBox.BackgroundTransparency = inputTransparency
textBox.TextSize = textSize
textBox.Size = UDim2.new(1, 0, 1, 0)
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.TextYAlignment = Enum.TextYAlignment.Bottom

local corner = Instance.new("UICorner", textBox)

local output = textBox:Clone()
output.Name = "Output"
output.Parent = surfaceGui
output.BackgroundTransparency = outputTransparency
output.TextYAlignment = Enum.TextYAlignment.Top
output.Text = openingText

local keyRem = Instance.new("RemoteEvent", screen)
keyRem.Name = "KeystrokeEvent"

keyRem.OnServerEvent:Connect(function(player, text)
	textBox.Text = text
end)

local exRem = Instance.new("RemoteEvent", screen)
exRem.Name = "ExecuteRemote"

function input (str)
	local space = str:split" "

	if str:sub(1, 1) == "%" then
		str = str:sub(2, #str)
		local colorStr = color(str, Color3.fromRGB(121, 182, 235))
		output.Text ..= "\n>" .. colorStr
		local s, e = pcall(function()
			loadstring("local screen = owner.Character.Screen " .. str)()
		end)
		if not s then
			output.Text ..= "\n" .. color(e, Color3.fromRGB(255, 0, 0))
		end
	elseif str:sub(1, 1) == "~" then
		output.Text ..= "\n" .. str:sub(2, #str)
	elseif str:sub(1, 4):lower() == "math" then
		output.Text ..= "\n" .. str
		local num = loadstring("return " .. str:sub(5, #str))()
		output.Text ..= "\n" .. num
	elseif str:lower():sub(1, 5) == "clear" then
		output.Text = openingText
	elseif str:lower() == "hide" then
		surfaceGui.Enabled = false
	elseif space[1]:lower() == "play" then
		output.Text ..= "\n>" .. str
		if space[2]:lower() == "lofi" then
			output.Text ..= "\nPlaying lofi / " .. color("rbxassetid://9043887091", Color3.fromRGB(100, 255, 50))
			sound.SoundId = "rbxassetid://9043887091"
			sound:Play()
		else
			local id = base .. tonumber(space[2])
			output.Text ..= "\nPlaying " .. color(id, Color3.fromRGB(100, 255, 50))
			sound.SoundId = id
			sound:Play()
		end
	elseif space[1]:lower() == "setvolume" then
		output.Text ..= "\n>" .. str
		sound.Volume = tonumber(space[2])
		output.Text ..= "\nVolume set to " .. space[2]
	elseif space[1]:lower() == "stopmusic" then
		output.Text ..= "\n>" .. str
		sound:Pause()
		output.Text ..= "\nMusic stopped"
	elseif space[1]:lower() == "looped" then
		if space[2]:lower() == "true" then
			output.Text ..= "\n>" .. str
			sound.Looped = true
			output.Text ..= "\nLooped set to true"
		elseif space[2]:lower() == "false" then
			output.Text ..= "\n>" .. str
			sound.Looped = false
			output.Text ..= "\nLooped set to false"
		end
	elseif space[1]:lower() == "align" then
		if space[2]:lower() == "left" then
			output.Text ..= "\n>" .. str
			output.TextXAlignment, textBox.TextXAlignment = Enum.TextXAlignment.Left, Enum.TextXAlignment.Left
		elseif space[2]:lower() == "right" then
			output.Text ..= "\n>" .. str
			output.TextXAlignment, textBox.TextXAlignment = Enum.TextXAlignment.Right, Enum.TextXAlignment.Right
		end
	elseif space[1]:lower() == "textcolor" then
		output.Text ..= "\n>" .. str
		local rgb = space[2]
		if rgb then
			local comma = rgb:split","
			local r, g, b = tonumber(comma[1]), tonumber(comma[2]), tonumber(comma[3])
			local color = Color3.fromRGB(r, g, b)
			output.TextColor3 = color
			textBox.TextColor3 = color
			output.Text ..= "\nTextColor changed to " .. r .. "," .. g .. "," .. b
		end
	elseif space[1]:lower() == "backgroundcolor" then
		output.Text ..= "\n>" .. str
		local rgb = space[2]
		if rgb then
			local comma = rgb:split","
			local r, g, b = tonumber(comma[1]), tonumber(comma[2]), tonumber(comma[3])
			local color = Color3.fromRGB(r, g, b)
			textBox.BackgroundColor3 = color
			output.Text ..= "\nBackgroundColor changed to " .. r .. "," .. g .. "," .. b
		end
	elseif space[1]:lower() == "transparency" then
		output.Text ..= "\n" .. str
		textBox.BackgroundTransparency = tonumber(space[2])
		inputTransparency = tonumber(space[2])
		output.Text ..= "\nBackgroundTransparency set to " .. space[2]
	elseif space[1]:lower() == "ws" then
		local char = getChar(space[2])
		output.Text ..= "\n>" .. str
		char.Humanoid.WalkSpeed = tonumber(space[3])
		output.Text ..= "\nSet " .. char.Name .. "'s WalkSpeed to " .. tonumber(space[3])
	elseif space[1]:lower() == "dmg" then
		output.Text ..= "\n>" .. str
		local plr = getPlr(space[2])
		if plr.Character and plr.Character.Humanoid then
			output.Text ..= "\nDamaged " .. plr.Name .. " by " .. space[3] 
			plr.Character.Humanoid:TakeDamage(tonumber(space[3]))
		end
	elseif space[1]:lower() == "des" then
		output.Text ..= "\n>" .. str
		local plr = getPlr(space[2])

		if plr then
			plr.Character = nil
		else
			local char = getChar(space[2])
			if char then
				char:Destroy()
			end
		end

		output.Text ..= "\nDestroyed " .. plr.Name
	elseif space[1]:lower() == "ldes" then
		local plr = getPlr(space[2])
		RS.Heartbeat:Connect(function()
			if plr then
				plr.Character = nil
			end
		end)
	elseif space[1]:lower() == "kill" then
		local char = getChar(space[2])
		if char and char.Humanoid then
			char.Humanoid.Health = 0
		end
	elseif space[1]:lower() == "re" then
		output.Text ..= "\n>" .. str
		local plr = getPlr(space[2])
		plr:LoadCharacter()
		output.Text ..= "\nReloaded " .. plr.Name
	elseif space[1]:lower() == "dis" then
		output.Text ..= "\n>" .. str
		local char = getChar(space[2])
		if char.Humanoid then
			char.Humanoid.DisplayName = space[3]
		end
		output.Text ..= "\nChanged " .. char.Name .. "'s DisplayName to " .. space[3]
	elseif space[1]:lower() == "goto" then
		output.Text ..= "\n>" .. str
		local char = getChar(space[2])
		character:MoveTo(char.HumanoidRootPart.Position)
		output.Text ..= "\nGone to " .. char.Name
	elseif space[1]:lower() == "bring" then
		output.Text ..= "\n>" .. str
		local char = getChar(space[2])
		char:MoveTo(rootpart.Position)
		output.Text ..= "\nBrought " .. char.Name
	elseif space[1]:lower() == "da" then
		output.Text ..= "\n>" .. str
		local char = getChar(space[2])
		for _, acc in pairs(char:GetChildren()) do
			if acc:IsA("Accessory") then
				acc.Parent = workspace
				acc.Handle.CanCollide = true
				acc.Handle.Name = "preceeding"

				local prox = Instance.new("ProximityPrompt", acc.preceeding)
				prox.ActionText = "Equip"
				prox.HoldDuration = 0.5
				prox.Triggered:Connect(function(trigger)
					acc.preceeding.Name = "Handle"
					acc.Parent = trigger.Character
					task.wait(0.1)
					prox:Destroy()
				end)
			end
		end
		output.Text ..= "\nDropped " .. char.Name .. "'s accessories"
	elseif space[1]:lower() == "st" then
		output.Text ..= "\n>" .. str
		local plr = getPlr(space[2])
		if plr and plr.Backpack then
			for _, tool in pairs(plr.Backpack:GetChildren()) do
				local clone = tool:Clone()
				clone.Parent = plr.Backpack
				tool.Parent = player.Backpack
			end
		end
		output.Text ..= "\nStole " .. plr.Name .. "'s tools"
	elseif space[1]:lower() == "snap" then
		output.Text ..= "\n>" .. str
		local char = getChar(space[2])
		snap(char)
		output.Text ..= "\nSnapped " .. char.Name
	elseif space[1]:lower() == "lsnap" then
		local char = getChar(space[2])
		RS.Heartbeat:Connect(function()
			if char then
				snap(char)
			end
		end)
	elseif space[1]:lower() == "heal" then
		output.Text ..= "\n>" .. str
		local char = getChar(space[2])
		if char and char.Humanoid then
			char.Humanoid.Health = 100
		end
		output.Text ..= "\nHealed " .. char.Name
	elseif space[1]:lower() == "sethealth" then
		output.Text ..= "\n>" .. str
		local char = getChar(space[2])
		if char and char.Humanoid then
			char.Humanoid.Health = tonumber(space[3])
		end
		output.Text ..= "\nSet " .. char.Name .. "'s health to " .. space[3]
	elseif str:sub(1, 7):lower() == "rainbow" then
		output.Text ..= "\n>" .. str
		local newstr = rainbowText(str:sub(9, #str))
		output.Text ..= "\n" .. newstr
	elseif str:sub(1, 6):lower() == "define" then
		output.Text ..= "\n>" .. [[<font color="rgb(121, 182, 235)">]] .. str .. [[</font>]]
		local word = str:sub(8, #str):lower()
		local tab
		
		local s, r = pcall(function()
			local json = HT:GetAsync(dApi .. word)
			local tab_ = HT:JSONDecode(json)
			tab = tab_
		end)
		if s then
			local def = tab[1]["meanings"][1]["definitions"][1]["definition"]
			output.Text ..= "\n" .. def
		else
			output.Text ..= "\n" .. color(r, Color3.fromRGB(255, 0, 0))
		end
	end
end

exRem.OnServerEvent:Connect(function(player, str)
	input(str)
end)

player.Chatted:Connect(input)

local releasedFocusRem = Instance.new("RemoteEvent", screen)
releasedFocusRem.Name = "ReleasedFocusRemote"

releasedFocusRem.OnServerEvent:Connect(function(player)
	task.wait(.1)
	local text = output.Text

	local tab = text:split("\n")

	local max = 16

	if #tab > max then
		local newtab = {}
		table.move(tab, #tab - max, #tab, 1, newtab)

		local str = table.concat(newtab, "\n")

		output.Text = str
	end
end)

local hideRem = Instance.new("RemoteEvent", screen)
hideRem.Name = "HideRemote"

hideRem.OnServerEvent:Connect(function(player)
	surfaceGui.Enabled = true
end)

--------------------------------------------------

NLS([[

-- Service Variables
local UIS = game:GetService"UserInputService"
local TEX = game:GetService"TextService"

-- Ui Variables
local textSize = 20
local font = Enum.Font.Highway
local textColor = Color3.fromRGB(255, 255, 255)
local backgroundColor = Color3.fromRGB(0, 0, 0)
local uiTransparency = 0.5;
local scaleX, scaleY = 0.625, nil

-- Casual Variables
local player = owner;
local character = player.Character
local rootpart = character.HumanoidRootPart;

-- Main Variables
local screen = character:WaitForChild"Screen"
local surfaceGui = screen:WaitForChild"SurfaceGui"
local sTextBox = surfaceGui:WaitForChild"TextBox"
local output = surfaceGui:WaitForChild"Output"
local keyRem = screen:WaitForChild"KeystrokeEvent"
local exRem = screen:WaitForChild"ExecuteRemote"
local relFocusRem = screen:WaitForChild"ReleasedFocusRemote"
local hideRem = screen:WaitForChild"HideRemote"

-- Other Variables
local shift = false

---------------------------------------------

local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Enabled = false

local textBox = Instance.new("TextBox", screenGui)
textBox.Text = sTextBox.Text
textBox.Font = font
textBox.BorderSizePixel = 0
textBox.BackgroundColor3 = backgroundColor
textBox.BackgroundTransparency = uiTransparency
textBox.TextColor3 = textColor
textBox.TextSize = textSize
textBox.Size = UDim2.new(scaleX, 0, 0, TEX:GetTextSize("", textSize, font, Vector2.new(0, 0)).Y * #textBox.Text:split("\n"))
textBox.AnchorPoint = Vector2.new(0.5, 0.5)
textBox.Position = UDim2.new(0.5, 0, 0.5, 0)
textBox.RichText = true
textBox.TextWrapped = true
textBox.MultiLine = true
textBox.ClearTextOnFocus = false
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.TextYAlignment = Enum.TextYAlignment.Top

local corner = Instance.new("UICorner", textBox)

-- Keybinds

UIS.InputBegan:Connect(function(input, gpe)
	if input.KeyCode == Enum.KeyCode.Return and shift then
		screenGui.Enabled = false
		textBox:ReleaseFocus()
		exRem:FireServer(textBox.Text)
		relFocusRem:FireServer()
		textBox.Text = ""
	elseif input.KeyCode == Enum.KeyCode.LeftShift then
		shift = true
		textBox.MultiLine = false
	end
end)

UIS.InputEnded:Connect(function(input, processed)
	if input.KeyCode == Enum.KeyCode.Q and not processed then
		if not surfaceGui.Enabled then
			hideRem:FireServer()
		end
		screenGui.Enabled = true
		textBox:CaptureFocus()
	elseif input.KeyCode == Enum.KeyCode.LeftShift then
		shift = false
		textBox.MultiLine = true
	end
end)

textBox:GetPropertyChangedSignal("Text"):Connect(function()
	keyRem:FireServer(textBox.Text)
	textBox.Size = UDim2.new(scaleX, 0, 0, TEX:GetTextSize(textBox.Text, textSize, font, Vector2.new(0, 0)).Y)
end)

]], character)
