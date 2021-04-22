env.info("Navy Loading", false)


trigger.action.outSound('Background Chatter.ogg')

--////CARRIER GROUP PATROL ROUTE
--////Set Carrier Group To Patrol Waypoints Indefinately
GROUP:FindByName("CVN-75 Truman"):PatrolRoute()

GROUP:FindByName("CSG_CarrierGrp_Tarawa"):PatrolRoute()


if ( Group.getByName("Khasab - Navy") ) then
	GROUP:FindByName("Khasab - Navy"):PatrolRoute()
end

if ( Group.getByName("Sirri Island - Navy") ) then
	GROUP:FindByName("Sirri Island - Navy"):PatrolRoute()
end

if ( Group.getByName("Bandar Lengeh - Navy") ) then
	GROUP:FindByName("Bandar Lengeh - Navy"):PatrolRoute()
end

if ( Group.getByName("Seerik - Navy") ) then
	GROUP:FindByName("Seerik - Navy"):PatrolRoute()
end

if ( Group.getByName("Dibba Al Hisn - Navy") ) then
	GROUP:FindByName("Dibba Al Hisn - Navy"):PatrolRoute()
end

if ( Group.getByName("Jask - Coastal Patrol") ) then
	GROUP:FindByName("Jask - Coastal Patrol"):PatrolRoute()
end




