FUNCTIONS = {}
MOVE_MODES = {}

BlacklistedTags = {
	ISHELD_TAG = "__ISHELD__", -- The CollectionService tag applied to items when they're picked up.
	BASE_TAG = "__BASE__",
	SPAWN_TAG = "__SPAWNLOCATION__"
}

FilterDescendantsInstances = {owner.Character} -- The instances that the hold distance raycast ignores.					(ARRAY)
RAYCASTPARAMS = RaycastParams.new() --																					(RAYCASTPARAMS)
RAYCASTPARAMS.FilterType = Enum.RaycastFilterType.Blacklist

MOVE_MODES.Camera = function ()
	local Origin = Camera.CFrame.Position
	local Direction = Camera.CFrame.LookVector
	local Distance = math.clamp(HOLD_DISTANCE, MINIMUM_HOLD_DISTANCE, (RAYCAST_HOLD_DISTANCE < MINIMUM_HOLD_DISTANCE and MINIMUM_HOLD_DISTANCE or RAYCAST_HOLD_DISTANCE))
	
	local Destination = Origin + Direction * Distance

	--if COLLISION_DETECTION_ENABLED then
	--	local MouseLocation = UserInputService:GetMouseLocation() - GuiService:GetGuiInset()
	--	local ScreenRay = Camera:ScreenPointToRay(MouseLocation.X, MouseLocation.Y)
	--	
	--	local Origin = Camera.CFrame.Position
	--	local Direction = ScreenRay.Direction * HOLD_DISTANCE
	--	
	--	local Result = workspace:Raycast(Origin, Direction, RAYCASTPARAMS)
	--	
	--	local Size = CURRENT_ITEM:IsA("BasePart") and CURRENT_ITEM.Size or CURRENT_ITEM:GetExtentsSize()
	--	
	--	local RotatedSize = Vector3.new(
	--		math.abs(ORIENTATION.RightVector.X * Size.X) + math.abs(ORIENTATION.UpVector.X * Size.Y) + math.abs(ORIENTATION.LookVector.X * Size.Z),
	--		math.abs(ORIENTATION.RightVector.Y * Size.X) + math.abs(ORIENTATION.UpVector.Y * Size.Y) + math.abs(ORIENTATION.LookVector.Y * Size.Z),
	--		math.abs(ORIENTATION.RightVector.Z * Size.X) + math.abs(ORIENTATION.UpVector.Z * Size.Y) + math.abs(ORIENTATION.LookVector.Z * Size.Z)
	--	)
	--	
	--	if Result then
	--		Destination = Destination + Result.Normal * RotatedSize / 2
	--	end
	--end
	
	return Destination
end

MOVE_MODES.Mouse = function ()
	local MouseLocation = UserInputService:GetMouseLocation() - GuiService:GetGuiInset()
	local ScreenRay = Camera:ScreenPointToRay(MouseLocation.X, MouseLocation.Y)
	
	local Origin = Camera.CFrame.Position
	local Direction = ScreenRay.Direction * 1e6
	
	local Result = workspace:Raycast(Origin, Direction, RAYCASTPARAMS)

	local Destination
	
	if Result then
		Destination = Result.Position

		if COLLISION_DETECTION_ENABLED then
			local Size = CURRENT_ITEM:IsA("BasePart") and CURRENT_ITEM.Size or CURRENT_ITEM:GetExtentsSize()
		
			local RotatedSize = Vector3.new(
				math.abs(ORIENTATION.RightVector.X * Size.X) + math.abs(ORIENTATION.UpVector.X * Size.Y) + math.abs(ORIENTATION.LookVector.X * Size.Z),
				math.abs(ORIENTATION.RightVector.Y * Size.X) + math.abs(ORIENTATION.UpVector.Y * Size.Y) + math.abs(ORIENTATION.LookVector.Y * Size.Z),
				math.abs(ORIENTATION.RightVector.Z * Size.X) + math.abs(ORIENTATION.UpVector.Z * Size.Y) + math.abs(ORIENTATION.LookVector.Z * Size.Z)
			)

			Destination = Destination + Result.Normal * RotatedSize / 2
		end
	else
		Destination = Origin + Direction
	end

	if CURRENT_ITEM:IsA("Model") then
		local PivotDifference = CURRENT_ITEM:GetBoundingBox().Position - CURRENT_ITEM:GetPivot().Position

		Destination = Destination - PivotDifference
	end

	return Destination
end

