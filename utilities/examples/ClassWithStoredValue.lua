local Table = {}
Table.__index = Table

function Table:New ()
	local OBJ = setmetatable({}, Table)
	OBJ.Index = 0

	return OBJ
end

function Table:GetIndex ()
	return self.Index
end

function Table:IncreaseIndex (n)
	self.Index = self.Index + n
end

local OBJ = Table:New()
print(OBJ:GetIndex())
OBJ:IncreaseIndex(5)
print(OBJ:GetIndex())

local OBJ2 = Table:New()
print(OBJ2:GetIndex())
OBJ2:IncreaseIndex(1)
print(OBJ2:GetIndex())
