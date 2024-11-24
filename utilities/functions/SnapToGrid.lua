return function (Position, GridScale)
	return Vector3.new(
		math.round(Position.X / GridScale.X) * GridScale.X,
		math.round(Position.Y / GridScale.Y) * GridScale.Y,
		math.round(Position.Z / GridScale.Z) * GridScale.Z
	)
end
