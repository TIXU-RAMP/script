local library = {}
local windowCount = 0
local windowOffset = 20
local activeWindows = {}
local uis = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local mouse = localPlayer:GetMouse()

if game.CoreGui:FindFirstChild("Fevber Hub") then
    game.CoreGui:FindFirstChild("Fevber Hub"):Destroy()
end

local function protectGui(obj)
    if syn and syn.protect_gui then
        syn.protect_gui(obj)
    end
    obj.Parent = game.CoreGui
end

local mainGui = Instance.new("ScreenGui")
mainGui.Name = "Fevber Hub"
protectGui(mainGui)

local function tween(object, properties, duration)
    game:GetService("TweenService"):Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        properties
    ):Play()
end

local function createCorner(object)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = object
end

local function updateCanvasSize(content)
    local totalHeight = 0
    for _, child in pairs(content:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("TextLabel") or child:IsA("Frame") then
            totalHeight = totalHeight + child.Size.Y.Offset + 10
        end
    end
    content.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

function library:CreateWindow(title)
    windowCount += 1

    local window = Instance.new("Frame")
    window.Name = "Window" .. windowCount
    window.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    window.BorderSizePixel = 0
    window.Size = UDim2.new(0, 220, 0, 40)
    window.Position = UDim2.new(0, windowOffset, 0, 20)
    window.Parent = mainGui
    createCorner(window)
    windowOffset += 240

    -- Fluent-inspired header with acrylic effect
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundTransparency = 0.5
    header.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    header.BorderSizePixel = 0
    header.Parent = window
    createCorner(header)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title or "Window"
    titleLabel.Font = Enum.Font.SourceSans
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    titleLabel.BackgroundTransparency = 0.7
    titleLabel.Size = UDim2.new(0.7, -40, 1, 0)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.Parent = header

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Text = "_"
    minimizeButton.Font = Enum.Font.SourceSansBold
    minimizeButton.TextSize = 18
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.BackgroundTransparency = 1
    minimizeButton.Size = UDim2.new(0, 40, 0, 40)
    minimizeButton.Position = UDim2.new(1, -40, 0, 0)
    minimizeButton.Parent = header

    -- Content section with smooth scrolling
    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, 0, 1, -40)
    content.Position = UDim2.new(0, 0, 0, 40)
    content.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    content.BorderSizePixel = 0
    content.Parent = window
    createCorner(content)
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.ScrollBarThickness = 10

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.Parent = content

    -- Minimize functionality
    minimizeButton.MouseButton1Click:Connect(function()
        content.Visible = not content.Visible
        minimizeButton.Text = content.Visible and "_" or "+"
        tween(window, {Size = content.Visible and UDim2.new(0, 220, 0, 200) or UDim2.new(0, 220, 0, 40)}, 0.2)
    end)

    local windowFunctions = {}

    -- Add Button
    function windowFunctions:AddButton(buttonText, callback)
        local button = Instance.new("TextButton")
        button.Text = buttonText or "Button"
        button.Size = UDim2.new(1, -20, 0, 30)
        button.Position = UDim2.new(0, 10, 0, 10)
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        button.BorderSizePixel = 0
        button.Font = Enum.Font.SourceSans
        button.TextSize = 16
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Parent = content
        createCorner(button)
        
        updateCanvasSize(content)

        button.MouseEnter:Connect(function()
            tween(button, {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}, 0.1)
        end)
        button.MouseLeave:Connect(function()
            tween(button, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.1)
        end)

        button.MouseButton1Click:Connect(callback or function() end)
    end

    -- Add Label
    function windowFunctions:AddLabel(labelText)
        local label = Instance.new("TextLabel")
        label.Text = labelText or "Label"
        label.Size = UDim2.new(1, -20, 0, 30)
        label.Position = UDim2.new(0, 10, 0, 10)
        label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        label.BackgroundTransparency = 0.3
        label.Font = Enum.Font.SourceSans
        label.TextSize = 16
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = content
        createCorner(label)
        
        updateCanvasSize(content)
    end

    -- Add Toggle with Subtitle
    function windowFunctions:AddToggleWithSubtitle(toggleText, subtitleText, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, -20, 0, 60)
        toggleFrame.Position = UDim2.new(0, 10, 0, 10)
        toggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        toggleFrame.BorderSizePixel = 0
        toggleFrame.Parent = content
        createCorner(toggleFrame)

        -- Toggle Button
        local toggleButton = Instance.new("TextButton")
        toggleButton.Text = toggleText or "Toggle"
        toggleButton.Size = UDim2.new(0, 50, 0, 30)
        toggleButton.Position = UDim2.new(0, 0, 0, 0)
        toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.Font = Enum.Font.SourceSans
        toggleButton.TextSize = 16
        toggleButton.Parent = toggleFrame

        -- Subtitle for Toggle
        local subtitle = Instance.new("TextLabel")
        subtitle.Text = subtitleText or "Subtitle"
        subtitle.Size = UDim2.new(1, -20, 0, 20)
        subtitle.Position = UDim2.new(0, 10, 0, 35)
        subtitle.BackgroundTransparency = 1
        subtitle.Font = Enum.Font.SourceSans
        subtitle.TextSize = 14
        subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
        subtitle.TextXAlignment = Enum.TextXAlignment.Left
        subtitle.Parent = toggleFrame

        local state = false
        toggleButton.MouseButton1Click:Connect(function()
            state = not state
            toggleButton.Text = state and "ON" or "OFF"
            toggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            if callback then callback(state) end
        end)

        updateCanvasSize(content)
    end

    -- Add TextBox with Subtitle
    function windowFunctions:AddTextBoxWithSubtitle(textBoxText, subtitleText, callback)
        local textBoxFrame = Instance.new("Frame")
        textBoxFrame.Size = UDim2.new(1, -20, 0, 60)
        textBoxFrame.Position = UDim2.new(0, 10, 0, 10)
        textBoxFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        textBoxFrame.BorderSizePixel = 0
        textBoxFrame.Parent = content
        createCorner(textBoxFrame)

        -- TextBox
        local textBox = Instance.new("TextBox")
        textBox.Text = textBoxText or ""
        textBox.Size = UDim2.new(1, -20, 0, 30)
        textBox.Position = UDim2.new(0, 10, 0, 0)
        textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        textBox.Font = Enum.Font.SourceSans
        textBox.TextSize = 16
        textBox.ClearTextOnFocus = false
        textBox.Parent = textBoxFrame

        -- Subtitle for TextBox
        local subtitle = Instance.new("TextLabel")
        subtitle.Text = subtitleText or "Subtitle"
        subtitle.Size = UDim2.new(1, -20, 0, 20)
        subtitle.Position = UDim2.new(0, 10, 0, 35)
        subtitle.BackgroundTransparency = 1
        subtitle.Font = Enum.Font.SourceSans
        subtitle.TextSize = 14
        subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
        subtitle.TextXAlignment = Enum.TextXAlignment.Left
        subtitle.Parent = textBoxFrame

        textBox.FocusLost:Connect(function()
            if callback then callback(textBox.Text) end
        end)

        updateCanvasSize(content)
    end

    window.Draggable = true

    return windowFunctions
end

return library
