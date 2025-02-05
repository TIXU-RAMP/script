local library = {}
local windowCount = 0
local uis = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local tweenService = game:GetService("TweenService")

if game.CoreGui:FindFirstChild("INSANE_UI") then
    game.CoreGui:FindFirstChild("INSANE_UI"):Destroy()
end

local mainGui = Instance.new("ScreenGui")
mainGui.Name = "INSANE_UI"
mainGui.Parent = game.CoreGui

local function tween(object, properties, duration)
    tweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), properties):Play()
end

function library:CreateWindow(title)
    windowCount += 1

    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 400, 0, 100)
    window.Position = UDim2.new(math.random(), 0, math.random(), 0)
    window.BackgroundColor3 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
    window.Parent = mainGui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title or "CHAOS WINDOW"
    titleLabel.Font = Enum.Font.Arcade
    titleLabel.TextSize = 36
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundColor3 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
    titleLabel.Size = UDim2.new(1, 0, 0.3, 0)
    titleLabel.Parent = window

    tween(titleLabel, {TextSize = 50, Rotation = 10}, 0.5)

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 0.7, 0)
    content.Position = UDim2.new(0, 0, 0.3, 0)
    content.BackgroundColor3 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
    content.Parent = window

    tween(content, {BackgroundColor3 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))}, 0.3)

    function dragify(object)
        local dragging, dragInput, start, position
        object.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                start = input.Position
                position = object.Position

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        object.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)

        uis.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - start
                object.Position = UDim2.new(position.X.Scale, position.X.Offset + delta.X, position.Y.Scale, position.Y.Offset + delta.Y)
            end
        end)
    end

    dragify(window)

    function library:AddButton(text, callback)
        local button = Instance.new("TextButton")
        button.Text = text or "CLICK ME!"
        button.Font = Enum.Font.GothamBlack
        button.TextSize = 30
        button.Size = UDim2.new(1, 0, 0.2, 0)
        button.BackgroundColor3 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
        button.Parent = content

        tween(button, {TextSize = 40, BackgroundColor3 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))}, 0.3)

        button.MouseButton1Click:Connect(function()
            if callback then callback() end
            button.Text = "WTF?!"
            button.TextSize = math.random(10, 50)
        end)
    end

    function library:AddLabel(text)
        local label = Instance.new("TextLabel")
        label.Text = text or "LOOK AT THIS!"
        label.Font = Enum.Font.SciFi
        label.TextSize = 24
        label.Size = UDim2.new(1, 0, 0.2, 0)
        label.BackgroundColor3 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
        label.Parent = content

        tween(label, {TextSize = 50, Rotation = math.random(-10,10)}, 0.5)
    end

    function library:AddMovingText(text)
        local label = Instance.new("TextLabel")
        label.Text = text or "I'M MOVING!"
        label.Font = Enum.Font.Arcade
        label.TextSize = 30
        label.Size = UDim2.new(1, 0, 0.2, 0)
        label.BackgroundColor3 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
        label.Parent = content

        tween(label, {Position = UDim2.new(0, math.random(-50, 50), 0, math.random(-50, 50))}, 0.5)
    end

    function library:AddFlickeringLabel(text)
        local label = Instance.new("TextLabel")
        label.Text = text or "BLINKING!"
        label.Font = Enum.Font.Fantasy
        label.TextSize = 40
        label.Size = UDim2.new(1, 0, 0.2, 0)
        label.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        label.Parent = content

        tween(label, {TextTransparency = 1}, 0.2)
    end

    return library
end

return library
