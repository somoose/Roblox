local InsertService = game:GetService("InsertService")

local Model = Instance.new("Model")
Model.Name = "Cookie"

local Cookie = InsertService:CreateMeshPartAsync("rbxassetid://7240841424", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
Cookie.TextureID = "rbxassetid://7240843295"
Cookie.Size = Cookie.Size / 6
Cookie.Parent = Model

return Model
