local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/stysscythe/script/main/LibTest.lua"))()
local Window = Library.Window('KR4K Library')

local Test1 = Window.CreateTab('Welcome!')
local Testw = Window.CreateTab('!')

Test1.CreateDivider("Im a divider!")

Test1.CreateLabel("i love being a label!")

Test1.CreateButton("Click me!", function()
	print("Yay! i got clicked!")
end

Test1.CreateToggle("Print boolean", function(state)
	if state then
		print("Toggled!")
	elseif state == false then
		print("Disabled :(")
	end
end)

Test1.CreateSlider("Print", 0, 50, function(s)
	print(s)
end)

Test1.CreateTextbox("Print Text", function(txt)
	print(txt)
end)

Test1.CreateKeybind("Print on key!", Enum.KeyCode.F, function()
	print("im a keybind!")
end)

Test1.CreateKeybind("Toggle UI", Enum.KeyCode.RightAlt, function()
	Library:ToggleUI()
end)
