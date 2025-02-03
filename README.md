local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/TIXU-RAMP/T/refs/heads/main/Libary.lua"))()

local myWindow = library:CreateWindow("ROBLOx is life🔥🗣")

myWindow:AddButton("Click Me", function()
    print("Button Clicked!")
end)

myWindow:AddLabel("This is a label.")

myWindow:AddToggleWithSubtitle("🔥", "i like to gamble.", function(state)
    print("Toggle is now:", state)
end)
