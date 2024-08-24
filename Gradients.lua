local Gradients = {
	Butterfly = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(159, 25, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 78, 8)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 192, 3))
	},
	
	Rainbow = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),    -- Red
		ColorSequenceKeypoint.new(0.14, Color3.fromRGB(255, 127, 0)), -- Orange
		ColorSequenceKeypoint.new(0.28, Color3.fromRGB(255, 255, 0)), -- Yellow
		ColorSequenceKeypoint.new(0.42, Color3.fromRGB(0, 255, 0)),   -- Green
		ColorSequenceKeypoint.new(0.57, Color3.fromRGB(0, 0, 255)),   -- Blue
		ColorSequenceKeypoint.new(0.71, Color3.fromRGB(75, 0, 130)), -- Indigo
		ColorSequenceKeypoint.new(0.85, Color3.fromRGB(148, 0, 211)), -- Violet
		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))       -- Red (loop back)
	}
}

return Gradients
