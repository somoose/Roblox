-- Update to use RunService
-- (bypasses HyperNull: when stack overflow causes signals to not fire)

local Lock = {List = {}}
function Lock:LockProperties (Instance, Properties)
	local InstanceList = self.List[Instance]
	if not InstanceList then
		InstanceList = {}
		self.List[Instance] = InstanceList
	end
	for Property, Value in pairs(Properties) do
		if InstanceList[Property] then
			InstanceList[Property].Connection:Disconnect()
			InstanceList[Property] = nil
		end
		Instance[Property] = Value
		local Connection = Instance:GetPropertyChangedSignal(Property):Connect(function()
			if Instance[Property] ~= Value then
				Instance[Property] = Value
			end
		end)
		InstanceList[Property] = {
			Value = Value,
			Connection = Connection
		}
	end
end
function Lock:UnlockProperties (Instance, Properties)
	local InstanceList = self.List[Instance]
	if not InstanceList then
		return
	end
	for _, Property in pairs(Properties) do
		local t = InstanceList[Property]
		t.Connection:Disconnect()
		InstanceList[Property] = nil
	end
end
function Lock:UnlockAllProperties (Instance)
	local InstanceList = self.List[Instance]
	for Property, t in pairs(InstanceList) do
		t.Connection:Disconnect()
		InstanceList[Property] = nil
	end
end
function Lock:ClearAllLockedProperties ()
	local List = self.List
	for _, InstanceList in pairs(List) do
		for Property, t in pairs(InstanceList) do
			t.Connection:Disconnect()
		end
	end
	table.clear(List)
end
function Lock:GetLockedProperties (Instance)
	local InstanceList = self.List[Instance]
	local Properties = {}
	for Property, t in pairs(InstanceList) do
		Properties[Property] = t.Value
	end
	return Properties
end
-- Make this return a function that disables the recreation.
function Lock:RecreateWhenDestroyed (Instance)
	local Parent = Instance.Parent
	local t = {}
	t.Event = function ()
		local Properties = self:GetLockedProperties(Instance)
		local New = Instance:Clone()
		New.Parent = Parent -- You can't set up signals on parts with nil parents.
		self:LockProperties(New, Properties)
		if Properties.CFrame then
			New.CFrame = Properties.CFrame
		end
		Instance:Destroy() -- Disconnects all events connected to prior Instance.
		Instance = New
		t.Connect()
	end
	t.Connect = function ()
		Instance:GetPropertyChangedSignal("Parent"):Connect(function()
			if Instance.Parent ~= Parent then
				t.Event()
			end
		end)
	end
	t.Connect()
	return function ()
		return Instance -- Return the current instance.
	end
end
return Lock