FUNCTIONS.ReturnPlayer = function (Name)
	if not Name then return end
	
	for _, Player in pairs(Players:GetPlayers()) do
		if Player.Name:lower():sub(1, #Name) == Name:lower() then return Player end
		if Player.DisplayName:lower():sub(1, #Name) == Name:lower() then return Player end
	end
end

FUNCTIONS.IsFirstPerson = function ()
	return owner.Character.Head.LocalTransparencyModifier > 0
end

FUNCTIONS.ParentBodyMovers = function (Parent)
	Attachment0.Parent = Parent
	AlignPosition.Parent = Parent
	AlignOrientation.Parent = Parent
end

FUNCTIONS.EditFilterDescendantsInstances = function (add, ...)
	for _, v in pairs({...}) do
		if add then
			table.insert(FilterDescendantsInstances, v)
		else
			table.remove(FilterDescendantsInstances, table.find(FilterDescendantsInstances, v))
		end
	end
	
	RAYCASTPARAMS.FilterDescendantsInstances = FilterDescendantsInstances
end

FUNCTIONS.ReturnPrimaryPart = function (Model)
	return Model.PrimaryPart or Model:FindFirstChildOfClass("BasePart", true) or Model:FindFirstChildOfClass("Part", true)
end

FUNCTIONS.FitsCriteria = function (Item) -- Check if an item fits the criteria for being picked up.
	for _, BlacklistedTag in pairs(BlacklistedTags) do
		if CollectionService:HasTag(Item, BlacklistedTag) then return end
	end
	
	if Item:IsA("BasePart") then
		if MUST_BE_UNLOCKED and Item.Locked then return end
		if MUST_BE_IN_RANGE and (Item.Position - owner.Character.Head.Position).Magnitude > MAXIMUM_GRAB_DISTANCE then return end
	elseif Item:IsA("Model") then
		if MUST_BE_UNLOCKED then for _, BasePart in pairs(Item:GetDescendants()) do if BasePart:IsA("BasePart") then if BasePart.Locked then return end end end end
		if MUST_BE_IN_RANGE and (FUNCTIONS.ReturnPrimaryPart(Item).Position - owner.Character.Head.Position).Magnitude > MAXIMUM_GRAB_DISTANCE then return end
	else
		return
	end
	
	return Item
end

FUNCTIONS.UpdateTarget = function () -- Sets TARGET to the suitable Part or Model of Mouse.Target depending on TARGET and INPUT based factors.
	if not HOLDING then
		local MouseTarget = Mouse.Target
		
		if MouseTarget then
			TARGET = FUNCTIONS.FitsCriteria(ALT_DOWN and MouseTarget or (MouseTarget:FindFirstAncestorOfClass("Model") or MouseTarget))
		else
			TARGET = nil
		end
	end
end

FUNCTIONS.UpdateRaycastHoldDistance = function ()
	if CLIPPING_DETECTION_ENABLED then
		local RaycastResult = workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * MAXIMUM_HOLD_DISTANCE, RAYCASTPARAMS)
		
		if RaycastResult then
			RAYCAST_HOLD_DISTANCE = (RaycastResult.Position - Camera.CFrame.Position).Magnitude
		else
			RAYCAST_HOLD_DISTANCE = MAXIMUM_HOLD_DISTANCE
		end
	else
		RAYCAST_HOLD_DISTANCE = MAXIMUM_HOLD_DISTANCE
	end
end

FUNCTIONS.FOCUS_TEXTBOX = function ()
	GUI.CommandBarTextBox.Visible = true
	GUI.CommandBarTextBox.Interactable = true
	
	GUI.CommandBarTextBox:CaptureFocus()
	GUI.CommandBarTextBox:GetPropertyChangedSignal("Text"):Wait()
	GUI.CommandBarTextBox.Text = GUI.CommandBarTextBox.Text:sub(1, #GUI.CommandBarTextBox.Text - 1)
end

FUNCTIONS.FOCUS_LOST = function (EnterPressed)
	GUI.CommandBarTextBox.Visible = false
	GUI.CommandBarTextBox.Interactable = false

	if EnterPressed then
		FUNCTIONS.RUN_COMMAND_BAR()
	end
end

FUNCTIONS.COMMAND_BAR_TEXT_CHANGED = function ()
	local Text = GUI.CommandBarTextBox.Text
	
	
end

FUNCTIONS.RUN_COMMAND_BAR = function ()
	local Text = GUI.CommandBarTextBox.Text
	
	if COMMAND_PREFIX then
		if Text:sub(1, 1):lower() ~= COMMAND_PREFIX:lower() then return end
		Text = Text:sub(2, #Text)
	end
	
	local ClientCommandsRun = false
	
	local Sections = Text:split(COMMAND_SEPARATOR)
	
	for _, Command in pairs(COMMANDS) do
		if Sections[1]:lower() == Command.CODE:lower() then
			table.remove(Sections, 1)
			Command.FUNCTION(table.unpack(Sections))
			ClientCommandsRun = true
		end
	end

	if ClientCommandsRun then return end
	
	ChatCommandRemote:FireServer(Text)
end

FUNCTIONS.GetCurve = function (Frequency, Intensity) return math.sin(os.clock() * Frequency) * Intensity end
