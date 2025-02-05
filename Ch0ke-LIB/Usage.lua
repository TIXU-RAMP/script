local VLib = loadstring(game:HttpGet("https://pastebin.com/raw/Mb49kKTP"))()

local win = VLib:Window("THREE PIECE", Color3.fromRGB(196, 40, 28))

local ss1 = win:Tab("HOW TO USE")
local ss = win:Tab("MAIN")
local sss = win:Tab("MISC")
local cred = win:Tab("CREDITS")

ss1:Button("Show Instructions", function()
    print("Here are the instructions: ...") -- Replace with actual instructions
end)

ss:Button("Equip Tool", function()
    print("Equipping tool...") -- Replace with logic to equip a tool
end)

sss:Button("Spam Skill C", function()
    print("Spamming skill C...") -- Replace with logic to spam skill C
end)

cred:Button("Open Discord", function()
    setclipboard("paste your discord link here") -- Replace with actual Discord link
end)
