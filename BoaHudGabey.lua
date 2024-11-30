-- OrionLib Integration for Gabe&Snicks BOA Cult
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Gabe&Snicks BOA Cult",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "OrionConfig"
})

-- Load Scripts
local gabeBoa = loadstring(game:HttpGet("https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/GabeBOA2.lua"))()
local BoaTeleports = loadstring(game:HttpGet("https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/TeleportPlaces.lua"))()
local InfiniteYield = loadstring(game:HttpGet("https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/InfiniteYield.lua"))()
local Powers = loadstring(game:HttpGet("https://raw.githubusercontent.com/Melharper/GabeBoa2/refs/heads/main/Powers.lua"))()

-- Auto-Farming Tab
local farmingTab = Window:MakeTab({
    Name = "Gabe Boa Farming",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

farmingTab:AddToggle({
    Name = "Enable Auto-BOA Farming",
    Default = false,
    Callback = function(value)
        if value then
            gabeBoa.enableFarming()
        else
            gabeBoa.disableFarming()
        end
    end
})

-- Boa Teleports Tab
local teleportTab = Window:MakeTab({
    Name = "Boa Teleports",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local teleportLocations = {
    "Powerstone BOA",
    "Arena BOA",
    "BOA By The Beach",
    "Gabe’s Got Candy",
    "Back Of The Bus Gabe",
    "Gabe on Display",
    "Idk Found White Visions Cape",
    "Inside Omega Building",
    "BOA Urself Up",
    "Gabe&Snicks XXX spot"
}

for _, location in ipairs(teleportLocations) do
    teleportTab:AddButton({
        Name = location,
        Callback = function()
            BoaTeleports.teleportTo(location)
        end
    })
end

-- Powers Tab
local powersTab = Window:MakeTab({
    Name = "Powers",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

powersTab:AddButton({
    Name = "Woman's Mace",
    Callback = function()
        Powers.womansMace()
    end
})

-- Infinite Yield Tab
local adminTab = Window:MakeTab({
    Name = "Infinite Yield",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

adminTab:AddButton({
    Name = "BOA Admin",
    Callback = function()
        InfiniteYield.load()
    end
})

-- Play the whitelisted sound
local function playWhitelistedSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://8196319469"
    sound.Volume = 10
    sound.Parent = game.Workspace
    sound:Play()

    -- Stop the sound after 4 seconds
    wait(4)
    sound:Stop()

    -- Additional sound for whitelisted users
    local additionalSound = Instance.new("Sound")
    additionalSound.SoundId = "rbxassetid://9656754733"
    additionalSound.Volume = 10
    additionalSound.Parent = game.Workspace
    additionalSound:Play()
end

-- Function to show the GUI message for whitelisted users
local function showWhitelistedGui()
    local gui = Instance.new("ScreenGui")
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local label = Instance.new("TextLabel")
    label.Parent = gui
    label.Text = "YOUR A BOA OG WHITELISTED USER"
    label.Size = UDim2.new(0.8, 0, 0.2, 0)
    label.Position = UDim2.new(0.1, 0, 0.4, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Chaos Red color
    label.Font = Enum.Font.FredokaOne
    label.TextScaled = true
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.TextStrokeTransparency = 0

    -- Simulate the blood drip effect by moving the text down slowly
    local dripTime = 0.1
    for i = 1, 10 do
        label.Position = label.Position + UDim2.new(0, 0, 0.05, 0)
        wait(dripTime)
    end

    -- Animate the Label to Shake
    local runService = game:GetService("RunService")
    local amplitude = 5
    local frequency = 50

    local connection
    connection = runService.RenderStepped:Connect(function(deltaTime)
        local xOffset = math.random(-amplitude, amplitude)
        local yOffset = math.random(-amplitude, amplitude)
        label.Position = UDim2.new(0.1, xOffset, 0.4, yOffset)
        wait(0.02) -- Smooth shaking
    end)

    -- Stop shaking after 8 seconds and destroy the GUI
    task.delay(8, function()
        connection:Disconnect()
        gui:Destroy()
    end)
end

-- Run the initial parts when the script is executed
playWhitelistedSound()  -- Play the sounds
showWhitelistedGui()  -- Show the GUI message

-- Initialize OrionLib
OrionLib:Init()
