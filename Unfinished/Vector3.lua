local Vector3 = {}
local mt = {
	__index = function (table, index)
		if index == "Magnitude" then
			return math.abs(math.sqrt(table.X^2 + table.Y^2 + table.Z^2))
		elseif index == "Unit" then
			return table / table.Magnitude
		else
			return rawget(table, index)
		end
	end,
	__add = function (table, value)
		local X = table.X + value.X
		local Y = table.Y + value.Y
		local Z = table.Z + value.Z
		return Vector3.new(X, Y, Z)
	end,
	__sub = function (table, value)
		local X = table.X - value.X
		local Y = table.Y - value.Y
		local Z = table.Z - value.Z
		return Vector3.new(X, Y, Z)
	end,
	__mul = function (table, value) print(value)
		if type(value) == "number" then value = Vector3.new(value, value, value) end
		local X = table.X * value.X
		local Y = table.Y * value.Y
		local Z = table.Z * value.Z
		return Vector3.new(X, Y, Z)
	end,
	__div = function (table, value)
		if type(value) == "number" then value = Vector3.new(value, value, value) end
		local X = table.X / value.X
		local Y = table.Y / value.Y
		local Z = table.Z / value.Z
		return Vector3.new(X, Y, Z)
	end
}
function Vector3.new (X, Y, Z)
	local obj = {
		X = X,
		Y = Y,
		Z = Z
	}
	setmetatable(obj, mt)
	return obj
end

local a = Vector3.new(10, 10, 0)
a *= 2

print(a)
