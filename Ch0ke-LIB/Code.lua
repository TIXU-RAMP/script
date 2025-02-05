local Library = {}
local UILib = Instance.new("ScreenGui")
local TabXPosition = 30

UILib.Name = "UILib"
UILib.Parent = game:GetService("CoreGui")
UILib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

function CreateUICorner(parent, radius)
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, radius)
	UICorner.Parent = parent
end

function CreateUIStroke(parent, thickness, color)
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Thickness = thickness
	UIStroke.Color = color
	UIStroke.Parent = parent
end

function CreateUIGradient(parent)
	local UIGradient = Instance.new("UIGradient")
	UIGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 80)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
	}
	UIGradient.Parent = parent
end

function Library:Tab(name)
	local Tab = Instance.new("TextLabel")
	local TabFrame = Instance.new("Frame")
	local TabFrameSize = 0
	local TabMouseLeft = true
	local TabFrameMouseLeft = true
	local DropDownFrameMouseLeft = true
	local ButtonListLayout = Instance.new("UIListLayout")

	Tab.Name = name
	Tab.Parent = UILib
	Tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Tab.BorderSizePixel = 0
	Tab.Position = UDim2.new(0, TabXPosition, 0, 30)
	Tab.Size = UDim2.new(0, 120, 0, 25)
	Tab.Font = Enum.Font.SciFi
	Tab.Text = name
	Tab.TextColor3 = Color3.new(1, 1, 1)
	Tab.TextSize = 16
	
	CreateUICorner(Tab, 8)
	CreateUIStroke(Tab, 2, Color3.fromRGB(255, 255, 255))
	CreateUIGradient(Tab)

	TabFrame.Name = "TabFrame"
	TabFrame.Parent = Tab
	TabFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	TabFrame.BorderSizePixel = 0
	TabFrame.Position = UDim2.new(0, 0, 0, 25)
	TabFrame.Size = UDim2.new(0, 120, 0, 0)

	CreateUICorner(TabFrame, 8)
	CreateUIStroke(TabFrame, 2, Color3.fromRGB(180, 180, 180))
	CreateUIGradient(TabFrame)

	ButtonListLayout.Parent = TabFrame
	ButtonListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	local TabLibrary = {}

	function TabLibrary:Button(text, func)
		TabFrameSize = TabFrameSize + 25
		local Button = Instance.new("TextButton")
		Button.Name = text
		Button.Parent = TabFrame
		Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		Button.Size = UDim2.new(0, 120, 0, 25)
		Button.Font = Enum.Font.SciFi
		Button.Text = " " .. text
		Button.TextColor3 = Color3.new(1, 1, 1)
		Button.TextSize = 16
		Button.TextXAlignment = Enum.TextXAlignment.Left
		Button.Visible = false

		CreateUICorner(Button, 6)
		CreateUIStroke(Button, 1.5, Color3.fromRGB(255, 255, 255))
		CreateUIGradient(Button)

		Button.MouseButton1Click:Connect(func)
	end

	return TabLibrary
end

return Library
