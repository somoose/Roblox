function ClampVector (Vector, Minimum, Maximum)
	if Vector.Magnitude == 0 then return Vector3.zero end
	
	return Vector.Unit * math.clamp(Vector.Magnitude, Minimum, Maximum)
end
