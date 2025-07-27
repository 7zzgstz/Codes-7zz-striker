local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local codes = {
    "SORRYFORTHESHUTDOWN",
    "UPDATEHALF",
    "TOBITO",
    "THANKSFORALLTHESUPPORT",
    "THANKSFOR30KLIKES",
    "THANKSFOR20KLIKES",
    "15KCCU",
    "THANKSFOR20K",
    "RELEASE",
}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CodesUI"
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(0, 85, 255) -- azul forte
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local useAllBtn = Instance.new("TextButton")
useAllBtn.Size = UDim2.new(0, 160, 0, 35)
useAllBtn.Position = UDim2.new(0.5, -80, 0.6, 0) -- botão mais afastado para cima
useAllBtn.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- rosa
useAllBtn.TextColor3 = Color3.new(1, 1, 1)
useAllBtn.Font = Enum.Font.SourceSansBold
useAllBtn.TextSize = 18
useAllBtn.Text = "Resgatar todos os códigos"
useAllBtn.Parent = frame

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 25)
footer.Position = UDim2.new(0, 0, 1, -30)
footer.BackgroundTransparency = 1
footer.TextColor3 = Color3.fromRGB(255, 105, 180)
footer.Font = Enum.Font.SourceSansBold
footer.TextSize = 16
footer.Text = "Sdds Nath"
footer.Parent = frame

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
