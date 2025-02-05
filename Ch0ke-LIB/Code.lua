local library = {}
local uis, ts, rs, plr = game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("RunService"), game:GetService("Players").LocalPlayer
local coreGui = game:GetService("CoreGui")
local guiName = "Fevber Hub v2"
if coreGui:FindFirstChild(guiName) then coreGui:FindFirstChild(guiName):Destroy() end
local sg, rnd = Instance.new("ScreenGui"), Random.new()

local function chaosColor()
    return Color3.fromRGB(rnd:NextInteger(0, 255), rnd:NextInteger(0, 255), rnd:NextInteger(0, 255))
end

sg.Name, sg.Parent = guiName, coreGui

local function createTween(obj, props, t)
    local tw = ts:Create(obj, TweenInfo.new(t, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), props)
    tw:Play()
end

local function recursiveUpdate(frame, depth)
    if depth > 10 then return end
    for _, child in pairs(frame:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") then
            createTween(child, {BackgroundColor3 = chaosColor()}, 0.5)
            recursiveUpdate(child, depth + 1)
        end
    end
end

local windows, dragMeta = {}, {}

function library:CreateWindow(title)
    local win, header, content, dragging = Instance.new("Frame"), Instance.new("Frame"), Instance.new("ScrollingFrame"), false
    local pos = UDim2.new(0, rnd:NextInteger(50, 500), 0, rnd:NextInteger(50, 400))
    
    win.Size, win.Position, win.BackgroundColor3 = UDim2.new(0, 250, 0, 40), pos, chaosColor()
    win.Parent, win.BorderSizePixel = sg, 0

    header.Size, header.BackgroundColor3 = UDim2.new(1, 0, 0, 40), chaosColor()
    header.Parent = win

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size, titleLabel.Text, titleLabel.Font = UDim2.new(1, -50, 1, 0), title or "UNKNOWN", Enum.Font.SourceSansBold
    titleLabel.TextSize, titleLabel.TextColor3, titleLabel.Parent = 20, Color3.new(1, 1, 1), header

    content.Size, content.Position, content.Parent = UDim2.new(1, 0, 1, -40), UDim2.new(0, 0, 0, 40), win
    content.BackgroundTransparency, content.CanvasSize, content.BorderSizePixel = 1, UDim2.new(0, 0, 0, 0), 0
    content.ScrollBarThickness = 5

    local layout = Instance.new("UIListLayout")
    layout.Parent = content

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            local offset = input.Position - win.Position
            rs.RenderStepped:Connect(function()
                if dragging then win.Position = UDim2.new(0, uis:GetMouseLocation().X - offset.X, 0, uis:GetMouseLocation().Y - offset.Y) end
            end)
        end
    end)
    
    header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    local windowFuncs = setmetatable({}, {
        __index = function(t, k)
            return function(...)
                if k == "AddLabel" then
                    local txt = Instance.new("TextLabel")
                    txt.Text, txt.Size, txt.Parent = ... or "LABEL", UDim2.new(1, -10, 0, 30), content
                    txt.BackgroundColor3, txt.TextColor3 = chaosColor(), Color3.new(1, 1, 1)
                    recursiveUpdate(txt, 0)
                elseif k == "AddButton" then
                    local btn, cb = Instance.new("TextButton"), select(2, ...)
                    btn.Size, btn.Text, btn.Parent = UDim2.new(1, -10, 0, 40), ..., content
                    btn.BackgroundColor3, btn.TextColor3 = chaosColor(), Color3.new(1, 1, 1)
                    btn.MouseButton1Click:Connect(function()
                        recursiveUpdate(win, 0)
                        if cb then cb() end
                    end)
                elseif k == "AddToggleWithSubtitle" then
                    local txt, subt, state, cb = ..., select(2, ...), false, select(3, ...)
                    local toggle, label = Instance.new("TextButton"), Instance.new("TextLabel")
                    toggle.Size, toggle.Parent, toggle.BackgroundColor3 = UDim2.new(1, -10, 0, 40), content, chaosColor()
                    toggle.Text, toggle.TextColor3 = txt, Color3.new(1, 1, 1)
                    label.Size, label.Parent, label.BackgroundTransparency = UDim2.new(1, -10, 0, 20), toggle, 1
                    label.Position, label.Text, label.TextColor3 = UDim2.new(0, 0, 1, 0), subt, Color3.new(0.7, 0.7, 0.7)
                    toggle.MouseButton1Click:Connect(function()
                        state = not state
                        toggle.Text = state and ("[ON] " .. txt) or ("[OFF] " .. txt)
                        if cb then cb(state) end
                    end)
                elseif k == "AddTextBoxWithSubtitle" then
                    local txt, subt, cb = ..., select(2, ...), select(3, ...)
                    local box, label = Instance.new("TextBox"), Instance.new("TextLabel")
                    box.Size, box.Parent, box.BackgroundColor3 = UDim2.new(1, -10, 0, 40), content, chaosColor()
                    box.Text, box.TextColor3 = txt, Color3.new(1, 1, 1)
                    label.Size, label.Parent, label.BackgroundTransparency = UDim2.new(1, -10, 0, 20), box, 1
                    label.Position, label.Text, label.TextColor3 = UDim2.new(0, 0, 1, 0), subt, Color3.new(0.7, 0.7, 0.7)
                    box.FocusLost:Connect(function()
                        if cb then cb(box.Text) end
                    end)
                end
            end
        end,
        __newindex = function() error("Forbidden") end
    })

    table.insert(windows, win)
    return windowFuncs
end

return library
