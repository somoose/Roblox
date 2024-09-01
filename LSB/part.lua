local ARGS = {...}

local Parent = (ARGS[1] == nil or ARGS[1] == "") and script or loadstring("return " .. ARGS[1])()
local Amount = tonumber(ARGS[2] or 1) or 1
local ClassName = (ARGS[3] == nil or ARGS[3] == "") and "Part" or ARGS[3]
local Code = ARGS[4]

for i = 1, Amount do
  local Part = Instance.new(ClassName, Parent)
  Part.CFrame = owner.Character:GetPivot() * CFrame.new(0, 0, -Part.Size.Z/2)

  if Code and Code ~= "" then
    loadstring("Part = table.unpack({...})" .. Code)(Part)
  end
end
