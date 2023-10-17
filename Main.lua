-- MAKE SURE TO PUT THIS IN AUTOEXEC FOLDER SO YOU WONT FREEZE: loadstring(game:HttpGet("https://raw.githubusercontent.com/Aureliustics/UWP-Detection-Bypass/main/Protected_6902974095357315.lua"))()

--[[Place IDs:
THE DEPTHS : 5735553160
ETREAN LUMINANT : 6032399813
DEEPWOKEN MENU : 4111023553
EASTERN LUMINANT : 6473861193
setclipboard(game.JobId) <— execute to copy current jobid
--]]

if game.PlaceId == 4111023553 then
pcall(function()
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Deepwoken Server Sniper", HidePremium = true, SaveConfig = false, ConfigFolder = "OrionTest", IntroEnabled = false, IntroText = false})

-- Values
_G.JobID = JobID
_G.serverAge = ""
local pg = game.Players.LocalPlayer.PlayerGui
_G.joinSlot = ""
_G.repeatJoin = true

local function checkValidity()
    _G.CharLength = _G.JobID
end

local function click(button)
    for i,v in pairs(getconnections(button.MouseButton1Click)) do
        v:Fire()
    end
end

local attempts = "0"

local waitTime = ""
_G.waitTime = ""

local Slots = {
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
}

local function selectSlot()
    keypress(0x46)
    task.wait(0.3)
    click(pg.LoadingGui.Overlay.Options.Option)
    task.wait(1)
    click(pg.LoadingGui.Overlay.Slots.A) -- Change this to whatever slot u want (A, B, C, D, ect)
    task.wait(1)
end

local function joinServer()
    checkValidity()
    if _G.JobID ~= nil and (string.len(_G.CharLength)) >= 32 and (string.len(_G.CharLength)) <= 36 then
    OrionLib:MakeNotification({
        Name = "Status",
        Content = "Joining Server: " .. _G.JobID,
        Image = "rbxassetid://4483345998",
        Time = 15
    })
    selectSlot()
    local RL = game:GetService("ReplicatedStorage")
    local Req = RL.Requests
    local SM = Req.StartMenu
    local PS = SM.PickServer
    PS:FireServer(_G.JobID)
    else
        OrionLib:MakeNotification({
            Name = "Error",
            Content = _G.JobID .. " is not a valid JobID!",
            Image = "rbxassetid://4483345998",
            Time = 15
        })
        warn("A JobID can only be 32-36 characters long, you inputted: " .. string.len(_G.CharLength))
    end
end

local function filterServers()
    for i, v in pairs(game.ReplicatedStorage:GetDescendants()) do
        if v.Name == "Age" then
            if v.Value:match(_G.serverAge) then
                if _G.serverAge ~= nil and _G.serverAge ~= "" and _G.serverAge ~= " " then
                    print(v.Parent.RichName.Value);
                OrionLib:MakeNotification({
                    Name = "Status",
                    Content = "Server Detected:  " .. v.Parent.RichName.Value .. " " .. v.Parent.Region.Value .. " " .. v.Parent.Age.Value,
                    Image = "rbxassetid://4483345998",
                    Time = 9e9
                })
            else
                OrionLib:MakeNotification({
                    Name = "Error",
                    Content = "Server Not Found! Output returned nil.",
                    Image = "rbxassetid://4483345998",
                    Time = 15
                })
                task.wait(9e9)
                end
            end
        end
    end
end

local function repeatJoin()
    if _G.JobID ~= nil and _G.JobID ~= "" and _G.JobID ~= " " and _G.JobID ~= "Input" then
        while _G.repeatJoin == true do
            local RL = game:GetService("ReplicatedStorage")
            local Req = RL.Requests
            local SM = Req.StartMenu
            local PS = SM.PickServer
            PS:FireServer(_G.JobID)
            attempts = attempts + 1
            OrionLib:MakeNotification({
                Name = "Status",
                Content = "Attempts: " .. attempts,
                Image = "rbxassetid://4483345998",
                Time = _G.waitTime
            })
            task.wait(_G.waitTime)
        end
    end
end


-- UI
OrionLib:MakeNotification({
	Name = "Reminder",
	Content = "Make sure you choose a slot before sniping server.",
	Image = "rbxassetid://4483345998",
	Time = 9e9
})


local SNIPER = Window:MakeTab({
	Name = "Sniper",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false 
})


local Section = SNIPER:AddSection({
	Name = "Input"
})

SNIPER:AddTextbox({
	Name = "Job ID",
	TextDisappear = false,
	Callback = function(Value)
        _G.JobID = Value
        joinServer()
	end	  
})

SNIPER:AddTextbox({
	Name = "Locate With Server Age",
    Default = "0d 0h 0m",
	TextDisappear = true,
	Callback = function(Value)
        _G.serverAge = Value
        -- warn("Server age selected:")
        -- warn(_G.serverAge)
        OrionLib:MakeNotification({
            Name = "Server Age Selected",
            Content = _G.serverAge,
            Image = "rbxassetid://4483345998",
            Time = 15
        })
        filterServers()
        task.wait(20)
    end
})

SNIPER:AddDropdown({
	Name = "Slot To Join",
	Default = "A",
	Options = Slots,
	Callback = function(Value)
        _G.joinSlot = Value
        OrionLib:MakeNotification({
            Name = "Status",
            Content = "Selected Slot: " .. _G.joinSlot,
            Image = "rbxassetid://4483345998",
            Time = 5
        })
	end    
})


SNIPER:AddParagraph("Credits:","@aureliustics_")

SNIPER:AddButton({
	Name = "Unload",
	Callback = function()
      		OrionLib:Destroy()
  	end    
})

local LOOPJOIN = Window:MakeTab({
	Name = "Server",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = LOOPJOIN:AddSection({
	Name = "Brute Force Full Server"
})



LOOPJOIN:AddToggle({
	Name = "Loop Join Server",
	Default = false,
	Callback = function(Value)
		_G.repeatJoin = Value
        repeatJoin()
	end    
})


LOOPJOIN:AddSlider({
	Name = "Interval Between Retrys",
	Min = 1,
	Max = 20,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 0.5,
	ValueName = "Seconds",
	Callback = function(Value)
		_G.waitTime = Value
        waitTime = _G.waitTime
	end    
})


local PLACEID = Window:MakeTab({
	Name = "Place IDs",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = PLACEID:AddSection({
	Name = "Copy PlaceIDs"
})

PLACEID:AddButton({
	Name = "Etrean Luminant",
	Callback = function()
      		setclipboard("6032399813")
            OrionLib:MakeNotification({
            Name = "Status",
            Content = "Etrean Luminant Place ID copied to clipboard!",
            Image = "rbxassetid://4483345998",
            Time = 15
        })
  	end    
})

PLACEID:AddButton({
	Name = "East Luminant",
	Callback = function()
      		setclipboard("6473861193")
            OrionLib:MakeNotification({
            Name = "Status",
            Content = "East Luminant Place ID copied to clipboard!",
            Image = "rbxassetid://4483345998",
            Time = 10
        })
  	end    
})

PLACEID:AddButton({
	Name = "The Depths",
	Callback = function()
      		setclipboard("5735553160")
            OrionLib:MakeNotification({
            Name = "Status",
            Content = "The Depths Place ID copied to clipboard!",
            Image = "rbxassetid://4483345998",
            Time = 10
        })
  	end    
})

OrionLib:Init()

    end,warn);
end