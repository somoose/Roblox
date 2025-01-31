-- Start with a ChainRoot and an EndEffector.
-- Get the joints connected to the chain root.
-- If there is only one connected joint, index through it's connected joints, if there is only one, then continue until
-- you reach the EndEffector.
-- That will give you your joint hierarchy.
-- If there is more than one connected joints, separate into different paths until you reach the different the EndEffector.

local IK = {}
IK.__index = IK

function IK:GetJointHierarchy (ChainRoot, EndEffector)
	local Hierarchy = {}
	
	local t = setmetatable({}, IK)
	t.PreviousRoot = nil
	t.CurrentRoot = ChainRoot
	t.UsedRoots = {}

	while t.CurrentRoot ~= EndEffector do task.wait()
		local ConnectedRoots = t:GetConnectedRoots()
		t.PreviousRoot = t.CurrentRoot
		if #ConnectedRoots < 2 then
			table.insert(t.UsedRoots, t.CurrentRoot)
		end
		t.CurrentRoot = ConnectedRoots[1]
		print(t.CurrentRoot.Name)
	end

	print("Looped ended")
	return Hierarchy
end

function IK:GetConnectedRoots ()
	local Part0Joints = self.CurrentRoot.Part0:GetJoints()
	local Part1Joints = self.CurrentRoot.Part1:GetJoints()

	local Roots = Part0Joints
	for _, Root in pairs(Part1Joints) do
		table.insert(Roots, Root)
	end
	
	repeat table.remove(Roots, table.find(Roots, self.CurrentRoot))
	until not table.find(Roots, self.CurrentRoot)

	if self.PreviousRoot then
		repeat table.remove(Roots, table.find(Roots, self.PreviousRoot))
		until not table.find(Roots, self.PreviousRoot)
	end
	
	for _, UsedRoot in pairs(self.UsedRoots) do
		if table.find(Roots, UsedRoot) then
			table.remove(Roots, table.find(Roots, UsedRoot))
		end
	end
	return Roots
end

local Character = owner.Character

local RightShoulder = Character:FindFirstChild("RightShoulder", true)
local RightElbow = Character:FindFirstChild("RightElbow", true)
local RightWrist = Character:FindFirstChild("RightWrist", true)

local Root = Character:FindFirstChild("Root", true)

print(IK:GetJointHierarchy(Root, RightWrist))
