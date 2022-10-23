--This script was brought to you by Elk! 🦌 (@E7LK on Roblox)

local locked = false
local lockedposition

local players = game:GetService"Players"
local runservice = game:GetService"RunService"
local marketplaceservice = game:GetService"MarketplaceService"
local textservice = game:GetService"TextService"

local player = owner
local character = function ()
	return player.Character
end

local stringcolor = {173, 241, 149}
local numbercolor = {255, 198, 0}

function roundvector (vector, m)
	m = m or 1
	
	return Vector3.new(
		math.round(vector.X * m) / m,
		math.round(vector.Y * m) / m,
		math.round(vector.Z * m) / m
	)
end

function bar (amount, maxpercentage, percentage)
	local barchar = {"█", "▒"}
	local basebar = ""

	for i = 1, amount do
		if i < amount * (percentage / maxpercentage) then
			basebar = basebar .. barchar[1]
		else
			basebar = basebar .. barchar[2]
		end
	end

	return basebar
end

function bartext (text, maxpercentage, percentage, rgb)
	rgb = rgb or {0, 0, 0}
	local breakpoint = #text * (percentage / maxpercentage)
	local a = text:sub(1, breakpoint)
	local b = text:sub(breakpoint+1, #text)

	return "<font color=\"rgb("..table.concat(rgb, ",")..")\">"..a.."</font>"..b
end

function colortext (text, rgb)
	return "<font color=\"rgb(".. table.concat(rgb, ",") ..")\">"..text.. "</font>"
end

function formattime (seconds)
	local pattern = "%02i:%02i"
	local remainder = seconds % 60

	local format = string.format(pattern,
		(seconds - remainder) / 60,
		seconds - (seconds - remainder)
	)

	return format
end

function autoscroll (textbox)
	local textsize = textbox.TextSize
	local fontsize = textbox.Font
	local boxsize = textbox.AbsoluteSize

	local height = textservice:GetTextSize("", textsize, fontsize, boxsize).Y
	local linebounds = math.round(boxsize.Y / height)

	textbox:GetPropertyChangedSignal"Text":Connect(function()
		local splitlines = textbox.Text:split"\n"
		local lineamount = #splitlines

		if lineamount > linebounds then
			local newlines = {}
			local linedifference = math.abs(lineamount - linebounds) + 1

			for i = linedifference, lineamount do
				table.insert(newlines, splitlines[i])
			end

			textbox.Text = table.concat(newlines, "\n")
		end
	end)
end

local screen = Instance.new"Part"
screen.Name = "Screen"
screen.Size = Vector3.new(20, 7.5, 0)
screen.Transparency = 1
screen.CastShadow = false
screen.CanCollide = false
screen.Anchored = true
screen.CanCollide = false
screen.Parent = script

local sound = Instance.new"Sound"
sound.Name = "ScreenSpeaker"
sound.Looped = true
sound.Volume = 0.5
sound.Parent = screen

local surface = Instance.new"SurfaceGui"
surface.Name = "ScreenDisplay"
surface.Face = Enum.NormalId.Back
surface.CanvasSize = Vector2.new(1500, 500)
surface.Parent = screen

local upperbox = Instance.new"TextBox"
upperbox.Name = "MainTextBox"
upperbox.Size = UDim2.fromScale(1, 1/3/1.025)
upperbox.TextXAlignment, upperbox.TextYAlignment = 0, 0
upperbox.Text = ""
upperbox.TextSize = 25
upperbox.LineHeight = 0.975
upperbox.RichText = true
upperbox.TextEditable = false
upperbox.ClearTextOnFocus = false
upperbox.Font = Enum.Font.Highway
upperbox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
upperbox.Transparency = 0.6
upperbox.TextColor3 = Color3.fromRGB(255, 255, 255)
upperbox.BorderSizePixel = 0
upperbox.Parent = surface

local corner = Instance.new"UICorner"
corner.CornerRadius = UDim.new(0, 7.5)
corner.Parent = upperbox

function loadupperbox (name, artist, timeposition, timelength)
	upperbox.Text = 
		"<font size=\"60\">"..name..
		"</font>\n"..artist..
		"\n\n\n"..formattime(timeposition)
		.." "..bar(78, timelength, timeposition)
		.." "..formattime(timelength)
end

loadupperbox("Song Name", "Artist Name", 30, 60)

local middlebox = upperbox:Clone()
middlebox.TextSize = 17.75
middlebox.Text = ""
middlebox.AnchorPoint = Vector2.new(0, 0.5)
middlebox.Position = UDim2.fromScale(0, 0.5)
middlebox.Parent = surface

autoscroll(middlebox)

local lowerbox = middlebox:Clone()
lowerbox.Text = ""
lowerbox.RichText = false
lowerbox.AnchorPoint = Vector2.new(0, 1)
lowerbox.Position = UDim2.fromScale(0, 1)
lowerbox.Parent = surface

autoscroll(lowerbox)

function log (a, b)
	local output = middlebox.Text

	if b and typeof(b) == "string" then
		b = b:lower()
	end

	a = "~ " .. a

	if b == "error" then
		a = colortext(a, {255, 0, 0})
	elseif b == "special" then
		a = colortext(a, {0, 255, 0})
	elseif b == "warn" then
		a = colortext(a, {255, 115, 21})
	end

	if output == "" then
		middlebox.Text = output .. a
	else
		middlebox.Text = output .. "\n" .. a
	end
end

local commands = "'~' prefix commands include:\n    setid number\n    play timeposition\n    time number\n    pause\n    volume number"

log("output loaded", "special")
log("script made by Elk 🦌 (@E7LK)", "warn")

runservice.Heartbeat:Connect(function(deltatime)
	local ch = character()

	if ch and ch:FindFirstChild"HumanoidRootPart" and not locked then
		screen.CFrame = screen.CFrame:Lerp(ch.HumanoidRootPart.CFrame * CFrame.new(0, 3, -6.5) * CFrame.Angles(math.rad(10), 0, math.rad(math.sin(tick()/1.2)/1.25)), 0.25)
	elseif ch and ch:FindFirstChild"HumanoidRootPart" and locked and lockedposition then
		screen.CFrame = lockedposition * CFrame.Angles(0, 0, math.rad(math.sin(tick()/1.2)/1.25))
	end
end)

local currentasset
local currentdata = setmetatable({}, {
	__index = function ()
		return "nil"
	end,
})

player.Chatted:Connect(function(message)
	if message:sub(1, 1) == "~" then
		message = message:sub(2, #message)

		if message:sub(1, 2):lower() == "id" then
			local idsection = message:sub(4, #message)
			local id = tonumber(idsection) or tonumber(idsection:match"%d+")
			local asset

			if id then
				if idsection:match"%D+" then
					asset = idsection
				else
					asset = "rbxassetid://" .. id
				end

				currentasset = asset

				local info

				local s, e = pcall(function()
					info = marketplaceservice:GetProductInfo(id)
				end)

				if s then
					local name = info.Name
					local artist = info.Creator.Name
					local assettype = info.AssetTypeId

					if assettype == 3 then
						sound:Pause()
						currentdata.name, currentdata.artist, currentdata.previous = name, artist, 0

						sound.SoundId = asset

						loadupperbox(name, artist, 0, sound.TimeLength)
						log("set id to " .. colortext(id, numbercolor) .. ", " .. colortext("\"" .. name .. "\"", stringcolor))
					else
						log("AssetTypeId error, expected 3, got " .. assettype, "error")
					end
				else
					log("asset does not exist", "error")
				end
			else
				log("expected number, got " .. idsection or "nil", "error")
			end
		elseif message:sub(1, 4):lower() == "play" then
			local parsedtimeposition = tonumber(message:sub(6, #message))

			sound:Play()

			if typeof(currentdata.previous) == "number" and not parsedtimeposition then
				sound.TimePosition = currentdata.previous
				log("playing " .. currentdata.name .. " at " .. colortext(formattime(currentdata.previous), numbercolor))
			elseif parsedtimeposition then
				sound.TimePosition = parsedtimeposition
				log("playing " .. currentdata.name .. " at " .. colortext(formattime(parsedtimeposition), numbercolor))
			else
				log("attempted to play nil", "error")
			end

			task.spawn(function()
				while sound.Playing and sound.SoundId == currentasset do task.wait()
					loadupperbox(currentdata.name, currentdata.artist, sound.TimePosition, sound.TimeLength)
				end
			end)
		elseif message:sub(1, 5):lower() == "pause" then
			if sound.Playing then
				sound:Pause()

				currentdata.previous = sound.TimePosition
				if currentdata.name ~= "nil" then
					log("paused " .. currentdata.name)
				else
					log("attempted to pause nil", "error")
				end
			else
				if currentdata.name ~= "nil" then
					log(currentdata.name .. " has been paused")
				else
					log("attempted to pause nil", "error")
				end
			end
		elseif message:sub(1, 6) == "volume" then
			local volume = tonumber(message:sub(8, #message))
			sound.Volume = volume

			log("volume has been set to " .. colortext(volume, numbercolor))
		elseif message:sub(1, 4) == "time" then
			if currentdata.name ~= "nil" and currentdata.artist ~= "nil" then
				local position = tonumber(message:sub(6, #message))
				currentdata.previous = position

				if sound.Playing then
					sound.TimePosition = position
				end

				loadupperbox(currentdata.name, currentdata.artist, position, sound.TimeLength)

				log("time position of " .. currentdata.name .. " has been set to " .. colortext(formattime(position), numbercolor))
			else
				log("attempted to set time position of nil", "error")
			end
		elseif message:lower() == "cmds" or message:lower() == "commands" then
			log(commands)
		elseif message:lower() == "lock" then
			local cframe = screen.CFrame
			local x, y, z = cframe:ToOrientation()
			
			locked, lockedposition = true, CFrame.new(cframe.Position) * CFrame.fromOrientation(x, y, 0)
			log("locked to " .. colortext("(" .. tostring(roundvector(screen.Position)) .. ")", numbercolor))
		elseif message:lower() == "unlock" then
			locked, lockedposition = false, nil
			log("unlocked")
		elseif message:sub(1, 5):lower() == "clear" then
			local target = message:sub(7, #message):lower()
			
			if target == "output" then
				middlebox.Text = ""
			end
		end
	end
end)
