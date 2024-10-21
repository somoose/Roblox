local function SnapToGrid (Position, GridScale, GridOffset)
	return Vector3.new(
		math.round((Position.X - GridOffset.X) / GridScale.X) * GridScale.X + GridOffset.X,
		math.round((Position.Y - GridOffset.Y) / GridScale.Y) * GridScale.Y + GridOffset.Y,
		math.round((Position.Z - GridOffset.Z) / GridScale.Z) * GridScale.Z + GridOffset.Z
	)
end
