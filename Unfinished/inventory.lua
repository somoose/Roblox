local TweenService = game:GetService("TweenService")
local function Lerp (a, b, t) return a + (b - a) * t end

local MouseModule = Instance.new("StringValue", owner.PlayerGui)
MouseModule.Name = "Mouse"
MouseModule.Value = game.HttpService:GetAsync("https://raw.githubusercontent.com/somoose/Roblox/refs/heads/master/utilities/modules/Mouse.lua")

local GetServerScriptRemote = Instance.new("RemoteFunction", owner.PlayerGui)
GetServerScriptRemote.Name = "GetServerScriptRemote"
GetServerScriptRemote.OnServerInvoke = function () return script end

local Backpack = Instance.new("Folder")

local function HasProperty (Instance, Property)
	local s = pcall(function()
		return Instance[Property]
	end)
	return s
end
local Data = {
	PreviousProperties = {},
	NewProperties = {
		Anchored = true,
		CanCollide = false,
		CanQuery = false,
		Disabled = true
	}
}
local function EaseOutQuint (t)
	return 1 - math.pow(1 - t, 5)
end
local function TweenModelSize (Model, Size, Duration, EasingFunction)
	task.spawn(function()
		local InitialScale = Model:GetScale()
		local IsTweening = true
		local StartTime = os.clock()
		while IsTweening do
			local ElapsedTime = os.clock() - StartTime
			local t = math.min(ElapsedTime / Duration, 1)
			if EasingFunction then t = EasingFunction(t) end
			Model:ScaleTo(Lerp(InitialScale, Size, t))
			if t >= 1 then IsTweening = false end
			task.wait()
		end
	end)
end
local function TweenModelCFrame (Model, CFrame, Duration, EasingFunction)
	task.spawn(function()
		local InitialCFrame = Model:GetPivot()
		local IsTweening = true
		local StartTime = os.clock()
		while IsTweening do
			local ElapsedTime = os.clock() - StartTime
			local t = math.min(ElapsedTime / Duration, 1)
			if EasingFunction then t = EasingFunction(t) end
			Model:PivotTo(InitialCFrame:Lerp(CFrame, t))
			if t >= 1 then IsTweening = false print"finished tweening model cframe"end
			task.wait()
		end
	end)
end
local function Pickup (Item)
	local ItemScale = Item:GetScale()
	print(ItemScale)
	local ItemSize = Item:GetExtentsSize()
	local Divisor = math.max(1, ItemSize.Magnitude / 1.5)
	local NewScale = ItemScale / Divisor
	if NewScale < ItemScale then
		TweenModelSize(Item, NewScale, 0.6, EaseOutQuint)
		task.wait(0.65)
	end
	TweenModelCFrame(Item, owner.Character.HumanoidRootPart.CFrame, 0.5, EaseOutQuint)
	task.wait(0.55)
	print"scaling model"
	Item:ScaleTo(ItemScale)
	Item.Parent = Backpack
	print"rescaled item"
end
local PickupRemote = Instance.new("RemoteEvent", owner.PlayerGui)
PickupRemote.Name = "PickupRemote"
PickupRemote.OnServerEvent:Connect(function(_, Item, DropPosition)
	if Item then
		if not DropPosition then -- Pickup item.
			for _, BasePart in pairs(Item:GetDescendants()) do
				for Property, Value in pairs(Data.NewProperties) do
					if not BasePart:IsA("BasePart") then continue end
					if HasProperty(BasePart, Property) then
						if not Data.PreviousProperties[BasePart] then Data.PreviousProperties[BasePart] = {} end
						Data.PreviousProperties[BasePart][Property] = BasePart[Property]
						BasePart[Property] = Value
					end
				end
			end
			Pickup(Item)
		else -- Drop item.
			Item.Parent = script
			Item:PivotTo(CFrame.new(DropPosition))
			for _, BasePart in pairs(Item:GetDescendants()) do
				if not BasePart:IsA("BasePart") then continue end
				if Data.PreviousProperties[BasePart] then
					for Property, Value in pairs(Data.PreviousProperties[BasePart]) do
						BasePart[Property] = Value
					end
				end
			end
		end
	end
end)

