local UILibrary = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function Tween(obj, props, duration)
    TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props):Play()
end

function UILibrary:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local BlurEffect = Instance.new("BlurEffect")
    
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Blur Effect
    BlurEffect.Size = 10
    BlurEffect.Parent = game.Lighting
    Tween(BlurEffect, {Size = 25}, 1)
    
    -- Main Window
    MainFrame.Size = UDim2.new(0, 450, 0, 350)
    MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MainFrame.BorderSizePixel = 2
    MainFrame.Parent = ScreenGui
    MainFrame.ClipsDescendants = true
    
    -- Top Bar
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TopBar.Parent = MainFrame
    
    -- Title
    TitleLabel.Size = UDim2.new(1, 0, 1, 0)
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 20
    TitleLabel.Parent = TopBar

    -- Draggable System
    local dragging, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    return {
        Frame = MainFrame,
        AddTab = function(self, tabName)
            local TabButton = Instance.new("TextButton")
            local TabFrame = Instance.new("Frame")

            TabButton.Size = UDim2.new(0, 100, 0, 40)
            TabButton.Text = tabName
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            TabButton.Parent = MainFrame
            
            TabFrame.Size = UDim2.new(1, 0, 1, -40)
            TabFrame.Position = UDim2.new(0, 0, 0, 40)
            TabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            TabFrame.Visible = false
            TabFrame.Parent = MainFrame
            
            TabButton.MouseEnter:Connect(function()
                Tween(TabButton, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}, 0.2)
            end)
            TabButton.MouseLeave:Connect(function()
                Tween(TabButton, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}, 0.2)
            end)
            
            TabButton.MouseButton1Click:Connect(function()
                for _, v in pairs(MainFrame:GetChildren()) do
                    if v:IsA("Frame") and v ~= TopBar and v ~= MainFrame then
                        v.Visible = false
                    end
                end
                TabFrame.Visible = true
            end)
            
            return {
                Frame = TabFrame,
                AddButton = function(self, buttonText, callback)
                    local Button = Instance.new("TextButton")
                    Button.Size = UDim2.new(0.8, 0, 0, 40)
                    Button.Position = UDim2.new(0.1, 0, 0, 10)
                    Button.Text = buttonText
                    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Button.Parent = TabFrame

                    Button.MouseEnter:Connect(function()
                        Tween(Button, {BackgroundColor3 = Color3.fromRGB(90, 90, 90)}, 0.2)
                    end)
                    Button.MouseLeave:Connect(function()
                        Tween(Button, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.2)
                    end)

                    Button.MouseButton1Click:Connect(callback)
                end,
                AddToggle = function(self, toggleText, callback)
                    local Toggle = Instance.new("TextButton")
                    local IsOn = false
                    
                    Toggle.Size = UDim2.new(0.8, 0, 0, 40)
                    Toggle.Position = UDim2.new(0.1, 0, 0, 60)
                    Toggle.Text = toggleText .. " (OFF)"
                    Toggle.BackgroundColor3 = Color3.fromRGB(100, 60, 60)
                    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Toggle.Parent = TabFrame
                    
                    Toggle.MouseButton1Click:Connect(function()
                        IsOn = not IsOn
                        Toggle.Text = toggleText .. (IsOn and " (ON)" or " (OFF)")
                        Tween(Toggle, {BackgroundColor3 = IsOn and Color3.fromRGB(60, 100, 60) or Color3.fromRGB(100, 60, 60)}, 0.3)
                        callback(IsOn)
                    end)
                end
            }
        end
    }
end

return UILibrary
