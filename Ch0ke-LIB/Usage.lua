local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/TIXU-RAMP/T/refs/heads/main/Ch0ke-LIB/Code.lua"))()

local myWindow = library:CreateWindow("🔥 ROBLOX is life 🗣️")

myWindow:AddButton("FAGGOT🤡", function()
    print("✅️U BECAME A FAT FAGGOT✅️")
end)

myWindow:AddLabel("UR SO FUCKING FAT🖕!")

myWindow:AddToggleWithSubtitle("KILL UR SELF", "NONE LIKES U.", function(state)
    print("Gambling Mode:", state)
end)

myWindow:AddTextBoxWithSubtitle("📜 Enter your name", "Type your name here", function(text)
    print("Name entered:", text)
end)

-- Fly Function
local function toggleFly()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/lilmond/roblox_fly_script/main/latest.lua'))()
end

myWindow:AddButton("🕊️ Toggle Fly", function()
    toggleFly()
end)

-- Speed Boost
local function speedBoost()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 50
    end
end

myWindow:AddButton("⚡ Speed Boost", function()
    speedBoost()
end)

-- Simple VFX Effect
local function addParticleEffect()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local char = player.Character
        local particle = Instance.new("ParticleEmitter")
        particle.Texture = "rbxassetid://24362244" -- Change to your desired texture
        particle.Rate = 90999999999
        particle.Lifetime = NumberRange.new(1, 2)
        particle.Parent = char:FindFirstChild("HumanoidRootPart")
    end
end

myWindow:AddButton("✨ Add VFX", function()
    addParticleEffect()
end)

