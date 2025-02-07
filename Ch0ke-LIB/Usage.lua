local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/TIXU-RAMP/T/refs/heads/main/Ch0ke-LIB/CODE.lua"))()

MAINTTL = "TIXU HUB"

local win = VLib:Window("THREE PIECE", Color3.fromRGB(196, 40, 28))

local ss1 = win:Tab("Main!")
local ss = win:Tab("Attacks")
local sss = win:Tab("Teleports")
local cred = win:Tab("Emotes")

local autoFarmEnabled = false
local teleportDistance = 3
local teleportDelay = 0.1
local randomOffsetRange = 2  -- Max random offset distance

ss:Toggle("Auto Farm", function(t)
    autoFarmEnabled = t
    if autoFarmEnabled then
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
                    local behindPosition = targetHRP.Position - (targetHRP.CFrame.LookVector * teleportDistance)

                    -- Add random X and Z offsets to make the teleport position less predictable
                    local randomOffset = Vector3.new(
                        math.random(-randomOffsetRange, randomOffsetRange),
                        0, 
                        math.random(-randomOffsetRange, randomOffsetRange)
                    )

                    hrp.CFrame = CFrame.new(behindPosition + randomOffset, targetHRP.Position)
                end
            end
        end

        task.spawn(function()
            while autoFarmEnabled do
                teleportBehindTarget()
                task.wait(teleportDelay)
            end
        end)
    end
end)

ss:Textbox("Auto Farm Distance", function(value)
    local num = tonumber(value)
    if num and num > 0 then
        teleportDistance = num
    end
end)

ss:Textbox("Random Offset Range", function(value)
    local num = tonumber(value)
    if num and num >= 0 then
        randomOffsetRange = num
    end
end)
