-- Códigos
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
    "TRAILER"
}

-- RemoteFunction alvo
local remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RemoteFunction")

-- Criar UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SevenZZ_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- rosa base
Frame.BorderSizePixel = 0
Frame.Name = "MainFrame"
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- Fundo com imagem
local Background = Instance.new("ImageLabel")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0, 0, 0, 0)
Background.BackgroundTransparency = 1
Background.Image = "rbxassetid://111116013305832"
Background.ZIndex = 0
Background.Parent = Frame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "7zz gostoso"
Title.Font = Enum.Font.FredokaOne
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 24
Title.ZIndex = 1
Title.Parent = Frame

-- Botão de fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 150, 200)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.FredokaOne
CloseButton.TextSize = 20
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.ZIndex = 1
CloseButton.Parent = Frame

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Botão de usar códigos
local RedeemButton = Instance.new("TextButton")
RedeemButton.Size = UDim2.new(0.8, 0, 0, 40)
RedeemButton.Position = UDim2.new(0.1, 0, 0.4, 0)
RedeemButton.BackgroundColor3 = Color3.fromRGB(255, 128, 192)
RedeemButton.Text = "Usar todos os códigos"
RedeemButton.Font = Enum.Font.GothamBold
RedeemButton.TextSize = 18
RedeemButton.TextColor3 = Color3.new(1, 1, 1)
RedeemButton.ZIndex = 1
RedeemButton.Parent = Frame

-- Rodapé
local Footer = Instance.new("TextLabel")
Footer.Size = UDim2.new(1, 0, 0, 20)
Footer.Position = UDim2.new(0, 0, 1, -20)
Footer.BackgroundTransparency = 1
Footer.Text = "Sdds Nath"
Footer.Font = Enum.Font.FredokaOne
Footer.TextColor3 = Color3.new(1, 1, 1)
Footer.TextSize = 16
Footer.ZIndex = 1
Footer.Parent = Frame

-- Função de resgatar códigos
local function redeemAll()
    for _, code in ipairs(codes) do
        local success, result = pcall(function()
            return remote:InvokeServer("RedeemCode", code)
        end)

        if success then
            print("[✔] Código resgatado:", code)
        else
            warn("[✖] Falha ao resgatar:", code, result)
        end

        wait(0.5)
    end
end

-- Ação do botão
RedeemButton.MouseButton1Click:Connect(function()
    redeemAll()
end)
