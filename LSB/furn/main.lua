local FUNCTIONS = {}
local COMMANDS = {}

local LSB_ARGS = {...}

local ID = 131302043244796
local FURN_ASSETS = LoadAssets(ID)
local ASSET_LIST = FURN_ASSETS:GetArray()

local CollectionService = game:GetService("CollectionService")

local FURN_TAG = "__FURN__"

FUNCTIONS.SpawnFurniture = function (AssetName, Amount, Scale, SeatDisabled) -- Returns a new piece of furniture, matching Index. Accepts truncated indces.
	-- This function automatically positions the furniture in front of the owner.
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

				if SeatDisabled then
					for _, Part in pairs(Clone:GetDescendants()) do
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

FUNCTIONS.ClearAllModels = function ()
	for _, Descendant in pairs(workspace:GetDescendants()) do
		if Descendant:IsA("BasePart") or Descendant:IsA("Model") then
			if CollectionService:HasTag(Descendant, FURN_TAG) then
				Model:Destroy()

				task.wait()
			end
		end
	end
end

table.insert(COMMANDS, {
	Code = "spawn",
	Description = "Spawns the specified amount of models at the specified size.",
	Arguments = "/index/amount/scale",
	Function = FUNCTIONS.SpawnFurniture
})
table.insert(COMMANDS, {
	Code = "clear",
	Description = "Clears all models with the '" .. FURN_TAG .. "' tag.",
	Arguments = "",
	Function = FUNCTIONS.ClearAllModels
})
table.insert(COMMANDS, {
	Code = "cmds",
	Arguments = "",
	Description = "Prints all the commands.",
	Function = function ()
		print(COMMANDS)
	end
})
table.insert(COMMANDS, {
	Code = "get",
	Description = "Prints all the spawnable furniture items.",
	Arguments = "",
	Function = function ()
		print(ASSET_LIST)
	end
})

for _, Command in pairs(COMMANDS) do
	if Command.Code:lower() == LSB_ARGS[1]:lower() then
		table.remove(LSB_ARGS, 1)

		Command.Function(table.unpack(LSB_ARGS))

		break
	end
end
