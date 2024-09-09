local ID = 131302043244796
local FURN_ASSETS = LoadAssets(ID)
ASSET_LIST = FURN_ASSETS:GetArray()

FURN_TAG = "__FURN__"

local FURN = {}

FURN.ClearAllModels = function ()
	for _, Descendant in pairs(workspace:GetDescendants()) do
		if Descendant:IsA("BasePart") or Descendant:IsA("Model") then
			if CollectionService:HasTag(Descendant, FURN_TAG) then
				Descendant:Destroy()

				task.wait()
			end
		end
	end
end

FURN.SpawnFurniture = function (AssetName, Amount, Scale, SeatDisabled)
	Index = Index or ASSET_LIST[math.random(#ASSET_LIST)]
	Amount = tonumber(Amount) or 1
	Scale = tonumber(Scale) or 1
	SeatDisabled = SeatDisabled == "true" and true or false

	local CharacterSize = owner.Character:GetExtentsSize()
	local CharacterPivot = owner.Character:GetPivot()

	for _, ASSET in pairs(ASSET_LIST) do
		if ASSET.Name:lower():sub(1, #AssetName) == AssetName:lower() then
			for i = 1, Amount do
				local Clone = FURN_ASSETS:Get(ASSET.Name)
				CollectionService:AddTag(Clone, FURN_TAG)

				for _, Part in pairs(Clone:GetDescendants()) do
					if Part:IsA("BasePart") then
						
					end

					if Part:IsA("StringValue") and Part.Name == "Script" then
						print("Running " .. Part:GetFullName())

						task.spawn(function()
							loadstring("local script = table.unpack({...})" .. Part.Value)(Part)
						end)
					end
					
					if SeatDisabled then
						if Part:IsA("Seat") or Part:IsA("VehicleSeat") then
							Part.Disabled = true
						end
					end
				end
				
				Clone:ScaleTo(Scale)
				Clone.PrimaryPart = Clone.PrimaryPart or Clone:FindFirstChildWhichIsA("BasePart")

				Clone.Parent = script

				local CloneSize = Clone:GetExtentsSize()
				local PivotDifference = Clone:GetBoundingBox().Position - Clone.PrimaryPart.Position

				Clone.Parent = nil

				local Destination = owner.Character:GetBoundingBox() * CFrame.new(
					0,
					CloneSize.Y/2 - CharacterSize.Y/2 + (i - 1) * CloneSize.Y,
					-(CharacterSize.Z + CloneSize.Z)/2
				) * CFrame.new(-PivotDifference)

				Clone:PivotTo(Destination)

				Clone.Parent = workspace
			end

			print("Spawned: " .. Amount .. " " .. ASSET.Name .. "'s at scale " .. Scale)

			return
		end
	end

	warn("Loop finished without creating anything.")
end

return FURN
