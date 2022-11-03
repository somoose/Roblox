function formattime (seconds)
	local pattern = "%02i:%02i:%02i"
	local remainder = seconds % 60
	
	local minutes = (seconds - remainder) / 60
	local hours = (minutes - minutes % 60) / 60
	local seconds = seconds - (seconds - remainder)
	minutes = minutes - hours * 60
		
	local format = string.format(pattern,
		hours, minutes, seconds
	)

	return format
end

local board = Instance.new"Part"
board.Anchored = true
board.Transparency = 1
board.Size = Vector3.new(6, 4, 0)
board.Material = Enum.Material.Marble
board.Position = Vector3.new(0, board.Size.Y/2, 0)
board.Parent = script

local surface = Instance.new"SurfaceGui"
surface.Parent = board

local back = Instance.new"TextBox"
back.TextEditable, back.ClearTextOnFocus = false, false
back.Size = UDim2.fromScale(1, 1)
back.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
back.TextColor3 = Color3.fromRGB(200, 200, 200)
back.TextSize = 45
back.Text = ""
back.Parent = surface

local corner = Instance.new"UICorner"
corner.CornerRadius = UDim.new(0, 40)
corner.Parent = back

task.spawn(function()
	while true do task.wait(1/60)
		board.CFrame = owner.Character.HumanoidRootPart.CFrame * CFrame.new(0, 6, 0)
		back.Text = "Server Age:\n" .. formattime(time())
	end
end)
