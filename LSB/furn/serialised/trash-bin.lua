local InsertService = game:GetService("InsertService")

local Model = Instance.new("Model")
Model.Name = "Trash Bin"

local TrashBin = InsertService:CreateMeshPartAsync("rbxassetid://8351096407", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
TrashBin.Material = Enum.Material.Metal
TrashBin.Parent = Model

return Model
