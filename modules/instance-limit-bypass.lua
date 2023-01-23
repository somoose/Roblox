-- Unincluded

local cloneables = {}

local function findclassintable (classname)
	for _, v in pairs(cloneables) do
		if v:IsA (classname) then
			return v
		end
	end
end

-- Module contents

local module = {}

module.Clone = game.Clone

module.New = function (classname, parent)
	local existing = findclassintable(classname)
	local new

	if existing then
		new = module.Clone(existing)
	else
		local instance = Instance.new (classname)
		table.insert(cloneables, instance)

		new = module.Clone(instance)
	end

	new.Parent = parent

	return new
end

return module
