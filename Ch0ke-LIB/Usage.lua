local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/TIXU-RAMP/T/refs/heads/main/Ch0ke-LIB/CODE.lua"))()


		MAINTTL = "TIXU HUB" 

local win = VLib:Window("THREE PIECE", Color3.fromRGB(196, 40, 28))

local ss1 = win:Tab("Main!")
local ss = win:Tab("Attacks")
local sss = win:Tab("Teleports")
local cred = win:Tab("Emotes")


--//ATTACKS\\--
 ss:Toggle("Auto Farm",function(t)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local function getNearestPlayer()
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

local function teleportBehindTarget()
    local target = getNearestPlayer()
    if target and target.Character then
        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
        if targetHRP then
            local behindPosition = targetHRP.Position - (targetHRP.CFrame.LookVector * 3)
            hrp.CFrame = CFrame.new(behindPosition, targetHRP.Position)
        end
    end
end

while wait(000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000.1) do
    teleportBehindTarget()
end

end)
--//TELEPORTS\\--
sss:Button("Death Counter", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if character then
        character:MoveTo(Vector3.new(1064.5374755859375, 131.3507080078125, 23007.78125)
    end
end)

sss:Button("Atomic Ball", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if character then
        character:MoveTo(Vector3.new(-64.56, 29.25, 20336.39))
    end
end)

sss:Button("Death Counter", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if character then
        character:MoveTo(Vector3.new(-64.56, 29.25, 20336.39))
    end
end)

sss:Button("Death Counter", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if character then
        character:MoveTo(Vector3.new(-64.56, 29.25, 20336.39))
    end
end)

sss:Button("Death Counter", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if character then
        character:MoveTo(Vector3.new(-64.56, 29.25, 20336.39))
    end
end)

sss:Button("Death Counter", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if character then
        character:MoveTo(Vector3.new(-64.56, 29.25, 20336.39))
    end
end)

sss:Button("Death Counter", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if character then
        character:MoveTo(Vector3.new(-64.56, 29.25, 20336.39))
    end
end)

sss:Button("Death Counter", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if character then
        character:MoveTo(Vector3.new(-64.56, 29.25, 20336.39))
    end
end)

sss:Button("Death Counter", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    if character then
        character:MoveTo(Vector3.new(-64.56, 29.25, 20336.39))
    end
end)
--//EMOTE\\--
sss:Button("Death Counter", function()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(Instance.new("Animation", game.Players.LocalPlayer.Character):SetAttribute("AnimationId", "rbxassetid://113876851900426")):Play()
end)

sss:Button("Death Counter", function()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(Instance.new("Animation", game.Players.LocalPlayer.Character):SetAttribute("AnimationId", "rbxassetid://113876851900426")):Play()
end)

sss:Button("Death Counter", function()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(Instance.new("Animation", game.Players.LocalPlayer.Character):SetAttribute("AnimationId", "rbxassetid://113876851900426")):Play()
end)

sss:Button("Death Counter", function()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(Instance.new("Animation", game.Players.LocalPlayer.Character):SetAttribute("AnimationId", "rbxassetid://113876851900426")):Play()
end)

sss:Button("Death Counter", function()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(Instance.new("Animation", game.Players.LocalPlayer.Character):SetAttribute("AnimationId", "rbxassetid://113876851900426")):Play()
end)

sss:Button("Death Counter", function()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(Instance.new("Animation", game.Players.LocalPlayer.Character):SetAttribute("AnimationId", "rbxassetid://113876851900426")):Play()
end)

sss:Button("Death Counter", function()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(Instance.new("Animation", game.Players.LocalPlayer.Character):SetAttribute("AnimationId", "rbxassetid://113876851900426")):Play()
end)

sss:Button("Death Counter", function()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(Instance.new("Animation", game.Players.LocalPlayer.Character):SetAttribute("AnimationId", "rbxassetid://113876851900426")):Play()
end)
