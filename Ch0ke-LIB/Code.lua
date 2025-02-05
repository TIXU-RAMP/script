local library = {}
local uis = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

if game.CoreGui:FindFirstChild("CustomUILib") then
    game.CoreGui:FindFirstChild("CustomUILib"):Destroy()
end

local mainGui = Instance.new("ScreenGui")
mainGui.Name = "CustomUILib"
mainGui.Parent = game.CoreGui

local function tween(object, properties, duration)
    tweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties):Play()
end

local function createCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = object
end

function library:CreateWindow(title)
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 400, 0, 300)
    window.Position = UDim2.new(0.5, -200, 0.5, -150)
    window.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    window.Parent = mainGui
    createCorner(window, 12)

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    header.Parent = window
    createCorner(header, 12)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Size = UDim2.new(1, -80, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header

    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 0, 40)
    tabContainer.Position = UDim2.new(0, 0, 0, 40)
    tabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    tabContainer.Parent = window

    local tabList = Instance.new("UIListLayout")
    tabList.FillDirection = Enum.FillDirection.Horizontal
    tabList.Parent = tabContainer

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 1, -80)
    content.Position = UDim2.new(0, 0, 0, 80)
    content.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    content.Parent = window
    createCorner(content, 12)

    local tabPages = {}

    local function switchTab(tabName)
        for name, page in pairs(tabPages) do
            page.Visible = (name == tabName)
        end
    end

    local function makeDraggable(frame)
        local dragging, dragInput, dragStart, startPos

        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)

        uis.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end

    makeDraggable(window)

    local windowFunctions = {}

    function windowFunctions:AddTab(tabTitle)
        local tabButton = Instance.new("TextButton")
        tabButton.Text = tabTitle
        tabButton.Font = Enum.Font.GothamBold
        tabButton.TextSize = 14
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        tabButton.Size = UDim2.new(0, 100, 1, 0)
        tabButton.Parent = tabContainer

        local tabPage = Instance.new("ScrollingFrame")
        tabPage.Size = UDim2.new(1, -10, 1, -10)
        tabPage.Position = UDim2.new(0, 5, 0, 5)
        tabPage.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tabPage.BorderSizePixel = 0
        tabPage.Parent = content
        tabPage.Visible = false

        local tabLayout = Instance.new("UIListLayout")
        tabLayout.Padding = UDim.new(0, 10)
        tabLayout.Parent = tabPage

        tabPages[tabTitle] = tabPage

        tabButton.MouseButton1Click:Connect(function()
            switchTab(tabTitle)
        end)

        switchTab(tabTitle)

        local tabFunctions = {}

        function tabFunctions:AddButton(text, callback)
            local button = Instance.new("TextButton")
            button.Text = text
            button.Size = UDim2.new(1, -20, 0, 40)
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            button.Font = Enum.Font.GothamBold
            button.TextSize = 14
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Parent = tabPage

            button.MouseButton1Click:Connect(callback)
        end

        function tabFunctions:AddLabel(text)
            local label = Instance.new("TextLabel")
            label.Text = text
            label.Size = UDim2.new(1, -20, 0, 40)
            label.BackgroundTransparency = 1
            label.Font = Enum.Font.GothamBold
            label.TextSize = 14
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Parent = tabPage
        end

        function tabFunctions:AddToggle(text, callback)
            local toggle = Instance.new("TextButton")
            toggle.Text = text
            toggle.Size = UDim2.new(1, -20, 0, 40)
            toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            toggle.Font = Enum.Font.GothamBold
            toggle.TextSize = 14
            toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggle.Parent = tabPage

            local state = false
            toggle.MouseButton1Click:Connect(function()
                state = not state
                toggle.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(60, 60, 60)
                callback(state)
            end)
        end

        return tabFunctions
    end

    return windowFunctions
end

return library
