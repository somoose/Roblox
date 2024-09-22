local function HasProperty (Instance, Property)
	local s = pcall(function()
		return Instance[Property]
	end)
	return s
end
