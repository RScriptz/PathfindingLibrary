local game = game
local plrs = game:GetService("Players")
local EasyPath = {}
EasyPath["PathfindingService"] = game:GetService("PathfindingService")
EasyPath["LocalPlayer"] = plrs.LocalPlayer
EasyPath["Character"] = EasyPath["LocalPlayer"].Character
EasyPath["Humanoid"] = EasyPath["Character"]:FindFirstChildWhichIsA("Humanoid")
EasyPath["HRP"] = EasyPath["Character"]:FindFirstChild("HumanoidRootPart")
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
    CFramePart.Parent = workspace
    CFramePart.Name = "EasyPath_CFrameReference"
    CFramePart.CanCollide = false
    CFramePart.CanTouch = false
    CFramePart.Transparency = 1
    CFramePart.CFrame = CFrame
end

function EasyPath:DeleteAllWaypoints()
    for i, v in pairs(workspace:GetChildren()) do
        if v.Name == "EasyPath_PathPoint" then v:Remove() end
    end
end

function EasyPath:WalkToPath(CustomPath)
    local PlayerWalkspeed = tonumber(EasyPath["Humanoid"].WalkSpeed)
    local WalkToPathfinding = EasyPath["PathfindingService"]:CreatePath()
    if typeof(CustomPath.Destination) == "CFrame" then
        EasyPath:CFrameToPart(CustomPath.Destination)
        WalkToPathfinding:ComputeAsync(EasyPath["HRP"].Position, workspace.EasyPath_CFrameReference.Position + CustomPath.PathOffset)
    elseif typeof(CustomPath.Destination) == "Vector3" then
        WalkToPathfinding:ComputeAsync(EasyPath["HRP"].Position, CustomPath.Destination + CustomPath.PathOffset)
    else
        WalkToPathfinding:ComputeAsync(EasyPath["HRP"].Position, CustomPath.Destination.Position + CustomPath.PathOffset)
    end

    if WalkToPathfinding.Status == Enum.PathStatus.Success then
        if CustomPath.DebugMode == true then print("Status: Starting...") end
        local WayPoints = WalkToPathfinding:GetWaypoints()
        for i = 1, #WayPoints do
            local point = WayPoints[i]
            if CustomPath.VisualPath == true then EasyPath:CreateVisualWaypoint(point, CustomPath.VisualPathSize, CustomPath.VisualPathColor, CustomPath.VisualPathOffset) end
            EasyPath["Humanoid"]:MoveTo(point.Position)
            local Success = EasyPath["Humanoid"].MoveToFinished:Wait()
            if point.Action == Enum.PathWaypointAction.Jump then
                if not CustomPath.StrongAnticheat then
                    EasyPath["Humanoid"].WalkSpeed = 0
                    task.delay(0.2, function() EasyPath["Humanoid"].WalkSpeed = PlayerWalkspeed end)
                end

                EasyPath["Humanoid"].Jump = true
            end

            if not Success then
                if CustomPath.DebugMode then print("Status: Broke, Trying Again...") end
                EasyPath["Humanoid"].Jump = true
                EasyPath["Humanoid"]:MoveTo(point.Position)
                if not EasyPath["Humanoid"].MoveToFinished:Wait() then break end
            else
                if CustomPath.DebugMode then print("Status: Walking To The Part...") end
            end
        end
    else
        if CustomPath.DebugMode then print("Status: Impossible To Reach Part.") end
        return
    end

    if not CustomPath.StrongAnticheat then EasyPath["Humanoid"].WalkSpeed = 0 end
    if CustomPath.DebugMode then print("Status: Got To The Part!") end
    if not CustomPath.StrongAnticheat then EasyPath["Humanoid"].WalkSpeed = PlayerWalkspeed end
    if CustomPath.DeletePathWhenDone then EasyPath:DeleteAllWaypoints() end
    if workspace:FindFirstChild("EasyPath_CFrameReference") then workspace.EasyPath_CFrameReference:Remove() end
end

