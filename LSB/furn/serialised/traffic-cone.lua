local InsertService = game:GetService("InsertService")

local Model = Instance.new("Model")
Model.Name = "Traffic Cone"

local TrafficCone = InsertService:CreateMeshPartAsync("http://www.roblox.com/asset/?id=1082802", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
TrafficCone.TextureID = "http://www.roblox.com/asset/?id=1082804"
TrafficCone.Parent = Model

return Model
