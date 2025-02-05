local library = {}
local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")
local players = game:GetService("Players")
local lp = players.LocalPlayer
local mouse = lp:GetMouse()

if game.CoreGui:FindFirstChild("Overload_UI") then
    game.CoreGui:FindFirstChild("Overload_UI"):Destroy()
end

local function protectGui(obj)
    if syn and syn.protect_gui then
        syn.protect_gui(obj)
    end
    obj.Parent = game.CoreGui
end

local mainGui = Instance.new("ScreenGui")
mainGui.Name = "Overload_UI"
protectGui(mainGui)

local function tween(obj, props, dur)
    ts:Create(obj, TweenInfo.new(dur, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props):Play()
end

local function createCorner(obj, rad)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, rad)
    corner.Parent = obj
end

function library:CreateWindow(title, imgUrl)
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 350, 0, 50)
    window.Position = UDim2.new(0.2, 0, 0.2, 0)
    window.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    window.Parent = mainGui
    createCorner(window, 15)

    local bgImage = Instance.new("ImageLabel")
    bgImage.Size = UDim2.new(1, 0, 1, 0)
    bgImage.BackgroundTransparency = 1
    bgImage.Image = imgUrl or "rbxassetid://10833439242"
    bgImage.ImageTransparency = 0.3
    bgImage.Parent = window

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 50)
    header.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    header.Parent = window
    createCorner(header, 15)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title or "Overload UI"
    titleLabel.Font = Enum.Font.FredokaOne
    titleLabel.TextSize = 20
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Position = UDim2.new(0, 20, 0, 0)
    titleLabel.Parent = header

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 0, 250)
    content.Position = UDim2.new(0, 0, 0, 50)
    content.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    content.Visible = false
    content.Parent = window
    createCorner(content, 15)

    local tabHolder = Instance.new("Frame")
    tabHolder.Size = UDim2.new(1, 0, 0, 40)
    tabHolder.Position = UDim2.new(0, 0, 0, 0)
    tabHolder.BackgroundTransparency = 1
    tabHolder.Parent = content

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Parent = tabHolder

    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Text = "⏷"
    minimizeBtn.Size = UDim2.new(0, 40, 0, 40)
    minimizeBtn.Position = UDim2.new(1, -50, 0, 5)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.Font = Enum.Font.FredokaOne
    minimizeBtn.TextSize = 20
    minimizeBtn.Parent = header
    createCorner(minimizeBtn, 15)

    minimizeBtn.MouseButton1Click:Connect(function()
        content.Visible = not content.Visible
        minimizeBtn.Text = content.Visible and "⏶" or "⏷"
        tween(window, {Size = content.Visible and UDim2.new(0, 350, 0, 300) or UDim2.new(0, 350, 0, 50)}, 0.3)
    end)

    local function dragify(obj)
        local dragging, dragInput, dragStart, startPos
        local function update(input)
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
        obj.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = obj.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        obj.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
        end)
        uis.InputChanged:Connect(function(input)
            if input == dragInput and dragging then update(input) end
        end)
    end
    dragify(window)

    local tabs = {}

    function tabs:CreateTab(tabName)
        local tabBtn = Instance.new("TextButton")
        tabBtn.Text = tabName
        tabBtn.Size = UDim2.new(0, 100, 0, 35)
        tabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabBtn.Font = Enum.Font.FredokaOne
        tabBtn.TextSize = 16
        tabBtn.Parent = tabHolder
        createCorner(tabBtn, 10)

        local tabContent = Instance.new("Frame")
        tabContent.Size = UDim2.new(1, 0, 1, -40)
        tabContent.Position = UDim2.new(0, 0, 0, 40)
        tabContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        tabContent.Parent = content
        tabContent.Visible = false
        createCorner(tabContent, 10)

        tabBtn.MouseButton1Click:Connect(function()
            for _, child in pairs(content:GetChildren()) do
                if child:IsA("Frame") and child ~= tabHolder then
                    child.Visible = false
                end
            end
            tabContent.Visible = true
        end)

        return {
            AddLabel = function(text)
                local lbl = Instance.new("TextLabel")
                lbl.Text = text
                lbl.Size = UDim2.new(1, -20, 0, 30)
                lbl.Position = UDim2.new(0, 10, 0, 10)
                lbl.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                lbl.Font = Enum.Font.FredokaOne
                lbl.TextSize = 16
                lbl.Parent = tabContent
                createCorner(lbl, 10)
            end
        }
    end

    return tabs
end

return library
