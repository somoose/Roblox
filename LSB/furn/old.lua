local githubprefix = "https://raw.githubusercontent.com/somoose/Roblox/master/LSB/furn/serialised/"

local furniturelinks = {
	["bench"] = "bench.lua",
	["chair"] = "chair.lua",
	["stool"] = "stool.lua",
	["table"] = "table.lua",
	["jenga"] = "jenga.lua",
	["square-stool"] = "square-stool.lua",
	["traffic-cone"] = "traffic-cone.lua",
	["trash-bin"] = "trash-bin.lua",
	["paper-bin"] = "paper-bin.lua",
	["gnome"] = "gnome.lua",
	["ps1-rat"] = "ps1-rat.lua",
	["blåhaj"] = "blåhaj.lua",
	["potato"] = "potato.lua",
	["cookie"] = "cookie.lua",
	["conveyor"] = "conveyor.lua"
}

for name, filename in pairs(furniturelinks) do
	furniturelinks[name] = githubprefix .. filename
end

local Keys = {}

for Key, Value in pairs(furniturelinks) do
	table.insert(Keys, Key)
end

local CollectionService = game:GetService("CollectionService")
local furnTag = "__tag__"
local HttpService = game:GetService("HttpService")

local Prefix = "furn/"
local LSBARGS = {...} -- r/arg1/arg2..

local LoadedModels = {} -- Stores models which have already been loaded to prevent overuse of HttpService.

function SpawnFurniture (Index, Amount, Scale, SeatDisabled) -- Returns a new piece of furniture matching Index, accepts truncated indices.
	-- This function automatically positions the furniture in front of the owner and parents them to workspace.
	Index = Index or Keys[math.random(#Keys)]
	Amount = tonumber(Amount) or 1
	Scale = tonumber(Scale) or 1
	SeatDisabled = SeatDisabled == "true" and true or false
	
	for Name, Link in pairs(furniturelinks) do
		if Name:lower():sub(1, #Index) == Index:lower() then
			print("Spawning: " .. Amount .. " " .. Name .. "'s at scale " .. Scale)
			local CharacterSize = owner.Character:GetExtentsSize()
			
			local Models = {}
			
			for i = 1, Amount do				
				if LoadedModels[Name] then -- Model has been loaded before.
					local Clone = LoadedModels[Name]:Clone()
					CollectionService:AddTag(Clone, furnTag)
					table.insert(Models, Clone)
				else -- Model has not been loaded before, and the link has to be processed through HttpService.
					LoadedModels[Name] = loadstring(HttpService:GetAsync(Link))()
					LoadedModels[Name].Parent = nil
					
					local Clone = LoadedModels[Name]:Clone()
					CollectionService:AddTag(Clone, furnTag)
					table.insert(Models, Clone)
				end
			end
			
			for i, Model in pairs(Models) do
				if SeatDisabled then
					for _, Part in pairs(Model:GetDescendants()) do
						if Part:IsA("Seat") then
							Part.Disabled = true
						end
					end
				end
				
				Model.PrimaryPart = Model.PrimaryPart or Model:FindFirstChildWhichIsA("BasePart")
				
				Model:ScaleTo(Scale)
				Model.Parent = workspace
				
				local ModelSize = Model:GetExtentsSize()
				local Difference = Model:GetBoundingBox().Position - Model.PrimaryPart.Position
				
				local TargetCFrame = owner.Character:GetBoundingBox() * CFrame.new(
					0,
					ModelSize.Y/2 - CharacterSize.Y/2 + (i - 1) * ModelSize.Y,
					-(CharacterSize.Z + ModelSize.Z)/2
				) * CFrame.new(-Difference)
				
				Model:PivotTo(TargetCFrame)
			end
			
			return Models
		end
	end

	warn"Loop finished without returning model."
end

function ClearAllModels ()
	for _, Model in pairs(workspace:GetDescendants()) do
		if Model:IsA("Model") then
			if CollectionService:HasTag(Model, furnTag) then
				Model:Destroy()
			end
		end
	end
end

local Commands = {
	{
		Code = "spawn",
		Description = "Spawns the specified amount of models at the specified size.",
		Arguments = "/index/amount/scale",
		Function = SpawnFurniture
	},
	{
		Code = "clear",
		Description = "Clears all models with the " .. furnTag .. " tag.",
		Arguments = "",
		Function = ClearAllModels
	},
	{
		Code = "cmds",
		Arguments = "",
		Description = "Prints all the commands."
	},
	{
		Code = "get",
		Description = "Prints all the spawnable furniture items.",
		Arguments = "",
		Function = function ()
			print(Keys)
		end
	}
}

Commands[3].Function = function () -- I set the function this way because I can't access the Commands table inside of the table.
	for _, Command in pairs(Commands) do
		warn("furn/" .. Command.Code .. Command.Arguments, Command.Description)
	end
end

if #LSBARGS > 0 then
	for _, Command in pairs(Commands) do
		if Command.Code:lower() == LSBARGS[1]:lower() then
			table.remove(LSBARGS, 1)
			Command.Function(table.unpack(LSBARGS))
			
			break
		end
	end
else
	owner.Chatted:Connect(function(Message)
		if Message:sub(1, #Prefix):lower() == Prefix:lower() then
			local Arguments = Message:sub(#Prefix + 1, #Message):split("/")
			
			for _, Command in pairs(Commands) do
				if Arguments[1] then
					if Command.Code:lower() == Arguments[1]:lower() then
						table.remove(Arguments, 1)
						Command.Function(table.unpack(Arguments))
					end
				end
			end
		end
	end)

	print("Say furn/cmds")
end
