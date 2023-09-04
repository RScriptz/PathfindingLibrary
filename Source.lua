local EasyPath = {}

function EasyPath:CreateVisualWaypoint(WaypointPosition, WaypointSize, WaypointColor, WaypointOffset)
	local neonBall = Instance.new("Part")
	neonBall.Size = WaypointSize
	neonBall.Color = WaypointColor
	neonBall.Anchored = true
	neonBall.Shape = "Ball"
	neonBall.CanCollide = false
	neonBall.Material = Enum.Material.Neon
	neonBall.Parent = workspace
	neonBall.Position = WaypointPosition.Position + WaypointOffset
	neonBall.Name = "EasyPath_PathPoint"
end

function EasyPath:CFrameToPart(CFrame)
	local CFramePart = Instance.new("Part")
	CFramePart.Parent = game:GetService("Workspace")
	CFramePart.Name = "EasyPath_CFrameReference"
	CFramePart.CanCollide = false
	CFramePart.CanTouch = false
	CFramePart.Transparency = 1
	CFramePart.CFrame = CFrame
end

function EasyPath:DeleteAllWaypoints()
	for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
		if v.Name == "EasyPath_PathPoint" then
			v:Remove()
		end
	end
end

function EasyPath:WalkToPath(CustomPath)
	local PlayerWalkspeed = tonumber(game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed)
	local WalkToPathfinding = game:GetService("PathfindingService"):CreatePath()

	if typeof(CustomPath.Destination) == "CFrame" then
		EasyPath:CFrameToPart(CustomPath.Destination)
		WalkToPathfinding:ComputeAsync(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, game:GetService("Workspace").EasyPath_CFrameReference.Position + CustomPath.PathOffset)
	elseif typeof(CustomPath.Destination) == "Vector3" then
		WalkToPathfinding:ComputeAsync(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, CustomPath.Destination + CustomPath.PathOffset)
	else
		WalkToPathfinding:ComputeAsync(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, CustomPath.Destination.Position + CustomPath.PathOffset)
	end
	if WalkToPathfinding.Status == Enum.PathStatus.Success then
		if CustomPath.DebugMode == true then
			print("Status: Starting...")
		end
		local WayPoints = WalkToPathfinding:GetWaypoints()
		for i = 1, #WayPoints do
			local point = WayPoints[i]
			if CustomPath.VisualPath == true then
				EasyPath:CreateVisualWaypoint(point, CustomPath.VisualPathSize, CustomPath.VisualPathColor, CustomPath.VisualPathOffset)
			end
			game:GetService("Players").LocalPlayer.Character.Humanoid:MoveTo(point.Position)
			local Success = game:GetService("Players").LocalPlayer.Character.Humanoid.MoveToFinished:Wait()
			if point.Action == Enum.PathWaypointAction.Jump then
				if not CustomPath.StrongAnticheat == true then
					game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = 0
				end
				wait(0.2)
				if not CustomPath.StrongAnticheat == true then
					game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = PlayerWalkspeed
				end
				game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = true
			end
			if not Success then
				if CustomPath.DebugMode == true then
					print("Status: Broke, Trying Again...")
				end
				game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = true
				game:GetService("Players").LocalPlayer.Character.Humanoid:MoveTo(point.Position)
				if not game:GetService("Players").LocalPlayer.Character.Humanoid.MoveToFinished:Wait() then
					break
				end
			else
				if CustomPath.DebugMode == true then
					print("Status: Walking To The Part...")
				end
			end
		end
	else
		if CustomPath.DebugMode == true then
			print("Status: Impossible To Reach Part.")
		end
		return
	end
	if not CustomPath.StrongAnticheat == true then
		game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = 0
	end
	if CustomPath.DebugMode == true then
		print("Status: Got To The Part!")
	end
	if not CustomPath.StrongAnticheat == true then
		game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = PlayerWalkspeed
	end
	if CustomPath.DeletePathWhenDone == true then
		EasyPath:DeleteAllWaypoints()
	end
	if game:GetService("Workspace"):FindFirstChild("EasyPath_CFrameReference") then
		game:GetService("Workspace").EasyPath_CFrameReference:Remove()
	end
end

