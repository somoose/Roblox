-- If you simply set the pivot of an object to your mouse's position, then (given that the objects pivot is the centre of the object) the object will be halfway through the ground/wall/etc.
-- To combat this, you need to take the mouse position and offset it based on the normal direction of the surface the mouse is on.

-- Without accounting for objects rotation you can do the following.

Object.Position = MousePosition + Normal * Object.Size / 2

-- That will work as long as the objects orientation is (0, 0, 0), but if you want the position to be offsetted correctly regardless of orientation, you should use the following.

function GetRotatedSize (Object)
    local Size = Object:IsA("BasePart") and Object.Size or Object:GetExtentsSize() -- Assumes that any object which isn't a BasePart is a Model.
    local Orientation = Object.CFrame - Object.Position
    
    return Vector3.new(
        math.abs(Orientation.RightVector.X * Size.X) + math.abs(Orientation.UpVector.X * Size.Y) + math.abs(Orientation.LookVector.X * Size.Z),
		math.abs(Orientation.RightVector.Y * Size.X) + math.abs(Orientation.UpVector.Y * Size.Y) + math.abs(Orientation.LookVector.Y * Size.Z),
		math.abs(Orientation.RightVector.Z * Size.X) + math.abs(Orientation.UpVector.Z * Size.Y) + math.abs(Orientation.LookVector.Z * Size.Z)
    )
end

Object.Position = MousePosition + Normal * GetRotatedSize(Object) / 2