NLS([[
local RunService = game:GetService("RunService")
local Mouse = loadstring(owner.PlayerGui.Mouse.Value)()
local UserInputService = game:GetService("UserInputService")

local PickupRemote = owner.PlayerGui.PickupRemote
local ServerScript = owner.PlayerGui.GetServerScriptRemote:InvokeServer()
local Highlight = Instance.new("Highlight", ServerScript)

local Data = {
	PotentialItem = nil, -- The item at the mouse when Item is nil.
	Item = nil, --  The item that the user clicked on to put in their inventory.
	SelectedItem = nil, -- The item that the user has selected from their inventory by clicking and dragging.
}

local NumberOfColumns = 4
local NumberOfRows = 4
local InventoryWidth = 0.3 -- Scale

local ScreenGui = Instance.new("ScreenGui", owner.PlayerGui)
ScreenGui.IgnoreGuiInset = true
ScreenGui.Name = "Inventory"
ScreenGui.Enabled = false
local InventoryFrame = Instance.new("Frame", ScreenGui)
InventoryFrame.AnchorPoint = Vector2.new(1, 0.5)
InventoryFrame.Position = UDim2.fromScale(0.975, 0.65)
InventoryFrame.Size = UDim2.fromScale(InventoryWidth, 1)
InventoryFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
InventoryFrame.BackgroundTransparency = 1
Instance.new("UICorner", InventoryFrame)
local UIGridLayout = Instance.new("UIGridLayout", InventoryFrame)
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Center
UIGridLayout.CellPadding = UDim2.fromOffset(3, 3)
UIGridLayout.CellSize = UDim2.fromOffset(InventoryFrame.AbsoluteSize.X/NumberOfColumns - UIGridLayout.CellPadding.X.Offset, InventoryFrame.AbsoluteSize.X/NumberOfColumns - UIGridLayout.CellPadding.X.Offset)
local function EnableInventoryOpened (Opened)
	if Opened then
		ScreenGui.Enabled = true
	else
		ScreenGui.Enabled = false
	end
end
local Cells = {}
for x = 1, NumberOfColumns do
	Cells[x] = {}
	for y = 1, NumberOfRows do
		local CellFrame = Instance.new("Frame", InventoryFrame)
		CellFrame.BackgroundColor3 = InventoryFrame.BackgroundColor3
		CellFrame.BackgroundTransparency = 0.75
		Instance.new("UICorner", CellFrame)
		Cells[x][y] = {Occupied = false, Frame = CellFrame}
	end
end
local function GetNextEmptySlot ()
	for x = 1, NumberOfColumns do
		for y = 1, NumberOfRows do
			if Cells[x][y].Occupied == false then return Cells[x][y] end
		end
	end
end
local function RemoveItemFromInventory (ItemFrame)
	ItemFrame:Destroy()
end
local function AddToInventory (Item)
	local Cell = GetNextEmptySlot()
	Cell.Occupied = true
	local ItemFrame = Instance.new("Frame", Cell.Frame)
	Cell.ItemFrame = ItemFrame
	ItemFrame.Size = UDim2.fromScale(1, 1)
	ItemFrame.BackgroundColor3 = InventoryFrame.BackgroundColor3
	ItemFrame.BackgroundTransparency = 0.75
	Instance.new("UICorner", ItemFrame)

	ItemFrame.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			if not Data.SelectedItem then
				RemoveItemFromInventory(ItemFrame)
				Item.Parent = ServerScript
				Data.SelectedItem = Item
			end
		end
	end)

	local NameLabel = Instance.new("TextLabel", ItemFrame)
	NameLabel.Size = UDim2.fromScale(1, 0.2)
	NameLabel.BackgroundTransparency = 1
	NameLabel.AnchorPoint = Vector2.new(0, 1)
	NameLabel.Position = UDim2.fromScale(0, 1)
	NameLabel.TextScaled = true
	NameLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
	NameLabel.TextStrokeTransparency = 0
	NameLabel.Font = Enum.Font.SourceSansSemibold
	NameLabel.Text = Item.Name
	NameLabel.ZIndex = 2

	local ViewportFrame = Instance.new("ViewportFrame", ItemFrame)
	ViewportFrame.Size = UDim2.fromScale(0.9, 0.9)
	ViewportFrame.Position = UDim2.fromScale(0.5, 0.5)
	ViewportFrame.AnchorPoint = Vector2.one / 2
	ViewportFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	ViewportFrame.BackgroundTransparency = 0.9
	ViewportFrame.BorderSizePixel = 0
	Instance.new("UICorner", ViewportFrame)

	local ViewportItem = Item:Clone()
	ViewportItem:PivotTo(CFrame.new())
	ViewportItem.Parent = ViewportFrame
	Instance.new("Highlight", ViewportItem)

	local ItemSize = ViewportItem:GetExtentsSize()
	local ItemPosition = ViewportItem:GetBoundingBox().Position
	
	local ViewportCamera = Instance.new("Camera", ViewportFrame)
	ViewportFrame.CurrentCamera = ViewportCamera

	local CameraPosition = (ViewportItem:GetBoundingBox() * CFrame.new(ItemSize.Magnitude * 0.5, ItemSize.Magnitude * 0.25, -ItemSize.Magnitude * 0.7)).Position
	ViewportCamera.CFrame = CFrame.new(CameraPosition, ItemPosition)
end

Highlight.FillTransparency = 0.5
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
Highlight.FillColor = Color3.fromRGB(255, 255, 255)

local function GetItemAtMouse ()
	local Target = Mouse.Target
	if Target then
		if Target.Locked then return end
		return Target:FindFirstAncestorOfClass("Model")
	end
end

UserInputService.InputBegan:Connect(function(Input, GPE)
	if GPE then return end
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		if Data.PotentialItem then
			Data.Item = Data.PotentialItem
			AddToInventory(Data.Item)
			Data.PotentialItem = nil
			PickupRemote:FireServer(Data.Item)
			Data.Item = nil
		end
	elseif Input.UserInputType == Enum.UserInputType.Keyboard then
		if Input.KeyCode == Enum.KeyCode.E then
			EnableInventoryOpened(not ScreenGui.Enabled)
		end
	end
end)
UserInputService.InputEnded:Connect(function(Input, GPE)
	if GPE then return end
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		if Data.SelectedItem then
			PickupRemote:FireServer(Data.SelectedItem, Mouse.Position)
			Data.SelectedItem = nil
		end
	end
end)

RunService.PostSimulation:Connect(function()
	if not Data.Item then
		Data.PotentialItem = GetItemAtMouse()
	end
	Highlight.Adornee = Data.PotentialItem
	if Data.SelectedItem then
		Data.SelectedItem:PivotTo(CFrame.new(Mouse.Position))
	end
end)
]])
