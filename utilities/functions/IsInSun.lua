local Lighting = game:GetService("Lighting")

function IsInSun (Position, Ignore: Table)
	local RaycastParams = RaycastParams.new()
	RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	RaycastParams.FilterDescendantsInstances = Ignore
	
	local SunPosition = Lighting:GetSunDirection() * 100000
	
	local Result = workspace:Raycast(Position, SunPosition, RaycastParams)
	
	if Result then
		if not Result.Instance.CastShadow then
			table.insert(Ignore, Result.Instance)
			return IsInSun(Position, Ignore)
		end
	else
		return true
	end
end
