-- Load the Ramp-LIB library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/TIXU-RAMP/T/refs/heads/main/Ramp-LIB/CODE"))()

-- Create a tab using the library (since there's no CreateWindow)
local myTab = Library:Tab("🔥 ROBLOX is life 🗣️")

-- Add a button to the tab
myTab:Button("🚀 Click Me", function()
    print("Button Clicked!")
end)

-- Add a label to the tab
myTab:Label("🎉 Welcome to the game!")

-- Add a toggle with subtitle to the tab
myTab:Toggle("🎲 Gambling Mode", function(state)
    print("Gambling Mode:", state)
end)

-- Add a text box with subtitle to the tab
myTab:TextBox("📜 Enter your name", function(text)
    print("Name entered:", text)
end)

-- Fly Function
local function toggleFly()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/lilmond/roblox_fly_script/main/latest.lua'))()
end

-- Add a button to toggle fly
myTab:Button("🕊️ Toggle Fly", function()
    toggleFly()
end)

-- Speed Boost
local function speedBoost()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 50
    end
end

-- Add a button to apply speed boost
myTab:Button("⚡ Speed Boost", function()
    speedBoost()
end)

-- Simple VFX Effect
local function addParticleEffect()
    local player = game.Players.LocalPlayer
    if player and player.Character then
        local char = player.Character
        local particle = Instance.new("ParticleEmitter")
        particle.Texture = "rbxassetid://24362244" -- Change to your desired texture
        particle.Rate = 50
        particle.Lifetime = NumberRange.new(1, 2)
        particle.Parent = char:FindFirstChild("HumanoidRootPart")
    end
end

-- Add a button to trigger particle effects
myTab:Button("✨ Add VFX", function()
    addParticleEffect()
end)
