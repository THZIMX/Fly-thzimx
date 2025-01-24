-- Fly Script para Roblox (Uso Educacional)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local camera = game.Workspace.CurrentCamera

local flying = false
local speed = 50
local height = 0 -- Inicia com a altura no chão
local bodyGyro, bodyVelocity

local isAnalogPressed = false -- Variável para saber se o analógico está pressionado

-- Função para alternar voo
local function toggleFly()
    flying = not flying
    
    if flying then
        -- Criando os componentes necessários para o voo
        bodyGyro = Instance.new("BodyGyro", humanoidRootPart)
        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.cframe = humanoidRootPart.CFrame
        
        bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
        bodyVelocity.velocity = Vector3.new(0, 0, 0)
        bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
        
    else
        -- Removendo os componentes para parar o voo
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
    end
end

-- Função para mover enquanto voa, controlado pelo analógico
local function moveFly()
    if flying and bodyVelocity and isAnalogPressed then
        local cameraDirection = camera.CFrame.lookVector
        local analogDirection = camera.CFrame.RightVector -- Direção lateral com base na câmera

        -- Combina o movimento com a direção da câmera e a direção do analógico
        local direction = (cameraDirection * speed) + (analogDirection * speed * 0.5) + Vector3.new(0, height, 0)
        bodyVelocity.velocity = direction
    end
end

-- Função para ajustar a altura com base no ângulo da câmera
local function updateHeight()
    if flying and bodyVelocity then
        -- Verifica a rotação da câmera para ajustar a altura
        local cameraAngle = camera.CFrame.LookVector.y
        if cameraAngle > 0 then
            height = speed * 0.5  -- Subir se a câmera estiver olhando para cima
        elseif cameraAngle < 0 then
            height = -speed * 0.5 -- Descer se a câmera estiver olhando para baixo
        else
            height = 0 -- Manter a altura se a câmera estiver reta
        end
    end
end

-- Detecta quando o analógico é pressionado
local function onAnalogPress()
    isAnalogPressed = true
end

-- Detecta quando o analógico é liberado
local function onAnalogRelease()
    isAnalogPressed = false
    if bodyVelocity then
        bodyVelocity.velocity = Vector3.new(0, 0, 0) -- Para o movimento quando o analógico é solto
    end
end

-- Interface Gráfica (Somente o botão de Fly)
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FlyGUI"

-- Botão de Ativar/Desativar Voo
local flyButton = Instance.new("TextButton", gui)
flyButton.Size = UDim2.new(0, 100, 0, 50)
flyButton.Position = UDim2.new(0, 10, 1, -60)
flyButton.Text = "Fly"
flyButton.TextScaled = true

flyButton.MouseButton1Click:Connect(toggleFly)

-- Atualização do movimento e altura
game:GetService("RunService").Heartbeat:Connect(function()
    if flying then
        -- Controla o movimento enquanto o analógico está pressionado
        moveFly()
        -- Controla a altura
        updateHeight()
    end
end)

-- Supondo que o analógico esteja sendo detectado de alguma forma no seu jogo:
-- Use esses métodos para ativar/desativar o movimento no analógico (modifique conforme necessário no seu jogo)
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Touch then
        onAnalogPress() -- Ativa o movimento no analógico quando pressionado
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        onAnalogRelease() -- Desativa o movimento no analógico quando solto
    end
end)
