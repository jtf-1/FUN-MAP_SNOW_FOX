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

airbossTruman=AIRBOSS:New( "CVN-75 Truman", "Truman" )

airbossTruman:Load(nil, "PG_Airboss-USS Truman_LSOgrades.csv")
airbossTruman:SetAutoSave(nil, "PG_Airboss-USS Truman_LSOgrades.csv")

local TrumanOffset_deg = 0
local TrumanDefaultPlayerSkill = AIRBOSS.Difficulty.Normal -- default skill level
local TrumanRadioRelayMarshall = UNIT:FindByName("RadioRelayMarshall_Truman")
local TrumanRadioRelayPaddles = UNIT:FindByName("RadioRelayPaddles_Truman")
local TrumanClouds, TrumanVisibility, TrumanFog, TrumanDust = airbossTruman:_GetStaticWeather() -- get mission weather (assumes static weather is used)

--- Determine Daytime Case
-- adjust case according to weather state

local TrumanCase = 1 -- default to Case I

if (TrumanClouds.base < 305 and TrumanClouds.density > 8) or TrumanVisibility < 8000 then -- cloudbase < 1000' or viz < 5 miles, Case III
  TrumanCase = 3
elseif TrumanFog and TrumanFog.thickness > 60 and TrumanFog.visibility < 8000 then -- visibility in fog < 5nm, Case III
  TrumanCase = 3
elseif (TrumanClouds.base < 915 and TrumanClouds.density > 8) and TrumanVisibility >= 8000 then -- cloudbase < 3000', viz > 5 miles, Case II
  TrumanCase = 2
end     
 
airbossTruman:SetMenuRecovery(20, 28, false, 30)
airbossTruman:SetSoundfilesFolder("Airboss Soundfiles/")
airbossTruman:SetVoiceOversLSOByRaynor()
airbossTruman:SetVoiceOversMarshalByRaynor()
airbossTruman:SetRecoveryTanker(ArcoRoosevelt)
airbossTruman:SetMaxSectionSize(4)
airbossTruman:SetTACAN(75,"X","TRU")
airbossTruman:SetICLS( 5,"TRU" )
airbossTruman:SetCarrierControlledArea( 50 )
airbossTruman:SetCollisionDistance(15)
airbossTruman:SetHandleAION()
airbossTruman:SetPatrolAdInfinitum(true)
airbossTruman:SetDespawnOnEngineShutdown(true)
airbossTruman:SetLSORadio(308.475, AM)
airbossTruman:SetMarshalRadio(285.675, AM)
airbossTruman:SetRadioRelayLSO( TrumanRadioRelayPaddles )
airbossTruman:SetRadioRelayMarshal( TrumanRadioRelayMarshall  )
airbossTruman:SetAirbossNiceGuy(true)
airbossTruman:SetDefaultPlayerSkill(TrumanDefaultPlayerSkill)
airbossTruman:SetRespawnAI(true)
airbossTruman:SetMenuSmokeZones(false)
airbossTruman:SetMenuMarkZones(false) -- disable marking zones using smoke or flares

--- Fun Map Recovery Windows 
-- sunrise and sunset dependant on mission date
-- https://www.timeanddate.com/sun/united-arab-emirates/abu-dhabi?month=4&year=2011
-- Sunrise @ 05:45, Sunset @ 18:45, recovery sunrise+10 and @ sunset-10
-- otherwise, intiate recovery through F10 menu
--airbossTruman:AddRecoveryWindow( "5:55", "18:35", TrumanCase, TrumanOffset_deg, true, 30 ) 
--airbossTruman:AddRecoveryWindow( "18:35", "5:55+1", 3, TrumanOffset_deg, true, 30 ) 
--airbossTruman:AddRecoveryWindow( "5:55+1", "18:35+1", TrumanCase, TrumanOffset_deg, true, 30 ) 

--[[
airbossTruman:AddRecoveryWindow("23:15", "23:45", 3, TrumanOffset_deg, true, 28, true)
--airbossTruman:AddRecoveryWindow("00:15", "00:45", 3, TrumanOffset_deg, true, 28)
airbossTruman:AddRecoveryWindow("01:15", "01:45", 3, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("02:15", "02:45", 3, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("03:15", "03:45", 3, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("04:15", "04:45", 3, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("05:15", "05:45", 3, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("06:15", "06:45", TrumanCase, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("07:15", "07:45", TrumanCase, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("08:15", "08:45", TrumanCase, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("09:15", "09:45", TrumanCase, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("10:15", "10:45", TrumanCase, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("11:15", "11:45", TrumanCase, TrumanOffset_deg, true, 28, true)
--airbossTruman:AddRecoveryWindow("12:15", "12:45", TrumanCase, TrumanOffset_deg, true, 28)
airbossTruman:AddRecoveryWindow("13:15", "13:45", TrumanCase, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("14:15", "14:45", TrumanCase, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("15:15", "15:45", TrumanCase, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("16:15", "16:45", TrumanCase, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("17:15", "17:45", TrumanCase, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("18:15", "18:45", TrumanCase, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("19:15", "19:45", TrumanCase, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("20:15", "20:45", 3, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("21:15", "21:45", 3, TrumanOffset_deg, true, 28, true)
airbossTruman:AddRecoveryWindow("22:15", "22:45", 3, TrumanOffset_deg, true, 28, true)
]]--


airbossTruman:Start()

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