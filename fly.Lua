-- Fly Script para Roblox (Uso Educacional)
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

-- Interface Gráfica (Botões para Mobile)
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FlyGUI"

-- Botão de Ativar/Desativar Voo
local flyButton = Instance.new("TextButton", gui)
flyButton.Size = UDim2.new(0, 100, 0, 50)
flyButton.Position = UDim2.new(0, 10, 1, -60)
flyButton.Text = "Fly"
flyButton.TextScaled = true

flyButton.MouseButton1Click:Connect(toggleFly)

-- Botões de Movimento
local directions = {
    {Name = "Forward", Direction = Vector3.new(0, 0, -1), Position = UDim2.new(0.5, -50, 0.8, -50)},
    {Name = "Backward", Direction = Vector3.new(0, 0, 1), Position = UDim2.new(0.5, -50, 0.9, -50)},
    {Name = "Left", Direction = Vector3.new(-1, 0, 0), Position = UDim2.new(0.4, -50, 0.85, -50)},
    {Name = "Right", Direction = Vector3.new(1, 0, 0), Position = UDim2.new(0.6, -50, 0.85, -50)},
}

for _, dir in pairs(directions) do
    local button = Instance.new("TextButton", gui)
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
