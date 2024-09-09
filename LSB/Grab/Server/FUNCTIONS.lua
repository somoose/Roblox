FUNCTIONS = FUNCTIONS or {}

FUNCTIONS.ReturnPlayer = function (Name)
	if not Name then return end
	
	for _, Player in pairs(game.Players:GetPlayers()) do
		if Player.Name:lower():sub(1, #Name) == Name:lower() then return Player end
		if Player.DisplayName:lower():sub(1, #Name) == Name:lower() then return Player end
	end
end

FUNCTIONS.CreateUID = function ()
	return tick() .. "|" .. math.random(100000000, 999999999)
end

PreviousItem = nil
PreviousNetworkOwners = {}
PreviousProperties = {}

CanCollide = CanCollide or false
Transparency = Transparency or 0.5
HumanoidSit = HumanoidSit or true

FUNCTIONS.GrabRemoteServerEvent = function (_, Item: Instance, BreakJoints: Boolean, TouchingParts: Array, AnchoringEnabled: Boolean)
	if Item then -- User is picking up Item.
		CollectionService:AddTag(Item, isHeld_TAG)
		
		PreviousItem = Item
		
		if Item:IsA("BasePart") then
			if BreakJoints then
				Item.CanCollide = true
				
				Item:BreakJoints()
				Item.Parent = workspace
			end
			
			PreviousProperties[Item.Name] = {
				Item.CanCollide,
				Item.Transparency,
				Item.Massless
			}
			
			if Item.Anchored then Item.Anchored = false end
			if Item.CanCollide ~= CanCollide then Item.CanCollide = CanCollide end
			if Item.Transparency < Transparency then Item.Transparency = Transparency end
			if not Item.Massless then Item.Massless = true end
			
			if Item:IsA("Seat") or Item:IsA("VehicleSeat") then
				table.insert(PreviousProperties[Item.Name], Item.Disabled)
				if not Item.Disabled then Item.Disabled = true end
			end
			
			PreviousNetworkOwners[Item.Name] = Item:GetNetworkOwner()
			Item:SetNetworkOwner(owner)
		elseif Item:IsA("Model") then
			local Parts = {}
			
			for _, Part in pairs(Item:GetDescendants()) do
				if Part:IsA("BasePart") then table.insert(Parts, Part)
					-- Store Part properties in PreviousProperties
					local UID = FUNCTIONS.CreateUID()
					CollectionService:AddTag(Part, UID)
					
					PreviousProperties[UID] = {
						Part.CanCollide,
						Part.Transparency,
						Part.Massless
					}
					
					if Part.Anchored then Part.Anchored = false end
					if Part.CanCollide ~= CanCollide then Part.CanCollide = CanCollide end
					if Part.Transparency < Transparency then Part.Transparency = Transparency end
					if not Part.Massless then Part.Massless = true end
					
					if Part:IsA("Seat") or Part:IsA("VehicleSeat") then
						table.insert(PreviousProperties[UID], Part.Disabled)
						if not Part.Disabled then Part.Disabled = true end
					end
				elseif Part:IsA("Humanoid") then
					if Part.Sit ~= HumanoidSit then Part.Sit = HumanoidSit end
				end
			end
			
			for _, Part in pairs(Parts) do -- Store original NetworkOwners.
				local NetworkOwner = Part:GetNetworkOwner()
				local UID = FUNCTIONS.CreateUID()
				CollectionService:AddTag(Part, UID)
				
				if NetworkOwner then
					PreviousNetworkOwners[UID] = NetworkOwner
				else
					PreviousNetworkOwners[UID] = "Server"
				end
			end
			
			for _, Part in pairs(Parts) do -- Set NetworkOwner to the user.
				Part:SetNetworkOwner(owner)
			end
		end
	else
		if PreviousItem then -- User is dropping PreviousItem.
			if PreviousItem:IsA("BasePart") then
				if PreviousNetworkOwners[PreviousItem.Name] then
					PreviousItem:SetNetworkOwner(PreviousNetworkOwners[PreviousItem.Name])
				end
				
				if PreviousProperties[PreviousItem.Name] then
					local Properties = PreviousProperties[PreviousItem.Name]

					PreviousItem.Anchored = AnchoringEnabled
					PreviousItem.CanCollide = Properties[1]
					PreviousItem.Transparency = Properties[2]
					PreviousItem.Massless = Properties[3]
					
					if PreviousItem:IsA("Seat") or PreviousItem:IsA("VehicleSeat") then
						PreviousItem.Disabled = Properties[4]
					end
				end
				
				for i, TouchingPart in pairs(TouchingParts) do
					if CollectionService:HasTag(TouchingPart, "__BASE__") then
						PreviousItem.Anchored = true
						
						TouchingParts[i] = nil
						
						break
					end
					
					local Weld = Instance.new("Weld", PreviousItem)
					Weld.C0 = PreviousItem.CFrame:Inverse() * TouchingPart.CFrame
					Weld.Part0 = PreviousItem
					Weld.Part1 = TouchingPart
				end
				
				if #TouchingParts == 1 then
					local Model = TouchingParts[1]:FindFirstAncestorOfClass("Model") or Instance.new("Model", TouchingParts[1].Parent)
					
					TouchingParts[1].Parent = Model
					PreviousItem.Parent = Model
				elseif #TouchingParts == 2 then
					
				end
			elseif PreviousItem:IsA("Model") then
				for _, Part in pairs(PreviousItem:GetDescendants()) do
					if Part:IsA("BasePart") or Part:IsA("Part") then
						local Tags = CollectionService:GetTags(Part)
						
						if Tags then
							for _, Tag in pairs(Tags) do
								if PreviousNetworkOwners[Tag] then
									if typeof(PreviousNetworkOwners[Tag]) == "string" then
										if PreviousNetworkOwners[Tag] == "Server" then
											Part:SetNetworkOwner(nil)
										end
									else
										Part:SetNetworkOwner(PreviousNetworkOwners[Tag])
									end
									
									CollectionService:RemoveTag(Part, Tag)
								end
								
								if PreviousProperties[Tag] then
									local Properties = PreviousProperties[Tag]

									Part.Anchored = AnchoringEnabled
									Part.CanCollide = Properties[1]
									Part.Transparency = Properties[2]
									Part.Massless = Properties[3]
									
									if Part:IsA("Seat") or Part:IsA("VehicleSeat") then
										Part.Disabled = Properties[4]
									end
									
									CollectionService:RemoveTag(Part, Tag)
								end
							end
						end
					end
				end
			end
			
			table.clear(PreviousNetworkOwners)
			table.clear(PreviousProperties)
			
			CollectionService:RemoveTag(PreviousItem, isHeld_TAG)
		end
	end
end
