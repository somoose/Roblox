COMMAND_PREFIX = COMMAND_PREFIX or nil
COMMAND_SEPARATOR = COMMAND_SEPARATOR or "/"

COMMANDS = {
	{
		CODE = "bring",
		ARGUMENTS = "player1" .. COMMAND_SEPARATOR .. "player2" .. COMMAND_SEPARATOR .. "...",
		DESCRIPTION = "Brings the parsed players.",
		FUNCTION = function (...)
			local Names = {...}
			
			for _, Name in pairs(Names) do
				local Target = FUNCTIONS.ReturnPlayer(Name)

				if Target then
					if Target.Character then
						Target.Character:PivotTo(owner.Character:GetPivot())
					end
				end
			end
		end
	},
	{
		CODE = "spawn",
		FUNCTION = FURN.SpawnFurniture
	},
	{
		CODE = "clear",
		FUNCTION = FURN.ClearAllModels
	},
	{
		CODE = "transparency",
		FUNCTION = function (NewTransparency)
			Transparency = tonumber(NewTransparency or 0.5) or 0.5
		end
	},
	{
		CODE = "sit",
		FUNCTION = function (Boolean)
			HumanoidSit = Boolean == "true" and true or false
		end
	},
	{
		CODE = "cancollide",
		FUNCTION = function (Boolean)
			CanCollide = Boolean == "true" and true or false
		end
	},
	{
		CODE = "get",
		FUNCTION = function ()
			print(ASSET_LIST)
		end
	}
}

FUNCTIONS.RUN_COMMAND = function (Text)
	if COMMAND_PREFIX then
		if Text:sub(1, 1):lower() ~= COMMAND_PREFIX:lower() then return end
		Text = Text:sub(2, #Text)
	end
	
	local Sections = Text:split(COMMAND_SEPARATOR)
	
	for _, Command in pairs(COMMANDS) do
		if Sections[1]:lower() == Command.CODE:lower() then
			table.remove(Sections, 1)
			Command.FUNCTION(table.unpack(Sections))
		end
	end
end
