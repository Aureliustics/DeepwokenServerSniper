-- MAKE SURE TO PUT THE SCRIPT IN AUTOEXEC FOLDER OTHERWISE YOU WILL FREEZE DUE TO DEEPWOKENS UWP DETECTION

--[[Place IDs:
THE DEPTHS : 5735553160
ETREAN LUMINANT : 6032399813
DEEPWOKEN MENU : 4111023553
EASTERN LUMINANT : 6473861193
setclipboard(game.JobId) <— execute to copy current jobid
--]]

-- TODO: LOG # OF PLAYERS IN SERVER TOO IN SERVERAGE FILTER | JOIN SMALLEST SERVER IN REGION OPTION | SLOT TO JOIN ON WITH DROPDOWN

if game.PlaceId == 4111023553 then
loadstring(game:HttpGet("https://raw.githubusercontent.com/Aureliustics/UWP-Detection-Bypass/main/Protected_6902974095357315.lua"))()
 pcall(function()
 local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
 
 local Window = OrionLib:MakeWindow({Name = "Deepwoken Server Sniper", HidePremium = true, SaveConfig = false, ConfigFolder = "OrionTest", IntroEnabled = false, IntroText = false})

 -- Values
 _G.JobID = JobID
 _G.serverAge = ""
 
 local function checkValidity()
     _G.CharLength = _G.JobID
 end
 
 local function joinServer()
     checkValidity()
     if _G.JobID ~= nil and (string.len(_G.CharLength)) == 36 then
     OrionLib:MakeNotification({
         Name = "Status",
         Content = "Joining Server: " .. _G.JobID,
         Image = "rbxassetid://4483345998",
         Time = 15
     })
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
         warn("A JobID can only be 36 characters long, you inputted: " .. string.len(_G.CharLength))
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
                     Content = "Server Detected:  " .. v.Parent.RichName.Value .. " " .. v.Parent.Region.Value .. " " .. _G.serverAge,
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
 

 -- UI
 OrionLib:MakeNotification({
     Name = "Reminder",
     Content = "Make sure you choose a slot before sniping server.",
     Image = "rbxassetid://4483345998",
     Time = 9e9
 })
 
 
 local Tab = Window:MakeTab({
     Name = "Sniper",
     Icon = "rbxassetid://4483345998",
     PremiumOnly = false
 })
 
 
 local Section = Tab:AddSection({
     Name = "Input"
 })
 
 Tab:AddTextbox({
     Name = "Job ID",
     TextDisappear = true,
     Callback = function(Value)
         _G.JobID = Value
         joinServer()
     end	  
 })
 
 Tab:AddTextbox({
     Name = "Locate With Server Age",
     Default = "0d 0h 0m",
     TextDisappear = true,
     Callback = function(Value)
         _G.serverAge = Value
         -- warn("Server age selected: " .. _G.serverAge)
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
 
 Tab:AddParagraph("Credits:","@aureliustics_")
 
 Tab:AddButton({
     Name = "Unload",
     Callback = function()
               OrionLib:Destroy()
       end    
 })
 
 local Tab = Window:MakeTab({
     Name = "Place IDs",
     Icon = "rbxassetid://4483345998",
     PremiumOnly = false
 })
 
 local Section = Tab:AddSection({
     Name = "Copy PlaceIDs"
 })
 
 Tab:AddButton({
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
 
 Tab:AddButton({
     Name = "Eastern Luminant",
     Callback = function()
               setclipboard("6473861193")
             OrionLib:MakeNotification({
             Name = "Status",
             Content = "Eastern Luminant Place ID copied to clipboard!",
             Image = "rbxassetid://4483345998",
             Time = 10
         })
             
       end    
 })
 
 Tab:AddButton({
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