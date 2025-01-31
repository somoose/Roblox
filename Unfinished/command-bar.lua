local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")


local PlayerGui = owner.PlayerGui


local FUNCTIONS = {}
local GUI = {}
local COMMANDS = nil


local COMMAND_PREFIX = nil
local COMMAND_SEPARATOR = "/"


local CLEAR_TEXT_ON_FOCUS = true


FUNCTIONS.GET_PLAYER = function (Name)
	if not Name then return end
	
	for _, Player in pairs(Players:GetPlayers()) do
		if Player.Name:lower():sub(1, #Name) == Name:lower() then return Player end
		if Player.DisplayName:lower():sub(1, #Name) == Name:lower() then return Player end
	end
end

FUNCTIONS.FOCUS_TEXTBOX = function ()
	GUI.TextBox.Visible = true
	GUI.TextBox.Interactable = true
	
	GUI.TextBox:CaptureFocus()
	GUI.TextBox:GetPropertyChangedSignal("Text"):Wait()
	GUI.TextBox.Text = GUI.TextBox.Text:sub(0, #GUI.TextBox.Text - 1)
end

FUNCTIONS.FOCUS_LOST = function (EnterPressed)
	GUI.TextBox.Visible = false
	GUI.TextBox.Interactable = false

	if EnterPressed then
		FUNCTIONS.RUN()
	end
end

FUNCTIONS.RUN = function ()
	local Text = GUI.TextBox.Text
	
	if COMMAND_PREFIX then
		if Text:sub(1, 1):lower() ~= COMMAND_PREFIX:lower() then return end
		Text = Text:sub(2, #Text)
	end
	
	local Sections = Text:split(COMMAND_SEPARATOR)
	
	for _, Command in pairs(COMMANDS) do
		if Sections[1]:lower() == Command.CODE:lower() then
			table.remove(Sections, 1)
			Command.FUNCTION(table.unpack(Sections))
		end
	end
end


COMMANDS = {
	{
		CODE = "bring",
		ARGUMENTS = "player1" .. COMMAND_SEPARATOR .. "player2" .. COMMAND_SEPARATOR .. "...",
		DESCRIPTION = "Brings the parsed players.",
		FUNCTION = function (...)
			local Names = {...}
			
			for _, Name in pairs(Names) do
				local Target = FUNCTIONS.GET_PLAYER(Name)

				if Target then
					if Target.Character then
						Target.Character:PivotTo(owner.Character:GetPivot())
					end
				end
			end
		end
	},
	{
		CODE = "spawn",
		FUNCTION = function ()
			
		end
	}
}


GUI.ScreenGui = Instance.new("ScreenGui", PlayerGui)
GUI.TextBox = Instance.new("TextBox", GUI.ScreenGui)

GUI.TextBox.ClearTextOnFocus = CLEAR_TEXT_ON_FOCUS
GUI.TextBox.BorderSizePixel = 0
GUI.TextBox.Size = UDim2.fromScale(1, 0.025)
GUI.TextBox.Position = UDim2.fromScale(0, GuiService:GetGuiInset())
GUI.TextBox.BackgroundTransparency = 0.25
GUI.TextBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
GUI.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
GUI.TextBox.TextStrokeTransparency = 1
GUI.TextBox.Font = Enum.Font.Code
GUI.TextBox.TextSize = GUI.TextBox.Size.Y.Scale * GUI.ScreenGui.AbsoluteSize.Y
GUI.TextBox.Text = ""
GUI.TextBox.PlaceholderText = ""
GUI.TextBox.Visible = false


GUI.TextBox.FocusLost:Connect(FUNCTIONS.FOCUS_LOST)

UserInputService.InputBegan:Connect(function(Input, GPE)
	if GPE then return end
	
	if Input.KeyCode == Enum.KeyCode.BackSlash then
		FUNCTIONS.FOCUS_TEXTBOX()
	end
end)
