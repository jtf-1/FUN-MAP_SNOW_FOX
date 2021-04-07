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

RedLgTansportsTemplate = { "RAT - Curl", 
           "RAT - Clank",
           "RAT - Candid",
           "RAT - rYak",
            }
       
RedHeloTemplate = { "RAT Mi-24V",
            "RAT Mi-26",
            "RAT Mi-28N",
            "RAT Mi-8MTV2"
            }
       
BlueHeloTemplate = { "RAT UH-60A",
            "RAT UH-1H",
            "RAT AH-64D",
            "RAT CH-47D",
            "RAT CH-53E"
            }
              
BlueLgTansportsTemplate = { "RAT - Galaxy", 
           "RAT - Osprey",
           "RAT - Orion",
           "RAT - Globemaster",
           "RAT - Atlas",
            }
            
BlueSmTansportsTemplate = { "RAT - bYak",
           "RAT - Eagle",
            }            

BlueCarrierTemplate = { "RAT - Greyhound",
           "RAT - S-3B",
           "USAF F/A-18C", 
           "USAF F-14B"
            } 
--[[                         
OilRigs = {   "Bukha Oil Field - Oil Rig 1",
          "Bukha Oil Field - Oil Rig 2",
          "Bukha Oil Field - Oil Rig 2",
          "Fateh Oil Field - Gas Platform 1",
          "Fateh Oil Field - Gas Platform 2",
          "Fateh Oil Field - Gas Platform 3",
          "Fateh Oil Field - Gas Platform 4",
          "Fateh Oil Field - Gas Platform 5",
          "Fateh Oil Field - Gas Platform 6",
          "Fateh Oil Field - Gas Platform 7",
          "Fateh Oil Field - Gas Platform 8",
          "Fateh Oil Field - Gas Platform 9",
          "Fateh Oil Field - Oil Rig 1",
          "Fateh Oil Field - Oil Rig 2",
          "Fateh Oil Field - Oil Rig 3",
          "Fateh Oil Field - Oil Rig 4",
          "Fateh Oil Field - Oil Rig 5",
          "Mubarek Oil Field - Gas Platform 1",
          "Mubarek Oil Field - Gas Platform 2",
          "Mubarek Oil Field - Gas Platform 3",
          "Mubarek Oil Field - Gas Platform 4",
          "Mubarek Oil Field - Oil Rig 1",
          "Mubarek Oil Field - Oil Rig 2",
          "Mubarek Oil Field - Oil Rig 3",
          "Mubarek Oil Field - Oil Rig 4",
          "Saleh Oil Field - Gas Platform 1",
          "Saleh Oil Field - Oil Rig 1",
          "Saleh Oil Field - Oil Rig 2",
          "Sic Oilfield - Gas Platform 1",
          "Sic Oilfield - Oil Rig 1",
          "Sic Oilfield - Oil Rig 2",
          "Sic Oilfield - Oil Rig 3",
          "Sic Oilfield - Oil Rig 4",
          "Sic Oilfield - Oil Rig 5",
          "Umm Al Adalkh - Oil Rig 1",
          "Umm Al Adalkh - Oil Rig 2",
          "Umm Al Adalkh - Oil Rig 3",
          "Umm Al Adalkh - Oil Rig 4",
          "Umm Al Adalkh - Oil Rig 5",
          "Umm Al Adalkh - Oil Rig 6",
          "Umm Al Adalkh - Oil Rig 7",
          "Umm Al Adalkh - Oil Rig 8",
          "Umm Al Adalkh - Oil Rig 9",
          "Umm Al Adalkh - Oil Rig 10",
          "Umm Al Adalkh - Oil Rig 11",
          "Umm Al Adalkh - Oil Rig 12",
          "Umm Al Adalkh - Oil Rig 13",
          "Umm Al Adalkh - Oil Rig 14",
          "Umm Al Adalkh - Oil Rig 15",
          "Umm Al Adalkh - Oil Rig 16",
          "Umm Al Adalkh - Oil Rig 17",
}
]]--

