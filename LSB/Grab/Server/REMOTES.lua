GrabRemote = Instance.new("RemoteEvent", owner.PlayerGui)
GrabRemote.Name = "GrabRemote"
GrabRemote.OnServerEvent:Connect(FUNCTIONS.GrabRemoteServerEvent)

GetServerScriptRemote = Instance.new("RemoteFunction", owner.PlayerGui)
GetServerScriptRemote.Name = "GetServerScriptRemote"
GetServerScriptRemote.OnServerInvoke = function () return script end

DeleteRemote = Instance.new("RemoteEvent", owner.PlayerGui)
DeleteRemote.Name = "DeleteRemote"
DeleteRemote.OnServerEvent:Connect(function(_, Item)
	Item:Destroy()
end)

ChatCommandRemote = Instance.new("RemoteEvent", owner.PlayerGui)
ChatCommandRemote.Name = "ChatCommandRemote"
ChatCommandRemote.OnServerEvent:Connect(function(_, Text)
	FUNCTIONS.RUN_COMMAND(Text)
end)

KeyBindRemote = Instance.new("RemoteEvent", owner.PlayerGui)
KeyBindRemote.Name = "KeyBindRemote"
