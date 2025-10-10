spawn(function()
    while task.wait() do
        pcall(function()
            if getgenv().Config["Instant Kill"] then
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                sethiddenproperty(player, "SimulationRadius", 112412400000)
                sethiddenproperty(player, "MaxSimulationRadius", 112412400000)
                
                local Den
                local folderName = getgenv().Config["Folder Mon"]

                if folderName == nil or folderName == "" then
                    Den = game.Workspace:GetDescendants()
                else
                    local folder = game.Workspace:FindFirstChild(folderName)
                    if folder then
                        Den = folder:GetDescendants()
                    else
                        warn("⚠️ Folder not found:", folderName)
                        Den = {}
                    end
                end

                for _, v in pairs(Den) do
                    if v:IsA("Humanoid") and v.Parent and v.Parent:IsA("Model") then
                        local MonPoz = v.Parent:FindFirstChild("HumanoidRootPart") and v.Parent.HumanoidRootPart.Position
                        local PlayerPoz = character:FindFirstChild("HumanoidRootPart") and character.HumanoidRootPart.Position
                        
                        if MonPoz and PlayerPoz and (MonPoz - PlayerPoz).Magnitude <= getgenv().Config["Radius"] then
                            if v.Health > 0 and v.Health < v.MaxHealth then
                                task.wait(0.1)
                                v.Health = 0
                            end
                        end
                    end
                end
            end
        end)
    end
end)
