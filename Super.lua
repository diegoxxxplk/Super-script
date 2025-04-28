-- BLUE LOCK SCRIPT MOBILE - Feito para diegoxxxplk
local player = game.Players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local skills = replicatedStorage:WaitForChild("Skills")
local soundService = game:GetService("SoundService")

-- Interface
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "BlueLockScriptGUI"

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "BLUE LOCK SCRIPT MOBILE"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

local loadedLabel = Instance.new("TextLabel", mainFrame)
loadedLabel.Size = UDim2.new(1, 0, 0, 30)
loadedLabel.Position = UDim2.new(0, 0, 0, 50)
loadedLabel.BackgroundTransparency = 1
loadedLabel.Text = "✅ Carregado com sucesso!"
loadedLabel.TextColor3 = Color3.new(0, 1, 0)
loadedLabel.Font = Enum.Font.SourceSans
loadedLabel.TextScaled = true

-- Funções
local function activateSkill(skillName)
    local skill = skills:FindFirstChild(skillName)
    if skill then
        skill:FireServer()
    else
        warn("Skill não encontrada: " .. skillName)
    end
end

local function sprintInfinito()
    while true do
        activateSkill("SprintSkill")
        wait(2)
    end
end

local function superChute()
    activateSkill("ShootSkill")
    -- Efeito visual azul
    local explosion = Instance.new("Explosion")
    explosion.Position = player.Character.HumanoidRootPart.Position
    explosion.BlastRadius = 10
    explosion.BlastPressure = 5000
    explosion.ExplosionType = Enum.ExplosionType.NoCraters
    explosion.Parent = workspace
end

local function zantetsuMode()
    while true do
        activateSkill("AccelerationSkill")
        wait(3)
    end
end

local function bachiraMode()
    while true do
        activateSkill("DribbleSkill")
        wait(4)
    end
end

local function autoGoal()
    while true do
        if workspace:FindFirstChild("Ball") then
            local ball = workspace.Ball
            ball.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        end
        wait(1)
    end
end

local musicPlaying = false
local backgroundMusic

local function toggleMusic()
    if not musicPlaying then
        backgroundMusic = Instance.new("Sound", soundService)
        backgroundMusic.SoundId = "rbxassetid://9128579874" -- Música épica
        backgroundMusic.Volume = 0.3
        backgroundMusic.Looped = true
        backgroundMusic:Play()
        musicPlaying = true
    else
        if backgroundMusic then
            backgroundMusic:Destroy()
        end
        musicPlaying = false
    end
end

-- Botões
local buttons = {
    {Name = "Sprint Infinito", Action = sprintInfinito},
    {Name = "Super Chute", Action = superChute},
    {Name = "Modo Zantetsu", Action = zantetsuMode},
    {Name = "Modo Bachira", Action = bachiraMode},
    {Name = "Auto Goal", Action = autoGoal},
    {Name = "Música ON/OFF", Action = toggleMusic}
}

for i, info in ipairs(buttons) do
    local btn = Instance.new("TextButton", mainFrame)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, 90 + (i - 1) * 50)
    btn.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    btn.Text = info.Name
    btn.MouseButton1Click:Connect(function()
        coroutine.wrap(info.Action)()
    end)
end

print("BLUE LOCK SCRIPT MOBILE carregado!")
