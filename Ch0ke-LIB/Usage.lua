local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/TIXU-RAMP/T/refs/heads/main/Ch0ke-LIB/CODE.lua"))()

MAINTTL = "TIXU HUB"
local win = VLib:Window("VERSION X1", Color3.fromRGB(196, 40, 28))

local ss1 = win:Tab("Main!")
local ss = win:Tab("Attacks")
local sss = win:Tab("Teleports")
local cred = win:Tab("Emotes")

sss:Dropdown("Get nearest player username and copy", {}, function()
    local nearestPlayer = nil
    local shortestDistance = math.huge  -- Set to a very high number to find the minimum

    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end

    if nearestPlayer then
        -- Copy the nearest player's username
        setclipboard(nearestPlayer.Name)
    end
end)
