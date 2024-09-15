JointModule = {}

JointModule.ReplaceJointWithConstraint = function (Joint, ConstraintClassName, Properties)
	local Constraint

	if Joint:IsA("Motor6D") then
		local Attachment0 = Instance.new("Attachment", Joint.Part0)
		local Attachment1 = Instance.new("Attachment", Joint.Part1)

		Attachment0.CFrame = Joint.C0
		Attachment1.CFrame = Joint.C1

		Constraint = Instance.new(ConstraintClassName, Joint.Part0)
		Constraint.Attachment0 = Attachment0
		Constraint.Attachment1 = Attachment1
	else
		Constraint = Instance.new(ConstraintClassName, Joint.Part0)
		Constraint.Attachment0 = Joint.Attachment0
		Constraint.Attachment1 = Joint.Attachment1
	end
	
	for Property, Value in pairs(Properties) do
		Constraint[Property] = Value
	end

	Joint:Destroy()

	return Constraint
end

JointModule.AddCollidableClone = function (BasePart, Parent)
	local NewPart = BasePart:Clone()
	NewPart:ClearAllChildren()
	NewPart.Name = "Collision - " .. BasePart.Name
	NewPart.Transparency = 1
	NewPart.CanCollide = true
	NewPart.CanQuery = false
	NewPart.Massless = true
	NewPart.Size /= 1.2
	NewPart.CollisionGroup = "CustomCollisionParts"
	
	local Weld = Instance.new("Weld", NewPart)
	Weld.Part0 = NewPart
	Weld.Part1 = BasePart

	NewPart.Parent = Parent or BasePart.Parent

	return NewPart
end

JointModule.DislocateJoint = function (Joint, ConstraintClassName, Properties)
	JointModule.AddCollidableClone(Joint.Part0)
	JointModule.AddCollidableClone(Joint.Part1)

	JointModule.ReplaceJointWithConstraint(Joint, ConstraintClassName, Properties)
end
