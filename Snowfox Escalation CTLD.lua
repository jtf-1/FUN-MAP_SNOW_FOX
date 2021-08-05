env.info("CTLD Loading", false)

local my_ctld = CTLD:New(coalition.side.BLUE,{"Helicargo", "Hercules", "zz"},"Lufttransportbrigade I")

-- HERCULES OPTIONS
my_ctld.useprefix = true -- this is true by default and MUST BE ON. 
my_ctld.enableHercules = true
my_ctld.HercMinAngels = 155 -- for troop/cargo drop via chute in meters, ca 470 ft
my_ctld.HercMaxAngels = 2000 -- for troop/cargo drop via chute in meters, ca 6000 ft
my_ctld.HercMaxSpeed = 77 -- 77mps or 270kph or 150kn

--CTLD OPTIONS
my_ctld.CrateDistance = 50 -- List and Load crates in this radius only.
my_ctld.dropcratesanywhere = false -- Option to allow crates to be dropped anywhere.
my_ctld.maximumHoverHeight = 15 -- Hover max this high to load.
my_ctld.minimumHoverHeight = 4 -- Hover min this low to load.
my_ctld.forcehoverload = false -- Crates (not: troops) can only be loaded while hovering.
my_ctld.hoverautoloading = true -- Crates in CrateDistance in a LOAD zone will be loaded automatically if space allows.
my_ctld.smokedistance = 2000 -- Smoke or flares can be request for zones this far away (in meters).
my_ctld.movetroopstowpzone = true -- Troops and vehicles will move to the nearest MOVE zone...
my_ctld.movetroopsdistance = 5000 -- .. but only if this far away (in meters)
my_ctld.smokedistance = 2000 -- Only smoke or flare zones if requesting player unit is this far away (in meters)
my_ctld.suppressmessages = false -- Set to true if you want to script your own messages.
my_ctld.repairtime = 300 -- Number of seconds it takes to repair a unit.

--AIRCRAFT SETTINGS  
my_ctld:UnitCapabilities("SA342Mistral", false, true, 0, 4)
my_ctld:UnitCapabilities("SA342L", false, true, 0, 2)
my_ctld:UnitCapabilities("SA342M", false, true, 0, 4)
my_ctld:UnitCapabilities("SA342Minigun", false, true, 0, 2)
my_ctld:UnitCapabilities("UH-1H", true, true, 1, 8)
my_ctld:UnitCapabilities("Mi-8MT", true, true, 2, 12)
my_ctld:UnitCapabilities("Ka-50", false, false, 0, 0)
my_ctld:UnitCapabilities("Mi-24P", true, true, 1, 8)
my_ctld:UnitCapabilities("Mi-24V", true, true, 1, 8)
my_ctld:UnitCapabilities("Hercules", true, true, 7, 64)


--[[
Default unit type capabilities are:

   ["SA342Mistral"] = {type="SA342Mistral", crates=false, troops=true, cratelimit = 0, trooplimit = 4},
   ["SA342L"] = {type="SA342L", crates=false, troops=true, cratelimit = 0, trooplimit = 2},
   ["SA342M"] = {type="SA342M", crates=false, troops=true, cratelimit = 0, trooplimit = 4},
   ["SA342Minigun"] = {type="SA342Minigun", crates=false, troops=true, cratelimit = 0, trooplimit = 2},
   ["UH-1H"] = {type="UH-1H", crates=true, troops=true, cratelimit = 1, trooplimit = 8},
   ["Mi-8MT"] = {type="Mi-8MT", crates=true, troops=true, cratelimit = 2, trooplimit = 12},
   ["Ka-50"] = {type="Ka-50", crates=false, troops=false, cratelimit = 0, trooplimit = 0},
   ["Mi-24P"] = {type="Mi-24P", crates=true, troops=true, cratelimit = 1, trooplimit = 8},
   ["Mi-24V"] = {type="Mi-24V", crates=true, troops=true, cratelimit = 1, trooplimit = 8},
   ["Hercules"] = {type="Hercules", crates=true, troops=true, cratelimit = 7, trooplimit = 64}, -- 19t cargo, 64 paratroopers
]]--

--ZONES
my_ctld:AddCTLDZone("pickzone1",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,true)
my_ctld:AddCTLDZone("pickzone2",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,true)
my_ctld:AddCTLDZone("pickzone3",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,true)
my_ctld:AddCTLDZone("pickzone4",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,true)
my_ctld:AddCTLDZone("pickzone5",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,true)
my_ctld:AddCTLDZone("pickzone6",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,true)


my_ctld:__Start(5)

env.info("CTLD Complete", false)