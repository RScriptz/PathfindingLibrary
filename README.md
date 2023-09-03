# Documentation

## EasyPath Is Made For Beginners Who Want To Make Legit Cheats But Dont Know The Basics Of Pathfinding, It Is By No Means Good.

### Loading The Library:

```lua
local EasyPath = loadstring(game:HttpGet(""))()
```

### Walk To Path:

```lua
--> Normal WalkToPath
EasyPath:WalkToPath({
	--[[->>Walking]]
		Destination = game:GetService("Workspace").Part, -- The Part The Character Should Pathfind To.
		PathOffset = Vector3.new(0,0,0), -- Makes The Humanoid To Walk To The Part + Theese Studs, Giving It A Slight Offset, Keep It As It Is For No Offset (Walks Right To The Part). NOTE: Changing The Height Vector To Over 2-5 Will Make The Target Impossible To Reach, Therefore The Script Wont Work.
	--[[->>Utilities]]
		DebugMode = true, -- Prints What The Script Is Doing At That Point In The Developer Console.
		StrongAnticheat = false, -- Whenever The Pathfinding Action Is Jumping, The Script Makes The Player's Walkspeed 0, So The Humanoid Instantly Stops, Then Changes It To 16, Well, Some Games May Detect That, So Enabling This Will Make The Script Skip That Action.
	--[[->>Visuals]]
		VisualPath = true, -- Shows The Path The Humanoid Follows.
		VisualPathSize = Vector3.new(1, 1, 1), -- Visual Path's Size, If Enabled.
		VisualPathColor = Color3.fromRGB(255,0,0), -- Visual Path's Color, If Enabled.
		VisualPathOffset = Vector3.new(0, 0, 0), -- Visual Path's Position Offset, Leave It As It Is If You Want The Visual Path To Be The Same As The Actual Path.
		DeletePathWhenDone = true -- Deletes The Visual Path When The Humanoid Finishes Pathfinding.
	})
```

### Simple Walk To Path:

```lua
	--> Simple WalkToPath
	EasyPath:WalkToBasicPath({
		Destination = game:GetService("Workspace").Part, -- The Part The Character Should Pathfind To.
		DebugMode = true, -- Prints What The Script Is Doing At That Point In The Developer Console.
		StrongAnticheat = false -- Whenever The Pathfinding Action Is Jumping, The Script Makes The Player's Walkspeed 0, So The Humanoid Instantly Stops, Then Changes It To 16, Well, Some Games May Detect That, So Enabling This Will Make The Script Skip That Action.
	})
```

### Player Walk To (Same As Roblox's :MoveTo()):

```lua
	--> PlayerWalkTo Example
	EasyPath:PlayerWalkTo(game:GetService("Workspace").Part) -- Same As Humanoid:WalkTo(), Except It Has A Few Extra Checks To Ensure The Function Never Errors, Note, Since This Only Walks To The Shortest Path, And It Doesnt Jump Nor Avoid Obstacles, This Can Easly Get Stuck.
```

### Player Walk To / Walk To Path Finished Check:

```lua
	--> WalkToPath Finished Check 1
	repeat wait() until EasyPath:FinishedPathfinding() == true -- Waits Until The Pathfinding Has Finished
	
	--> WalkToPath Finished Check 2
	if EasyPath:FinishedPathfinding() == true then -- Checks If The Pathfinding Has Finished
		print("Pathfinding Has Finished")
	end
	
	--> WalkToPath Finished Check 3
	for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
		if v.Name == "Part" then
			repeat wait() until EasyPath:FinishedPathfinding() == true -- Waits Until Pathfinding Has Finished
			EasyPath:WalkToPath({
				Destination = v,
				PathOffset = Vector3.new(0,0,0),
				DebugMode = true,
				StrongAnticheat = false,
				VisualPath = true,
				VisualPathSize = Vector3.new(1, 1, 1),
				VisualPathColor = Color3.fromRGB(255,0,0),
				VisualPathOffset = Vector3.new(0, 0, 0),
				DeletePathWhenDone = true
			})
		end
	end
	
	--> WalkToPath Finished Check 4
	for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
		if v.Name == "Part" and EasyPath:FinishedPathfinding() == true then -- Checks If The Pathfinding Has Finished
			EasyPath:WalkToPath({
				Destination = v,
				PathOffset = Vector3.new(0,0,0),
				DebugMode = true,
				StrongAnticheat = false,
				VisualPath = true,
				VisualPathSize = Vector3.new(1, 1, 1),
				VisualPathColor = Color3.fromRGB(255,0,0),
				VisualPathOffset = Vector3.new(0, 0, 0),
				DeletePathWhenDone = true
			})
		end
	end
```

### Can Pathfind To Check:

```lua
	--> CanPathfindTo Use Case 1
	for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
		if v.Name == "Part" and EasyPath:FinishedPathfinding() == true then
			if EasyPath:CanPathfindTo(v) == true then -- Checks If The Part Is Pathfindable, If It Isnt, It Skips To The Next One. Also Waits Until Humanoid Exists.
				print("-----------------------------------------")
			end
		end
	end
	
	--> CanPathfindTo Use Case 2
	if EasyPath:CanPathfindTo(game:GetService("Workspace").Part) == true then -- If The Part Exists Then It Pathfinds To It, Else It Waits Until The Part Exists. Also Waits Until Humanoid Exists.
		EasyPath:WalkToPath({
			Destination = game:GetService("Workspace").Part,
			PathOffset = Vector3.new(0,0,0),
			DebugMode = true,
			StrongAnticheat = false,
			VisualPath = true,
			VisualPathSize = Vector3.new(1, 1, 1),
			VisualPathColor = Color3.fromRGB(255,0,0),
			VisualPathOffset = Vector3.new(0, 0, 0),
			DeletePathWhenDone = true
		})
	else
		repeat wait() until game:GetService("Workspace"):FindFirstChild("Part")
	end
```

### Delete Visual Waypoints Manually:

```lua
	EasyPath:DeleteAllWaypoints() -- Deletes All Visual Waypoints Manually.
```
