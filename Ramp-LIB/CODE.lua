local Library = {}
local UILib = Instance.new("ScreenGui")
local TabXPosition = 30
UILib.Name = "UILib"
UILib.Parent = game:GetService("CoreGui")
UILib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function createInstance(class, properties)
    local instance = Instance.new(class)
    for prop, value in pairs(properties) do
        instance[prop] = value
    end
    return instance
end

local function dragify(Frame)
    local dragToggle, dragInput, dragStart, startPos, Delta, Position
    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true
            dragStart = input.Position
            startPos = Frame.Position
        end
    end)

    Frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragToggle then
            Delta = input.Position - dragStart
            Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
            game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.15), {Position = Position}):Play()
        end
    end)
end

function Library:Tab(name)
    local Tab = createInstance("TextLabel", {
        Name = name,
        Parent = UILib,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
        Position = UDim2.new(0, TabXPosition, 0, 30),
        Size = UDim2.new(0, 120, 0, 20),
        Font = Enum.Font.SciFi,
        Text = name,
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 14,
    })
    TabXPosition = TabXPosition + 130
    dragify(Tab)

    local TabFrame = createInstance("Frame", {
        Name = "TabFrame",
        Parent = Tab,
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 20),
        Size = UDim2.new(0, 120, 0, 0),
    })

    local ButtonListLayout = createInstance("UIListLayout", {
        Parent = TabFrame,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    local TabLibrary = {}

    function TabLibrary:Button(text, func)
        local Button = createInstance("TextButton", {
            Name = text,
            Parent = TabFrame,
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            BorderSizePixel = 0,
            Size = UDim2.new(0, 120, 0, 20),
            Font = Enum.Font.SciFi,
            Text = " " .. text,
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = 14,
        })
        Button.MouseButton1Click:Connect(func)
        Button.TouchTap:Connect(func) -- Added support for mobile touch input
    end

    function TabLibrary:DropDown(text, drops, func)
        local DropDownButton = createInstance("TextButton", {
            Name = text,
            Parent = TabFrame,
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            BorderSizePixel = 0,
            Size = UDim2.new(0, 120, 0, 20),
            Font = Enum.Font.SciFi,
            Text = text,
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = 14,
        })

        local DropDownFrame = createInstance("Frame", {
            Name = "DropDownFrame",
            Parent = DropDownButton,
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 20),
            Size = UDim2.new(0, 120, 0, 0),
        })

        local DropDownListLayout = createInstance("UIListLayout", {
            Parent = DropDownFrame,
            SortOrder = Enum.SortOrder.LayoutOrder,
        })

        local DropDownOpened = false
        DropDownButton.MouseButton1Click:Connect(function()
            DropDownOpened = not DropDownOpened
            local targetSize = DropDownOpened and UDim2.new(0, 120, 0, #drops * 20) or UDim2.new(0, 120, 0, 0)
            DropDownFrame:TweenSize(targetSize, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.25, true)
            
            for _, v in pairs(DropDownFrame:GetChildren()) do
                if v:IsA("TextButton") then
                    v.Visible = DropDownOpened
                end
            end
        end)

        for _, v in pairs(drops) do
            local DropButton = createInstance("TextButton", {
                Name = v,
                Parent = DropDownFrame,
                BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                BorderSizePixel = 0,
                Size = UDim2.new(0, 120, 0, 20),
                Font = Enum.Font.SciFi,
                Text = " " .. v,
                TextColor3 = Color3.new(1, 1, 1),
                TextSize = 14,
            })
            DropButton.MouseButton1Click:Connect(function()
                DropDownFrame:TweenSize(UDim2.new(0, 120, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.25, true)
                func(v)
            end)
            DropButton.TouchTap:Connect(function()  -- Added for mobile support
                DropDownFrame:TweenSize(UDim2.new(0, 120, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.25, true)
                func(v)
            end)
        end
    end

    function TabLibrary:Label(name, text)
        local Label = createInstance("TextLabel", {
            Name = name,
            Parent = TabFrame,
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            BorderSizePixel = 0,
            Size = UDim2.new(0, 120, 0, 20),
            Font = Enum.Font.SciFi,
            Text = " " .. text,
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = 14,
        })
    end

    function TabLibrary:TextBox(text, func)
        local TextBox = createInstance("TextBox", {
            Name = text,
            Parent = TabFrame,
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            BorderSizePixel = 0,
            Size = UDim2.new(0, 120, 0, 20),
            Font = Enum.Font.SciFi,
            PlaceholderColor3 = Color3.fromRGB(128, 128, 128),
            PlaceholderText = text,
            Text = "",
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = 14,
        })
        TextBox.FocusLost:Connect(function(Enter)
            if Enter then
                func(TextBox.Text)
            end
        end)
    end

    function TabLibrary:Toggle(text, func)
        local ToggleLabel = createInstance("TextLabel", {
            Name = text,
            Parent = TabFrame,
            BackgroundColor3 = Color3.fromRGB(50, 50, 50),
            BorderSizePixel = 0,
            Size = UDim2.new(0, 120, 0, 20),
            Font = Enum.Font.SciFi,
            Text = " " .. text,
            TextColor3 = Color3.new(1, 1, 1),
            TextSize = 14,
        })

        local ToggleButton = createInstance("TextButton", {
            Name = "ToggleButton",
            Parent = ToggleLabel,
            BackgroundColor3 = Color3.new(1, 0, 0),
            Position = UDim2.new(0, 102, 0, 2),
            Size = UDim2.new(0, 16, 0, 16),
            Font = Enum.Font.SourceSans,
            Text = "",
            TextColor3 = Color3.new(0, 0, 0),
            TextSize = 14,
        })

        ToggleButton.MouseButton1Click:Connect(function()
            local isOn = ToggleButton.BackgroundColor3 == Color3.new(0, 1, 0)
            ToggleButton.BackgroundColor3 = isOn and Color3.new(1, 0, 0) or Color3.new(0, 1, 0)
            func(not isOn)
        end)
        ToggleButton.TouchTap:Connect(function() -- Added for mobile support
            local isOn = ToggleButton.BackgroundColor3 == Color3.new(0, 1, 0)
            ToggleButton.BackgroundColor3 = isOn and Color3.new(1, 0, 0) or Color3.new(0, 1, 0)
            func(not isOn)
        end)
    end

    return TabLibrary
end

return Library
