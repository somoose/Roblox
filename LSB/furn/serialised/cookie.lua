local InsertService = game:GetService("InsertService")

local Model = Instance.new("Model")
Model.Name = "Cookie"

local Cookie = InsertService:CreateMeshPartAsync("rbxassetid://7240841424", Enum.CollisionFidelity.Default, Enum.RenderFidelity.Automatic)
Cookie.Size = Cookie.Size * 2
Cookie.Parent = Model

local SurfaceAppearance = Instance.new("SurfaceAppearance", Cookie)
SurfaceAppearance.AlphaMode = Enum.AlphaMode.Transparency
SurfaceAppearance.ColorMap = "rbxassetid://7240843295"
SurfaceAppearance.NormalMap = "rbxassetid://7240845031"
SurfaceAppearance.RoughnessMap = "rbxassetid://7240845588"

return Model
