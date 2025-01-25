-- Fly Script com Painel de Abas
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

-- GUI principal
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "FlyPanelGUI"

-- Painel lateral
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0, 200, 0, 300)
panel.Position = UDim2.new(0, 10, 0.5, -150)
panel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
panel.BorderSizePixel = 2

-- Nome do painel
local panelTitle = Instance.new("TextLabel", panel)
panelTitle.Size = UDim2.new(1, 0, 0, 40)
panelTitle.Text = "Fly thzimx"
panelTitle.TextScaled = true
panelTitle.BackgroundTransparency = 1
panelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Botão da aba "Fly"
local flyTab = Instance.new("TextButton", panel)
flyTab.Size = UDim2.new(0, 80, 0, 30)
flyTab.Position = UDim2.new(0, 10, 0, 50)
flyTab.Text = "Fly"
flyTab.TextScaled = true
flyTab.BackgroundColor3 = Color3.fromRGB(100, 100, 255)

-- Botão da aba "Outras Opções"
local otherTab = Instance.new("TextButton", panel)
otherTab.Size = UDim2.new(0, 120, 0, 30)
otherTab.Position = UDim2.new(0, 10, 0, 90)
otherTab.Text = "Outras Opções"
otherTab.TextScaled = true
otherTab.BackgroundColor3 = Color3.fromRGB(100, 255, 100)

-- Conteúdo da aba "Fly"
local flyContent = Instance.new("Frame", panel)
flyContent.Size = UDim2.new(1, -20, 0, 200)
flyContent.Position = UDim2.new(0, 10, 0, 130)
flyContent.BackgroundTransparency = 1
flyContent.Visible = true -- Inicialmente visível

local flyButton = Instance.new("TextButton", flyContent)
flyButton.Size = UDim2.new(1, 0, 0, 50)
flyButton.Position = UDim2.new(0, 0, 0, 0)
flyButton.Text = "Ativar Fly"
flyButton.TextScaled = true
flyButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
flyButton.MouseButton1Click:Connect(toggleFly)

-- Conteúdo da aba "Outras Opções"
local otherContent = Instance.new("Frame", panel)
otherContent.Size = UDim2.new(1, -20, 0, 200)
otherContent.Position = UDim2.new(0, 10, 0, 130)
otherContent.BackgroundTransparency = 1
otherContent.Visible = false -- Inicialmente invisível

local otherLabel = Instance.new("TextLabel", otherContent)
otherLabel.Size = UDim2.new(1, 0, 0, 50)
otherLabel.Position = UDim2.new(0, 0, 0, 0)
otherLabel.Text = "Outros que eu vou colocar no futuro"
otherLabel.TextScaled = true
otherLabel.BackgroundTransparency = 1
otherLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Alternar abas
flyTab.MouseButton1Click:Connect(function()
    flyContent.Visible = true
    otherContent.Visible = false
end)

otherTab.MouseButton1Click:Connect(function()
    flyContent.Visible = false
    otherContent.Visible = true
end)