function EasyPath:WalkToBasicPath(CustomPath)
	local PlayerWalkspeed = tonumber(game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed)
	local WalkToPathfinding = game:GetService("PathfindingService"):CreatePath()

	if typeof(CustomPath.Destination) == "CFrame" then
		EasyPath:CFrameToPart(CustomPath.Destination)
		WalkToPathfinding:ComputeAsync(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, game:GetService("Workspace").EasyPath_CFrameReference.Position + CustomPath.PathOffset)
	elseif typeof(CustomPath.Destination) == "Vector3" then
		WalkToPathfinding:ComputeAsync(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, CustomPath.Destination + CustomPath.PathOffset)
	else
		WalkToPathfinding:ComputeAsync(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, CustomPath.Destination.Position + CustomPath.PathOffset)
	end
	if WalkToPathfinding.Status == Enum.PathStatus.Success then
		if CustomPath.DebugMode == true then
			print("Status: Starting...")
		end
		local WayPoints = WalkToPathfinding:GetWaypoints()
		for i = 1, #WayPoints do
			local point = WayPoints[i]
			game:GetService("Players").LocalPlayer.Character.Humanoid:MoveTo(point.Position)
			local Success = game:GetService("Players").LocalPlayer.Character.Humanoid.MoveToFinished:Wait()
			if point.Action == Enum.PathWaypointAction.Jump then
				if not CustomPath.StrongAnticheat == true then
					game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = 0
				end
				wait(0.2)
				if not CustomPath.StrongAnticheat == true then
					game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = PlayerWalkspeed
				end
				game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = true
			end
			if not Success then
				if CustomPath.DebugMode == true then
					print("Status: Broke, Trying Again...")
				end
				game:GetService("Players").LocalPlayer.Character.Humanoid.Jump = true
				game:GetService("Players").LocalPlayer.Character.Humanoid:MoveTo(point.Position)
				if not game:GetService("Players").LocalPlayer.Character.Humanoid.MoveToFinished:Wait() then
					break
				end
			else
				if CustomPath.DebugMode == true then
					print("Status: Walking To The Part...")
				end
			end
		end
	else
		if CustomPath.DebugMode == true then
			print("Status: Impossible To Reach Part.")
		end
		return
	end
	if not CustomPath.StrongAnticheat == true then
		game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = 0
	end
	if CustomPath.DebugMode == true then
		print("Status: Got To The Part!")
	end
	if not CustomPath.StrongAnticheat == true then
		game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = PlayerWalkspeed
	end
	if game:GetService("Workspace"):FindFirstChild("EasyPath_CFrameReference") then
		game:GetService("Workspace").EasyPath_CFrameReference:Remove()
	end
end

function EasyPath:FinishedPathfinding()
	repeat
		wait()
	until game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") and game:GetService("Players").LocalPlayer.Character.Humanoid.MoveToFinished
	return true
end

function EasyPath:PlayerWalkTo(Destination, Offset)
	repeat 
		wait()
	until game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
	if typeof(Destination) == "CFrame" then
		EasyPath:CFrameToPart(Destination)
		game:GetService("Players").LocalPlayer.Character.Humanoid:MoveTo(game:GetService("Workspace").EasyPath_CFrameReference.Position + Offset)
	elseif typeof(Destination) == "Vector3" then
		game:GetService("Players").LocalPlayer.Character.Humanoid:MoveTo(Destination + Offset)
	else
		game:GetService("Players").LocalPlayer.Character.Humanoid:MoveTo(Destination.Position + Offset)
	end
	game:GetService("Players").LocalPlayer.Character.Humanoid.MoveToFinished:Wait()
	if game:GetService("Workspace"):FindFirstChild("EasyPath_CFrameReference") then
		game:GetService("Workspace").EasyPath_CFrameReference:Remove()
	end
end

function EasyPath:CanPathfindTo(Destination, Offset)
	local Result
	local WalkToPathfinding = game:GetService("PathfindingService"):CreatePath()

	pcall(function()
		if not game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character.Humanoid then
			print("(error) Humanoid Not Found, Waiting For Humanoid.")
			repeat 
				wait()
			until game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
		end


		if typeof(Destination) == "CFrame" then
			EasyPath:CFrameToPart(Destination)
			WalkToPathfinding:ComputeAsync(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, game:GetService("Workspace").EasyPath_CFrameReference.Position + Offset)
			if WalkToPathfinding.Status == Enum.PathStatus.Success then
				print("(true) Can Reach CFrame")
				Result = true
			else
				print("(false) Impossible To Reach CFrame")
				Result = false
			end
		elseif typeof(Destination) == "Vector3" then
			WalkToPathfinding:ComputeAsync(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, Destination + Offset)
			if WalkToPathfinding.Status == Enum.PathStatus.Success then
				print("(true) Can Reach Vector3")
				Result = true
			else
				print("(false) Impossible To Reach Vector3")
				Result = false
			end
		else
			if Destination == nil or Destination == "nil" or Destination.Parent == nil then
				print("(false) Part Does Not Exist")
				Result = false
			else
				WalkToPathfinding:ComputeAsync(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, Destination.Position + Offset)
				if WalkToPathfinding.Status == Enum.PathStatus.Success then
					print("(true) Can Reach Part")
					Result = true
				else
					print("(false) Impossible To Reach Part")
					Result = false
				end
			end
		end
	end)
	if game:GetService("Workspace"):FindFirstChild("EasyPath_CFrameReference") then
		game:GetService("Workspace").EasyPath_CFrameReference:Remove()
	end
	return Result
end

return EasyPath
