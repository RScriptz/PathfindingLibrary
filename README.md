# Documentation

## EasyPath Is Made For Beginners Who Want To Make Legit Cheats But Dont Know The Basics Of Pathfinding, It Is By No Means Good.

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
