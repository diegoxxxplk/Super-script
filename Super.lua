-- Super Menu Mobile
local player = game.Players.LocalPlayer

-- Interface
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", screenGui)
frame.Position = UDim2.new(0.35, 0, 0.3, 0)
frame.Size = UDim2.new(0.3, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 5
frame.BorderColor3 = Color3.fromRGB(255, 255, 255)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0.2, 0)
title.BackgroundTransparency = 1
title.Text = "Super Menu"
title.Font = Enum.Font.FredokaOne
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Função botão
local function criarBotao(text, posY, func)
    local button = Instance.new("TextButton", frame)
    button.Size = UDim2.new(0.8, 0, 0.15, 0)
    button.Position = UDim2.new(0.1, 0, posY, 0)
    button.BackgroundColor3 = Color3.fromRGB(0, 60, 255)
    button.Text = text
    button.Font = Enum.Font.FredokaOne
    button.TextScaled = true
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.MouseButton1Click:Connect(func)
end

-- Ultimate infinita (botão)
local ultimateAtivado = false
criarBotao("Ultimate Infinita", 0.25, function()
    ultimateAtivado = not ultimateAtivado
    if ultimateAtivado then
        while ultimateAtivado do
            local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 32
                humanoid.JumpPower = 100
            end
            task.wait(1)
        end
    else
        if player.Character then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
                humanoid.JumpPower = 50
            end
        end
    end
end)

-- Música épica (botão)
local musicaAtivada = false
local sound
criarBotao("Música Épica", 0.45, function()
    musicaAtivada = not musicaAtivada
    if musicaAtivada then
        sound = Instance.new("Sound", workspace)
        sound.SoundId = "rbxassetid://1837635128" -- Link da música (pode mudar depois)
        sound.Volume = 2
        sound.Looped = true
        sound:Play()
    else
        if sound then
            sound:Stop()
            sound:Destroy()
        end
    end
end)

-- Super chute + explosão azul
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.ButtonR2 or input.UserInputType == Enum.UserInputType.Touch then
        local ball = workspace:FindFirstChild("SoccerBall") or workspace:FindFirstChild("Ball")
        if ball and (ball.Position - player.Character.HumanoidRootPart.Position).Magnitude < 10 then
            ball.Velocity = (ball.Position - player.Character.HumanoidRootPart.Position).unit * 300
            -- Efeito explosão azul
            local explosion = Instance.new("Explosion")
            explosion.Position = ball.Position
            explosion.BlastPressure = 0
            explosion.BlastRadius = 5
            explosion.ExplosionType = Enum.ExplosionType.NoCraters
            explosion.Parent = workspace
            explosion.Visible = true
        end
    end
end)

-- Sprint infinito
task.spawn(function()
    while task.wait(0.5) do
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 25
        end
    end
end)

-- Drible automático
task.spawn(function()
    while task.wait(3) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(20), 0)
        end
    end
end)

-- Roubo de bola automático
task.spawn(function()
    while task.wait(1) do
        local ball = workspace:FindFirstChild("SoccerBall") or workspace:FindFirstChild("Ball")
        if ball and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if (ball.Position - player.Character.HumanoidRootPart.Position).Magnitude < 5 then
                ball.CFrame = player.Character.HumanoidRootPart.CFrame
            end
        end
    end
end)

print("Super Menu carregado!")