function EasyPath:WalkToBasicPath(CustomPath)
    local PlayerWalkspeed = tonumber(EasyPath["Humanoid"].WalkSpeed)
    local WalkToPathfinding = EasyPath["PathfindingService"]:CreatePath()
    if typeof(CustomPath.Destination) == "CFrame" then
        EasyPath:CFrameToPart(CustomPath.Destination)
        WalkToPathfinding:ComputeAsync(EasyPath["HRP"].Position, workspace.EasyPath_CFrameReference.Position + CustomPath.PathOffset)
    elseif typeof(CustomPath.Destination) == "Vector3" then
        WalkToPathfinding:ComputeAsync(EasyPath["HRP"].Position, CustomPath.Destination + CustomPath.PathOffset)
    else
        WalkToPathfinding:ComputeAsync(EasyPath["HRP"].Position, CustomPath.Destination.Position + CustomPath.PathOffset)
    end

    if WalkToPathfinding.Status == Enum.PathStatus.Success then
        if CustomPath.DebugMode == true then print("Status: Starting...") end
        local WayPoints = WalkToPathfinding:GetWaypoints()
        for i = 1, #WayPoints do
            local point = WayPoints[i]
            EasyPath["Humanoid"]:MoveTo(point.Position)
            local Success = EasyPath["Humanoid"].MoveToFinished:Wait()
            if point.Action == Enum.PathWaypointAction.Jump then
                if not CustomPath.StrongAnticheat then
                    EasyPath["Humanoid"].WalkSpeed = 0
                    task.delay(0.2, function() EasyPath["Humanoid"].WalkSpeed = PlayerWalkspeed end)
                end

                EasyPath["Humanoid"].Jump = true
            end

            if not Success then
                if CustomPath.DebugMode then print("Status: Broke, Trying Again...") end
                EasyPath["Humanoid"].Jump = true
                EasyPath["Humanoid"]:MoveTo(point.Position)
                if not EasyPath["Humanoid"].MoveToFinished:Wait() then break end
            else
                if CustomPath.DebugMode then print("Status: Walking To The Part...") end
            end
        end
    else
        if CustomPath.DebugMode then print("Status: Impossible To Reach Part.") end
        return
    end

    if CustomPath.DebugMode then print("Status: Got To The Part!") end
    if workspace:FindFirstChild("EasyPath_CFrameReference") then workspace.EasyPath_CFrameReference:Remove() end
end

function EasyPath:FinishedPathfinding()
    repeat
        wait()
    until EasyPath["Character"] and EasyPath["Humanoid"] and EasyPath["Humanoid"].MoveToFinished
    return true
end

function EasyPath:PlayerWalkTo(Destination, Offset)
    repeat
        wait()
    until EasyPath["Character"] and EasyPath["Humanoid"]

    if typeof(Destination) == "CFrame" then
        EasyPath:CFrameToPart(Destination)
        EasyPath["Humanoid"]:MoveTo(workspace.EasyPath_CFrameReference.Position + Offset)
    elseif typeof(Destination) == "Vector3" then
        EasyPath["Humanoid"]:MoveTo(Destination + Offset)
    else
        EasyPath["Humanoid"]:MoveTo(Destination.Position + Offset)
    end

    EasyPath["Humanoid"].MoveToFinished:Wait()
    if workspace:FindFirstChild("EasyPath_CFrameReference") then workspace.EasyPath_CFrameReference:Remove() end
end

function EasyPath:CanPathfindTo(Destination, Offset)
    local Result
    local WalkToPathfinding = EasyPath["PathfindingService"]:CreatePath()
    pcall(
        function()
            if not EasyPath["Character"] and EasyPath["Humanoid"] then
                print("(error) Humanoid Not Found, Waiting For Humanoid.")
                repeat
                    wait()
                until EasyPath["Character"] and EasyPath["Humanoid"]
            end

            if typeof(Destination) == "CFrame" then
                EasyPath:CFrameToPart(Destination)
                WalkToPathfinding:ComputeAsync(EasyPath["HRP"].Position, workspace.EasyPath_CFrameReference.Position + Offset)
                if WalkToPathfinding.Status == Enum.PathStatus.Success then
                    print("(true) Can Reach CFrame")
                    Result = true
                else
                    print("(false) Impossible To Reach CFrame")
                    Result = false
                end
            elseif typeof(Destination) == "Vector3" then
                WalkToPathfinding:ComputeAsync(EasyPath["HRP"].Position, Destination + Offset)
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
                    WalkToPathfinding:ComputeAsync(EasyPath["HRP"].Position, Destination.Position + Offset)
                    if WalkToPathfinding.Status == Enum.PathStatus.Success then
                        print("(true) Can Reach Part")
                        Result = true
                    else
                        print("(false) Impossible To Reach Part")
                        Result = false
                    end
                end
            end
        end
    )

    if workspace:FindFirstChild("EasyPath_CFrameReference") then workspace.EasyPath_CFrameReference:Remove() end
    return Result
end
return EasyPath
