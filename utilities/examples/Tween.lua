local function Lerp (a, b, t) return a + (b - a) * t end
local function Tween (StartValue, EndValue, Duration, EasingFunction, Callback)
	local IsTweening = true
	local StartTime = os.clock()
	
	while IsTweening do
		local CurrentTime = os.clock()
		local ElapsedTime = CurrentTime - StartTime
		local t = math.min(ElapsedTime / Duration, 1)
		if EasingFunction then t = EasingFunction(t) end
		local NewValue = Lerp(StartValue, EndValue, t)
		if Callback then Callback(NewValue) end
		if t >= 1 then
			IsTweening = false
		end
		task.wait()
	end
end
Tween(5, 25, 2, nil, print)
