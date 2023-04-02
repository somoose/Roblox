function LevitationLoop (Part, Y)
	task.spawn(function()
		Part.AssemblyLinearVelocity = Vector3.zero
		Part.AssemblyAngularVelocity = Vector3.zero
		Part.Orientation = Vector3.new(0, Part.Orientation.Y, 0)

		while true do task.wait()
			local Difference = Y - Part.Position.Y

			Part.AssemblyLinearVelocity += Vector3.new(
				0,
				Difference - Part.AssemblyLinearVelocity.Y,
				0
			)

			Part.AssemblyAngularVelocity += Vector3.new(
				-Part.AssemblyAngularVelocity.X,
				0,
				-Part.AssemblyAngularVelocity.Z
			)
			
			local X = math.round(Part.Orientation.X)
			local Z = math.round(Part.Orientation.Z)
			
			local MaxTilt = 1
			
			if (X > MaxTilt or X < -MaxTilt) or (Z > MaxTilt or Z < -MaxTilt) then
				Part.Orientation = Part.Orientation:Lerp(Part.Orientation + Vector3.new(
					-X,
					0,
					-Z
				), 0.1)
			end
		end
	end)
end
