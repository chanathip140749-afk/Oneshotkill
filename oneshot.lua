spawn(function()
	while task.wait() do
		pcall(function()
			if getgenv().Config["Instant Kill"] then
				local player = game.Players.LocalPlayer
				local character = player.Character or player.CharacterAdded:Wait()
				local humanoid = character:FindFirstChildOfClass("Humanoid")
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
						warn("Not found:", folderName)
						Den = {}
					end
				end

				for _, v in pairs(Den) do
					if v:IsA("Humanoid") and v.Parent and v.Parent:IsA("Model") then
						local model = v.Parent

						-- ✅ Skip your own character or anything inside it
						if model == character or character:IsAncestorOf(model) then
							continue
						end
						-- ✅ Skip any other player characters
						if game.Players:GetPlayerFromCharacter(model) then
							continue
						end

						local hrp = model:FindFirstChild("HumanoidRootPart")
						local chrp = character:FindFirstChild("HumanoidRootPart")
						if hrp and chrp then
							local dist = (hrp.Position - chrp.Position).Magnitude
							if dist <= getgenv().Config["Radius"] and v.Health > 0 then
								task.wait(0.05)
								v.Health = 0
							end
						end
					end
				end
			end
		end)
	end
end)
