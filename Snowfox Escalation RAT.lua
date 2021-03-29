env.info("RAT Loading", false)

--[[
In this example, three different #RAT objects are created (but not spawned manually).
The #RATMANAGER takes care that at least five aircraft of each type are alive and that the total number of aircraft spawned is 25.
The #RATMANAGER is started after 30 seconds and stopped after two hours.

local a10c=RAT:New("RAT_A10C", "A-10C managed")
a10c:SetDeparture({"Batumi"})

local f15c=RAT:New("RAT_F15C", "F15C managed")
f15c:SetDeparture({"Sochi-Adler"})
f15c:DestinationZone()
f15c:SetDestination({"Zone C"})

local av8b=RAT:New("RAT_AV8B", "AV8B managed")
av8b:SetDeparture({"Zone C"})
av8b:SetTakeoff("air")
av8b:DestinationZone()
av8b:SetDestination({"Zone A"})

local manager=RATMANAGER:New(25)
manager:Add(a10c, 5)
manager:Add(f15c, 5)
manager:Add(av8b, 5)
manager:Start(30)
manager:Stop(7200)
]]--

RedLgTansports = { "RAT - Curl", 
           "RAT - Clank",
           "RAT - Candid",
           "RAT - rYak",
            }
            
BlueLgTansports = { "RAT - Galaxy", 
           "RAT - Osprey",
           "RAT - Orion",
           "RAT - Globemaster",
           "RAT - Atlas",
            }
            
BlueSmTansports = { "RAT - bYak",
           "RAT - Eagle",
            }            

BlueCarrier = { "RAT - Greyhound",
           "RAT - S-3B",
            }                   


--////RedLgTansports
local RedLgTransportRAT = RAT:New("RAT - Curl", "Red Transport") --yak1:RAT("RAT_YAK") will create a RAT object called "yak1". The template group in the mission editor must have the name "RAT_YAK".
RedLgTransportRAT:InitRandomizeTemplate(RedLgTansports)
RedLgTransportRAT:SetTerminalType(AIRBASE.TerminalType.OpenBig)
RedLgTransportRAT:ExcludedAirports({AIRBASE.PersianGulf.Al_Maktoum_Intl, AIRBASE.PersianGulf.Sir_Abu_Nuayr, AIRBASE.PersianGulf.Tunb_Kochak})
RedLgTransportRAT:_Debug(false) --Turn debug on=true or off=false. No argument means on.
RedLgTransportRAT:EnableATC(true)
RedLgTransportRAT:ATC_Messages(true)
RedLgTransportRAT:SetCoalition("sameonly") --"same"=own coalition+neutral (default), "sameonly"=own coalition only, "neutral"=all neutral airports. Default is "same", so aircraft will use airports of the coalition their spawn template has plus all neutral airports.
RedLgTransportRAT:CheckOnRunway(true, 75, distance)
RedLgTransportRAT:CheckOnTop(true, 2)
RedLgTransportRAT:ContinueJourney()
--RedLgTransportRAT:RadioMenuON()
RedLgTransportRAT:RespawnAfterCrashON()
RedLgTransportRAT:RespawnInAirAllowed(true) --If aircraft cannot be spawned on parking spots, it is allowed to spawn them in air above the same airport.
RedLgTransportRAT:SetEPLRS(true) --If true (or nil), turn EPLRS on.
RedLgTransportRAT:PlaceMarkers(false)
--RedLgTransportRAT:SetTakeoff("cold") --Type can be "takeoff-cold" or "cold", "takeoff-hot" or "hot", "takeoff-runway" or "runway", "air".
RedLgTransportRAT:TimeDestroyInactive(300) --Time in seconds. Default is 600 seconds = 10 minutes. Minimum is 60 seconds.
RedLgTransportRAT:Spawn(10)

