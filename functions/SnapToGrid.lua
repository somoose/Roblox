function SnapToGrid (Vector, Scale)
	local HalfScale = Scale / 2
	
	return Vector3.new(
		math.round(Vector.X / Scale) * Scale + (Vector.X % Scale >= Scale/2 and -Scale/2 or Scale/2),
		Vector.Y,
		math.round(Vector.Z / Scale) * Scale + (Vector.Z % Scale >= Scale/2 and -Scale/2 or Scale/2)
	)
end
