local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/TIXU-RAMP/T/refs/heads/main/Ch0ke-LIB/CODE.lua"))()

MAINTTL = "TIXU HUB"
local win = VLib:Window("VERSION X1", Color3.fromRGB(196, 40, 28))

local ss1 = win:Tab("Main!")
local ss = win:Tab("Attacks")
local sss = win:Tab("Teleports")
local cred = win:Tab("Emotes")

local spamEnabled = false
local teleportDistance = 3
local teleportDelay = 000000000000000000000000000000000000000000000000000000000000000000000000000000000.1

-- Function to fire server events (left click)
local function fireServer(args)
    game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))
end

-- Function to simulate left-click
local function leftClick()
    local args1 = {
        [1] = {
            ["Mobile"] = true,
            ["Goal"] = "LeftClick"
        }
    }
    fireServer(args1)
    wait(000000000000000000000000000000000000000000000000000000000000000000000000000000000.1)

    local args2 = {
        [1] = {
            ["Goal"] = "LeftClickRelease",
            ["Mobile"] = true
        }
    }
    fireServer(args2)
end

-- Function to simulate key press (1, 2, 3, 4, G)
local function sendKeyEvent(isPressed, key)
    local VIM = game:GetService('VirtualInputManager')
    VIM:SendKeyEvent(isPressed, key, false, game)
end

-- Function to get the nearest player
local function getNearestPlayer()
    local player = game.Players.LocalPlayer
    local hrp = player.Character and player.Character:WaitForChild("HumanoidRootPart")
    local nearestPlayer = nil
    local shortestDistance = math.huge

    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (hrp.Position - otherPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = otherPlayer
            end
        end
    end

    return nearestPlayer
end

-- Teleport behind nearest player
local function teleportBehindTarget()
    local target = getNearestPlayer()
    if target and target.Character then
        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP then
            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
            local behindPosition = targetHRP.Position - (targetHRP.CFrame.LookVector * teleportDistance)
            hrp.CFrame = CFrame.new(behindPosition, targetHRP.Position)
        end
    end
end

-- Toggle for spamming left-click, keys, and teleporting
ss:Toggle("AUTO FARM", function(t)
    spamEnabled = t
    if spamEnabled then
        task.spawn(function()
            while spamEnabled 
                leftClick()
                teleportBehindTarget()

                sendKeyEvent(true, Enum.KeyCode.One)
                sendKeyEvent(true, Enum.KeyCode.Two)
                sendKeyEvent(true, Enum.KeyCode.Three)
                sendKeyEvent(true, Enum.KeyCode.Four)
                sendKeyEvent(true, Enum.KeyCode.G)

                sendKeyEvent(false, Enum.KeyCode.One)
                sendKeyEvent(false, Enum.KeyCode.Two)
                sendKeyEvent(false, Enum.KeyCode.Three)
                sendKeyEvent(false, Enum.KeyCode.Four)
                sendKeyEvent(false, Enum.KeyCode.G)

                task.wait(teleportDelay)
            end
        end)
    end
end)

ss:Label(" The auto farm maybe choppy")

sss:Dropdown("Teleport to Player", {}, function(choice)  
    local player = game.Players:FindFirstChild(choice)  
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then  
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame  
    end  
end)

game.Players.PlayerAdded:Connect(function(player)  
    sss:UpdateDropdown("Teleport to Player", game.Players:GetPlayers())  
end)  

game.Players.PlayerRemoving:Connect(function(player)  
    sss:UpdateDropdown("Teleport to Player", game.Players:GetPlayers())  
end)  
