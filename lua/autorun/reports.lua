AddCSLuaFile("reports/shared.lua")
AddCSLuaFile("reports/client.lua")
if SERVER then
    include("reports/shared.lua")
    include("reports/server.lua")
else
    include("reports/shared.lua")
    include("reports/client.lua")
end