--////BlueLgTansports
local BlueLgTransportRAT = RAT:New("RAT - Galaxy", "Blue Transport") --yak1:RAT("RAT_YAK") will create a RAT object called "yak1". The template group in the mission editor must have the name "RAT_YAK".
BlueLgTransportRAT:InitRandomizeTemplate(BlueLgTansports)
BlueLgTransportRAT:SetTerminalType(AIRBASE.TerminalType.OpenBig)
BlueLgTransportRAT:ExcludedAirports({AIRBASE.PersianGulf.Al_Maktoum_Intl, AIRBASE.PersianGulf.Sir_Abu_Nuayr, AIRBASE.PersianGulf.Tunb_Kochak})
BlueLgTransportRAT:_Debug(false) --Turn debug on=true or off=false. No argument means on.
BlueLgTransportRAT:EnableATC(true)
BlueLgTransportRAT:ATC_Messages(true)
BlueLgTransportRAT:SetCoalition("sameonly") --"same"=own coalition+neutral (default), "sameonly"=own coalition only, "neutral"=all neutral airports. Default is "same", so aircraft will use airports of the coalition their spawn template has plus all neutral airports.
BlueLgTransportRAT:CheckOnRunway(true, 75, distance)
BlueLgTransportRAT:CheckOnTop(true, 2)
BlueLgTransportRAT:ContinueJourney()
--BlueLgTransportRAT:RadioMenuON()
BlueLgTransportRAT:RespawnAfterCrashON()
BlueLgTransportRAT:RespawnInAirAllowed(true) --If aircraft cannot be spawned on parking spots, it is allowed to spawn them in air above the same airport.
BlueLgTransportRAT:SetEPLRS(true) --If true (or nil), turn EPLRS on.
BlueLgTransportRAT:PlaceMarkers(false)
--BlueLgTransportRAT:SetTakeoff("cold") --Type can be "takeoff-cold" or "cold", "takeoff-hot" or "hot", "takeoff-runway" or "runway", "air".
BlueLgTransportRAT:TimeDestroyInactive(300) --Time in seconds. Default is 600 seconds = 10 minutes. Minimum is 60 seconds.
BlueLgTransportRAT:Spawn(10)

--////BlueCarrier
local BlueCarrierRAT = RAT:New("RAT - Greyhound", "Blue Carrier Transport") --yak1:RAT("RAT_YAK") will create a RAT object called "yak1". The template group in the mission editor must have the name "RAT_YAK".
BlueCarrierRAT:InitRandomizeTemplate(BlueCarrier)
--BlueCarrierRAT:SetTerminalType(AIRBASE.TerminalType.OpenBig)
BlueCarrierRAT:_Debug(false) --Turn debug on=true or off=false. No argument means on.
BlueCarrierRAT:EnableATC(true)
BlueCarrierRAT:ATC_Messages(true)
BlueCarrierRAT:SetCoalition("sameonly") --"same"=own coalition+neutral (default), "sameonly"=own coalition only, "neutral"=all neutral airports. Default is "same", so aircraft will use airports of the coalition their spawn template has plus all neutral airports.
BlueCarrierRAT:CheckOnRunway(true, 75, distance)
BlueCarrierRAT:CheckOnTop(true, 2)
BlueCarrierRAT:Commute(starshape) --If true, keep homebase, i.e. travel A-->B-->A-->C-->A-->D... instead of A-->B-->A-->B-->A...BlueCarrierRAT:Immortal()
BlueCarrierRAT:SetDeparture({"Al Dhafra AFB","Al Minhad AFB"})
BlueCarrierRAT:SetDestination("CVN-75 Truman")
--BlueCarrierRAT:RadioMenuON()
BlueCarrierRAT:RespawnAfterCrashON()
BlueCarrierRAT:RespawnInAirAllowed(true) --If aircraft cannot be spawned on parking spots, it is allowed to spawn them in air above the same airport.
BlueCarrierRAT:SetEPLRS(true) --If true (or nil), turn EPLRS on.
BlueCarrierRAT:PlaceMarkers(false)
--BlueCarrierRAT:SetTakeoff("cold") --Type can be "takeoff-cold" or "cold", "takeoff-hot" or "hot", "takeoff-runway" or "runway", "air".
BlueCarrierRAT:TimeDestroyInactive(300) --Time in seconds. Default is 600 seconds = 10 minutes. Minimum is 60 seconds.
BlueCarrierRAT:Spawn(2)
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
--BlueTransportRAT:SetCoalitionAircraft(color) --Color of coalition, i.e. "red" or blue" or "neutral".
--BlueTransportRAT:RadioMenuOFF()
--BlueTransportRAT:Livery(skins)
--BlueTransportRAT:ExcludedAirports(ports)
--BlueTransportRAT:Commute(starshape) --If true, keep homebase, i.e. travel A-->B-->A-->C-->A-->D... instead of A-->B-->A-->B-->A...

env.info("RAT Compelte", false)