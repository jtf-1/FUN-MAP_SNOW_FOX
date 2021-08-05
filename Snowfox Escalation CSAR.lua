 env.info("CSAR Loading", false)
 
 
 -- Instantiate and start a CSAR for the blue side, with template "Downed Pilot" and alias "Luftrettung"
   local snowfox_csar = CSAR:New(coalition.side.BLUE,"Downed Pilot","Downed Pilot")
   -- options
   snowfox_csar.allowDownedPilotCAcontrol = false -- Set to false if you don\'t want to allow control by Combined Arms.
   snowfox_csar.allowFARPRescue = true -- allows pilots to be rescued by landing at a FARP or Airbase. Else MASH only!
   snowfox_csar.autosmoke = true -- automatically smoke a downed pilot\'s location when a heli is near.
   snowfox_csar.autosmokedistance = 1000 -- distance for autosmoke
   snowfox_csar.coordtype = 1 -- Use Lat/Long DDM (0), Lat/Long DMS (1), MGRS (2), Bullseye imperial (3) or Bullseye metric (4) for coordinates.
   snowfox_csar.csarOncrash = true -- (WIP) If set to true, will generate a downed pilot when a plane crashes as well.
   snowfox_csar.enableForAI = false -- set to false to disable AI pilots from being rescued.
   snowfox_csar.pilotRuntoExtractPoint = true -- Downed pilot will run to the rescue helicopter up to snowfox_csar.extractDistance in meters. 
   snowfox_csar.extractDistance = 500 -- Distance the downed pilot will start to run to the rescue helicopter.
   snowfox_csar.immortalcrew = true -- Set to true to make wounded crew immortal.
   snowfox_csar.invisiblecrew = false -- Set to true to make wounded crew insvisible.
   snowfox_csar.loadDistance = 75 -- configure distance for pilots to get into helicopter in meters.
   snowfox_csar.mashprefix = {"MASH"} -- prefixes of #GROUP objects used as MASHes.
   snowfox_csar.max_units = 6 -- max number of pilots that can be carried if #CSAR.AircraftType is undefined.
   snowfox_csar.messageTime = 15 -- Time to show messages for in seconds. Doubled for long messages.
   snowfox_csar.radioSound = "beacon.ogg" -- the name of the sound file to use for the pilots\' radio beacons. 
   snowfox_csar.smokecolor = 4 -- Color of smokemarker, 0 is green, 1 is red, 2 is white, 3 is orange and 4 is blue.
   snowfox_csar.useprefix = true  -- Requires CSAR helicopter #GROUP names to have the prefix(es) defined below.
   snowfox_csar.csarPrefix = { "helicargo", "MEDEVAC", "zz"} -- #GROUP name prefixes used for useprefix=true - DO NOT use # in helicopter names in the Mission Editor! 
   snowfox_csar.verbose = 0 -- set to > 1 for stats output for debugging.
   -- (added 0.1.4) limit amount of downed pilots spawned by **ejection** events
   snowfox_csar.limitmaxdownedpilots = true
   snowfox_csar.maxdownedpilots = 10 
   -- (added 0.1.8) - allow to set far/near distance for approach and optionally pilot must open doors
   snowfox_csar.approachdist_far = 5000 -- switch do 10 sec interval approach mode, meters
   snowfox_csar.approachdist_near = 3000 -- switch to 5 sec interval approach mode, meters
   snowfox_csar.pilotmustopendoors = false -- switch to true to enable check of open doors
   -- start the FSM
   snowfox_csar:__Start(5)
   
   env.info("CSAR Complete", false)