local ARGS = {...}

local RaycastParams = RaycastParams.new()
RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
RaycastParams.FilterDescendantsInstances = {owner.Character}

local Result = workspace:Raycast(owner.Character.HumanoidRootPart.Position, owner.Character.HumanoidRootPart.CFrame.LookVector * 100, RaycastParams)

if Result then
	loadstring("Part = table.unpack({...})" .. ARGS[1])(Result.Instance)
end