function SEF_BattlePhaseCheckAwacsTankers()

  if (    Airbase.getByName(AIRBASE.PersianGulf.Abu_Dhabi_International_Airport):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Al_Bateen_Airport):getCoalition() ~= 2 or     
        Airbase.getByName(AIRBASE.PersianGulf.Al_Ain_International_Airport):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Al_Dhafra_AB):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Al_Maktoum_Intl):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Dubai_Intl):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Sas_Al_Nakheel_Airport):getCoalition() ~= 2 or 
        Airbase.getByName(AIRBASE.PersianGulf.Sharjah_Intl):getCoalition() ~= 2 ) then
      
        --trigger.action.outText("Mission Objective\n\nPhase 1", 15)        
        --Then we must be in Phase 1
        return 1
        
  
  elseif (  Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Fujairah_Intl):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 2 ) then
        
        --trigger.action.outText("Mission Objective\n\nPhase 2", 15)        
        --Then we must be in Phase 2
        return 2
        
  elseif (  Airbase.getByName(AIRBASE.PersianGulf.Abu_Musa_Island_Airport):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Sir_Abu_Nuayr):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() ~= 2 or 
        Airbase.getByName(AIRBASE.PersianGulf.Tunb_Island_AFB):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Tunb_Kochak):getCoalition() ~= 2 ) then
  
        --trigger.action.outText("Mission Objective\n\nPhase 3", 15)
        --Then we must be in Phase 3
        return 3
        
  elseif (    Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Bandar_Lengeh):getCoalition() ~= 2 or 
        Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 2 or 
        Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() ~= 2 or 
        Airbase.getByName(AIRBASE.PersianGulf.Lavan_Island_Airport):getCoalition() ~= 2 or    
        Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() ~= 2 ) then
        
        --trigger.action.outText("Mission Objective\n\nPhase 4", 15)
        --Then we must be in Phase 4
        return 4
        
  elseif (    Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Jiroft_Airport):getCoalition() ~= 2 or 
        Airbase.getByName(AIRBASE.PersianGulf.Shiraz_International_Airport):getCoalition() ~= 2 or 
        Airbase.getByName(AIRBASE.PersianGulf.Kerman_Airport):getCoalition() ~= 2 ) then
        
        --trigger.action.outText("Mission Objective\n\nPhase 5", 15)
        --Then we must be in Phase 5
        return 5        
  else
    return 1
  end
end

--////RedLgTansports
local RedLgTransportRAT = RAT:New("RAT - Curl", "Red Transport") --yak1:RAT("RAT_YAK") will create a RAT object called "yak1". The template group in the mission editor must have the name "RAT_YAK".
RedLgTransportRAT:InitRandomizeTemplate(RedLgTansportsTemplate)
RedLgTransportRAT:SetTerminalType(AIRBASE.TerminalType.OpenBig)
RedLgTransportRAT:ExcludedAirports({AIRBASE.PersianGulf.Al_Maktoum_Intl, AIRBASE.PersianGulf.Sir_Abu_Nuayr, AIRBASE.PersianGulf.Tunb_Kochak, AIRBASE.PersianGulf.Havadarya})
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
local Phase = SEF_BattlePhaseCheckAwacsTankers()
RedLgTransportRAT:Spawn(17-(Phase*2))

--////RedHelos
local RedHelos = RAT:New("RAT Mi-24V", "Red Helo") --yak1:RAT("RAT_YAK") will create a RAT object called "yak1". The template group in the mission editor must have the name "RAT_YAK".
RedHelos:InitRandomizeTemplate(RedHeloTemplate)
RedHelos:SetCoalition("sameonly") --"same"=own coalition+neutral (default), "sameonly"=own coalition only, "neutral"=all neutral airports. Default is "same", so aircraft will use airports of the coalition their spawn template has plus all neutral airports.
RedHelos:SetTerminalType(AIRBASE.TerminalType.HelicopterUsable)
RedHelos:ExcludedAirports({AIRBASE.PersianGulf.Kerman_Airport, AIRBASE.PersianGulf.Sharjah_Intl})
RedHelos:SetMaxDistance(190)
RedHelos:_Debug(false) --Turn debug on=true or off=false. No argument means on.
RedHelos:EnableATC(true)
RedHelos:ATC_Messages(true)
RedHelos:CheckOnRunway(true, 75, distance)
RedHelos:CheckOnTop(true, 2)
RedHelos:ContinueJourney()
--RedHelos:RadioMenuON()
RedHelos:RespawnAfterCrashON()
RedHelos:RespawnInAirAllowed(true) --If aircraft cannot be spawned on parking spots, it is allowed to spawn them in air above the same airport.
RedHelos:SetEPLRS(true) --If true (or nil), turn EPLRS on.
RedHelos:PlaceMarkers(false)
--RedHelos:SetTakeoff("cold") --Type can be "takeoff-cold" or "cold", "takeoff-hot" or "hot", "takeoff-runway" or "runway", "air".
RedHelos:TimeDestroyInactive(300) --Time in seconds. Default is 600 seconds = 10 minutes. Minimum is 60 seconds.
local Phase = SEF_BattlePhaseCheckAwacsTankers()
RedHelos:Spawn((17-(Phase*2))/2)

