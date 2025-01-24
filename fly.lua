-- Fly Script com Painel de Controle e Botão "TH"

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 50
local bodyGyro, bodyVelocity

-- Função para alternar voo
local function toggleFly()
    flying = not flying

    if flying then
        bodyGyro = Instance.new("BodyGyro", humanoidRootPart)
        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.cframe = humanoidRootPart.CFrame
        
        bodyVelocity = Instance.new("BodyVelocity", humanoidRootPart)
        bodyVelocity.velocity = Vector3.new(0, 0, 0)
        bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
    else
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
    end
end

-- Função para mover enquanto voa
local function moveFly(direction)
    if flying and bodyVelocity then
        bodyVelocity.velocity = direction * speed
    end
end

-- Criando a GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FlyPanelGUI"

-- Painel de Controle
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0, 200, 0, 300)
panel.Position = UDim2.new(0.5, -100, 0.5, -150)
panel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
panel.Visible = false -- Inicialmente invisível

-- Nome do Painel
local panelTitle = Instance.new("TextLabel", panel)
panelTitle.Size = UDim2.new(0, 200, 0, 40)
panelTitle.Position = UDim2.new(0, 0, 0, 0)
panelTitle.Text = "Fly thzimx"
panelTitle.TextScaled = true
panelTitle.BackgroundTransparency = 1
panelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Botão para abrir/fechar o painel
local togglePanelButton = Instance.new("TextButton", gui)
togglePanelButton.Size = UDim2.new(0, 100, 0, 50)
togglePanelButton.Position = UDim2.new(0, 10, 1, -60)
togglePanelButton.Text = "Abrir Painel"
togglePanelButton.TextScaled = true

togglePanelButton.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible  -- Alterna a visibilidade do painel
end)

-- Botão de Ativar/Desativar Fly com texto "TH"
local flyButton = Instance.new("TextButton", panel)
flyButton.Size = UDim2.new(0, 180, 0, 50)
flyButton.Position = UDim2.new(0, 10, 0, 50)
flyButton.Text = "TH"  -- Texto "TH" no botão
flyButton.TextScaled = true
flyButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Fundo branco do botão
flyButton.MouseButton1Click:Connect(toggleFly)

-- Botões de Movimento
local directions = {
    {Name = "Forward", Direction = Vector3.new(0, 0, -1), Position = UDim2.new(0.5, -50, 0.6, -50)},
    {Name = "Backward", Direction = Vector3.new(0, 0, 1), Position = UDim2.new(0.5, -50, 0.7, -50)},
    {Name = "Left", Direction = Vector3.new(-1, 0, 0), Position = UDim2.new(0.4, -50, 0.65, -50)},
    {Name = "Right", Direction = Vector3.new(1, 0, 0), Position = UDim2.new(0.6, -50, 0.65, -50)},
}

for _, dir in pairs(directions) do
    local button = Instance.new("TextButton", panel)
    button.Name = dir.Name
    button.Size = UDim2.new(0, 80, 0, 50)
    button.Position = dir.Position
    button.Text = dir.Name
    button.TextScaled = true
    
    button.MouseButton1Down:Connect(function()
        moveFly(dir.Direction)
    end)
    
    button.MouseButton1Up:Connect(function()
        moveFly(Vector3.new(0, 0, 0))
    end)
end
