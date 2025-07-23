local Players = game:GetService("Players")
local InsertService = game:GetService("InsertService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Códigos para resgatar
local codes = {
    "THANKSFOR30KLIKES",
    "THANKSFOR20KLIKES",
    "ILUVAFS",
    "APOLOGIESFORBUGS",
    "THANKSFOR10KLIKES",
    "THANKSFOR5KLIKES",
    "SORRY4SHUTDOWN",
    "15KCCU",
    "RELEASE",
    "THANKSFOR20K",
    "TRAILER",
}

-- Cria ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CodesUI"
screenGui.Parent = playerGui

-- Cria Frame principal (UI)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 220)
frame.Position = UDim2.new(0.5, -150, 0.5, -110)
frame.BackgroundColor3 = Color3.new(1, 1, 1)
frame.BackgroundTransparency = 1 -- transparente para mostrar ViewportFrame
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- ViewportFrame para mostrar o modelo 3D
local viewport = Instance.new("ViewportFrame")
viewport.Size = UDim2.new(1, 0, 1, 0)
viewport.BackgroundTransparency = 1
viewport.Parent = frame

-- Carrega o modelo 3D "Cachorro 200 reais"
local success, model = pcall(function()
    return InsertService:LoadAsset(10333301952)
end)

if success and model then
    model.Parent = viewport

    if not model.PrimaryPart then
        for _, part in pairs(model:GetChildren()) do
            if part:IsA("BasePart") then
                model.PrimaryPart = part
                break
            end
        end
    end

    if model.PrimaryPart then
        model:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
    end

    -- Cria e posiciona a câmera para o ViewportFrame
    local camera = Instance.new("Camera")
    camera.Parent = viewport
    viewport.CurrentCamera = camera
    camera.CFrame = CFrame.new(Vector3.new(0, 2, 5), Vector3.new(0, 1, 0))
else
    warn("Falha ao carregar o modelo 3D")
end

-- Botão transparente para resgatar códigos
local useAllBtn = Instance.new("TextButton")
useAllBtn.Size = UDim2.new(0, 120, 0, 30)
useAllBtn.Position = UDim2.new(0.5, -60, 0.85, 0)
useAllBtn.BackgroundColor3 = Color3.new(1, 1, 1)
useAllBtn.BackgroundTransparency = 0.7 -- transparente para deixar ver o fundo
useAllBtn.TextColor3 = Color3.new(0, 0, 0)
useAllBtn.Font = Enum.Font.SourceSansBold
useAllBtn.TextSize = 16
useAllBtn.Text = "Resgatar códigos"
useAllBtn.Parent = frame

-- Texto com nome embaixo
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -25)
footer.BackgroundTransparency = 1
footer.TextColor3 = Color3.fromRGB(255, 105, 180)
footer.Font = Enum.Font.SourceSansBold
footer.TextSize = 14
footer.Text = "Sdds Nath"
footer.Parent = frame

-- Botão fechar UI
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
closeButton.TextColor3 = Color3.new(1, 0, 0)
closeButton.Text = "X"
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Função para usar os códigos
useAllBtn.MouseButton1Click:Connect(function()
    for _, code in ipairs(codes) do
        local success, err = pcall(function()
            ReplicatedStorage.Remotes.RemoteFunction:InvokeServer("RedeemCode", code)
        end)
        if success then
            print("Código resgatado: "..code)
        else
            warn("Falha no código: "..code.." - "..tostring(err))
        end
        wait(0.5)
    end
end)