--////blueHelos
local BlueHelos = RAT:New("RAT UH-60A", "Blue Helo") --yak1:RAT("RAT_YAK") will create a RAT object called "yak1". The template group in the mission editor must have the name "RAT_YAK".
BlueHelos:InitRandomizeTemplate(BlueHeloTemplate)
BlueHelos:SetTerminalType(AIRBASE.TerminalType.HelicopterUsable)
--BlueHelos:ExcludedAirports(AIRBASE.PersianGulf.Kerman_Airport, AIRBASE.PersianGulf.Shiraz_International_Airport)
BlueHelos:SetMaxDistance(190)
BlueHelos:_Debug(false) --Turn debug on=true or off=false. No argument means on.
BlueHelos:EnableATC(true)
BlueHelos:ATC_Messages(true)
BlueHelos:SetCoalition("sameonly") --"same"=own coalition+neutral (default), "sameonly"=own coalition only, "neutral"=all neutral airports. Default is "same", so aircraft will use airports of the coalition their spawn template has plus all neutral airports.
BlueHelos:CheckOnRunway(true, 75, distance)
BlueHelos:CheckOnTop(true, 2)
BlueHelos:ContinueJourney()
--RedHelos:RadioMenuON()
BlueHelos:RespawnAfterCrashON()
BlueHelos:RespawnInAirAllowed(true) --If aircraft cannot be spawned on parking spots, it is allowed to spawn them in air above the same airport.
BlueHelos:SetEPLRS(true) --If true (or nil), turn EPLRS on.
BlueHelos:PlaceMarkers(false)
--RedHelos:SetTakeoff("cold") --Type can be "takeoff-cold" or "cold", "takeoff-hot" or "hot", "takeoff-runway" or "runway", "air".
BlueHelos:TimeDestroyInactive(300) --Time in seconds. Default is 600 seconds = 10 minutes. Minimum is 60 seconds.
local Phase = SEF_BattlePhaseCheckAwacsTankers()
BlueHelos:Spawn(((Phase*2)+5)/2)

--////BlueLgTansports
local BlueLgTransportRAT = RAT:New("RAT - Galaxy", "Blue Transport") --yak1:RAT("RAT_YAK") will create a RAT object called "yak1". The template group in the mission editor must have the name "RAT_YAK".
BlueLgTransportRAT:InitRandomizeTemplate(BlueLgTansportsTemplate)
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
local Phase = SEF_BattlePhaseCheckAwacsTankers()
BlueLgTransportRAT:Spawn(((Phase*2)+5))

--[[
--////BlueCarrier
local BlueCarrierRAT = RAT:New("RAT - Greyhound", "Blue Carrier Transport") --yak1:RAT("RAT_YAK") will create a RAT object called "yak1". The template group in the mission editor must have the name "RAT_YAK".
BlueCarrierRAT:InitRandomizeTemplate(BlueCarrierTemplate)
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
]]--

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
--BlueTransportRAT:SetCoalitionAircraft(color) --Color of coalition, i.e. "red" or blue" or "neutral".
--BlueTransportRAT:RadioMenuOFF()
--BlueTransportRAT:Livery(skins)
--BlueTransportRAT:ExcludedAirports(ports)
--BlueTransportRAT:Commute(starshape) --If true, keep homebase, i.e. travel A-->B-->A-->C-->A-->D... instead of A-->B-->A-->B-->A...

env.info("RAT Compelte", false)