--[[
local airbossTruman=AIRBOSS:New("CVN-75 Truman")
airbossTruman:SetSoundfilesFolder("Airboss Soundfiles/")
airbossTruman:SetVoiceOversLSOByRaynor()
airbossTruman:SetVoiceOversMarshalByRaynor()
airbossTruman:SetRespawnAI(true)
airbossTruman:SetStaticWeather(false)
airbossTruman:SetRecoveryTanker("22nd ARW Arco")
airbossTruman:SetTACAN(75, "X", "TRU")
airbossTruman:SetICLS(5, "TRU")
airbossTruman:SetBeaconRefresh(300)
airbossTruman:SetLSORadio(308.475, AM)
airbossTruman:SetMarshalRadio(285.675, AM)
airbossTruman:SetCarrierControlledArea(50)
airbossTruman:SetCarrierControlledZone(10)
airbossTruman:SetCollisionDistance(25, distance)
airbossTruman:AddRecoveryWindow("23:15", "23:45", 3, nil, true, 28)
airbossTruman:AddRecoveryWindow("00:15", "00:45", 3, nil, true, 28)
airbossTruman:AddRecoveryWindow("01:15", "01:45", 3, nil, true, 28)
airbossTruman:AddRecoveryWindow("02:15", "02:45", 3, nil, true, 28)
airbossTruman:AddRecoveryWindow("03:15", "03:45", 3, nil, true, 28)
airbossTruman:AddRecoveryWindow("04:15", "04:45", 3, nil, true, 28)
airbossTruman:AddRecoveryWindow("05:15", "05:45", 3, nil, true, 28)
airbossTruman:AddRecoveryWindow("06:15", "06:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("07:15", "07:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("08:15", "08:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("09:15", "09:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("10:15", "10:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("11:15", "11:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("12:15", "12:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("13:15", "13:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("14:15", "14:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("15:15", "15:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("16:15", "16:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("17:15", "17:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("18:15", "18:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("19:15", "19:45", 1, nil, true, 28)
airbossTruman:AddRecoveryWindow("20:15", "20:45", 3, nil, true, 28)
airbossTruman:AddRecoveryWindow("21:15", "21:45", 3, nil, true, 28)
airbossTruman:AddRecoveryWindow("22:15", "22:45", 3, nil, true, 28)
--airbossTruman:SetPatrolAdInfinitum(switch)
airbossTruman:SetDefaultPlayerSkill("Flight Student")
airbossTruman:SetMenuSmokeZones(false)
airbossTruman:SetMenuMarkZones(false)
airbossTruman:SetMenuSingleCarrier(true)
airbossTruman:SetMenuRecovery(15, 28, false, 30)
airbossTruman:SetAirbossNiceGuy(true)
--airbossTruman:SetAutoSave("C:\\AirbossGrades\\")
--airbossTruman:SetTrapSheet("C:\\AirbossGrades\\TrapSheets\\", "trap")
airbossTruman:Start()
]]--


-----------------------
--- Airboss Arco ---
-----------------------

local ArcoRoosevelt=RECOVERYTANKER:New(UNIT:FindByName("CVN-75 Truman"), "Tanker_S3-B_Arco1")
ArcoRoosevelt:SetTakeoffAir()
ArcoRoosevelt:SetTACAN(106, "ARC")
ArcoRoosevelt:SetRadio(251.500, "AM")
ArcoRoosevelt:SetCallsign(2,1)
ArcoRoosevelt:Start()

-----------------------
--- Airboss Truman ---
-----------------------

airbosstruman=AIRBOSS:New( "CVN-75 Truman", "Truman" )

airbosstruman:Load(nil, "PG_Airboss-USS Truman_LSOgrades.csv")
airbosstruman:SetAutoSave(nil, "PG_Airboss-USS Truman_LSOgrades.csv")

local trumanOffset_deg = 0
local trumanDefaultPlayerSkill = AIRBOSS.Difficulty.Normal -- default skill level
local trumanRadioRelayMarshall = UNIT:FindByName("RadioRelayMarshall_Truman")
local trumanRadioRelayPaddles = UNIT:FindByName("RadioRelayPaddles_Truman")
local trumanClouds, trumanVisibility, trumanFog, trumanDust = airbosstruman:_GetStaticWeather() -- get mission weather (assumes static weather is used)

--- Determine Daytime Case
-- adjust case according to weather state

local trumanCase = 1 -- default to Case I

if (trumanClouds.base < 305 and trumanClouds.density > 8) or trumanVisibility < 8000 then -- cloudbase < 1000' or viz < 5 miles, Case III
  trumanCase = 3
elseif trumanFog and trumanFog.thickness > 60 and trumanFog.visibility < 8000 then -- visibility in fog < 5nm, Case III
  trumanCase = 3
elseif (trumanClouds.base < 915 and trumanClouds.density > 8) and trumanVisibility >= 8000 then -- cloudbase < 3000', viz > 5 miles, Case II
  trumanCase = 2
end     
 
airbosstruman:SetMenuRecovery(20, 28, false, 30)
airbosstruman:SetSoundfilesFolder("Airboss Soundfiles/")
airbosstruman:SetVoiceOversLSOByRaynor()
airbosstruman:SetVoiceOversMarshalByRaynor()
airbosstruman:SetRecoveryTanker(ArcoRoosevelt)
airbosstruman:SetMaxSectionSize(4)
airbosstruman:SetTACAN(75,"X","TRU")
airbosstruman:SetICLS( 5,"TRU" )
airbosstruman:SetCarrierControlledArea( 50 )
airbosstruman:SetCollisionDistance(15)
airbosstruman:SetHandleAION()
airbosstruman:SetPatrolAdInfinitum(true)
airbosstruman:SetDespawnOnEngineShutdown(true)
airbosstruman:SetLSORadio(308.475, AM)
airbosstruman:SetMarshalRadio(285.675, AM)
airbosstruman:SetRadioRelayLSO( trumanRadioRelayPaddles )
airbosstruman:SetRadioRelayMarshal( trumanRadioRelayMarshall  )
airbosstruman:SetAirbossNiceGuy(true)
airbosstruman:SetDefaultPlayerSkill(trumanDefaultPlayerSkill)
airbosstruman:SetRespawnAI(true)
airbosstruman:SetMenuSmokeZones(false)
airbosstruman:SetMenuMarkZones(false) -- disable marking zones using smoke or flares

--[[
--- Fun Map Recovery Windows 
-- sunrise and sunset dependant on mission date
-- https://www.timeanddate.com/sun/united-arab-emirates/abu-dhabi?month=4&year=2011
-- Sunrise @ 05:45, Sunset @ 18:45, recovery sunrise+10 and @ sunset-10
-- otherwise, intiate recovery through F10 menu
--airbosstruman:AddRecoveryWindow( "5:55", "18:35", trumanCase, trumanOffset_deg, true, 30 ) 
--airbosstruman:AddRecoveryWindow( "18:35", "5:55+1", 3, trumanOffset_deg, true, 30 ) 
--airbosstruman:AddRecoveryWindow( "5:55+1", "18:35+1", trumanCase, trumanOffset_deg, true, 30 ) 


airbosstruman:AddRecoveryWindow("23:15", "23:45", 3, trumanOffset_deg, true, 28, true)
--airbosstruman:AddRecoveryWindow("00:15", "00:45", 3, trumanOffset_deg, true, 28)
airbosstruman:AddRecoveryWindow("01:15", "01:45", 3, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("02:15", "02:45", 3, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("03:15", "03:45", 3, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("04:15", "04:45", 3, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("05:15", "05:45", 3, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("06:15", "06:45", trumanCase, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("07:15", "07:45", trumanCase, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("08:15", "08:45", trumanCase, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("09:15", "09:45", trumanCase, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("10:15", "10:45", trumanCase, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("11:15", "11:45", trumanCase, trumanOffset_deg, true, 28, true)
--airbosstruman:AddRecoveryWindow("12:15", "12:45", trumanCase, trumanOffset_deg, true, 28)
airbosstruman:AddRecoveryWindow("13:15", "13:45", trumanCase, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("14:15", "14:45", trumanCase, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("15:15", "15:45", trumanCase, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("16:15", "16:45", trumanCase, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("17:15", "17:45", trumanCase, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("18:15", "18:45", trumanCase, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("19:15", "19:45", trumanCase, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("20:15", "20:45", 3, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("21:15", "21:45", 3, trumanOffset_deg, true, 28, true)
airbosstruman:AddRecoveryWindow("22:15", "22:45", 3, trumanOffset_deg, true, 28, true)
]]--

airbosstruman:Start()

-----------------------
--- Airboss Tarawa ---
-----------------------

airbossTarawa=AIRBOSS:New( "CSG_CarrierGrp_Tarawa", "Tarawa" )

airbossTarawa:Load(nil, "PG_Airboss-USS Tarawa_LSOgrades.csv")
airbossTarawa:SetAutoSave(nil, "PG_Airboss-USS Tarawa_LSOgrades.csv")

local tarawaOffset_deg = 0
local tarawaDefaultPlayerSkill = AIRBOSS.Difficulty.Normal -- default skill level
local tarawaRadioRelayMarshall = UNIT:FindByName("RadioRelayMarshall_Tarawa")
local tarawaRadioRelayPaddles = UNIT:FindByName("RadioRelayPaddles_Tarawa")
local tarawaClouds, tarawaVisibility, tarawaFog, tarawaDust = airbossTarawa:_GetStaticWeather() -- get mission weather (assumes static weather is used)

--- Determine Daytime Case
-- adjust case according to weather state

local tarawaCase = 1 -- default to Case I

if (tarawaClouds.base < 305 and tarawaClouds.density > 8) or tarawaVisibility < 8000 then -- cloudbase < 1000' or viz < 5 miles, Case III
  tarawaCase = 3
elseif tarawaFog and tarawaFog.thickness > 60 and tarawaFog.visibility < 8000 then -- visibility in fog < 5nm, Case III
  tarawaCase = 3
elseif (tarawaClouds.base < 915 and tarawaClouds.density > 8) and tarawaVisibility >= 8000 then -- cloudbase < 3000', viz > 5 miles, Case II
  tarawaCase = 2
end     
 
airbossTarawa:SetMenuRecovery(30, 25, false, 30)
airbossTarawa:SetSoundfilesFolder("Airboss Soundfiles/")
airbossTarawa:SetVoiceOversLSOByRaynor()
airbossTarawa:SetVoiceOversMarshalByRaynor()
airbossTarawa:SetTACAN(1,"X","TAR")
airbossTarawa:SetICLS( 1,"TAR" )
airbossTarawa:SetCarrierControlledArea( 50 )
airbossTarawa:SetCollisionDistance(10)
airbossTarawa:SetPatrolAdInfinitum(true)
airbossTarawa:SetDespawnOnEngineShutdown(true)
airbossTarawa:SetMarshalRadio( 285.675, "AM" )
airbossTarawa:SetLSORadio( 255.725, "AM" )
airbossTarawa:SetRadioRelayLSO( tarawaRadioRelayPaddles )
airbossTarawa:SetRadioRelayMarshal( tarawaRadioRelayMarshall  )
airbossTarawa:SetAirbossNiceGuy(true)
airbossTarawa:SetDefaultPlayerSkill(tarawaDefaultPlayerSkill)
airbossTarawa:SetRespawnAI(true)
airbossTarawa:SetMenuSmokeZones(false)
airbossTarawa:SetMenuMarkZones(false) -- disable marking zones using smoke or flares

--- Fun Map Recovery Windows 
-- sunrise and sunset dependant on mission date
-- https://www.timeanddate.com/sun/united-arab-emirates/abu-dhabi?month=4&year=2011
-- Sunrise @ 05:45, Sunset @ 18:45, recovery sunrise+10 and @ sunset-10
-- otherwise, intiate recovery through F10 menu
airbossTarawa:AddRecoveryWindow( "5:55", "18:35", tarawaCase, tarawaOffset_deg, true, 30 ) 
airbossTarawa:AddRecoveryWindow( "18:35", "5:55+1", 3, tarawaOffset_deg, true, 30 ) 
airbossTarawa:AddRecoveryWindow( "5:55+1", "18:35+1", tarawaCase, tarawaOffset_deg, true, 30 ) 

airbossTarawa:Start()

env.info("Navy Complete", false)