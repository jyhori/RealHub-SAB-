local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

local Window = Rayfield:CreateWindow({
   Name = "Steal a Brainrot | Mega Menu",
   LoadingTitle = "Delta Edition",
   LoadingSubtitle = "by Script Master",
   ConfigurationSaving = { Enabled = true, FileName = "BrainrotConfig" }
})

local MainTab = Window:CreateTab("Main", 4483362458) -- Иконка

-- Функция Noclip
local Noclipping = nil
MainTab:CreateToggle({
   Name = "Noclip (Сквозь стены)",
   CurrentValue = false,
   Callback = function(Value)
       if Value then
           Noclipping = game:GetService("RunService").Stepped:Connect(function()
               if game.Players.LocalPlayer.Character then
                   for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                       if v:IsA("BasePart") then v.CanCollide = false end
                   end
               end
           end)
       else
           if Noclipping then Noclipping:Disconnect() end
       end
   end,
})

-- Скорость и Прыжок
MainTab:CreateSlider({
   Name = "WalkSpeed (Скорость)",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value end,
})

-- Бесконечный прыжок
game:GetService("UserInputService").JumpRequest:Connect(function()
    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
end)

local FarmTab = Window:CreateTab("Auto-Farm", 4483362458)

FarmTab:CreateButton({
   Name = "Instant Steal (Мгновенный кража)",
   Callback = function()
       -- Логика зависит от удаленного события (RemoteEvent) в игре
       print("Steal Activated")
       -- Пример: game:GetService("ReplicatedStorage").Events.Steal:FireServer()
   end,
})

local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateButton({
   Name = "Server Hop (Смена сервера)",
   Callback = function()
       local ts = game:GetService("TeleportService")
       local p = game.Players.LocalPlayer
       ts:Teleport(game.PlaceId, p)
   end,
})

Rayfield:Notify({ Title = "Готово!", Content = "Скрипт успешно запущен на Delta", Duration = 5 })
