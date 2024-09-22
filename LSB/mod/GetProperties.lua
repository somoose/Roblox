local LSB_ARGS = {...}
local TargetClassName = LSB_ARGS[1] or "Decal"
table.remove(LSB_ARGS, 1)
local Properties = #LSB_ARGS > 0 and LSB_ARGS or (TargetClassName == "Decal" and {"Texture"} or {})

for _, Descendant in pairs(workspace:GetDescendants()) do
	if Descendant:IsA(TargetClassName) then
		local StoredProperties = {
			["Parent"] = Descendant.Parent:GetFullName(),
			["Name"] = Descendant:GetFullName(),
			["ClassName"] = TargetClassName
		}
		
		for _, Property in pairs(Properties) do
			StoredProperties[Property] = Descendant[Property]
		end
		
		print(StoredProperties)
	end
end
