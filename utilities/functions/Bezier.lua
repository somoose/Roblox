local Bezier = {}

Bezier.Quad = function (A, B, C, T)
	return A:Lerp(B,T):Lerp(B:Lerp(C,T),T)
end

Bezier.Cubic = function (A, B, C, D, T)
	return A:Lerp(B,T):Lerp(B:Lerp(C,T),T):Lerp(B:Lerp(C,T):Lerp(C:Lerp(D,T),T),T)
end

return Bezier
