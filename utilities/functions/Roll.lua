-- You can convert a directional vector into a rotation by crossing it with (0, -1, 0)

local function ConvertToRotation (Direction)
    return Direction:Cross(Vector3.new(0, -1, 0))
end

local function Roll (Part, Direction, Force)
    Part.AssemblyAngularVelocity = ConvertToRotation(Direction) * Force
end
