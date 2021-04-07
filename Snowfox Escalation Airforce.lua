env.info("Airforce Loading", false)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--////VARIABLES

CAPZoneBlueCarrier 	= ZONE_GROUP:New("CAP Zone Carrier", GROUP:FindByName( "CVN-75 Truman" ), 25000)

RedSquadronName1 = "Alpha"
RedSquadronName2 = "Beta"
RedSquadronName3 = "Gamma"
RedSquadronName4 = "Delta"
RedSquadronName5 = "Epsilon"

REDSQUADRON1GROUPNAME = ""
REDSQUADRON2GROUPNAME = ""
REDSQUADRON3GROUPNAME = ""
REDSQUADRON4GROUPNAME = ""
REDSQUADRON5GROUPNAME = ""

BlueSquadronName1 = "USN Fighter"
BlueSquadronName2 = "UAEAF Fighter"
BlueSquadronName3 = "USAF Fighter"
BlueSquadronName4 = "Zulu"
BlueSquadronName5 = "Xray"

BLUESQUADRON1GROUPNAME = ""
BLUESQUADRON2GROUPNAME = ""
BLUESQUADRON3GROUPNAME = ""
BLUESQUADRON4GROUPNAME = ""
BLUESQUADRON5GROUPNAME = ""

BlueSquadronsEnabled = 1
RedSquadronsEnabled = 1

BlueRespawnTimerInitialMin = 30
BlueRespawnTimerInitialMax = 60
RedRespawnTimerInitialMin = 150
RedRespawnTimerInitialMax = 300

BlueRespawnTimerMin = 300
BlueRespawnTimerMax = 900
RedRespawnTimerMin  = 900
RedRespawnTimerMax  = 1500

RedFlightLevelMin = 5
RedFlightLevelMax = 13
BlueFlightLevelMin = 5
BlueFlightLevelMax = 13

RedPatrolWaypointDistance = 46300
RedPatrolWaypointInitial = 18520

BluePatrolWaypointDistance = 46300
BluePatrolWaypointInitial = 18520

EngagementDistance = 74080

CleanupTime = 300

AlphaStatus = "Alpha Squadron\nAirspace Is Controlled By Iran\n"
BetaStatus = "Beta Squadron\nAirspace Is Controlled By Iran\n"
GammaStatus = "Gamma Squadron\nAirspace Is Controlled By Iran\n"
DeltaStatus = "Delta Squadron\nAirspace Is Controlled By Iran\n"
EpsilonStatus = "Epsilon Squadron\nAirspace Is Controlled By Iran\n"
ZuluStatus = "Zulu Squadron\nAirspace Is Controlled By The Allies\n"
XrayStatus = "Xrzy Squadron\nAirspace Is Controlled By The Allies\n"


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--////TABLES

USAFAirForceCAP  = { "USAF F-16C", 
				 	 "USAF F/A-18C", 
					 "USAF F-15C" }

USNAirForceCAP   = { "USAF F/A-18C", 
					 "USAF F-14B" }

UAEAFAirForceCAP = { "UAEAF M-2000C", 
					 "UAEAF F-16C" }

CombinedBlueCAP  = { "USAF F-16C", 
					 "USAF F/A-18C", 
					 "USAF F-15C", 
					 "USAF F-14B", 
					 "UAEAF M-2000C", 
					 "UAEAF F-16C" }

--////F-14A ~9.1% Chance
IRIAFAirForceCAP = { "IRIAF F-4E", 
					 "IRIAF F-5E-3", 
					 "IRIAF MiG-21Bis", 
					 "IRIAF MiG-29A", 
					 "IRIAF Mirage F1", 
					 "IRIAF F-4E", 
					 "IRIAF F-5E-3", 
					 "IRIAF MiG-21Bis", 
					 "IRIAF MiG-29A", 
					 "IRIAF Mirage F1",
					 "IRIAF F-14A" }

--////MiG-31 ~5.9% Chance
VVSAirForcesCAP  = { "VVS MiG-21Bis", 
				 	 "VVS MiG-29A", 
					 "VVS MiG-29S", 
					 "VVS MiG-23MLD", 
					 "VVS MiG-25PD",					 
					 "VVS Su-27", 
					 "VVS Su-30", 
					 "VVS Su-33",
					 "VVS MiG-21Bis", 
					 "VVS MiG-29A", 
					 "VVS MiG-29S", 
					 "VVS MiG-23MLD", 
					 "VVS MiG-25PD",					 
					 "VVS Su-27", 
					 "VVS Su-30", 
					 "VVS Su-33",
           "VVS JF-17", 				 	
					 "VVS MiG-31" }					 

--////MiG-31 or F-14A ~13.3% Chance
CombinedRedCAP 	 = { "IRIAF F-4E", 
					 "IRIAF F-5E-3", 
					 "IRIAF MiG-21Bis", 
					 "IRIAF MiG-29A", 
					 "IRIAF F-14A", 
					 "IRIAF Mirage F1", 
					 "VVS MiG-21Bis", 
					 "VVS MiG-29A", 
					 "VVS MiG-29S", 
					 "VVS MiG-23MLD", 
					 "VVS MiG-25PD", 
					 "VVS MiG-31", 
					 "VVS Su-27", 
					 "VVS Su-30", 
					 "VVS Su-33" }
					 
KhasabRedCAP 	 = { 
					"IRIAF F-4E", 
					"IRIAF F-5E-3", 
					"IRIAF MiG-21Bis", 
					"IRIAF MiG-29A", 
					--"IRIAF F-14A", 
					"IRIAF Mirage F1", 
					"VVS MiG-21Bis", 
					"VVS MiG-29A", 
					"VVS MiG-29S", 
					"VVS MiG-23MLD", 
					"VVS MiG-25PD", 
					"VVS MiG-31",
					--"VVS Su-27", 
					--"VVS Su-30", 
					--"VVS Su-33",
					 }

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

USAFAWACS_DATA = {}
USAFAWACS_DATA[1] = {
	TimeStamp 	= nil,
	Vec2 		= nil	
}

TEXACO_DATA = {}
TEXACO_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

SHELL_DATA = {}
SHELL_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

ARCO_DATA = {}
ARCO_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

REDSQUADRON1_DATA = {}
REDSQUADRON1_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
REDSQUADRON1_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

REDSQUADRON2_DATA = {}
REDSQUADRON2_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
REDSQUADRON2_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

REDSQUADRON3_DATA = {}
REDSQUADRON3_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
REDSQUADRON3_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

REDSQUADRON4_DATA = {}
REDSQUADRON4_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
REDSQUADRON4_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

REDSQUADRON5_DATA = {}
REDSQUADRON5_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
REDSQUADRON5_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

BLUESQUADRON1_DATA = {}
BLUESQUADRON1_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
BLUESQUADRON1_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

BLUESQUADRON2_DATA = {}
BLUESQUADRON2_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
BLUESQUADRON2_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

BLUESQUADRON3_DATA = {}
BLUESQUADRON3_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
BLUESQUADRON3_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

BLUESQUADRON4_DATA = {}
BLUESQUADRON4_DATA[1] = {
  TimeStamp   = nil,
  Vec2    = nil
}
BLUESQUADRON4_DATA[2] = {
  TimeStamp   = nil,
  Vec2    = nil
}

BLUESQUADRON5_DATA = {}
BLUESQUADRON5_DATA[1] = {
  TimeStamp   = nil,
  Vec2    = nil
}
BLUESQUADRON5_DATA[2] = {
  TimeStamp   = nil,
  Vec2    = nil
}

USAEFCAP_DATA = {}
USAEFCAP_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
USAEFCAP_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

USAEFCAS_DATA = {}
USAEFCAS_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
USAEFCAS_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

USAEFSEAD_DATA = {}
USAEFSEAD_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
USAEFSEAD_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

USAEFPIN_DATA = {}
USAEFPIN_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
USAEFPIN_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

USAEFASS_DATA = {}
USAEFASS_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
USAEFASS_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

USAEFDRONE_DATA = {}
USAEFDRONE_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

IRIAFC130_DATA = {}
IRIAFC130_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

IRIAFMI8_DATA = {}
IRIAFMI8_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

USAFC130_DATA = {}
USAFC130_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

USAFUH60A_DATA = {}
USAFUH60A_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

IRIAFSU24M_DATA = {}
IRIAFSU24M_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
IRIAFSU24M_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

VVSSU25T_DATA = {}
VVSSU25T_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}
VVSSU25T_DATA[2] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

VVSTU95MS_DATA = {}
VVSTU95MS_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

VVSTU160_DATA = {}
VVSTU160_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}

VVSTU22M3_DATA = {}
VVSTU22M3_DATA[1] = {
	TimeStamp 	= nil,
	Vec2		= nil
}					 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

SEF_AIRBASEINFORMATION = {}
SEF_AIRBASEINFORMATION[1] = {				
		AirbaseName = "Abu Dhabi Intl",
		Neighbours = { "Al-Bateen", "Sas Al Nakheel", "Al Dhafra AFB", "Al Maktoum Intl", "Al Ain Intl" },			
}	
SEF_AIRBASEINFORMATION[2] = {				
		AirbaseName = "Abu Musa Island",
		Neighbours = { "Tunb Island AFB", "Tunb Kochak", "Sirri Island", "Sir Abu Nuayr", "Dubai Intl", "Sharjah Intl", "Ras Al Khaimah Intl" },			
}
SEF_AIRBASEINFORMATION[3] = {				
		AirbaseName = "Al Ain Intl",
		Neighbours = { "Al Dhafra AFB", "Abu Dhabi Intl", "Al Maktoum Intl", "Al Minhad AFB", "Fujairah Intl" },		
}
SEF_AIRBASEINFORMATION[4] = {				
		AirbaseName = "Al-Bateen",
		Neighbours = { "Al Dhafra AFB", "Sas Al Nakheel", "Liwa AFB", "Sir Abu Nuayr" },		
}
SEF_AIRBASEINFORMATION[5] = {				
		AirbaseName = "Al Dhafra AFB",
		Neighbours = { "Liwa AFB", "Al-Bateen", "Sas Al Nakheel", "Abu Dhabi Intl", "Al Ain Intl" },		
}
SEF_AIRBASEINFORMATION[6] = {				
		AirbaseName = "Al Maktoum Intl",
		Neighbours = { "Abu Dhabi Intl", "Sir Abu Nuayr", "Al Minhad AFB", "Al Ain Intl", "Dubai Intl"  },		
}
SEF_AIRBASEINFORMATION[7] = {				
		AirbaseName = "Al Minhad AFB",
		Neighbours = { "Al Maktoum Intl", "Dubai Intl", "Fujairah Intl", "Al Ain Intl", "Sharjah Intl", "Sir Abu Nuayr" },		
}
SEF_AIRBASEINFORMATION[8] = {				
		AirbaseName = "Bandar Abbas Intl",
		Neighbours = { "Havadarya", "Qeshm Island", "Khasab", "Bandar-e-Jask", "Jiroft", "Lar", "Bandar Lengeh" },		
}
SEF_AIRBASEINFORMATION[9] = {				
		AirbaseName = "Bandar Lengeh",
		Neighbours = { "Lar", "Tunb Island AFB", "Tunb Kochak", "Kish Intl", "Sirri Island", "Abu Musa Island" },		
}
SEF_AIRBASEINFORMATION[10] = {				
		AirbaseName = "Bandar-e-Jask",
		Neighbours = { "Khasab", "Havadarya", "Bandar Abbas Intl", "Qeshm Island", "Ras Al Khaimah Intl", "Fujairah Intl" },		
}
SEF_AIRBASEINFORMATION[11] = {				
		AirbaseName = "Dubai Intl",
		Neighbours = { "Sharjah Intl", "Fujairah Intl", "Al Minhad AFB", "Al Maktoum Intl", "Sir Abu Nuayr", "Abu Musa Island", "Sirri Island" },		
}
SEF_AIRBASEINFORMATION[12] = {				
		AirbaseName = "Fujairah Intl",
		Neighbours = { "Bandar-e-Jask", "Ras Al Khaimah Intl", "Khasab", "Sharjah Intl", "Dubai Intl", "Al Minhad AFB", "Al Maktoum Intl", "Al Ain Intl" },		
}
SEF_AIRBASEINFORMATION[13] = {				
		AirbaseName = "Havadarya",
		Neighbours = { "Qeshm Island", "Bandar Abbas Intl", "Khasab", "Bandar-e-Jask", "Jiroft", "Lar", "Bandar Lengeh" },		
}
SEF_AIRBASEINFORMATION[14] = {				
		AirbaseName = "Jiroft",
		Neighbours = { "Kerman", "Bandar Abbas Intl", "Shiraz Intl", "Havadarya", "Lar", "Bandar-e-Jask" },		
}
SEF_AIRBASEINFORMATION[15] = {				
		AirbaseName = "Kerman",
		Neighbours = { "Lar", "Jiroft", "Shiraz Intl" },		
}
SEF_AIRBASEINFORMATION[16] = {				
		AirbaseName = "Khasab",
		Neighbours = { "Tunb Island AFB", "Tunb Kochak", "Ras Al Khaimah Intl", "Abu Musa Island", "Bandar-e-Jask", "Havadarya", "Bandar Abbas Intl", "Qeshm Island", "Bandar Lengeh" },		
}
SEF_AIRBASEINFORMATION[17] = {				
		AirbaseName = "Kish Intl",
		Neighbours = { "Bandar Lengeh", "Tunb Island AFB", "Tunb Kochak", "Sirri Island", "Lavan Island", "Lar", "Sir Abu Nuayr" },		
}
SEF_AIRBASEINFORMATION[18] = {				
		AirbaseName = "Lar",
		Neighbours = { "Lavan Island", "Kish Intl", "Bandar Lengeh", "Havadarya", "Bandar Abbas Intl", "Qeshm Island", "Jiroft", "Shiraz Intl" },		
}
SEF_AIRBASEINFORMATION[19] = {				
		AirbaseName = "Lavan Island",
		Neighbours = { "Lar", "Kish Intl", "Bandar Lengeh", "Shiraz Intl", "Sirri Island" },		
}
SEF_AIRBASEINFORMATION[20] = {				
		AirbaseName = "Liwa AFB",
		Neighbours = { "Al Dhafra AFB", "Al-Bateen", "Sas Al Nakheel" },		
}
SEF_AIRBASEINFORMATION[21] = {				
		AirbaseName = "Qeshm Island",
		Neighbours = { "Havadarya", "Bandar Abbas Intl", "Khasab", "Tunb Island AFB", "Tunb Kochak", "Bandar Lengeh", "Lar" },		
}
SEF_AIRBASEINFORMATION[22] = {				
		AirbaseName = "Ras Al Khaimah Intl",
		Neighbours = { "Tunb Island AFB", "Tunb Kochak", "Khasab", "Bandar-e-Jask", "Fujairah Intl", "Sharjah Intl", "Abu Musa Island" },		
}
SEF_AIRBASEINFORMATION[23] = {				
		AirbaseName = "Sas Al Nakheel",
		Neighbours = { "Al-Bateen", "Abu Dhabi Intl", "Al Dhafra AFB", "Sir Abu Nuayr"},		
}
SEF_AIRBASEINFORMATION[24] = {				
		AirbaseName = "Sharjah Intl",
		Neighbours = { "Dubai Intl", "Ras Al Khaimah Intl", "Fujairah Intl", "Al Minhad AFB", "Abu Musa Island", "Sirri Island" },		
}
SEF_AIRBASEINFORMATION[25] = {				
		AirbaseName = "Shiraz Intl",
		Neighbours = { "Lavan Island", "Lar", "Jiroft", "Kerman" },		
}
SEF_AIRBASEINFORMATION[26] = {				
		AirbaseName = "Sir Abu Nuayr",
		Neighbours = { "Abu Musa Island", "Sirri Island", "Sharjah Intl", "Al-Bateen", "Abu Dhabi Intl", "Sas Al Nakheel", "Al Maktoum Intl", "Al Minhad AFB", "Dubai Intl" },		
}
SEF_AIRBASEINFORMATION[27] = {				
		AirbaseName = "Sirri Island",
		Neighbours = { "Sir Abu Nuayr", "Abu Musa Island", "Tunb Island AFB", "Tunb Kochak", "Kish Intl", "Bandar Lengeh", "Dubai Intl", "Sharjah Intl" },		
}
SEF_AIRBASEINFORMATION[28] = {				
		AirbaseName = "Tunb Island AFB",
		Neighbours = { "Tunb Kochak", "Bandar Lengeh", "Sirri Island", "Abu Musa Island", "Kish Intl", "Khasab", "Ras Al Khaimah Intl" },		
}
SEF_AIRBASEINFORMATION[29] = {				
		AirbaseName = "Tunb Kochak",
		Neighbours = { "Tunb Island AFB", "Bandar Lengeh", "Sirri Island", "Abu Musa Island", "Kish Intl", "Khasab", "Ras Al Khaimah Intl" },		
}

function SEF_BLUESQUADRONSTOGGLE()
	if ( BlueSquadronsEnabled == 1 ) then		
		BlueSquadronsEnabled = 0
		trigger.action.outText("Allied AI CAP Flights Are Now Disabled", 15)		
	elseif ( BlueSquadronsEnabled == 0 ) then			
		BlueSquadronsEnabled = 1
		trigger.action.outText("Allied AI CAP Flights Are Now Enabled", 15)
	else
	end	
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--////RED SQUADRONS
--------------------------------------------------------------------------------------------------------------------------------------------------------------------

function SEF_REDSQUADRON1_SCHEDULER()
    
	if ( RedSquadronsEnabled == 1 ) then
		if ( GROUP:FindByName(REDSQUADRON1GROUPNAME) ~= nil and GROUP:FindByName(REDSQUADRON1GROUPNAME):IsAlive() ) then				
			timer.scheduleFunction(SEF_REDSQUADRON1_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))			
		else
			SEF_REDSQUADRON1_INITIALISE()
			
			timer.scheduleFunction(SEF_REDSQUADRON1_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))
		end
	else	
		timer.scheduleFunction(SEF_REDSQUADRON1_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))		
	end	
end

function SEF_REDSQUADRON2_SCHEDULER()
    
	if ( RedSquadronsEnabled == 1 ) then
		if ( GROUP:FindByName(REDSQUADRON2GROUPNAME) ~= nil and GROUP:FindByName(REDSQUADRON2GROUPNAME):IsAlive() ) then				
			timer.scheduleFunction(SEF_REDSQUADRON2_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))			
		else
			SEF_REDSQUADRON2_INITIALISE()
			
			timer.scheduleFunction(SEF_REDSQUADRON2_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))
		end
	else	
		timer.scheduleFunction(SEF_REDSQUADRON2_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))		
	end	
end

function SEF_REDSQUADRON3_SCHEDULER()
    
	if ( RedSquadronsEnabled == 1 ) then
		if ( GROUP:FindByName(REDSQUADRON3GROUPNAME) ~= nil and GROUP:FindByName(REDSQUADRON3GROUPNAME):IsAlive() ) then				
			timer.scheduleFunction(SEF_REDSQUADRON3_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))			
		else
			SEF_REDSQUADRON3_INITIALISE()
			
			timer.scheduleFunction(SEF_REDSQUADRON3_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))
		end
	else	
		timer.scheduleFunction(SEF_REDSQUADRON3_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))		
	end	
end

function SEF_REDSQUADRON4_SCHEDULER()
    
	if ( RedSquadronsEnabled == 1 ) then
		if ( GROUP:FindByName(REDSQUADRON4GROUPNAME) ~= nil and GROUP:FindByName(REDSQUADRON4GROUPNAME):IsAlive() ) then				
			timer.scheduleFunction(SEF_REDSQUADRON4_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))			
		else
			SEF_REDSQUADRON4_INITIALISE()
			
			timer.scheduleFunction(SEF_REDSQUADRON4_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))
		end
	else	
		timer.scheduleFunction(SEF_REDSQUADRON4_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))		
	end	
end

function SEF_REDSQUADRON5_SCHEDULER()
    
	if ( RedSquadronsEnabled == 1 ) then
		if ( GROUP:FindByName(REDSQUADRON5GROUPNAME) ~= nil and GROUP:FindByName(REDSQUADRON5GROUPNAME):IsAlive() ) then				
			timer.scheduleFunction(SEF_REDSQUADRON5_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))			
		else
			SEF_REDSQUADRON5_INITIALISE()
			
			timer.scheduleFunction(SEF_REDSQUADRON5_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))
		end
	else	
		timer.scheduleFunction(SEF_REDSQUADRON5_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerMin, RedRespawnTimerMax))		
	end	
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

function SEF_REDSQUADRON1_INITIALISE()

	--Retrieve The Standard Deployment For The Squadron
	SEF_REDSQUADRON1_DEPLOYMENT()
	
	SET_AIRFIELDPERIMETERCLIENTS = SET_CLIENT:New():FilterCoalitions("blue"):FilterCategories( { "plane", "helicopter" } ):FilterActive():FilterOnce()
	
	AlphaPrimaryPerimeterCount = 0			
			
	--ALPHA
	SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AlphaPrimaryAirbase.." Perimeter Zone"), function ( GroupObject )	
		AlphaPrimaryPerimeterCount = AlphaPrimaryPerimeterCount + 1		
		end
	)	
	
	--////ALPHA			
	if ( AlphaPrimaryPerimeterCount > 0 ) then		
		AlphaStatus = AlphaPrimaryAirbase.." - Alpha Squadron\nAirspace Is Being Contested By The Allies\n"
		
		--Sirri Island -> Kish -> Bandar Lengeh -> Lar
		
		if ( AlphaPrimaryAirbase == AIRBASE.PersianGulf.Sirri_Island ) then
			
			KishPerimeterCount = 0
			BandarLengehPerimeterCount = 0
					
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Bandar_Lengeh.." Perimeter Zone"), function ( GroupObject )
				BandarLengehPerimeterCount = BandarLengehPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Kish_International_Airport.." Perimeter Zone"), function ( GroupObject )
				KishPerimeterCount = KishPerimeterCount + 1		
				end
			)		

			if ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Lengeh):getCoalition() == 1 and BandarLengehPerimeterCount == 0 ) then				
				SEF_REDSQUADRON1_SPAWN(AIRBASE.PersianGulf.Bandar_Lengeh, AlphaDestinationAirbase)				
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 1 and KishPerimeterCount == 0 ) then			
				SEF_REDSQUADRON1_SPAWN(AIRBASE.PersianGulf.Kish_International_Airport, AlphaDestinationAirbase)
			else			
				SEF_REDSQUADRON1_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, AlphaDestinationAirbase)
			end									
		
		elseif ( AlphaPrimaryAirbase == AIRBASE.PersianGulf.Kish_International_Airport ) then
		
			SirriPerimeterCount = 0
			BandarLengehPerimeterCount = 0
			
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Sirri_Island.." Perimeter Zone"), function ( GroupObject )
				SirriPerimeterCount = SirriPerimeterCount + 1		
				end
			)			
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Bandar_Lengeh.." Perimeter Zone"), function ( GroupObject )
				BandarLengehPerimeterCount = BandarLengehPerimeterCount + 1		
				end
			)
			
			if ( Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 1 and SirriPerimeterCount == 0 ) then			
				SEF_REDSQUADRON1_SPAWN(AIRBASE.PersianGulf.Sirri_Island, AlphaDestinationAirbase)
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Lengeh):getCoalition() == 1 and BandarLengehPerimeterCount == 0 ) then			
				SEF_REDSQUADRON1_SPAWN(AIRBASE.PersianGulf.Bandar_Lengeh, AlphaDestinationAirbase)
			else			
				SEF_REDSQUADRON1_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, AlphaDestinationAirbase)
			end				
		elseif ( AlphaPrimaryAirbase == AIRBASE.PersianGulf.Bandar_Lengeh ) then
		
			KishPerimeterCount = 0
			SirriPerimeterCount = 0

			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Kish_International_Airport.." Perimeter Zone"), function ( GroupObject )
				KishPerimeterCount = KishPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Sirri_Island.." Perimeter Zone"), function ( GroupObject )
				SirriPerimeterCount = SirriPerimeterCount + 1		
				end
			)
			
			if ( Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 1 and KishPerimeterCount == 0 ) then			
				SEF_REDSQUADRON1_SPAWN(AIRBASE.PersianGulf.Kish_International_Airport, AlphaDestinationAirbase)
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 1 and SirriPerimeterCount == 0 ) then			
				SEF_REDSQUADRON1_SPAWN(AIRBASE.PersianGulf.Sirri_Island, AlphaDestinationAirbase)
			else			
				SEF_REDSQUADRON1_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, AlphaDestinationAirbase)
			end
		elseif ( AlphaPrimaryAirbase == AIRBASE.PersianGulf.Lar_Airbase ) then			
			SEF_REDSQUADRON1_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, AlphaDestinationAirbase)
		else			
			SEF_REDSQUADRON1_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, AlphaDestinationAirbase)
		end		
	else
		AlphaStatus = AlphaPrimaryAirbase.." - Alpha Squadron\nAirspace Is Controlled By Iran\n"
		SEF_REDSQUADRON1_SPAWN(AlphaPrimaryAirbase, AlphaDestinationAirbase)
	end
end

function SEF_REDSQUADRON1_DEPLOYMENT()	
		
	--ALPHA
	if ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Lengeh):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 1 ) then
		--Set Alpha To Sirri Island And Patrol Sirri, Hold The Forward Line
		AlphaPrimaryAirbase = AIRBASE.PersianGulf.Sirri_Island
		AlphaDestinationAirbase = AIRBASE.PersianGulf.Sirri_Island
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Lengeh):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() ~= 1 ) then
		--Set Alpha To Sirri Island And Patrol Sirri, Ignore The Loss Of Kish And Hold The Forward Line
		AlphaPrimaryAirbase = AIRBASE.PersianGulf.Sirri_Island
		AlphaDestinationAirbase = AIRBASE.PersianGulf.Sirri_Island
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Lengeh):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 1 ) then
		--Set Alpha To Bandar Lengeh Or Kish Island And Patrol Sirri, We Are Trying To Recapture Sirri Island		
		local Randomiser = math.random(1,100)		
		if ( Randomiser <= 50 ) then
			--Set Alpha To Bandar Lengeh And Patrol Sirri, We Are Trying To Recapture Sirri Island
			AlphaPrimaryAirbase = AIRBASE.PersianGulf.Bandar_Lengeh
			AlphaDestinationAirbase = AIRBASE.PersianGulf.Sirri_Island
		else
			--Set Alpha To Kish And Patrol Sirri, We Are Trying To Recapture Sirri Island
			AlphaPrimaryAirbase = AIRBASE.PersianGulf.Kish_International_Airport
			AlphaDestinationAirbase = AIRBASE.PersianGulf.Sirri_Island
		end
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Lengeh):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() ~= 1 ) then
		--Set Alpha To Bandar Lengeh And Patrol Sirri, Ignore The Loss Of Kish And Hold The Forward Line
		AlphaPrimaryAirbase = AIRBASE.PersianGulf.Bandar_Lengeh
		AlphaDestinationAirbase = AIRBASE.PersianGulf.Sirri_Island			
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Lengeh):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 1 ) then
		--Set Alpha To Kish Or Sirri Or Lar And Patrol Bandar Lengeh As We Need That Link Back		
		local Randomiser = math.random(1,100)		
		if ( Randomiser <= 33 ) then		
			AlphaPrimaryAirbase = AIRBASE.PersianGulf.Kish_International_Airport
			AlphaDestinationAirbase = AIRBASE.PersianGulf.Bandar_Lengeh	
		elseif ( Randomiser > 33 and Randomiser <= 66 ) then
			AlphaPrimaryAirbase = AIRBASE.PersianGulf.Sirri_Island
			AlphaDestinationAirbase = AIRBASE.PersianGulf.Bandar_Lengeh
		else
			AlphaPrimaryAirbase = AIRBASE.PersianGulf.Lar_Airbase
			AlphaDestinationAirbase = AIRBASE.PersianGulf.Bandar_Lengeh
		end	
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Lengeh):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() ~= 1 ) then
		--Set Alpha To Sirri Or Lar And Patrol Bandar Lengeh As We Need That Link Back		
		local Randomiser = math.random(1,100)		
		if ( Randomiser <= 50 ) then			
			AlphaPrimaryAirbase = AIRBASE.PersianGulf.Sirri_Island
			AlphaDestinationAirbase = AIRBASE.PersianGulf.Bandar_Lengeh	
		else			
			AlphaPrimaryAirbase = AIRBASE.PersianGulf.Lar_Airbase
			AlphaDestinationAirbase = AIRBASE.PersianGulf.Bandar_Lengeh
		end	
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Lengeh):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 1 ) then
		--Set Alpha To Kish Or Lar And Patrol Bandar Lengeh As We Need That Link Back		
		local Randomiser = math.random(1,100)		
		if ( Randomiser <= 50 ) then			
			AlphaPrimaryAirbase = AIRBASE.PersianGulf.Kish_International_Airport
			AlphaDestinationAirbase = AIRBASE.PersianGulf.Bandar_Lengeh			
		else			
			AlphaPrimaryAirbase = AIRBASE.PersianGulf.Lar_Airbase
			AlphaDestinationAirbase = AIRBASE.PersianGulf.Bandar_Lengeh
		end
	else
		--Set Alpha To Lar And Patrol Bandar Lengeh As We Need That Link Back		
		AlphaPrimaryAirbase = AIRBASE.PersianGulf.Lar_Airbase
		AlphaDestinationAirbase = AIRBASE.PersianGulf.Bandar_Lengeh
	end		
end

function SEF_REDSQUADRON1_SPAWN(DepartureAirbaseName, DestinationAirbaseName)
	
	if ( GROUP:FindByName(REDSQUADRON1GROUPNAME) ~= nil and GROUP:FindByName(REDSQUADRON1GROUPNAME):IsAlive() ) then
		--trigger.action.outText("Red Squadron 1 Is Currently Active, Not Spawning A Replacement Yet",15)	
	else
		REDSQUADRON1_DATA[1].Vec2 = nil
		REDSQUADRON1_DATA[1].TimeStamp = nil
		REDSQUADRON1_DATA[2].Vec2 = nil
		REDSQUADRON1_DATA[2].TimeStamp = nil
		
		local SpawnZone = AIRBASE:FindByName(DepartureAirbaseName):GetZone()
		local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		
		local Randomiser = math.random(RedFlightLevelMin,RedFlightLevelMax)
		RS1_FlightLevel = Randomiser * 1000
				
		local DepartureZoneVec2 = SpawnZone:GetVec2()
		local TargetZoneVec2 	= DestinationZone:GetVec2()
					
		local FlightDirection = math.random(1,100)
					
		if ( FlightDirection <= 50 ) then			
			--////Clockwise
			--Spawn Point
			RS1_WP0X = DepartureZoneVec2.x
			RS1_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			RS1_WP1X = DepartureZoneVec2.x + RedPatrolWaypointInitial
			RS1_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone North Point
			RS1_WP2X = TargetZoneVec2.x + RedPatrolWaypointDistance
			RS1_WP2Y = TargetZoneVec2.y 						
			--Perimeter Zone East Point
			RS1_WP3X = TargetZoneVec2.x
			RS1_WP3Y = TargetZoneVec2.y + RedPatrolWaypointDistance						
			--Perimeter Zone South Point
			RS1_WP4X = TargetZoneVec2.x - RedPatrolWaypointDistance
			RS1_WP4Y = TargetZoneVec2.y						
			--Perimeter Zone West Point
			RS1_WP5X = TargetZoneVec2.x
			RS1_WP5Y = TargetZoneVec2.y - RedPatrolWaypointDistance								
		else			
			--////Anti-Clockwise
			--Spawn Point
			RS1_WP0X = DepartureZoneVec2.x
			RS1_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			RS1_WP1X = DepartureZoneVec2.x - RedPatrolWaypointInitial
			RS1_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone South Point
			RS1_WP2X = TargetZoneVec2.x - RedPatrolWaypointDistance
			RS1_WP2Y = TargetZoneVec2.y 						
			--Perimeter Zone East Point
			RS1_WP3X = TargetZoneVec2.x
			RS1_WP3Y = TargetZoneVec2.y + RedPatrolWaypointDistance						
			--Perimeter Zone North Point
			RS1_WP4X = TargetZoneVec2.x + RedPatrolWaypointDistance
			RS1_WP4Y = TargetZoneVec2.y						
			--Perimeter Zone West Point
			RS1_WP5X = TargetZoneVec2.x
			RS1_WP5Y = TargetZoneVec2.y - RedPatrolWaypointDistance					
		end		
		
		REDSQUADRON1 = SPAWN:NewWithAlias("IRIAF MiG-29A", RedSquadronName1)
							:InitRandomizeTemplate(IRIAFAirForceCAP)									
		
		:OnSpawnGroup(
			function( SpawnGroup )						
				REDSQUADRON1GROUPNAME = SpawnGroup.GroupName
				REDSQUADRON1GROUP = GROUP:FindByName(SpawnGroup.GroupName)							
													
				--////CAP Mission Profile, Engage Targets Along Route Unrestricted Distance, Switch Waypoint From WP5 to WP2, 0.7Mach, Randomised Flight Level From Above Parameters
				Mission = {
					["id"] = "Mission",
					["params"] = {		
						["route"] = 
						{                                    
							["points"] = 
							{
								[1] = 
								{
									["alt"] = RS1_FlightLevel/2,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["enabled"] = true,
													["auto"] = true,
													["id"] = "WrappedAction",
													["number"] = 1,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "EPLRS",
															["params"] = 
															{
																["value"] = true,
																["groupId"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
												[2] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 2,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["variantIndex"] = 1,
																["name"] = 5,
																["formationIndex"] = 6,
																["value"] = 393217,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [2]
												[3] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "EngageTargets",
													["number"] = 3,
													["params"] = 
													{
														["targetTypes"] = 
														{
															[1] = "Air",
														}, -- end of ["targetTypes"]
														["priority"] = 0,
														["value"] = "Air;",
														["noTargetTypes"] = 
														{
															[1] = "Cruise missiles",
															[2] = "Antiship Missiles",
															[3] = "AA Missiles",
															[4] = "AG Missiles",
															[5] = "SA Missiles",
														}, -- end of ["noTargetTypes"]
														["maxDistEnabled"] = true,
														["maxDist"] = EngagementDistance,
													}, -- end of ["params"]
												}, -- end of [3]
												[4] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 4,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 3,
																["name"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [4]
												[5] = 
												{
													["number"] = 5,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 264241152,
																["name"] = 10,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [5]
												[6] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 6,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 19,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [6]
												[7] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 7,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [7]		
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 0,
									["ETA_locked"] = true,
									["y"] = RS1_WP0Y,
									["x"] = RS1_WP0X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [1]
								[2] = 
								{
									["alt"] = RS1_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 127.32626754758,
									["ETA_locked"] = false,
									["y"] = RS1_WP1Y,
									["x"] = RS1_WP1X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [2]
								[3] = 
								{
									["alt"] = RS1_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 380.31328316984,
									["ETA_locked"] = false,
									["y"] = RS1_WP2Y,
									["x"] = RS1_WP2X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [3]
								[4] = 
								{
									["alt"] = RS1_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 832.92276094724,
									["ETA_locked"] = false,
									["y"] = RS1_WP3Y,
									["x"] = RS1_WP3X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [4]
								[5] = 
								{
									["alt"] = RS1_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1289.20366255,
									["ETA_locked"] = false,
									["y"] = RS1_WP4Y,
									["x"] = RS1_WP4X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [5]
								[6] = 
								{
									["alt"] = RS1_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["number"] = 1,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "SwitchWaypoint",
															["params"] = 
															{
																["goToWaypointIndex"] = 3,
																["fromWaypointIndex"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1744.9128539618,
									["ETA_locked"] = false,
									["y"] = RS1_WP5Y,
									["x"] = RS1_WP5X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [6]
							}, -- end of ["points"]
						}, -- end of ["route"]
					}, --end of ["params"]
				}--end of Mission				
				REDSQUADRON1GROUP:SetTask(Mission)				
			end
		)
		--:SpawnInZone( SpawnZone, false, RS1_FlightLevel, RS1_FlightLevel )
		:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot ) --SPAWN.Takeoff.Hot SPAWN.Takeoff.Cold SPAWN.Takeoff.Runway
		--trigger.action.outText("Red Squadron 1 Is Launching Fighters", 15)	
	end
end

function SEF_REDSQUADRON2_SPAWN(DepartureAirbaseName, DestinationAirbaseName)
	
	if ( GROUP:FindByName(REDSQUADRON2GROUPNAME) ~= nil and GROUP:FindByName(REDSQUADRON2GROUPNAME):IsAlive() ) then
		--trigger.action.outText("Red Squadron 2 Is Currently Active, Not Spawning A Replacement Yet",15)	
	else
		REDSQUADRON2_DATA[1].Vec2 = nil
		REDSQUADRON2_DATA[1].TimeStamp = nil
		REDSQUADRON2_DATA[2].Vec2 = nil
		REDSQUADRON2_DATA[2].TimeStamp = nil
		
		if ( DepartureAirbaseName == "Khasab" ) then
			RS2CAPTable = KhasabRedCAP
		else
			RS2CAPTable = CombinedRedCAP
		end
		
		local SpawnZone = AIRBASE:FindByName(DepartureAirbaseName):GetZone()
		local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		
		local Randomiser = math.random(RedFlightLevelMin,RedFlightLevelMax)
		RS2_FlightLevel = Randomiser * 1000
				
		local DepartureZoneVec2 = SpawnZone:GetVec2()
		local TargetZoneVec2 	= DestinationZone:GetVec2()
					
		local FlightDirection = math.random(1,100)
					
		if ( FlightDirection <= 50 ) then			
			--////Clockwise
			--Spawn Point
			RS2_WP0X = DepartureZoneVec2.x
			RS2_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			RS2_WP1X = DepartureZoneVec2.x + RedPatrolWaypointInitial
			RS2_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone North Point
			RS2_WP2X = TargetZoneVec2.x + RedPatrolWaypointDistance
			RS2_WP2Y = TargetZoneVec2.y 						
			--Perimeter Zone East Point
			RS2_WP3X = TargetZoneVec2.x
			RS2_WP3Y = TargetZoneVec2.y + RedPatrolWaypointDistance						
			--Perimeter Zone South Point
			RS2_WP4X = TargetZoneVec2.x - RedPatrolWaypointDistance
			RS2_WP4Y = TargetZoneVec2.y						
			--Perimeter Zone West Point
			RS2_WP5X = TargetZoneVec2.x
			RS2_WP5Y = TargetZoneVec2.y - RedPatrolWaypointDistance								
		else			
			--////Anti-Clockwise
			--Spawn Point
			RS2_WP0X = DepartureZoneVec2.x
			RS2_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			RS2_WP1X = DepartureZoneVec2.x - RedPatrolWaypointInitial
			RS2_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone South Point
			RS2_WP2X = TargetZoneVec2.x - RedPatrolWaypointDistance
			RS2_WP2Y = TargetZoneVec2.y 						
			--Perimeter Zone East Point
			RS2_WP3X = TargetZoneVec2.x
			RS2_WP3Y = TargetZoneVec2.y + RedPatrolWaypointDistance						
			--Perimeter Zone North Point
			RS2_WP4X = TargetZoneVec2.x + RedPatrolWaypointDistance
			RS2_WP4Y = TargetZoneVec2.y						
			--Perimeter Zone West Point
			RS2_WP5X = TargetZoneVec2.x
			RS2_WP5Y = TargetZoneVec2.y - RedPatrolWaypointDistance					
		end		
		
		REDSQUADRON2 = SPAWN:NewWithAlias("IRIAF MiG-29A", RedSquadronName2)
							:InitRandomizeTemplate(RS2CAPTable)									
		
		:OnSpawnGroup(
			function( SpawnGroup )						
				REDSQUADRON2GROUPNAME = SpawnGroup.GroupName
				REDSQUADRON2GROUP = GROUP:FindByName(SpawnGroup.GroupName)							
													
				--////CAP Mission Profile, Engage Targets Along Route Unrestricted Distance, Switch Waypoint From WP5 to WP2, 0.7Mach, Randomised Flight Level From Above Parameters
				Mission = {
					["id"] = "Mission",
					["params"] = {		
						["route"] = 
						{                                    
							["points"] = 
							{
								[1] = 
								{
									["alt"] = RS2_FlightLevel/2,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["enabled"] = true,
													["auto"] = true,
													["id"] = "WrappedAction",
													["number"] = 1,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "EPLRS",
															["params"] = 
															{
																["value"] = true,
																["groupId"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
												[2] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 2,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["variantIndex"] = 1,
																["name"] = 5,
																["formationIndex"] = 6,
																["value"] = 393217,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [2]
												[3] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "EngageTargets",
													["number"] = 3,
													["params"] = 
													{
														["targetTypes"] = 
														{
															[1] = "Air",
														}, -- end of ["targetTypes"]
														["priority"] = 0,
														["value"] = "Air;",
														["noTargetTypes"] = 
														{
															[1] = "Cruise missiles",
															[2] = "Antiship Missiles",
															[3] = "AA Missiles",
															[4] = "AG Missiles",
															[5] = "SA Missiles",
														}, -- end of ["noTargetTypes"]
														["maxDistEnabled"] = true,
														["maxDist"] = EngagementDistance,
													}, -- end of ["params"]
												}, -- end of [3]
												[4] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 4,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 3,
																["name"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [4]
												[5] = 
												{
													["number"] = 5,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 264241152,
																["name"] = 10,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [5]
												[6] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 6,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 19,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [6]
												[7] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 7,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [7]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 0,
									["ETA_locked"] = true,
									["y"] = RS2_WP0Y,
									["x"] = RS2_WP0X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [1]
								[2] = 
								{
									["alt"] = RS2_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 127.32626754758,
									["ETA_locked"] = false,
									["y"] = RS2_WP1Y,
									["x"] = RS2_WP1X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [2]
								[3] = 
								{
									["alt"] = RS2_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 380.31328316984,
									["ETA_locked"] = false,
									["y"] = RS2_WP2Y,
									["x"] = RS2_WP2X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [3]
								[4] = 
								{
									["alt"] = RS2_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 832.92276094724,
									["ETA_locked"] = false,
									["y"] = RS2_WP3Y,
									["x"] = RS2_WP3X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [4]
								[5] = 
								{
									["alt"] = RS2_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1289.20366255,
									["ETA_locked"] = false,
									["y"] = RS2_WP4Y,
									["x"] = RS2_WP4X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [5]
								[6] = 
								{
									["alt"] = RS2_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["number"] = 1,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "SwitchWaypoint",
															["params"] = 
															{
																["goToWaypointIndex"] = 3,
																["fromWaypointIndex"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1744.9128539618,
									["ETA_locked"] = false,
									["y"] = RS2_WP5Y,
									["x"] = RS2_WP5X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [6]
							}, -- end of ["points"]
						}, -- end of ["route"]
					}, --end of ["params"]
				}--end of Mission				
				REDSQUADRON2GROUP:SetTask(Mission)				
			end
		)
		if ( DepartureAirbaseName == AIRBASE.PersianGulf.Khasab ) then
			REDSQUADRON2:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Khasab), {4,5,2,3}, SPAWN.Takeoff.Hot)
		else
			REDSQUADRON2:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )
		end		
		--:SpawnInZone( SpawnZone, false, RS2_FlightLevel, RS2_FlightLevel )
		--:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot ) --SPAWN.Takeoff.Hot SPAWN.Takeoff.Cold SPAWN.Takeoff.Runway
		--trigger.action.outText("Red Squadron 2 Is Launching Fighters", 15)	
	end
end

function SEF_REDSQUADRON3_SPAWN(DepartureAirbaseName, DestinationAirbaseName)
	
	if ( GROUP:FindByName(REDSQUADRON3GROUPNAME) ~= nil and GROUP:FindByName(REDSQUADRON3GROUPNAME):IsAlive() ) then
		--trigger.action.outText("Red Squadron 3 Is Currently Active, Not Spawning A Replacement Yet",15)	
	else					
		REDSQUADRON3_DATA[1].Vec2 = nil
		REDSQUADRON3_DATA[1].TimeStamp = nil
		REDSQUADRON3_DATA[2].Vec2 = nil
		REDSQUADRON3_DATA[2].TimeStamp = nil
		
		local SpawnZone = AIRBASE:FindByName(DepartureAirbaseName):GetZone()
		local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		
		local Randomiser = math.random(RedFlightLevelMin,RedFlightLevelMax)
		RS3_FlightLevel = Randomiser * 1000
				
		local DepartureZoneVec2 = SpawnZone:GetVec2()
		local TargetZoneVec2 	= DestinationZone:GetVec2()
					
		local FlightDirection = math.random(1,100)
					
		if ( FlightDirection <= 50 ) then			
			--////Clockwise
			--Spawn Point
			RS3_WP0X = DepartureZoneVec2.x
			RS3_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			RS3_WP1X = DepartureZoneVec2.x + RedPatrolWaypointInitial
			RS3_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone North Point
			RS3_WP2X = TargetZoneVec2.x + RedPatrolWaypointDistance
			RS3_WP2Y = TargetZoneVec2.y 						
			--Perimeter Zone East Point
			RS3_WP3X = TargetZoneVec2.x
			RS3_WP3Y = TargetZoneVec2.y + RedPatrolWaypointDistance						
			--Perimeter Zone South Point
			RS3_WP4X = TargetZoneVec2.x - RedPatrolWaypointDistance
			RS3_WP4Y = TargetZoneVec2.y						
			--Perimeter Zone West Point
			RS3_WP5X = TargetZoneVec2.x
			RS3_WP5Y = TargetZoneVec2.y - RedPatrolWaypointDistance								
		else			
			--////Anti-Clockwise
			--Spawn Point
			RS3_WP0X = DepartureZoneVec2.x
			RS3_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			RS3_WP1X = DepartureZoneVec2.x - RedPatrolWaypointInitial
			RS3_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone South Point
			RS3_WP2X = TargetZoneVec2.x - RedPatrolWaypointDistance
			RS3_WP2Y = TargetZoneVec2.y 						
			--Perimeter Zone East Point
			RS3_WP3X = TargetZoneVec2.x
			RS3_WP3Y = TargetZoneVec2.y + RedPatrolWaypointDistance						
			--Perimeter Zone North Point
			RS3_WP4X = TargetZoneVec2.x + RedPatrolWaypointDistance
			RS3_WP4Y = TargetZoneVec2.y						
			--Perimeter Zone West Point
			RS3_WP5X = TargetZoneVec2.x
			RS3_WP5Y = TargetZoneVec2.y - RedPatrolWaypointDistance					
		end		
		
		REDSQUADRON3 = SPAWN:NewWithAlias("IRIAF MiG-29A", RedSquadronName3)
							:InitRandomizeTemplate(IRIAFAirForceCAP)									
		
		:OnSpawnGroup(
			function( SpawnGroup )						
				REDSQUADRON3GROUPNAME = SpawnGroup.GroupName
				REDSQUADRON3GROUP = GROUP:FindByName(SpawnGroup.GroupName)							
													
				--////CAP Mission Profile, Engage Targets Along Route Unrestricted Distance, Switch Waypoint From WP5 to WP2, 0.7Mach, Randomised Flight Level From Above Parameters
				Mission = {
					["id"] = "Mission",
					["params"] = {		
						["route"] = 
						{                                    
							["points"] = 
							{
								[1] = 
								{
									["alt"] = RS3_FlightLevel/2,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["enabled"] = true,
													["auto"] = true,
													["id"] = "WrappedAction",
													["number"] = 1,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "EPLRS",
															["params"] = 
															{
																["value"] = true,
																["groupId"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
												[2] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 2,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["variantIndex"] = 1,
																["name"] = 5,
																["formationIndex"] = 6,
																["value"] = 393217,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [2]
												[3] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "EngageTargets",
													["number"] = 3,
													["params"] = 
													{
														["targetTypes"] = 
														{
															[1] = "Air",
														}, -- end of ["targetTypes"]
														["priority"] = 0,
														["value"] = "Air;",
														["noTargetTypes"] = 
														{
															[1] = "Cruise missiles",
															[2] = "Antiship Missiles",
															[3] = "AA Missiles",
															[4] = "AG Missiles",
															[5] = "SA Missiles",
														}, -- end of ["noTargetTypes"]
														["maxDistEnabled"] = true,
														["maxDist"] = EngagementDistance,
													}, -- end of ["params"]
												}, -- end of [3]
												[4] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 4,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 3,
																["name"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [4]
												[5] = 
												{
													["number"] = 5,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 264241152,
																["name"] = 10,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [5]
												[6] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 6,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 19,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [6]
												[7] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 7,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [7]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 0,
									["ETA_locked"] = true,
									["y"] = RS3_WP0Y,
									["x"] = RS3_WP0X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [1]
								[2] = 
								{
									["alt"] = RS3_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 127.32626754758,
									["ETA_locked"] = false,
									["y"] = RS3_WP1Y,
									["x"] = RS3_WP1X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [2]
								[3] = 
								{
									["alt"] = RS3_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 380.31328316984,
									["ETA_locked"] = false,
									["y"] = RS3_WP2Y,
									["x"] = RS3_WP2X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [3]
								[4] = 
								{
									["alt"] = RS3_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 832.92276094724,
									["ETA_locked"] = false,
									["y"] = RS3_WP3Y,
									["x"] = RS3_WP3X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [4]
								[5] = 
								{
									["alt"] = RS3_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1289.20366255,
									["ETA_locked"] = false,
									["y"] = RS3_WP4Y,
									["x"] = RS3_WP4X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [5]
								[6] = 
								{
									["alt"] = RS3_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["number"] = 1,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "SwitchWaypoint",
															["params"] = 
															{
																["goToWaypointIndex"] = 3,
																["fromWaypointIndex"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1744.9128539618,
									["ETA_locked"] = false,
									["y"] = RS3_WP5Y,
									["x"] = RS3_WP5X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [6]
							}, -- end of ["points"]
						}, -- end of ["route"]
					}, --end of ["params"]
				}--end of Mission				
				REDSQUADRON3GROUP:SetTask(Mission)				
			end
		)
		if ( DepartureAirbaseName == AIRBASE.PersianGulf.Bandar_Abbas_Intl ) then
			--REDSQUADRON3:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot, nil, AIRBASE.TerminalType.OpenBig )
			REDSQUADRON3:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl), {4,29,14,24}, SPAWN.Takeoff.Hot)
		else
			REDSQUADRON3:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )
		end		
		--:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )	--SPAWN.Takeoff.Hot SPAWN.Takeoff.Cold SPAWN.Takeoff.Runway
		--trigger.action.outText("Red Squadron 3 Is Launching Fighters", 15)	
	end
end

function SEF_REDSQUADRON4_SPAWN(DepartureAirbaseName, DestinationAirbaseName)
	
	if ( GROUP:FindByName(REDSQUADRON4GROUPNAME) ~= nil and GROUP:FindByName(REDSQUADRON4GROUPNAME):IsAlive() ) then
		--trigger.action.outText("Red Squadron 4 Is Currently Active, Not Spawning A Replacement Yet",15)	
	else
		REDSQUADRON4_DATA[1].Vec2 = nil
		REDSQUADRON4_DATA[1].TimeStamp = nil
		REDSQUADRON4_DATA[2].Vec2 = nil
		REDSQUADRON4_DATA[2].TimeStamp = nil		
		
		--If Khasab Spawn Smaller Planes Because Khasab Is Retarded For Bigger Fighters Like Su-27/33 When Dynamically Spawned, 2nd Plane Drives Into The Dirt
		if ( DepartureAirbaseName == "Khasab" ) then
			RS4CAPTable = KhasabRedCAP
		else
			RS4CAPTable = CombinedRedCAP
		end		
		
		local SpawnZone = AIRBASE:FindByName(DepartureAirbaseName):GetZone()
		local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		
		local Randomiser = math.random(RedFlightLevelMin,RedFlightLevelMax)
		RS4_FlightLevel = Randomiser * 1000
				
		local DepartureZoneVec2 = SpawnZone:GetVec2()
		local TargetZoneVec2 	= DestinationZone:GetVec2()
					
		local FlightDirection = math.random(1,100)
					
		if ( FlightDirection <= 50 ) then			
			--////Clockwise
			--Spawn Point
			RS4_WP0X = DepartureZoneVec2.x
			RS4_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			RS4_WP1X = DepartureZoneVec2.x + RedPatrolWaypointInitial
			RS4_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone North Point
			RS4_WP2X = TargetZoneVec2.x + RedPatrolWaypointDistance
			RS4_WP2Y = TargetZoneVec2.y 						
			--Perimeter Zone East Point
			RS4_WP3X = TargetZoneVec2.x
			RS4_WP3Y = TargetZoneVec2.y + RedPatrolWaypointDistance						
			--Perimeter Zone South Point
			RS4_WP4X = TargetZoneVec2.x - RedPatrolWaypointDistance
			RS4_WP4Y = TargetZoneVec2.y						
			--Perimeter Zone West Point
			RS4_WP5X = TargetZoneVec2.x
			RS4_WP5Y = TargetZoneVec2.y - RedPatrolWaypointDistance								
		else			
			--////Anti-Clockwise
			--Spawn Point
			RS4_WP0X = DepartureZoneVec2.x
			RS4_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			RS4_WP1X = DepartureZoneVec2.x - RedPatrolWaypointInitial
			RS4_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone South Point
			RS4_WP2X = TargetZoneVec2.x - RedPatrolWaypointDistance
			RS4_WP2Y = TargetZoneVec2.y 						
			--Perimeter Zone East Point
			RS4_WP3X = TargetZoneVec2.x
			RS4_WP3Y = TargetZoneVec2.y + RedPatrolWaypointDistance						
			--Perimeter Zone North Point
			RS4_WP4X = TargetZoneVec2.x + RedPatrolWaypointDistance
			RS4_WP4Y = TargetZoneVec2.y						
			--Perimeter Zone West Point
			RS4_WP5X = TargetZoneVec2.x
			RS4_WP5Y = TargetZoneVec2.y - RedPatrolWaypointDistance					
		end		
		
		REDSQUADRON4 = SPAWN:NewWithAlias("IRIAF MiG-29A", RedSquadronName4)
							:InitRandomizeTemplate(RS4CAPTable)																
		
		:OnSpawnGroup(
			function( SpawnGroup )						
				REDSQUADRON4GROUPNAME = SpawnGroup.GroupName
				REDSQUADRON4GROUP = GROUP:FindByName(SpawnGroup.GroupName)							
													
				--////CAP Mission Profile, Engage Targets Along Route Unrestricted Distance, Switch Waypoint From WP5 to WP2, 0.7Mach, Randomised Flight Level From Above Parameters
				Mission = {
					["id"] = "Mission",
					["params"] = {		
						["route"] = 
						{                                    
							["points"] = 
							{
								[1] = 
								{
									["alt"] = RS4_FlightLevel/2,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["enabled"] = true,
													["auto"] = true,
													["id"] = "WrappedAction",
													["number"] = 1,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "EPLRS",
															["params"] = 
															{
																["value"] = true,
																["groupId"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
												[2] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 2,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["variantIndex"] = 1,
																["name"] = 5,
																["formationIndex"] = 6,
																["value"] = 393217,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [2]
												[3] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "EngageTargets",
													["number"] = 3,
													["params"] = 
													{
														["targetTypes"] = 
														{
															[1] = "Air",
														}, -- end of ["targetTypes"]
														["priority"] = 0,
														["value"] = "Air;",
														["noTargetTypes"] = 
														{
															[1] = "Cruise missiles",
															[2] = "Antiship Missiles",
															[3] = "AA Missiles",
															[4] = "AG Missiles",
															[5] = "SA Missiles",
														}, -- end of ["noTargetTypes"]
														["maxDistEnabled"] = true,
														["maxDist"] = EngagementDistance,
													}, -- end of ["params"]
												}, -- end of [3]
												[4] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 4,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 3,
																["name"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [4]
												[5] = 
												{
													["number"] = 5,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 264241152,
																["name"] = 10,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [5]
												[6] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 6,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 19,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [6]
												[7] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 7,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [7]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 0,
									["ETA_locked"] = true,
									["y"] = RS4_WP0Y,
									["x"] = RS4_WP0X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [1]
								[2] = 
								{
									["alt"] = RS4_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 127.32626754758,
									["ETA_locked"] = false,
									["y"] = RS4_WP1Y,
									["x"] = RS4_WP1X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [2]
								[3] = 
								{
									["alt"] = RS4_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 380.31328316984,
									["ETA_locked"] = false,
									["y"] = RS4_WP2Y,
									["x"] = RS4_WP2X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [3]
								[4] = 
								{
									["alt"] = RS4_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 832.92276094724,
									["ETA_locked"] = false,
									["y"] = RS4_WP3Y,
									["x"] = RS4_WP3X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [4]
								[5] = 
								{
									["alt"] = RS4_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1289.20366255,
									["ETA_locked"] = false,
									["y"] = RS4_WP4Y,
									["x"] = RS4_WP4X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [5]
								[6] = 
								{
									["alt"] = RS4_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["number"] = 1,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "SwitchWaypoint",
															["params"] = 
															{
																["goToWaypointIndex"] = 3,
																["fromWaypointIndex"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1744.9128539618,
									["ETA_locked"] = false,
									["y"] = RS4_WP5Y,
									["x"] = RS4_WP5X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [6]
							}, -- end of ["points"]
						}, -- end of ["route"]
					}, --end of ["params"]
				}--end of Mission				
				REDSQUADRON4GROUP:SetTask(Mission)				
			end
		)
		if ( DepartureAirbaseName == AIRBASE.PersianGulf.Bandar_Abbas_Intl ) then
			--REDSQUADRON4:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot, nil, AIRBASE.TerminalType.OpenBig )
			REDSQUADRON4:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl), {7,34,15,32}, SPAWN.Takeoff.Hot)
		elseif ( DepartureAirbaseName == AIRBASE.PersianGulf.Khasab ) then
			REDSQUADRON4:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Khasab), {8,9,6,7}, SPAWN.Takeoff.Hot)
		else
			REDSQUADRON4:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )
		end
		--:SpawnInZone( SpawnZone, false, RS4_FlightLevel, RS4_FlightLevel )
		--:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot ) --SPAWN.Takeoff.Hot SPAWN.Takeoff.Cold SPAWN.Takeoff.Runway
		--trigger.action.outText("Red Squadron 4 Is Launching Fighters", 15)	
	end
end

function SEF_REDSQUADRON5_SPAWN(DepartureAirbaseName, DestinationAirbaseName)
	
	if ( GROUP:FindByName(REDSQUADRON5GROUPNAME) ~= nil and GROUP:FindByName(REDSQUADRON5GROUPNAME):IsAlive() ) then
		--trigger.action.outText("Red Squadron 5 Is Currently Active, Not Spawning A Replacement Yet",15)	
	else
		REDSQUADRON5_DATA[1].Vec2 = nil
		REDSQUADRON5_DATA[1].TimeStamp = nil
		REDSQUADRON5_DATA[2].Vec2 = nil
		REDSQUADRON5_DATA[2].TimeStamp = nil
		
		local SpawnZone = AIRBASE:FindByName(DepartureAirbaseName):GetZone()
		local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		
		local Randomiser = math.random(RedFlightLevelMin,RedFlightLevelMax)
		RS5_FlightLevel = Randomiser * 1000
				
		local DepartureZoneVec2 = SpawnZone:GetVec2()
		local TargetZoneVec2 	= DestinationZone:GetVec2()
					
		local FlightDirection = math.random(1,100)
					
		if ( FlightDirection <= 50 ) then			
			--////Clockwise
			--Spawn Point
			RS5_WP0X = DepartureZoneVec2.x
			RS5_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			RS5_WP1X = DepartureZoneVec2.x + RedPatrolWaypointInitial
			RS5_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone North Point
			RS5_WP2X = TargetZoneVec2.x + RedPatrolWaypointDistance
			RS5_WP2Y = TargetZoneVec2.y 						
			--Perimeter Zone East Point
			RS5_WP3X = TargetZoneVec2.x
			RS5_WP3Y = TargetZoneVec2.y + RedPatrolWaypointDistance						
			--Perimeter Zone South Point
			RS5_WP4X = TargetZoneVec2.x - RedPatrolWaypointDistance
			RS5_WP4Y = TargetZoneVec2.y						
			--Perimeter Zone West Point
			RS5_WP5X = TargetZoneVec2.x
			RS5_WP5Y = TargetZoneVec2.y - RedPatrolWaypointDistance								
		else			
			--////Anti-Clockwise
			--Spawn Point
			RS5_WP0X = DepartureZoneVec2.x
			RS5_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			RS5_WP1X = DepartureZoneVec2.x - RedPatrolWaypointInitial
			RS5_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone South Point
			RS5_WP2X = TargetZoneVec2.x - RedPatrolWaypointDistance
			RS5_WP2Y = TargetZoneVec2.y 						
			--Perimeter Zone East Point
			RS5_WP3X = TargetZoneVec2.x
			RS5_WP3Y = TargetZoneVec2.y + RedPatrolWaypointDistance						
			--Perimeter Zone North Point
			RS5_WP4X = TargetZoneVec2.x + RedPatrolWaypointDistance
			RS5_WP4Y = TargetZoneVec2.y						
			--Perimeter Zone West Point
			RS5_WP5X = TargetZoneVec2.x
			RS5_WP5Y = TargetZoneVec2.y - RedPatrolWaypointDistance					
		end		
		
		REDSQUADRON5 = SPAWN:NewWithAlias("VVS MiG-29A", RedSquadronName5)
							:InitRandomizeTemplate(VVSAirForcesCAP)									
		
		:OnSpawnGroup(
			function( SpawnGroup )						
				REDSQUADRON5GROUPNAME = SpawnGroup.GroupName
				REDSQUADRON5GROUP = GROUP:FindByName(SpawnGroup.GroupName)							
													
				--////CAP Mission Profile, Engage Targets Along Route Unrestricted Distance, Switch Waypoint From WP5 to WP2, 0.7Mach, Randomised Flight Level From Above Parameters
				Mission = {
					["id"] = "Mission",
					["params"] = {		
						["route"] = 
						{                                    
							["points"] = 
							{
								[1] = 
								{
									["alt"] = RS5_FlightLevel/2,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["enabled"] = true,
													["auto"] = true,
													["id"] = "WrappedAction",
													["number"] = 1,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "EPLRS",
															["params"] = 
															{
																["value"] = true,
																["groupId"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
												[2] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 2,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["variantIndex"] = 1,
																["name"] = 5,
																["formationIndex"] = 6,
																["value"] = 393217,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [2]
												[3] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "EngageTargets",
													["number"] = 3,
													["params"] = 
													{
														["targetTypes"] = 
														{
															[1] = "Air",
														}, -- end of ["targetTypes"]
														["priority"] = 0,
														["value"] = "Air;",
														["noTargetTypes"] = 
														{
															[1] = "Cruise missiles",
															[2] = "Antiship Missiles",
															[3] = "AA Missiles",
															[4] = "AG Missiles",
															[5] = "SA Missiles",
														}, -- end of ["noTargetTypes"]
														["maxDistEnabled"] = true,
														["maxDist"] = EngagementDistance,
													}, -- end of ["params"]
												}, -- end of [3]
												[4] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 4,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 3,
																["name"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [4]
												[5] = 
												{
													["number"] = 5,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 264241152,
																["name"] = 10,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [5]
												[6] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 6,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 19,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [6]
												[7] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 7,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [7]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 0,
									["ETA_locked"] = true,
									["y"] = RS5_WP0Y,
									["x"] = RS5_WP0X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [1]
								[2] = 
								{
									["alt"] = RS5_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 127.32626754758,
									["ETA_locked"] = false,
									["y"] = RS5_WP1Y,
									["x"] = RS5_WP1X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [2]
								[3] = 
								{
									["alt"] = RS5_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 380.31328316984,
									["ETA_locked"] = false,
									["y"] = RS5_WP2Y,
									["x"] = RS5_WP2X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [3]
								[4] = 
								{
									["alt"] = RS5_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 832.92276094724,
									["ETA_locked"] = false,
									["y"] = RS5_WP3Y,
									["x"] = RS5_WP3X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [4]
								[5] = 
								{
									["alt"] = RS5_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1289.20366255,
									["ETA_locked"] = false,
									["y"] = RS5_WP4Y,
									["x"] = RS5_WP4X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [5]
								[6] = 
								{
									["alt"] = RS5_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["number"] = 1,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "SwitchWaypoint",
															["params"] = 
															{
																["goToWaypointIndex"] = 3,
																["fromWaypointIndex"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1744.9128539618,
									["ETA_locked"] = false,
									["y"] = RS5_WP5Y,
									["x"] = RS5_WP5X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [6]
							}, -- end of ["points"]
						}, -- end of ["route"]
					}, --end of ["params"]
				}--end of Mission				
				REDSQUADRON5GROUP:SetTask(Mission)				
			end
		)
		if ( DepartureAirbaseName == AIRBASE.PersianGulf.Bandar_Abbas_Intl ) then
			--REDSQUADRON5:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot, nil, AIRBASE.TerminalType.OpenBig )
			REDSQUADRON5:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl), {12,31,16,35}, SPAWN.Takeoff.Hot)
		else
			REDSQUADRON5:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )
		end		
		--:SpawnInZone( SpawnZone, false, RS5_FlightLevel, RS5_FlightLevel )
		--:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot ) --SPAWN.Takeoff.Hot SPAWN.Takeoff.Cold SPAWN.Takeoff.Runway AIRBASE.TerminalType.OpenMedOrBig AIRBASE.TerminalType.OpenMed AIRBASE.TerminalType.OpenBig , nil, AIRBASE.TerminalType.OpenMedOrBig
		--trigger.action.outText("Red Squadron 5 Is Launching Fighters", 15)	
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

function SEF_REDSQUADRON2_INITIALISE()

	--Retrieve The Standard Deployment For The Squadron
	SEF_REDSQUADRON2_DEPLOYMENT()
	
	SET_AIRFIELDPERIMETERCLIENTS = SET_CLIENT:New():FilterCoalitions("blue"):FilterCategories( { "plane", "helicopter" } ):FilterActive():FilterOnce()
	
	BetaPrimaryPerimeterCount = 0			
			
	--BETA
	SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(BetaPrimaryAirbase.." Perimeter Zone"), function ( GroupObject )
		BetaPrimaryPerimeterCount = BetaPrimaryPerimeterCount + 1
		end
	)	
	
	--////BETA
	if ( BetaPrimaryPerimeterCount > 0 ) then		
		BetaStatus = BetaPrimaryAirbase.." - Beta Squadron\nAirspace Is Being Contested By The Allies\n"
		
		--Ras Al Khaimah Intl -> Khasab -> Qeshm Island -> Havadarya -> Lar

		if ( BetaPrimaryAirbase == AIRBASE.PersianGulf.Ras_Al_Khaimah ) then
			
			KhasabPerimeterCount = 0
			QeshmPerimeterCount = 0
			HavadaryaPerimeterCount = 0
					
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Khasab.." Perimeter Zone"), function ( GroupObject )
				KhasabPerimeterCount = KhasabPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Qeshm_Island.." Perimeter Zone"), function ( GroupObject )
				QeshmPerimeterCount = QeshmPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Havadarya.." Perimeter Zone"), function ( GroupObject )
				HavadaryaPerimeterCount = HavadaryaPerimeterCount + 1		
				end
			)		

			if ( Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 1 and KhasabPerimeterCount == 0 ) then							
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Khasab, BetaDestinationAirbase)	
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and QeshmPerimeterCount == 0 ) then			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Qeshm_Island, BetaDestinationAirbase)						
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() == 1 and HavadaryaPerimeterCount == 0 ) then			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Havadarya, BetaDestinationAirbase)			
			else			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, BetaDestinationAirbase)
			end			
		elseif ( BetaPrimaryAirbase == AIRBASE.PersianGulf.Khasab ) then
		
			RasPerimeterCount = 0
			QeshmPerimeterCount = 0
			HavadaryaPerimeterCount = 0
					
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Ras_Al_Khaimah.." Perimeter Zone"), function ( GroupObject )
				RasPerimeterCount = RasPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Qeshm_Island.." Perimeter Zone"), function ( GroupObject )
				QeshmPerimeterCount = QeshmPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Havadarya.." Perimeter Zone"), function ( GroupObject )
				HavadaryaPerimeterCount = HavadaryaPerimeterCount + 1		
				end
			)		

			if ( Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 1 and RasPerimeterCount == 0 ) then			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Ras_Al_Khaimah, BetaDestinationAirbase)
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and QeshmPerimeterCount == 0 ) then			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Qeshm_Island, BetaDestinationAirbase)
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() == 1 and HavadaryaPerimeterCount == 0 ) then			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Havadarya, BetaDestinationAirbase)
			else			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, BetaDestinationAirbase)
			end		
		elseif ( BetaPrimaryAirbase == AIRBASE.PersianGulf.Qeshm_Island ) then
		
			RasPerimeterCount = 0
			KhasabPerimeterCount = 0
			HavadaryaPerimeterCount = 0
					
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Ras_Al_Khaimah.." Perimeter Zone"), function ( GroupObject )
				RasPerimeterCount = RasPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Khasab.." Perimeter Zone"), function ( GroupObject )
				KhasabPerimeterCount = KhasabPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Havadarya.." Perimeter Zone"), function ( GroupObject )
				HavadaryaPerimeterCount = HavadaryaPerimeterCount + 1		
				end
			)		

			if ( Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 1 and RasPerimeterCount == 0 ) then			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Ras_Al_Khaimah, BetaDestinationAirbase)			
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 1 and KhasabPerimeterCount == 0 ) then			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Khasab, BetaDestinationAirbase)		
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() == 1 and HavadaryaPerimeterCount == 0 ) then			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Havadarya, BetaDestinationAirbase)			
			else			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, BetaDestinationAirbase)				
			end		
		elseif ( BetaPrimaryAirbase == AIRBASE.PersianGulf.Havadarya ) then
			
			RasPerimeterCount = 0
			KhasabPerimeterCount = 0
			QeshmPerimeterCount = 0
					
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Ras_Al_Khaimah.." Perimeter Zone"), function ( GroupObject )
				RasPerimeterCount = RasPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Khasab.." Perimeter Zone"), function ( GroupObject )
				KhasabPerimeterCount = KhasabPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Qeshm_Island.." Perimeter Zone"), function ( GroupObject )
				QeshmPerimeterCount = QeshmPerimeterCount + 1		
				end
			)		

			if ( Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 1 and RasPerimeterCount == 0 ) then			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Ras_Al_Khaimah, BetaDestinationAirbase)				
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 1 and KhasabPerimeterCount == 0 ) then			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Khasab, BetaDestinationAirbase)						
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and QeshmPerimeterCount == 0 ) then			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Qeshm_Island, BetaDestinationAirbase)			
			else			
				SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, BetaDestinationAirbase)				
			end		
		elseif ( BetaPrimaryAirbase == AIRBASE.PersianGulf.Lar_Airbase ) then
			SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, BetaDestinationAirbase)	
		else			
			SEF_REDSQUADRON2_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, BetaDestinationAirbase)
		end		
	else
		BetaStatus = BetaPrimaryAirbase.." - Beta Squadron\nAirspace Is Controlled By Iran\n"
		SEF_REDSQUADRON2_SPAWN(BetaPrimaryAirbase, BetaDestinationAirbase)	
	end	
end

function SEF_REDSQUADRON2_DEPLOYMENT()
	
	--BETA
	if ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 1 ) then
		--Set Beta To Ras Al Khaimah Intl
		BetaPrimaryAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
		BetaDestinationAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah	
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() ~= 1 ) then
		--Set Beta To Khasab And Patrol Ras Al Khaimah Intl
		BetaPrimaryAirbase = AIRBASE.PersianGulf.Khasab	
		BetaDestinationAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 1 ) then
		--Set Beta To Ras Al Khaimah Intl And Patrol Ras Al Khaimah Intl And Leave Khasab For Delta To Patrol
		BetaPrimaryAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah	
		BetaDestinationAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() ~= 1 ) then
		--Set Beta To Qeshm And Patrol Khasab, Delta Will Be Doing The Same Here
		BetaPrimaryAirbase = AIRBASE.PersianGulf.Qeshm_Island
		BetaDestinationAirbase = AIRBASE.PersianGulf.Khasab	
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 1 ) then
		--Set Beta To Ras Al Khaimah Intl, Patrol Ras Al Khaimah Intl And Leave Qeshm For Delta
		BetaPrimaryAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
		BetaDestinationAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() ~= 1 ) then
		--Set Beta To Khasab, Patrol Ras Al Khaimah Intl And Leave Qeshm For Delta
		BetaPrimaryAirbase = AIRBASE.PersianGulf.Khasab	
		BetaDestinationAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 1 ) then
		--Set Beta To Ras Al Khaimah Intl, Patrol Ras Al Khaimah Intl And Leave Qeshm And Khasab For Delta
		BetaPrimaryAirbase = AIRBASE.PersianGulf.Khasab
		BetaDestinationAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah	
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() ~= 1 ) then
		--Set Beta To Havadarya, Patrol Qeshm
		BetaPrimaryAirbase = AIRBASE.PersianGulf.Havadarya
		BetaDestinationAirbase = AIRBASE.PersianGulf.Qeshm_Island
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 1 ) then
		--Set Beta To Qeshm, Patrol Havadarya
		BetaPrimaryAirbase = AIRBASE.PersianGulf.Qeshm_Island
		BetaDestinationAirbase = AIRBASE.PersianGulf.Havadarya
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() ~= 1 ) then
		--Set Beta To Qeshm, Patrol Havadarya
		BetaPrimaryAirbase = AIRBASE.PersianGulf.Qeshm_Island
		BetaDestinationAirbase = AIRBASE.PersianGulf.Havadarya
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 1 ) then
		--Set Beta To Qeshm, Patrol Havadarya
		BetaPrimaryAirbase = AIRBASE.PersianGulf.Qeshm_Island
		BetaDestinationAirbase = AIRBASE.PersianGulf.Havadarya
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() ~= 1 ) then
		--Set Beta To Qeshm, Patrol Havadarya
		BetaPrimaryAirbase = AIRBASE.PersianGulf.Qeshm_Island
		BetaDestinationAirbase = AIRBASE.PersianGulf.Havadarya
	else
		--Set Beta To Lar As We've Lost Both Havadarya And Qeshm, We're On The Defensive
		BetaPrimaryAirbase = AIRBASE.PersianGulf.Lar_Airbase
		BetaDestinationAirbase = AIRBASE.PersianGulf.Havadarya
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

function SEF_REDSQUADRON3_INITIALISE()

	--Retrieve The Standard Deployment For The Squadron
	SEF_REDSQUADRON3_DEPLOYMENT()
	
	SET_AIRFIELDPERIMETERCLIENTS = SET_CLIENT:New():FilterCoalitions("blue"):FilterCategories( { "plane", "helicopter" } ):FilterActive():FilterOnce()
	
	GammaPrimaryPerimeterCount = 0			
			
	--GAMMA
	SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(GammaPrimaryAirbase.." Perimeter Zone"), function ( GroupObject )
		GammaPrimaryPerimeterCount = GammaPrimaryPerimeterCount + 1
		end
	)	
		
	--////GAMMA
	if ( GammaPrimaryPerimeterCount > 0 ) then		
		GammaStatus = GammaPrimaryAirbase.." - Gamma Squadron\nAirspace Is Being Contested By The Allies\n"		
		
		--Fujairah or Jask -> Fujairah or Jask -> Bandar Abbas -> Jiroft
				
		if ( GammaPrimaryAirbase == AIRBASE.PersianGulf.Fujairah_Intl ) then
			
			JaskPerimeterCount = 0
			BandarAbbasPerimeterCount = 0
			
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield.." Perimeter Zone"), function ( GroupObject )
				JaskPerimeterCount = JaskPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl.." Perimeter Zone"), function ( GroupObject )
				BandarAbbasPerimeterCount = BandarAbbasPerimeterCount + 1		
				end
			)		

			if ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield):getCoalition() == 1 and JaskPerimeterCount == 0 ) then			
				SEF_REDSQUADRON3_SPAWN(AIRBASE.PersianGulf.Bandar_e_Jask_airfield, GammaDestinationAirbase)
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() == 1 and BandarAbbasPerimeterCount == 0 ) then			
				SEF_REDSQUADRON3_SPAWN(AIRBASE.PersianGulf.Bandar_Abbas_Intl, GammaDestinationAirbase)
			else			
				SEF_REDSQUADRON3_SPAWN(AIRBASE.PersianGulf.Jiroft_Airport, GammaDestinationAirbase)
			end			
		elseif ( GammaPrimaryAirbase == AIRBASE.PersianGulf.Bandar_e_Jask_airfield ) then
		
			FujairahPerimeterCount = 0
			BandarAbbasPerimeterCount = 0			
			
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Fujairah_Intl.." Perimeter Zone"), function ( GroupObject )
				FujairahPerimeterCount = FujairahPerimeterCount + 1		
				end
			)			
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl.." Perimeter Zone"), function ( GroupObject )
				BandarAbbasPerimeterCount = BandarAbbasPerimeterCount + 1		
				end
			)		

			if ( Airbase.getByName(AIRBASE.PersianGulf.Fujairah_Intl):getCoalition() == 1 and FujairahPerimeterCount == 0 ) then			
				SEF_REDSQUADRON3_SPAWN(AIRBASE.PersianGulf.Fujairah_Intl, GammaDestinationAirbase)
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() == 1 and BandarAbbasPerimeterCount == 0 ) then			
				SEF_REDSQUADRON3_SPAWN(AIRBASE.PersianGulf.Bandar_Abbas_Intl, GammaDestinationAirbase)
			else			
				SEF_REDSQUADRON3_SPAWN(AIRBASE.PersianGulf.Jiroft_Airport, GammaDestinationAirbase)				
			end			
		elseif ( GammaPrimaryAirbase == AIRBASE.PersianGulf.Bandar_Abbas_Intl ) then 
			
			JaskPerimeterCount = 0
			FujairahPerimeterCount = 0
						
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Fujairah_Intl.." Perimeter Zone"), function ( GroupObject )
				FujairahPerimeterCount = FujairahPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield.." Perimeter Zone"), function ( GroupObject )
				JaskPerimeterCount = JaskPerimeterCount + 1		
				end
			)					

			if ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield):getCoalition() == 1 and JaskPerimeterCount == 0 ) then			
				SEF_REDSQUADRON3_SPAWN(AIRBASE.PersianGulf.Bandar_e_Jask_airfield, GammaDestinationAirbase)									
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Fujairah_Intl):getCoalition() == 1 and FujairahPerimeterCount == 0 ) then			
				SEF_REDSQUADRON3_SPAWN(AIRBASE.PersianGulf.Fujairah_Intl, GammaDestinationAirbase)			
			else			
				SEF_REDSQUADRON3_SPAWN(AIRBASE.PersianGulf.Jiroft_Airport, GammaDestinationAirbase)				
			end			
		elseif ( GammaPrimaryAirbase == AIRBASE.PersianGulf.Jiroft_Airport ) then
			SEF_REDSQUADRON3_SPAWN(AIRBASE.PersianGulf.Jiroft_Airport, GammaDestinationAirbase)
		else
			SEF_REDSQUADRON3_SPAWN(AIRBASE.PersianGulf.Jiroft_Airport, GammaDestinationAirbase)
		end	
	else
		GammaStatus = GammaPrimaryAirbase.." - Gamma Squadron\nAirspace Is Controlled By Iran\n"
		SEF_REDSQUADRON3_SPAWN(GammaPrimaryAirbase, GammaDestinationAirbase)
	end		
end

function SEF_REDSQUADRON3_DEPLOYMENT()
	
	--GAMMA
	if ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Fujairah_Intl):getCoalition() == 1 ) then
		--Case 111: Set Gamma To Jask Or Fujairah And Patrol Jask Or Fujairah		
		local Randomiser = math.random(1,100)		
		if ( Randomiser <= 50 ) then	
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Bandar_e_Jask_airfield
			GammaDestinationAirbase = AIRBASE.PersianGulf.Bandar_e_Jask_airfield
		else
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Fujairah_Intl
			GammaDestinationAirbase = AIRBASE.PersianGulf.Fujairah_Intl
		end	
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Fujairah_Intl):getCoalition() ~= 1 ) then
		--Case 110: Set Gamma To Jask And Either Patrol Jask Or Patrol Fujairah
		local Randomiser = math.random(1,100)		
		if ( Randomiser <= 50 ) then
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Bandar_e_Jask_airfield
			GammaDestinationAirbase = AIRBASE.PersianGulf.Bandar_e_Jask_airfield
		else
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Bandar_e_Jask_airfield
			GammaDestinationAirbase = AIRBASE.PersianGulf.Fujairah_Intl
		end	
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Fujairah_Intl):getCoalition() == 1 ) then
		--Case 101: Set Gamma To Fujairah And Either Patrol Jask Or Patrol Fujairah
		local Randomiser = math.random(1,100)		
		if ( Randomiser <= 50 ) then
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Fujairah_Intl
			GammaDestinationAirbase = AIRBASE.PersianGulf.Fujairah_Intl
		else			
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Fujairah_Intl
			GammaDestinationAirbase = AIRBASE.PersianGulf.Bandar_e_Jask_airfield
		end
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Fujairah_Intl):getCoalition() ~= 1 ) then
		--Case 100: Set Gamma To Bandar Abbas And Either Patrol Jask Or Patrol Fujairah
		local Randomiser = math.random(1,100)		
		if ( Randomiser <= 50 ) then
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Bandar_Abbas_Intl
			GammaDestinationAirbase = AIRBASE.PersianGulf.Fujairah_Intl
		else			
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Bandar_Abbas_Intl
			GammaDestinationAirbase = AIRBASE.PersianGulf.Bandar_e_Jask_airfield
		end		
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Fujairah_Intl):getCoalition() == 1 ) then
		--Case 011: Set Gamma To Jask Or Fujairah And Patrol Jask Or Fujairah	And Leave Bandar Abbas For Delta/Epsilon	
		local Randomiser = math.random(1,100)		
		if ( Randomiser <= 50 ) then	
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Bandar_e_Jask_airfield
			GammaDestinationAirbase = AIRBASE.PersianGulf.Bandar_e_Jask_airfield
		else
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Fujairah_Intl
			GammaDestinationAirbase = AIRBASE.PersianGulf.Fujairah_Intl
		end	
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Fujairah_Intl):getCoalition() ~= 1 ) then
		--Case 010: Set Gamma To Jask And Patrol Either Jask Or Fujairah And Leave Bandar Abbas For Delta/Epsilon
		local Randomiser = math.random(1,100)		
		if ( Randomiser <= 50 ) then
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Bandar_e_Jask_airfield
			GammaDestinationAirbase = AIRBASE.PersianGulf.Bandar_e_Jask_airfield
		else
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Bandar_e_Jask_airfield
			GammaDestinationAirbase = AIRBASE.PersianGulf.Fujairah_Intl
		end	
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Fujairah_Intl):getCoalition() == 1 ) then
		--Case 001: Set Gamma To Fujairah And Patrol Either Jask Or Fujairah And Leave Bandar Abbas For Delta/Epsilon
		local Randomiser = math.random(1,100)		
		if ( Randomiser <= 50 ) then
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Fujairah_Intl
			GammaDestinationAirbase = AIRBASE.PersianGulf.Bandar_e_Jask_airfield
		else
			GammaPrimaryAirbase = AIRBASE.PersianGulf.Fujairah_Intl
			GammaDestinationAirbase = AIRBASE.PersianGulf.Fujairah_Intl
		end		
	else
		--Case 000: Set Gamma To Jiroft And Patrol Bandar Abbas
		GammaPrimaryAirbase = AIRBASE.PersianGulf.Jiroft_Airport
		GammaDestinationAirbase = AIRBASE.PersianGulf.Bandar_Abbas_Intl
	end
end	

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

function SEF_REDSQUADRON4_INITIALISE()

	--Retrieve The Standard Deployment For The Squadron
	SEF_REDSQUADRON4_DEPLOYMENT()
	
	SET_AIRFIELDPERIMETERCLIENTS = SET_CLIENT:New():FilterCoalitions("blue"):FilterCategories( { "plane", "helicopter" } ):FilterActive():FilterOnce()
	
	DeltaPrimaryPerimeterCount = 0			
			
	--DELTA
	SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(DeltaPrimaryAirbase.." Perimeter Zone"), function ( GroupObject )
		DeltaPrimaryPerimeterCount = DeltaPrimaryPerimeterCount + 1
		end
	)	
		
	--////DELTA
	if ( DeltaPrimaryPerimeterCount > 0 ) then		
		DeltaStatus = DeltaPrimaryAirbase.." - Delta Squadron\nAirspace Is Being Contested By The Allies\n"	
		
		--Khasab -> Qeshm -> Bandar Abbas -> Jiroft	
		
		if ( DeltaPrimaryAirbase == AIRBASE.PersianGulf.Khasab ) then

			QeshmPerimeterCount = 0
			BandarAbbasPerimeterCount = 0
					
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Qeshm_Island.." Perimeter Zone"), function ( GroupObject )
				QeshmPerimeterCount = QeshmPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl.." Perimeter Zone"), function ( GroupObject )
				BandarAbbasPerimeterCount = BandarAbbasPerimeterCount + 1		
				end
			)		

			if ( Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and QeshmPerimeterCount == 0 ) then			
				SEF_REDSQUADRON4_SPAWN(AIRBASE.PersianGulf.Qeshm_Island, DeltaDestinationAirbase)
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() == 1 and BandarAbbasPerimeterCount == 0 ) then			
				SEF_REDSQUADRON4_SPAWN(AIRBASE.PersianGulf.Bandar_Abbas_Intl, DeltaDestinationAirbase)
			else			
				SEF_REDSQUADRON4_SPAWN(AIRBASE.PersianGulf.Jiroft_Airport, DeltaDestinationAirbase)
			end	

		elseif ( DeltaPrimaryAirbase == AIRBASE.PersianGulf.Qeshm_Island ) then
			
			KhasabPerimeterCount = 0			
			BandarAbbasPerimeterCount = 0
					
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Khasab.." Perimeter Zone"), function ( GroupObject )
				KhasabPerimeterCount = KhasabPerimeterCount + 1		
				end
			)			
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl.." Perimeter Zone"), function ( GroupObject )
				BandarAbbasPerimeterCount = BandarAbbasPerimeterCount + 1		
				end
			)		

			if ( Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 1 and KhasabPerimeterCount == 0 ) then			
				SEF_REDSQUADRON4_SPAWN(AIRBASE.PersianGulf.Khasab, DeltaDestinationAirbase)
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() == 1 and BandarAbbasPerimeterCount == 0 ) then			
				SEF_REDSQUADRON4_SPAWN(AIRBASE.PersianGulf.Bandar_Abbas_Intl, DeltaDestinationAirbase)
			else			
				SEF_REDSQUADRON4_SPAWN(AIRBASE.PersianGulf.Jiroft_Airport, DeltaDestinationAirbase)				
			end		
		elseif ( DeltaPrimaryAirbase == AIRBASE.PersianGulf.Bandar_Abbas_Intl ) then
			
			KhasabPerimeterCount = 0
			QeshmPerimeterCount = 0			
					
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Khasab.." Perimeter Zone"), function ( GroupObject )
				KhasabPerimeterCount = KhasabPerimeterCount + 1		
				end
			)
			SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Qeshm_Island.." Perimeter Zone"), function ( GroupObject )
				QeshmPerimeterCount = QeshmPerimeterCount + 1		
				end
			)
			
			if ( Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 1 and KhasabPerimeterCount == 0 ) then			
				SEF_REDSQUADRON4_SPAWN(AIRBASE.PersianGulf.Khasab, DeltaDestinationAirbase)			
			elseif ( Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and QeshmPerimeterCount == 0 ) then			
				SEF_REDSQUADRON4_SPAWN(AIRBASE.PersianGulf.Qeshm_Island, DeltaDestinationAirbase)						
			else			
				SEF_REDSQUADRON4_SPAWN(AIRBASE.PersianGulf.Jiroft_Airport, DeltaDestinationAirbase)				
			end		
		elseif ( DeltaPrimaryAirbase == AIRBASE.PersianGulf.Jiroft_Airport ) then
			SEF_REDSQUADRON4_SPAWN(AIRBASE.PersianGulf.Jiroft_Airport, DeltaDestinationAirbase)
		else
			SEF_REDSQUADRON4_SPAWN(AIRBASE.PersianGulf.Jiroft_Airport, DeltaDestinationAirbase)
		end
	else
		DeltaStatus = DeltaPrimaryAirbase.." - Delta Squadron\nAirspace Is Controlled By Iran\n"
		SEF_REDSQUADRON4_SPAWN(DeltaPrimaryAirbase, DeltaDestinationAirbase)
	end		
end

function SEF_REDSQUADRON4_DEPLOYMENT()
	--DELTA
	if ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 1 ) then
		--Set Delta To Khasab
		DeltaPrimaryAirbase = AIRBASE.PersianGulf.Khasab
		DeltaDestinationAirbase = AIRBASE.PersianGulf.Khasab	
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 1 ) then
		--Set Delta To Qeshm And Patrol Khasab As We Need It Back
		DeltaPrimaryAirbase = AIRBASE.PersianGulf.Qeshm_Island
		DeltaDestinationAirbase = AIRBASE.PersianGulf.Khasab
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 1 ) then
		--Set Delta To Bandar Abbas And Patrol Qeshm As We Need It Back
		DeltaPrimaryAirbase = AIRBASE.PersianGulf.Bandar_Abbas_Intl
		DeltaDestinationAirbase = AIRBASE.PersianGulf.Qeshm_Island
	elseif ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() == 1 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 1 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 1 ) then
		--Set Delta To Bandar Abbas And Patrol Qeshm As We Need It Back
		DeltaPrimaryAirbase = AIRBASE.PersianGulf.Bandar_Abbas_Intl
		DeltaDestinationAirbase = AIRBASE.PersianGulf.Qeshm_Island
	else
		--Set Delta To Jiroft And Patrol Bandar Abbas As We Need It Back
		DeltaPrimaryAirbase = AIRBASE.PersianGulf.Jiroft_Airport
		DeltaDestinationAirbase = AIRBASE.PersianGulf.Bandar_Abbas_Intl
	end	
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

function SEF_REDSQUADRON5_INITIALISE()

	--Retrieve The Standard Deployment For The Squadron
	SEF_REDSQUADRON5_DEPLOYMENT()
	
	SET_AIRFIELDPERIMETERCLIENTS = SET_CLIENT:New():FilterCoalitions("blue"):FilterCategories( { "plane", "helicopter" } ):FilterActive():FilterOnce()
	
	EpsilonPrimaryPerimeterCount = 0			
			
	--EPSILON	
	SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(EpsilonPrimaryAirbase.." Perimeter Zone"), function ( GroupObject )
		EpsilonPrimaryPerimeterCount = EpsilonPrimaryPerimeterCount + 1
		end
	)	
		
	--////EPSILON
	if ( EpsilonPrimaryPerimeterCount > 0 ) then		
		EpsilonStatus = EpsilonPrimaryAirbase.." - Epsilon Squadron\nAirspace Is Being Contested By The Allies\n"		
		SEF_REDSQUADRON5_SPAWN(AIRBASE.PersianGulf.Jiroft_Airport, EpsilonDestinationAirbase)
	else
		EpsilonStatus = EpsilonPrimaryAirbase.." - Epsilon Squadron\nAirspace Is Controlled By Iran\n"
		SEF_REDSQUADRON5_SPAWN(EpsilonPrimaryAirbase, EpsilonDestinationAirbase)
	end		
end

function SEF_REDSQUADRON5_DEPLOYMENT()	
	--EPSILON
	if ( Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() == 1 ) then
		--Set Epsilon To Bandar Abbas And Patrol Bandar Abbas
		EpsilonPrimaryAirbase = AIRBASE.PersianGulf.Bandar_Abbas_Intl
		EpsilonDestinationAirbase = AIRBASE.PersianGulf.Bandar_Abbas_Intl
	else
		--Set Epsilon To Jiroft And Patrol Bandar Abbas As We Need It Back
		EpsilonPrimaryAirbase = AIRBASE.PersianGulf.Jiroft_Airport
		EpsilonDestinationAirbase = AIRBASE.PersianGulf.Bandar_Abbas_Intl
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--////BLUE SQUADRONS

function SEF_BLUESQUADRON1_SCHEDULER()
    
	if ( BlueSquadronsEnabled == 1 ) then
		if ( GROUP:FindByName(BLUESQUADRON1GROUPNAME) ~= nil and GROUP:FindByName(BLUESQUADRON1GROUPNAME):IsAlive() ) then				
			timer.scheduleFunction(SEF_BLUESQUADRON1_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))			
		else
			SEF_BLUESQUADRON1_SPAWN()
			
			timer.scheduleFunction(SEF_BLUESQUADRON1_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))
		end
	else	
		timer.scheduleFunction(SEF_BLUESQUADRON1_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))		
	end	
end

function SEF_BLUESQUADRON2_SCHEDULER()
    
	if ( BlueSquadronsEnabled == 1 ) then
		if ( GROUP:FindByName(BLUESQUADRON2GROUPNAME) ~= nil and GROUP:FindByName(BLUESQUADRON2GROUPNAME):IsAlive() ) then				
			timer.scheduleFunction(SEF_BLUESQUADRON2_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))			
		else
			SEF_BLUESQUADRON2_SPAWN()
			
			timer.scheduleFunction(SEF_BLUESQUADRON2_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))
		end
	else	
		timer.scheduleFunction(SEF_BLUESQUADRON2_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))		
	end	
end

function SEF_BLUESQUADRON3_SCHEDULER()
    
	if ( BlueSquadronsEnabled == 1 ) then
		if ( GROUP:FindByName(BLUESQUADRON3GROUPNAME) ~= nil and GROUP:FindByName(BLUESQUADRON3GROUPNAME):IsAlive() ) then				
			timer.scheduleFunction(SEF_BLUESQUADRON3_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))			
		else
			SEF_BLUESQUADRON3_SPAWN()
			
			timer.scheduleFunction(SEF_BLUESQUADRON3_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))
		end
	else	
		timer.scheduleFunction(SEF_BLUESQUADRON3_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))		
	end	
end

function SEF_BLUESQUADRON1_SPAWN()
	
	if ( GROUP:FindByName(BLUESQUADRON1GROUPNAME) ~= nil and GROUP:FindByName(BLUESQUADRON1GROUPNAME):IsAlive() ) then
		--trigger.action.outText("Blue Squadron 1 Is Currently Active, Not Spawning A Replacement Yet",15)	
	else
		BLUESQUADRON1_DATA[1].Vec2 = nil
		BLUESQUADRON1_DATA[1].TimeStamp = nil
		BLUESQUADRON1_DATA[2].Vec2 = nil
		BLUESQUADRON1_DATA[2].TimeStamp = nil
		
		--local SpawnZone = AIRBASE:FindByName("CVN-75 Truman"):GetZone()
		local SpawnZone = CAPZoneBlueCarrier
		--local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		
		local Randomiser = math.random(BlueFlightLevelMin,BlueFlightLevelMax)
		BS1_FlightLevel = Randomiser * 1000
				
		local DepartureZoneVec2 = SpawnZone:GetVec2()
		--local TargetZoneVec2 	= DestinationZone:GetVec2()
					
		local FlightDirection = math.random(1,100)
					
		if ( FlightDirection <= 50 ) then			
			--////Clockwise
			--Spawn Point
			BS1_WP0X = DepartureZoneVec2.x
			BS1_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			BS1_WP1X = DepartureZoneVec2.x + BluePatrolWaypointInitial
			BS1_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone North Point
			BS1_WP2X = DepartureZoneVec2.x + BluePatrolWaypointDistance
			BS1_WP2Y = DepartureZoneVec2.y 						
			--Perimeter Zone East Point
			BS1_WP3X = DepartureZoneVec2.x
			BS1_WP3Y = DepartureZoneVec2.y + BluePatrolWaypointDistance						
			--Perimeter Zone South Point
			BS1_WP4X = DepartureZoneVec2.x - BluePatrolWaypointDistance
			BS1_WP4Y = DepartureZoneVec2.y						
			--Perimeter Zone West Point
			BS1_WP5X = DepartureZoneVec2.x
			BS1_WP5Y = DepartureZoneVec2.y - BluePatrolWaypointDistance								
		else			
			--////Anti-Clockwise
			--Spawn Point
			BS1_WP0X = DepartureZoneVec2.x
			BS1_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			BS1_WP1X = DepartureZoneVec2.x - BluePatrolWaypointInitial
			BS1_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone South Point
			BS1_WP2X = DepartureZoneVec2.x - BluePatrolWaypointDistance
			BS1_WP2Y = DepartureZoneVec2.y 						
			--Perimeter Zone East Point
			BS1_WP3X = DepartureZoneVec2.x
			BS1_WP3Y = DepartureZoneVec2.y + BluePatrolWaypointDistance						
			--Perimeter Zone North Point
			BS1_WP4X = DepartureZoneVec2.x + BluePatrolWaypointDistance
			BS1_WP4Y = DepartureZoneVec2.y						
			--Perimeter Zone West Point
			BS1_WP5X = DepartureZoneVec2.x
			BS1_WP5Y = DepartureZoneVec2.y - BluePatrolWaypointDistance					
		end		
		
		BLUESQUADRON1 = SPAWN:NewWithAlias("USAF F-14B", BlueSquadronName1)
							:InitRandomizeTemplate( USNAirForceCAP )									
		
		:OnSpawnGroup(
			function( SpawnGroup )						
				BLUESQUADRON1GROUPNAME = SpawnGroup.GroupName
				BLUESQUADRON1GROUP = GROUP:FindByName(SpawnGroup.GroupName)							
													
				--////CAP Mission Profile, Engage Targets Along Route Unrestricted Distance, Switch Waypoint From WP5 to WP2, 0.7Mach, Randomised Flight Level From Above Parameters
				Mission = {
					["id"] = "Mission",
					["params"] = {		
						["route"] = 
						{                                    
							["points"] = 
							{
								[1] = 
								{
									["alt"] = BS1_FlightLevel/2,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["enabled"] = true,
													["auto"] = true,
													["id"] = "WrappedAction",
													["number"] = 1,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "EPLRS",
															["params"] = 
															{
																["value"] = true,
																["groupId"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
												[2] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 2,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["variantIndex"] = 1,
																["name"] = 5,
																["formationIndex"] = 6,
																["value"] = 393217,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [2]
												[3] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "EngageTargets",
													["number"] = 3,
													["params"] = 
													{
														["targetTypes"] = 
														{
															[1] = "Air",
														}, -- end of ["targetTypes"]
														["priority"] = 0,
														["value"] = "Air;",
														["noTargetTypes"] = 
														{
															[1] = "Cruise missiles",
															[2] = "Antiship Missiles",
															[3] = "AA Missiles",
															[4] = "AG Missiles",
															[5] = "SA Missiles",
														}, -- end of ["noTargetTypes"]
														["maxDistEnabled"] = true,
														["maxDist"] = EngagementDistance,
													}, -- end of ["params"]
												}, -- end of [3]
												[4] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 4,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 2,
																["name"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [4]
												[5] = 
												{
													["number"] = 5,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 264241152,
																["name"] = 10,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [5]
												[6] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 6,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 19,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [6]
												[7] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 7,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [7]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 0,
									["ETA_locked"] = true,
									["y"] = BS1_WP0Y,
									["x"] = BS1_WP0X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [1]
								[2] = 
								{
									["alt"] = BS1_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 127.32626754758,
									["ETA_locked"] = false,
									["y"] = BS1_WP1Y,
									["x"] = BS1_WP1X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [2]
								[3] = 
								{
									["alt"] = BS1_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 380.31328316984,
									["ETA_locked"] = false,
									["y"] = BS1_WP2Y,
									["x"] = BS1_WP2X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [3]
								[4] = 
								{
									["alt"] = BS1_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 832.92276094724,
									["ETA_locked"] = false,
									["y"] = BS1_WP3Y,
									["x"] = BS1_WP3X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [4]
								[5] = 
								{
									["alt"] = BS1_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1289.20366255,
									["ETA_locked"] = false,
									["y"] = BS1_WP4Y,
									["x"] = BS1_WP4X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [5]
								[6] = 
								{
									["alt"] = BS1_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["number"] = 1,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "SwitchWaypoint",
															["params"] = 
															{
																["goToWaypointIndex"] = 3,
																["fromWaypointIndex"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1744.9128539618,
									["ETA_locked"] = false,
									["y"] = BS1_WP5Y,
									["x"] = BS1_WP5X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [6]
							}, -- end of ["points"]
						}, -- end of ["route"]
					}, --end of ["params"]
				}--end of Mission				
				BLUESQUADRON1GROUP:SetTask(Mission)				
			end
		)
		--:SpawnInZone( SpawnZone, false, BS1_FlightLevel, BS1_FlightLevel )
		:SpawnAtAirbase( AIRBASE:FindByName( "CVN-75 Truman" ), SPAWN.Takeoff.Hot ) --SPAWN.Takeoff.Hot SPAWN.Takeoff.Cold
		--trigger.action.outText("Blue Squadron 1 Is Launching Fighters", 15)	
	end
end

function SEF_BLUESQUADRON2_SPAWN()
	
	if ( GROUP:FindByName(BLUESQUADRON2GROUPNAME) ~= nil and GROUP:FindByName(BLUESQUADRON2GROUPNAME):IsAlive() ) then
		--trigger.action.outText("Blue Squadron 2 Is Currently Active, Not Spawning A Replacement Yet",15)	
	else
		BLUESQUADRON2_DATA[1].Vec2 = nil
		BLUESQUADRON2_DATA[1].TimeStamp = nil
		BLUESQUADRON2_DATA[2].Vec2 = nil
		BLUESQUADRON2_DATA[2].TimeStamp = nil
		
		local SpawnZone = AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Dhafra_AB):GetZone()
		--local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		
		local Randomiser = math.random(BlueFlightLevelMin,BlueFlightLevelMax)
		BS2_FlightLevel = Randomiser * 1000
				
		local DepartureZoneVec2 = SpawnZone:GetVec2()
		--local TargetZoneVec2 	= DestinationZone:GetVec2()
					
		local FlightDirection = math.random(1,100)
					
		if ( FlightDirection <= 50 ) then			
			--////Clockwise
			--Spawn Point
			BS2_WP0X = DepartureZoneVec2.x
			BS2_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			BS2_WP1X = DepartureZoneVec2.x + BluePatrolWaypointInitial
			BS2_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone North Point
			BS2_WP2X = DepartureZoneVec2.x + BluePatrolWaypointDistance
			BS2_WP2Y = DepartureZoneVec2.y 						
			--Perimeter Zone East Point
			BS2_WP3X = DepartureZoneVec2.x
			BS2_WP3Y = DepartureZoneVec2.y + BluePatrolWaypointDistance						
			--Perimeter Zone South Point
			BS2_WP4X = DepartureZoneVec2.x - BluePatrolWaypointDistance
			BS2_WP4Y = DepartureZoneVec2.y						
			--Perimeter Zone West Point
			BS2_WP5X = DepartureZoneVec2.x
			BS2_WP5Y = DepartureZoneVec2.y - BluePatrolWaypointDistance								
		else			
			--////Anti-Clockwise
			--Spawn Point
			BS2_WP0X = DepartureZoneVec2.x
			BS2_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			BS2_WP1X = DepartureZoneVec2.x - BluePatrolWaypointInitial
			BS2_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone South Point
			BS2_WP2X = DepartureZoneVec2.x - BluePatrolWaypointDistance
			BS2_WP2Y = DepartureZoneVec2.y 						
			--Perimeter Zone East Point
			BS2_WP3X = DepartureZoneVec2.x
			BS2_WP3Y = DepartureZoneVec2.y + BluePatrolWaypointDistance						
			--Perimeter Zone North Point
			BS2_WP4X = DepartureZoneVec2.x + BluePatrolWaypointDistance
			BS2_WP4Y = DepartureZoneVec2.y						
			--Perimeter Zone West Point
			BS2_WP5X = DepartureZoneVec2.x
			BS2_WP5Y = DepartureZoneVec2.y - BluePatrolWaypointDistance					
		end		
		
		BLUESQUADRON2 = SPAWN:NewWithAlias("UAEAF F-16C", BlueSquadronName2)							
							:InitRandomizeTemplate( UAEAFAirForceCAP )														
							
		:OnSpawnGroup(
			function( SpawnGroup )						
				BLUESQUADRON2GROUPNAME = SpawnGroup.GroupName
				BLUESQUADRON2GROUP = GROUP:FindByName(SpawnGroup.GroupName)							
													
				--////CAP Mission Profile, Engage Targets Along Route Unrestricted Distance, Switch Waypoint From WP5 to WP2, 0.7Mach, Randomised Flight Level From Above Parameters
				Mission = {
					["id"] = "Mission",
					["params"] = {		
						["route"] = 
						{                                    
							["points"] = 
							{
								[1] = 
								{
									["alt"] = BS2_FlightLevel/2,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["enabled"] = true,
													["auto"] = true,
													["id"] = "WrappedAction",
													["number"] = 1,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "EPLRS",
															["params"] = 
															{
																["value"] = true,
																["groupId"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
												[2] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 2,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["variantIndex"] = 1,
																["name"] = 5,
																["formationIndex"] = 6,
																["value"] = 393217,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [2]
												[3] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "EngageTargets",
													["number"] = 3,
													["params"] = 
													{
														["targetTypes"] = 
														{
															[1] = "Air",
														}, -- end of ["targetTypes"]
														["priority"] = 0,
														["value"] = "Air;",
														["noTargetTypes"] = 
														{
															[1] = "Cruise missiles",
															[2] = "Antiship Missiles",
															[3] = "AA Missiles",
															[4] = "AG Missiles",
															[5] = "SA Missiles",
														}, -- end of ["noTargetTypes"]
														["maxDistEnabled"] = true,
														["maxDist"] = EngagementDistance,
													}, -- end of ["params"]
												}, -- end of [3]
												[4] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 4,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 2,
																["name"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [4]
												[5] = 
												{
													["number"] = 5,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 264241152,
																["name"] = 10,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [5]
												[6] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 6,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 19,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [6]
												[7] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 7,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [7]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 0,
									["ETA_locked"] = true,
									["y"] = BS2_WP0Y,
									["x"] = BS2_WP0X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [1]
								[2] = 
								{
									["alt"] = BS2_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 127.32626754758,
									["ETA_locked"] = false,
									["y"] = BS2_WP1Y,
									["x"] = BS2_WP1X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [2]
								[3] = 
								{
									["alt"] = BS2_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 380.31328316984,
									["ETA_locked"] = false,
									["y"] = BS2_WP2Y,
									["x"] = BS2_WP2X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [3]
								[4] = 
								{
									["alt"] = BS2_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 832.92276094724,
									["ETA_locked"] = false,
									["y"] = BS2_WP3Y,
									["x"] = BS2_WP3X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [4]
								[5] = 
								{
									["alt"] = BS2_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1289.20366255,
									["ETA_locked"] = false,
									["y"] = BS2_WP4Y,
									["x"] = BS2_WP4X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [5]
								[6] = 
								{
									["alt"] = BS2_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["number"] = 1,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "SwitchWaypoint",
															["params"] = 
															{
																["goToWaypointIndex"] = 3,
																["fromWaypointIndex"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1744.9128539618,
									["ETA_locked"] = false,
									["y"] = BS2_WP5Y,
									["x"] = BS2_WP5X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [6]
							}, -- end of ["points"]
						}, -- end of ["route"]
					}, --end of ["params"]
				}--end of Mission				
				BLUESQUADRON2GROUP:SetTask(Mission)				
			end
		)		
		:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Dhafra_AB), {252,251,250,249}, SPAWN.Takeoff.Hot)
		--:SpawnInZone( SpawnZone, false, BS2_FlightLevel, BS2_FlightLevel )
		--:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.PersianGulf.Al_Dhafra_AB ), SPAWN.Takeoff.Hot ) --SPAWN.Takeoff.Hot SPAWN.Takeoff.Cold
		--trigger.action.outText("Blue Squadron 2 Is Launching Fighters", 15)	
	end
end

function SEF_BLUESQUADRON3_SPAWN()
	
	if ( GROUP:FindByName(BLUESQUADRON3GROUPNAME) ~= nil and GROUP:FindByName(BLUESQUADRON3GROUPNAME):IsAlive() ) then
		--trigger.action.outText("Blue Squadron 3 Is Currently Active, Not Spawning A Replacement Yet",15)	
	else
		BLUESQUADRON3_DATA[1].Vec2 = nil
		BLUESQUADRON3_DATA[1].TimeStamp = nil
		BLUESQUADRON3_DATA[2].Vec2 = nil
		BLUESQUADRON3_DATA[2].TimeStamp = nil
		
		local SpawnZone = AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB):GetZone()
		--local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		
		local Randomiser = math.random(BlueFlightLevelMin,BlueFlightLevelMax)
		BS3_FlightLevel = Randomiser * 1000
				
		local DepartureZoneVec2 = SpawnZone:GetVec2()
		--local TargetZoneVec2 	= DestinationZone:GetVec2()
					
		local FlightDirection = math.random(1,100)
					
		if ( FlightDirection <= 50 ) then			
			--////Clockwise
			--Spawn Point
			BS3_WP0X = DepartureZoneVec2.x
			BS3_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			BS3_WP1X = DepartureZoneVec2.x + BluePatrolWaypointInitial
			BS3_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone North Point
			BS3_WP2X = DepartureZoneVec2.x + BluePatrolWaypointDistance
			BS3_WP2Y = DepartureZoneVec2.y 						
			--Perimeter Zone East Point
			BS3_WP3X = DepartureZoneVec2.x
			BS3_WP3Y = DepartureZoneVec2.y + BluePatrolWaypointDistance						
			--Perimeter Zone South Point
			BS3_WP4X = DepartureZoneVec2.x - BluePatrolWaypointDistance
			BS3_WP4Y = DepartureZoneVec2.y						
			--Perimeter Zone West Point
			BS3_WP5X = DepartureZoneVec2.x
			BS3_WP5Y = DepartureZoneVec2.y - BluePatrolWaypointDistance								
		else			
			--////Anti-Clockwise
			--Spawn Point
			BS3_WP0X = DepartureZoneVec2.x
			BS3_WP0Y = DepartureZoneVec2.y
			--Initial Waypoint
			BS3_WP1X = DepartureZoneVec2.x - BluePatrolWaypointInitial
			BS3_WP1Y = DepartureZoneVec2.y			
			--Perimeter Zone South Point
			BS3_WP2X = DepartureZoneVec2.x - BluePatrolWaypointDistance
			BS3_WP2Y = DepartureZoneVec2.y 						
			--Perimeter Zone East Point
			BS3_WP3X = DepartureZoneVec2.x
			BS3_WP3Y = DepartureZoneVec2.y + BluePatrolWaypointDistance						
			--Perimeter Zone North Point
			BS3_WP4X = DepartureZoneVec2.x + BluePatrolWaypointDistance
			BS3_WP4Y = DepartureZoneVec2.y						
			--Perimeter Zone West Point
			BS3_WP5X = DepartureZoneVec2.x
			BS3_WP5Y = DepartureZoneVec2.y - BluePatrolWaypointDistance					
		end		
		
		BLUESQUADRON3 = SPAWN:NewWithAlias("USAF F-15C", BlueSquadronName3)							
							:InitRandomizeTemplate( USAFAirForceCAP )														
							
		:OnSpawnGroup(
			function( SpawnGroup )						
				BLUESQUADRON3GROUPNAME = SpawnGroup.GroupName
				BLUESQUADRON3GROUP = GROUP:FindByName(SpawnGroup.GroupName)							
													
				--////CAP Mission Profile, Engage Targets Along Route Unrestricted Distance, Switch Waypoint From WP5 to WP2, 0.7Mach, Randomised Flight Level From Above Parameters
				Mission = {
					["id"] = "Mission",
					["params"] = {		
						["route"] = 
						{                                    
							["points"] = 
							{
								[1] = 
								{
									["alt"] = BS3_FlightLevel/2,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["enabled"] = true,
													["auto"] = true,
													["id"] = "WrappedAction",
													["number"] = 1,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "EPLRS",
															["params"] = 
															{
																["value"] = true,
																["groupId"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
												[2] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 2,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["variantIndex"] = 1,
																["name"] = 5,
																["formationIndex"] = 6,
																["value"] = 393217,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [2]
												[3] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "EngageTargets",
													["number"] = 3,
													["params"] = 
													{
														["targetTypes"] = 
														{
															[1] = "Air",
														}, -- end of ["targetTypes"]
														["priority"] = 0,
														["value"] = "Air;",
														["noTargetTypes"] = 
														{
															[1] = "Cruise missiles",
															[2] = "Antiship Missiles",
															[3] = "AA Missiles",
															[4] = "AG Missiles",
															[5] = "SA Missiles",
														}, -- end of ["noTargetTypes"]
														["maxDistEnabled"] = true,
														["maxDist"] = EngagementDistance,
													}, -- end of ["params"]
												}, -- end of [3]
												[4] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 4,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 2,
																["name"] = 1,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [4]
												[5] = 
												{
													["number"] = 5,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = 264241152,
																["name"] = 10,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [5]
												[6] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 6,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 19,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [6]
												[7] = 
												{
													["enabled"] = true,
													["auto"] = false,
													["id"] = "WrappedAction",
													["number"] = 7,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "Option",
															["params"] = 
															{
																["value"] = true,
																["name"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [7]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 0,
									["ETA_locked"] = true,
									["y"] = BS3_WP0Y,
									["x"] = BS3_WP0X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [1]
								[2] = 
								{
									["alt"] = BS3_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 127.32626754758,
									["ETA_locked"] = false,
									["y"] = BS3_WP1Y,
									["x"] = BS3_WP1X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [2]
								[3] = 
								{
									["alt"] = BS3_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 380.31328316984,
									["ETA_locked"] = false,
									["y"] = BS3_WP2Y,
									["x"] = BS3_WP2X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [3]
								[4] = 
								{
									["alt"] = BS3_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 832.92276094724,
									["ETA_locked"] = false,
									["y"] = BS3_WP3Y,
									["x"] = BS3_WP3X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [4]
								[5] = 
								{
									["alt"] = BS3_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1289.20366255,
									["ETA_locked"] = false,
									["y"] = BS3_WP4Y,
									["x"] = BS3_WP4X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [5]
								[6] = 
								{
									["alt"] = BS3_FlightLevel,
									["action"] = "Turning Point",
									["alt_type"] = "BARO",
									["speed"] = 234.32754852983,
									["task"] = 
									{
										["id"] = "ComboTask",
										["params"] = 
										{
											["tasks"] = 
											{
												[1] = 
												{
													["number"] = 1,
													["auto"] = false,
													["id"] = "WrappedAction",
													["enabled"] = true,
													["params"] = 
													{
														["action"] = 
														{
															["id"] = "SwitchWaypoint",
															["params"] = 
															{
																["goToWaypointIndex"] = 3,
																["fromWaypointIndex"] = 6,
															}, -- end of ["params"]
														}, -- end of ["action"]
													}, -- end of ["params"]
												}, -- end of [1]
											}, -- end of ["tasks"]
										}, -- end of ["params"]
									}, -- end of ["task"]
									["type"] = "Turning Point",
									["ETA"] = 1744.9128539618,
									["ETA_locked"] = false,
									["y"] = BS3_WP5Y,
									["x"] = BS3_WP5X,
									["formation_template"] = "",
									["speed_locked"] = true,
								}, -- end of [6]
							}, -- end of ["points"]
						}, -- end of ["route"]
					}, --end of ["params"]
				}--end of Mission				
				BLUESQUADRON3GROUP:SetTask(Mission)				
			end
		)
		:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB), {23,24}, SPAWN.Takeoff.Hot)
		--:SpawnInZone( SpawnZone, false, BS3_FlightLevel, BS3_FlightLevel )
		--:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.PersianGulf.Al_Minhad_AB ), SPAWN.Takeoff.Hot ) --SPAWN.Takeoff.Hot SPAWN.Takeoff.Cold
		--trigger.action.outText("Blue Squadron 3 Is Launching Fighters", 15)	
	end
end


function SEF_BLUESQUADRON4_SCHEDULER()
    
  if ( BlueSquadronsEnabled == 1 ) then
    if ( GROUP:FindByName(BLUESQUADRON4GROUPNAME) ~= nil and GROUP:FindByName(BLUESQUADRON4GROUPNAME):IsAlive() ) then        
      timer.scheduleFunction(SEF_BLUESQUADRON4_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))      
    else
      SEF_BLUESQUADRON4_INITIALISE()
      
      timer.scheduleFunction(SEF_BLUESQUADRON4_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))
    end
  else  
    timer.scheduleFunction(SEF_BLUESQUADRON4_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))    
  end 
end

function SEF_BLUESQUADRON4_SPAWN(DepartureAirbaseName, DestinationAirbaseName)
  
  if ( GROUP:FindByName(BLUESQUADRON4GROUPNAME) ~= nil and GROUP:FindByName(BLUESQUADRON4GROUPNAME):IsAlive() ) then
    --trigger.action.outText("Red Squadron 2 Is Currently Active, Not Spawning A Replacement Yet",15) 
  else
    BLUESQUADRON4_DATA[1].Vec2 = nil
    BLUESQUADRON4_DATA[1].TimeStamp = nil
    BLUESQUADRON4_DATA[2].Vec2 = nil
    BLUESQUADRON4_DATA[2].TimeStamp = nil
       
    local SpawnZone = AIRBASE:FindByName(DepartureAirbaseName):GetZone()
    local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()  
    
    local Randomiser = math.random(BlueFlightLevelMin,BlueFlightLevelMax)
    BS4_FlightLevel = Randomiser * 1000
        
    local DepartureZoneVec2 = SpawnZone:GetVec2()
    local TargetZoneVec2  = DestinationZone:GetVec2()
          
    local FlightDirection = math.random(1,100)
          
    if ( FlightDirection <= 50 ) then     
      --////Clockwise
      --Spawn Point
      BS4_WP0X = DepartureZoneVec2.x
      BS4_WP0Y = DepartureZoneVec2.y
      --Initial Waypoint
      BS4_WP1X = DepartureZoneVec2.x + BluePatrolWaypointInitial
      BS4_WP1Y = DepartureZoneVec2.y      
      --Perimeter Zone North Point
      BS4_WP2X = TargetZoneVec2.x + BluePatrolWaypointDistance
      BS4_WP2Y = TargetZoneVec2.y             
      --Perimeter Zone East Point
      BS4_WP3X = TargetZoneVec2.x
      BS4_WP3Y = TargetZoneVec2.y + BluePatrolWaypointDistance           
      --Perimeter Zone South Point
      BS4_WP4X = TargetZoneVec2.x - BluePatrolWaypointDistance
      BS4_WP4Y = TargetZoneVec2.y           
      --Perimeter Zone West Point
      BS4_WP5X = TargetZoneVec2.x
      BS4_WP5Y = TargetZoneVec2.y - BluePatrolWaypointDistance               
    else      
      --////Anti-Clockwise
      --Spawn Point
      BS4_WP0X = DepartureZoneVec2.x
      BS4_WP0Y = DepartureZoneVec2.y
      --Initial Waypoint
      BS4_WP1X = DepartureZoneVec2.x - BluePatrolWaypointInitial
      BS4_WP1Y = DepartureZoneVec2.y      
      --Perimeter Zone South Point
      BS4_WP2X = TargetZoneVec2.x - BluePatrolWaypointDistance
      BS4_WP2Y = TargetZoneVec2.y             
      --Perimeter Zone East Point
      BS4_WP3X = TargetZoneVec2.x
      BS4_WP3Y = TargetZoneVec2.y + BluePatrolWaypointDistance           
      --Perimeter Zone North Point
      BS4_WP4X = TargetZoneVec2.x + BluePatrolWaypointDistance
      BS4_WP4Y = TargetZoneVec2.y           
      --Perimeter Zone West Point
      BS4_WP5X = TargetZoneVec2.x
      BS4_WP5Y = TargetZoneVec2.y - BluePatrolWaypointDistance         
    end   
    
    BLUESQUADRON4 = SPAWN:NewWithAlias("USN F/A-18C", BlueSquadronName4)
              :InitRandomizeTemplate(CombinedBlueCAP)                 
    
    :OnSpawnGroup(
      function( SpawnGroup )            
        BLUESQUADRON4GROUPNAME = SpawnGroup.GroupName
        BLUESQUADRON4GROUP = GROUP:FindByName(SpawnGroup.GroupName)              
                          
        --////CAP Mission Profile, Engage Targets Along Route Unrestricted Distance, Switch Waypoint From WP5 to WP2, 0.7Mach, Randomised Flight Level From Above Parameters
        Mission = {
          ["id"] = "Mission",
          ["params"] = {    
            ["route"] = 
            {                                    
              ["points"] = 
              {
                [1] = 
                {
                  ["alt"] = BS4_FlightLevel/2,
                  ["action"] = "Turning Point",
                  ["alt_type"] = "BARO",
                  ["speed"] = 234.32754852983,
                  ["task"] = 
                  {
                    ["id"] = "ComboTask",
                    ["params"] = 
                    {
                      ["tasks"] = 
                      {
                        [1] = 
                        {
                          ["enabled"] = true,
                          ["auto"] = true,
                          ["id"] = "WrappedAction",
                          ["number"] = 1,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "EPLRS",
                              ["params"] = 
                              {
                                ["value"] = true,
                                ["groupId"] = 1,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [1]
                        [2] = 
                        {
                          ["enabled"] = true,
                          ["auto"] = false,
                          ["id"] = "WrappedAction",
                          ["number"] = 2,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "Option",
                              ["params"] = 
                              {
                                ["variantIndex"] = 1,
                                ["name"] = 5,
                                ["formationIndex"] = 6,
                                ["value"] = 393217,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [2]
                        [3] = 
                        {
                          ["enabled"] = true,
                          ["auto"] = false,
                          ["id"] = "EngageTargets",
                          ["number"] = 3,
                          ["params"] = 
                          {
                            ["targetTypes"] = 
                            {
                              [1] = "Air",
                            }, -- end of ["targetTypes"]
                            ["priority"] = 0,
                            ["value"] = "Air;",
                            ["noTargetTypes"] = 
                            {
                              [1] = "Cruise missiles",
                              [2] = "Antiship Missiles",
                              [3] = "AA Missiles",
                              [4] = "AG Missiles",
                              [5] = "SA Missiles",
                            }, -- end of ["noTargetTypes"]
                            ["maxDistEnabled"] = true,
                            ["maxDist"] = EngagementDistance,
                          }, -- end of ["params"]
                        }, -- end of [3]
                        [4] = 
                        {
                          ["enabled"] = true,
                          ["auto"] = false,
                          ["id"] = "WrappedAction",
                          ["number"] = 4,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "Option",
                              ["params"] = 
                              {
                                ["value"] = 3,
                                ["name"] = 1,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [4]
                        [5] = 
                        {
                          ["number"] = 5,
                          ["auto"] = false,
                          ["id"] = "WrappedAction",
                          ["enabled"] = true,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "Option",
                              ["params"] = 
                              {
                                ["value"] = 264241152,
                                ["name"] = 10,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [5]
                        [6] = 
                        {
                          ["enabled"] = true,
                          ["auto"] = false,
                          ["id"] = "WrappedAction",
                          ["number"] = 6,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "Option",
                              ["params"] = 
                              {
                                ["value"] = true,
                                ["name"] = 19,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [6]
                        [7] = 
                        {
                          ["enabled"] = true,
                          ["auto"] = false,
                          ["id"] = "WrappedAction",
                          ["number"] = 7,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "Option",
                              ["params"] = 
                              {
                                ["value"] = true,
                                ["name"] = 6,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [7]
                      }, -- end of ["tasks"]
                    }, -- end of ["params"]
                  }, -- end of ["task"]
                  ["type"] = "Turning Point",
                  ["ETA"] = 0,
                  ["ETA_locked"] = true,
                  ["y"] = BS4_WP0Y,
                  ["x"] = BS4_WP0X,
                  ["formation_template"] = "",
                  ["speed_locked"] = true,
                }, -- end of [1]
                [2] = 
                {
                  ["alt"] = BS4_FlightLevel,
                  ["action"] = "Turning Point",
                  ["alt_type"] = "BARO",
                  ["speed"] = 234.32754852983,
                  ["task"] = 
                  {
                    ["id"] = "ComboTask",
                    ["params"] = 
                    {
                      ["tasks"] = 
                      {
                      }, -- end of ["tasks"]
                    }, -- end of ["params"]
                  }, -- end of ["task"]
                  ["type"] = "Turning Point",
                  ["ETA"] = 127.32626754758,
                  ["ETA_locked"] = false,
                  ["y"] = BS4_WP1Y,
                  ["x"] = BS4_WP1X,
                  ["formation_template"] = "",
                  ["speed_locked"] = true,
                }, -- end of [2]
                [3] = 
                {
                  ["alt"] = BS4_FlightLevel,
                  ["action"] = "Turning Point",
                  ["alt_type"] = "BARO",
                  ["speed"] = 234.32754852983,
                  ["task"] = 
                  {
                    ["id"] = "ComboTask",
                    ["params"] = 
                    {
                      ["tasks"] = 
                      {
                      }, -- end of ["tasks"]
                    }, -- end of ["params"]
                  }, -- end of ["task"]
                  ["type"] = "Turning Point",
                  ["ETA"] = 380.31328316984,
                  ["ETA_locked"] = false,
                  ["y"] = BS4_WP2Y,
                  ["x"] = BS4_WP2X,
                  ["formation_template"] = "",
                  ["speed_locked"] = true,
                }, -- end of [3]
                [4] = 
                {
                  ["alt"] = BS4_FlightLevel,
                  ["action"] = "Turning Point",
                  ["alt_type"] = "BARO",
                  ["speed"] = 234.32754852983,
                  ["task"] = 
                  {
                    ["id"] = "ComboTask",
                    ["params"] = 
                    {
                      ["tasks"] = 
                      {
                      }, -- end of ["tasks"]
                    }, -- end of ["params"]
                  }, -- end of ["task"]
                  ["type"] = "Turning Point",
                  ["ETA"] = 832.92276094724,
                  ["ETA_locked"] = false,
                  ["y"] = BS4_WP3Y,
                  ["x"] = BS4_WP3X,
                  ["formation_template"] = "",
                  ["speed_locked"] = true,
                }, -- end of [4]
                [5] = 
                {
                  ["alt"] = BS4_FlightLevel,
                  ["action"] = "Turning Point",
                  ["alt_type"] = "BARO",
                  ["speed"] = 234.32754852983,
                  ["task"] = 
                  {
                    ["id"] = "ComboTask",
                    ["params"] = 
                    {
                      ["tasks"] = 
                      {
                      }, -- end of ["tasks"]
                    }, -- end of ["params"]
                  }, -- end of ["task"]
                  ["type"] = "Turning Point",
                  ["ETA"] = 1289.20366255,
                  ["ETA_locked"] = false,
                  ["y"] = BS4_WP4Y,
                  ["x"] = BS4_WP4X,
                  ["formation_template"] = "",
                  ["speed_locked"] = true,
                }, -- end of [5]
                [6] = 
                {
                  ["alt"] = BS4_FlightLevel,
                  ["action"] = "Turning Point",
                  ["alt_type"] = "BARO",
                  ["speed"] = 234.32754852983,
                  ["task"] = 
                  {
                    ["id"] = "ComboTask",
                    ["params"] = 
                    {
                      ["tasks"] = 
                      {
                        [1] = 
                        {
                          ["number"] = 1,
                          ["auto"] = false,
                          ["id"] = "WrappedAction",
                          ["enabled"] = true,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "SwitchWaypoint",
                              ["params"] = 
                              {
                                ["goToWaypointIndex"] = 3,
                                ["fromWaypointIndex"] = 6,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [1]
                      }, -- end of ["tasks"]
                    }, -- end of ["params"]
                  }, -- end of ["task"]
                  ["type"] = "Turning Point",
                  ["ETA"] = 1744.9128539618,
                  ["ETA_locked"] = false,
                  ["y"] = BS4_WP5Y,
                  ["x"] = BS4_WP5X,
                  ["formation_template"] = "",
                  ["speed_locked"] = true,
                }, -- end of [6]
              }, -- end of ["points"]
            }, -- end of ["route"]
          }, --end of ["params"]
        }--end of Mission       
        BLUESQUADRON4GROUP:SetTask(Mission)        
      end
    )
    if ( DepartureAirbaseName == AIRBASE.PersianGulf.Khasab ) then
      BLUESQUADRON4:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Khasab), {4,5,2,3}, SPAWN.Takeoff.Hot)
    else
      BLUESQUADRON4:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )
    end   
    --:SpawnInZone( SpawnZone, false, BS4_FlightLevel, BS4_FlightLevel )
    --:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot ) --SPAWN.Takeoff.Hot SPAWN.Takeoff.Cold SPAWN.Takeoff.Runway
    --trigger.action.outText("Blue Squadron 4 Is Launching Fighters", 15)  
  end
end

function SEF_BLUESQUADRON4_INITIALISE()

  --Retrieve The Standard Deployment For The Squadron
  SEF_BLUESQUADRON4_DEPLOYMENT()
  
  SET_AIRFIELDPERIMETERCLIENTS = SET_CLIENT:New():FilterCoalitions("red"):FilterCategories( { "plane", "helicopter" } ):FilterActive():FilterOnce()
  
  ZuluPrimaryPerimeterCount = 0     
      
  --Zulu
  SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(ZuluPrimaryAirbase.." Perimeter Zone"), function ( GroupObject )
    ZuluPrimaryPerimeterCount = ZuluPrimaryPerimeterCount + 1
    end
  ) 
  
  --////Zulu
  if ( ZuluPrimaryPerimeterCount > 0 ) then   
    ZuluStatus = ZuluPrimaryAirbase.." - Zulu Squadron\nAirspace Is Being Contested By Iran\n"
    
    --Ras Al Khaimah Intl -> Khasab -> Qeshm Island -> Havadarya -> Lar

    if ( ZuluPrimaryAirbase == AIRBASE.PersianGulf.Qeshm_Island ) then
      
      KhasabPerimeterCount = 0
      RasPerimeterCount = 0
      MinhadPerimeterCount = 0
          
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Khasab.." Perimeter Zone"), function ( GroupObject )
        KhasabPerimeterCount = KhasabPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Ras_Al_Khaimah.." Perimeter Zone"), function ( GroupObject )
        RasPerimeterCount = RasPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB.." Perimeter Zone"), function ( GroupObject )
        MinhadPerimeterCount = MinhadPerimeterCount + 1   
        end
      )   

      if ( Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 2 and KhasabPerimeterCount == 0 ) then             
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Khasab, ZuluDestinationAirbase)  
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 2 and RasPerimeterCount == 0 ) then      
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Ras_Al_Khaimah, ZuluDestinationAirbase)            
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() == 2 and MinhadPerimeterCount == 0 ) then     
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, ZuluDestinationAirbase)     
      else      
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Al_Dhafra_AB, ZuluDestinationAirbase)
      end     
    elseif ( ZuluPrimaryAirbase == AIRBASE.PersianGulf.Khasab ) then
    
      RasPerimeterCount = 0
      QeshmPerimeterCount = 0
      MinhadPerimeterCount = 0
          
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Qeshm_Island.." Perimeter Zone"), function ( GroupObject )
        QeshmPerimeterCount = QeshmPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Ras_Al_Khaimah.." Perimeter Zone"), function ( GroupObject )
        RasPerimeterCount = RasPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB.." Perimeter Zone"), function ( GroupObject )
        MinhadPerimeterCount = MinhadPerimeterCount + 1   
        end
      )   

      if ( Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 2 and QeshmPerimeterCount == 0 ) then      
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Qeshm_Island, ZuluDestinationAirbase)
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 2 and RasPerimeterCount == 0 ) then      
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Ras_Al_Khaimah, ZuluDestinationAirbase)
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() == 2 and MinhadPerimeterCount == 0 ) then     
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, ZuluDestinationAirbase)
      else      
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Al_Dhafra_AB, ZuluDestinationAirbase)
      end   
    elseif ( ZuluPrimaryAirbase == AIRBASE.PersianGulf.Ras_Al_Khaimah ) then
    
      QeshmPerimeterCount = 0
      KhasabPerimeterCount = 0
      MinhadPerimeterCount = 0
          
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Qeshm_Island.." Perimeter Zone"), function ( GroupObject )
        QeshmPerimeterCount = QeshmPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Khasab.." Perimeter Zone"), function ( GroupObject )
        KhasabPerimeterCount = KhasabPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB.." Perimeter Zone"), function ( GroupObject )
        MinhadPerimeterCount = MinhadPerimeterCount + 1   
        end
      )   

      if ( Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 2 and QeshmPerimeterCount == 0 ) then      
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Qeshm_Island, ZuluDestinationAirbase)      
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 2 and KhasabPerimeterCount == 0 ) then     
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Khasab, ZuluDestinationAirbase)    
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() == 2 and MinhadPerimeterCount == 0 ) then     
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, ZuluDestinationAirbase)     
      else      
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Al_Dhafra_AB, ZuluDestinationAirbase)       
      end   
    elseif ( ZuluPrimaryAirbase == AIRBASE.PersianGulf.Al_Minhad_AB ) then
      
      QeshmPerimeterCount = 0
      KhasabPerimeterCount = 0
      RasPerimeterCount = 0
            
          
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Qeshm_Island.." Perimeter Zone"), function ( GroupObject )
        QeshmPerimeterCount = QeshmPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Khasab.." Perimeter Zone"), function ( GroupObject )
        KhasabPerimeterCount = KhasabPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Ras_Al_Khaimah.." Perimeter Zone"), function ( GroupObject )
        RasPerimeterCount = RasPerimeterCount + 1   
        end
      )   

      if ( Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 2 and QeshmPerimeterCount == 0 ) then      
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Qeshm_Island, ZuluDestinationAirbase)        
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 2 and KhasabPerimeterCount == 0 ) then     
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Khasab, ZuluDestinationAirbase)            
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 2 and RasPerimeterCount == 0 ) then      
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Ras_Al_Khaimah, ZuluDestinationAirbase)      
      else      
        SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Al_Dhafra_AB, ZuluDestinationAirbase)       
      end   
    elseif ( ZuluPrimaryAirbase == AAIRBASE.PersianGulf.Al_Dhafra_AB ) then
      SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Al_Dhafra_AB, ZuluDestinationAirbase) 
    else      
      SEF_BLUESQUADRON4_SPAWN(AIRBASE.PersianGulf.Al_Dhafra_AB, ZuluDestinationAirbase)
    end   
  else
    ZuluStatus = ZuluPrimaryAirbase.." - Zulu Squadron\nAirspace Is Controlled By Iran\n"
    SEF_BLUESQUADRON4_SPAWN(ZuluPrimaryAirbase, ZuluDestinationAirbase)  
  end 
end

function SEF_BLUESQUADRON4_DEPLOYMENT()
  
  --Zulu
  if ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 2 ) then
    --Set Zulu To Ras Al Khaimah Intl
    ZuluPrimaryAirbase = AIRBASE.PersianGulf.Khasab
    ZuluDestinationAirbase = AIRBASE.PersianGulf.Qeshm_Island 
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 2 ) then
    --Set Zulu To Khasab And Patrol Ras Al Khaimah Intl
    ZuluPrimaryAirbase = AIRBASE.PersianGulf.Khasab 
    ZuluDestinationAirbase = AIRBASE.PersianGulf.Khasab 
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 2 ) then
    --Set Zulu To Ras Al Khaimah Intl And Patrol Ras Al Khaimah Intl And Leave Khasab For Delta To Patrol
    ZuluPrimaryAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
    ZuluDestinationAirbase = AIRBASE.PersianGulf.Khasab
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 2 ) then
    --Set Zulu To Qeshm And Patrol Khasab, Delta Will Be Doing The Same Here
    ZuluPrimaryAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
    ZuluDestinationAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 2 ) then
    --Set Zulu To Ras Al Khaimah Intl, Patrol Ras Al Khaimah Intl And Leave Qeshm For Delta
    ZuluPrimaryAirbase = AIRBASE.PersianGulf.Al_Minhad_AB
    ZuluDestinationAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 2 ) then
    --Set Zulu To Khasab, Patrol Ras Al Khaimah Intl And Leave Qeshm For Delta
    ZuluPrimaryAirbase = AIRBASE.PersianGulf.Al_Minhad_AB
    ZuluDestinationAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 2 ) then
    --Set Zulu To Ras Al Khaimah Intl, Patrol Ras Al Khaimah Intl And Leave Qeshm And Khasab For Delta
    ZuluPrimaryAirbase = AIRBASE.PersianGulf.Al_Minhad_AB
    ZuluDestinationAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 2 ) then
    --Set Zulu To Havadarya, Patrol Qeshm
    ZuluPrimaryAirbase = AIRBASE.PersianGulf.Al_Minhad_AB
    ZuluDestinationAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 2 ) then
    --Set Zulu To Qeshm, Patrol Havadarya
    ZuluPrimaryAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
    ZuluDestinationAirbase = AIRBASE.PersianGulf.Al_Minhad_AB
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 2 ) then
    --Set Zulu To Qeshm, Patrol Havadarya
    ZuluPrimaryAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
    ZuluDestinationAirbase = AIRBASE.PersianGulf.Al_Minhad_AB
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() == 2 ) then
    --Set Zulu To Qeshm, Patrol Havadarya
    ZuluPrimaryAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
    ZuluDestinationAirbase = AIRBASE.PersianGulf.Al_Minhad_AB
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 2 ) then
    --Set Zulu To Qeshm, Patrol Havadarya
    ZuluPrimaryAirbase = AIRBASE.PersianGulf.Ras_Al_Khaimah
    ZuluDestinationAirbase = AIRBASE.PersianGulf.Al_Minhad_AB
  else
    --Set Zulu To Lar As We've Lost Both Havadarya And Qeshm, We're On The Defensive
    ZuluPrimaryAirbase = AIRBASE.PersianGulf.Al_Dhafra_AB
    ZuluDestinationAirbase = AIRBASE.PersianGulf.Al_Minhad_AB
  end
end




function SEF_BLUESQUADRON5_SCHEDULER()
    
  if ( BlueSquadronsEnabled == 1 ) then
    if ( GROUP:FindByName(BLUESQUADRON5GROUPNAME) ~= nil and GROUP:FindByName(BLUESQUADRON5GROUPNAME):IsAlive() ) then        
      timer.scheduleFunction(SEF_BLUESQUADRON5_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))      
    else
      SEF_BLUESQUADRON5_INITIALISE()
      
      timer.scheduleFunction(SEF_BLUESQUADRON5_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))
    end
  else  
    timer.scheduleFunction(SEF_BLUESQUADRON5_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerMin, BlueRespawnTimerMax))    
  end 
end

function SEF_BLUESQUADRON5_SPAWN(DepartureAirbaseName, DestinationAirbaseName)
  
  if ( GROUP:FindByName(BLUESQUADRON5GROUPNAME) ~= nil and GROUP:FindByName(BLUESQUADRON5GROUPNAME):IsAlive() ) then
    --trigger.action.outText("Red Squadron 2 Is Currently Active, Not Spawning A Replacement Yet",15) 
  else
    BLUESQUADRON5_DATA[1].Vec2 = nil
    BLUESQUADRON5_DATA[1].TimeStamp = nil
    BLUESQUADRON5_DATA[2].Vec2 = nil
    BLUESQUADRON5_DATA[2].TimeStamp = nil
       
    local SpawnZone = AIRBASE:FindByName(DepartureAirbaseName):GetZone()
    local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()  
    
    local Randomiser = math.random(BlueFlightLevelMin,BlueFlightLevelMax)
    BS5_FlightLevel = Randomiser * 1000
        
    local DepartureZoneVec2 = SpawnZone:GetVec2()
    local TargetZoneVec2  = DestinationZone:GetVec2()
          
    local FlightDirection = math.random(1,100)
          
    if ( FlightDirection <= 50 ) then     
      --////Clockwise
      --Spawn Point
      BS5_WP0X = DepartureZoneVec2.x
      BS5_WP0Y = DepartureZoneVec2.y
      --Initial Waypoint
      BS5_WP1X = DepartureZoneVec2.x + BluePatrolWaypointInitial
      BS5_WP1Y = DepartureZoneVec2.y      
      --Perimeter Zone North Point
      BS5_WP2X = TargetZoneVec2.x + BluePatrolWaypointDistance
      BS5_WP2Y = TargetZoneVec2.y             
      --Perimeter Zone East Point
      BS5_WP3X = TargetZoneVec2.x
      BS5_WP3Y = TargetZoneVec2.y + BluePatrolWaypointDistance           
      --Perimeter Zone South Point
      BS5_WP4X = TargetZoneVec2.x - BluePatrolWaypointDistance
      BS5_WP4Y = TargetZoneVec2.y           
      --Perimeter Zone West Point
      BS5_WP5X = TargetZoneVec2.x
      BS5_WP5Y = TargetZoneVec2.y - BluePatrolWaypointDistance               
    else      
      --////Anti-Clockwise
      --Spawn Point
      BS5_WP0X = DepartureZoneVec2.x
      BS5_WP0Y = DepartureZoneVec2.y
      --Initial Waypoint
      BS5_WP1X = DepartureZoneVec2.x - BluePatrolWaypointInitial
      BS5_WP1Y = DepartureZoneVec2.y      
      --Perimeter Zone South Point
      BS5_WP2X = TargetZoneVec2.x - BluePatrolWaypointDistance
      BS5_WP2Y = TargetZoneVec2.y             
      --Perimeter Zone East Point
      BS5_WP3X = TargetZoneVec2.x
      BS5_WP3Y = TargetZoneVec2.y + BluePatrolWaypointDistance           
      --Perimeter Zone North Point
      BS5_WP4X = TargetZoneVec2.x + BluePatrolWaypointDistance
      BS5_WP4Y = TargetZoneVec2.y           
      --Perimeter Zone West Point
      BS5_WP5X = TargetZoneVec2.x
      BS5_WP5Y = TargetZoneVec2.y - BluePatrolWaypointDistance         
    end   
    
    BLUESQUADRON5 = SPAWN:NewWithAlias("USN F-14B", BlueSquadronName5)
              :InitRandomizeTemplate(CombinedBlueCAP)                 
    
    :OnSpawnGroup(
      function( SpawnGroup )            
        BLUESQUADRON5GROUPNAME = SpawnGroup.GroupName
        BLUESQUADRON5GROUP = GROUP:FindByName(SpawnGroup.GroupName)              
                          
        --////CAP Mission Profile, Engage Targets Along Route Unrestricted Distance, Switch Waypoint From WP5 to WP2, 0.7Mach, Randomised Flight Level From Above Parameters
        Mission = {
          ["id"] = "Mission",
          ["params"] = {    
            ["route"] = 
            {                                    
              ["points"] = 
              {
                [1] = 
                {
                  ["alt"] = BS5_FlightLevel/2,
                  ["action"] = "Turning Point",
                  ["alt_type"] = "BARO",
                  ["speed"] = 234.32754852983,
                  ["task"] = 
                  {
                    ["id"] = "ComboTask",
                    ["params"] = 
                    {
                      ["tasks"] = 
                      {
                        [1] = 
                        {
                          ["enabled"] = true,
                          ["auto"] = true,
                          ["id"] = "WrappedAction",
                          ["number"] = 1,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "EPLRS",
                              ["params"] = 
                              {
                                ["value"] = true,
                                ["groupId"] = 1,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [1]
                        [2] = 
                        {
                          ["enabled"] = true,
                          ["auto"] = false,
                          ["id"] = "WrappedAction",
                          ["number"] = 2,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "Option",
                              ["params"] = 
                              {
                                ["variantIndex"] = 1,
                                ["name"] = 5,
                                ["formationIndex"] = 6,
                                ["value"] = 393217,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [2]
                        [3] = 
                        {
                          ["enabled"] = true,
                          ["auto"] = false,
                          ["id"] = "EngageTargets",
                          ["number"] = 3,
                          ["params"] = 
                          {
                            ["targetTypes"] = 
                            {
                              [1] = "Air",
                            }, -- end of ["targetTypes"]
                            ["priority"] = 0,
                            ["value"] = "Air;",
                            ["noTargetTypes"] = 
                            {
                              [1] = "Cruise missiles",
                              [2] = "Antiship Missiles",
                              [3] = "AA Missiles",
                              [4] = "AG Missiles",
                              [5] = "SA Missiles",
                            }, -- end of ["noTargetTypes"]
                            ["maxDistEnabled"] = true,
                            ["maxDist"] = EngagementDistance,
                          }, -- end of ["params"]
                        }, -- end of [3]
                        [4] = 
                        {
                          ["enabled"] = true,
                          ["auto"] = false,
                          ["id"] = "WrappedAction",
                          ["number"] = 4,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "Option",
                              ["params"] = 
                              {
                                ["value"] = 3,
                                ["name"] = 1,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [4]
                        [5] = 
                        {
                          ["number"] = 5,
                          ["auto"] = false,
                          ["id"] = "WrappedAction",
                          ["enabled"] = true,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "Option",
                              ["params"] = 
                              {
                                ["value"] = 264241152,
                                ["name"] = 10,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [5]
                        [6] = 
                        {
                          ["enabled"] = true,
                          ["auto"] = false,
                          ["id"] = "WrappedAction",
                          ["number"] = 6,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "Option",
                              ["params"] = 
                              {
                                ["value"] = true,
                                ["name"] = 19,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [6]
                        [7] = 
                        {
                          ["enabled"] = true,
                          ["auto"] = false,
                          ["id"] = "WrappedAction",
                          ["number"] = 7,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "Option",
                              ["params"] = 
                              {
                                ["value"] = true,
                                ["name"] = 6,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [7]
                      }, -- end of ["tasks"]
                    }, -- end of ["params"]
                  }, -- end of ["task"]
                  ["type"] = "Turning Point",
                  ["ETA"] = 0,
                  ["ETA_locked"] = true,
                  ["y"] = BS5_WP0Y,
                  ["x"] = BS5_WP0X,
                  ["formation_template"] = "",
                  ["speed_locked"] = true,
                }, -- end of [1]
                [2] = 
                {
                  ["alt"] = BS5_FlightLevel,
                  ["action"] = "Turning Point",
                  ["alt_type"] = "BARO",
                  ["speed"] = 234.32754852983,
                  ["task"] = 
                  {
                    ["id"] = "ComboTask",
                    ["params"] = 
                    {
                      ["tasks"] = 
                      {
                      }, -- end of ["tasks"]
                    }, -- end of ["params"]
                  }, -- end of ["task"]
                  ["type"] = "Turning Point",
                  ["ETA"] = 127.32626754758,
                  ["ETA_locked"] = false,
                  ["y"] = BS5_WP1Y,
                  ["x"] = BS5_WP1X,
                  ["formation_template"] = "",
                  ["speed_locked"] = true,
                }, -- end of [2]
                [3] = 
                {
                  ["alt"] = BS5_FlightLevel,
                  ["action"] = "Turning Point",
                  ["alt_type"] = "BARO",
                  ["speed"] = 234.32754852983,
                  ["task"] = 
                  {
                    ["id"] = "ComboTask",
                    ["params"] = 
                    {
                      ["tasks"] = 
                      {
                      }, -- end of ["tasks"]
                    }, -- end of ["params"]
                  }, -- end of ["task"]
                  ["type"] = "Turning Point",
                  ["ETA"] = 380.31328316984,
                  ["ETA_locked"] = false,
                  ["y"] = BS5_WP2Y,
                  ["x"] = BS5_WP2X,
                  ["formation_template"] = "",
                  ["speed_locked"] = true,
                }, -- end of [3]
                [4] = 
                {
                  ["alt"] = BS5_FlightLevel,
                  ["action"] = "Turning Point",
                  ["alt_type"] = "BARO",
                  ["speed"] = 234.32754852983,
                  ["task"] = 
                  {
                    ["id"] = "ComboTask",
                    ["params"] = 
                    {
                      ["tasks"] = 
                      {
                      }, -- end of ["tasks"]
                    }, -- end of ["params"]
                  }, -- end of ["task"]
                  ["type"] = "Turning Point",
                  ["ETA"] = 832.92276094724,
                  ["ETA_locked"] = false,
                  ["y"] = BS5_WP3Y,
                  ["x"] = BS5_WP3X,
                  ["formation_template"] = "",
                  ["speed_locked"] = true,
                }, -- end of [4]
                [5] = 
                {
                  ["alt"] = BS5_FlightLevel,
                  ["action"] = "Turning Point",
                  ["alt_type"] = "BARO",
                  ["speed"] = 234.32754852983,
                  ["task"] = 
                  {
                    ["id"] = "ComboTask",
                    ["params"] = 
                    {
                      ["tasks"] = 
                      {
                      }, -- end of ["tasks"]
                    }, -- end of ["params"]
                  }, -- end of ["task"]
                  ["type"] = "Turning Point",
                  ["ETA"] = 1289.20366255,
                  ["ETA_locked"] = false,
                  ["y"] = BS5_WP4Y,
                  ["x"] = BS5_WP4X,
                  ["formation_template"] = "",
                  ["speed_locked"] = true,
                }, -- end of [5]
                [6] = 
                {
                  ["alt"] = BS5_FlightLevel,
                  ["action"] = "Turning Point",
                  ["alt_type"] = "BARO",
                  ["speed"] = 234.32754852983,
                  ["task"] = 
                  {
                    ["id"] = "ComboTask",
                    ["params"] = 
                    {
                      ["tasks"] = 
                      {
                        [1] = 
                        {
                          ["number"] = 1,
                          ["auto"] = false,
                          ["id"] = "WrappedAction",
                          ["enabled"] = true,
                          ["params"] = 
                          {
                            ["action"] = 
                            {
                              ["id"] = "SwitchWaypoint",
                              ["params"] = 
                              {
                                ["goToWaypointIndex"] = 3,
                                ["fromWaypointIndex"] = 6,
                              }, -- end of ["params"]
                            }, -- end of ["action"]
                          }, -- end of ["params"]
                        }, -- end of [1]
                      }, -- end of ["tasks"]
                    }, -- end of ["params"]
                  }, -- end of ["task"]
                  ["type"] = "Turning Point",
                  ["ETA"] = 1744.9128539618,
                  ["ETA_locked"] = false,
                  ["y"] = BS5_WP5Y,
                  ["x"] = BS5_WP5X,
                  ["formation_template"] = "",
                  ["speed_locked"] = true,
                }, -- end of [6]
              }, -- end of ["points"]
            }, -- end of ["route"]
          }, --end of ["params"]
        }--end of Mission       
        BLUESQUADRON5GROUP:SetTask(Mission)        
      end
    )
    if ( DepartureAirbaseName == AIRBASE.PersianGulf.Kish_International_Airport ) then
      --BLUESQUADRON5:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Kish_International_Airport), {4,5,2,3}, SPAWN.Takeoff.Hot)
      BLUESQUADRON5:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )
      
    else
      BLUESQUADRON5:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )
    end   
    --:SpawnInZone( SpawnZone, false, BS5_FlightLevel, BS5_FlightLevel )
    --:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot ) --SPAWN.Takeoff.Hot SPAWN.Takeoff.Cold SPAWN.Takeoff.Runway
    --trigger.action.outText("Blue Squadron 4 Is Launching Fighters", 15)  
  end
end

function SEF_BLUESQUADRON5_INITIALISE()

  --Retrieve The Standard Deployment For The Squadron
  SEF_BLUESQUADRON5_DEPLOYMENT()
  
  SET_AIRFIELDPERIMETERCLIENTS = SET_CLIENT:New():FilterCoalitions("red"):FilterCategories( { "plane", "helicopter" } ):FilterActive():FilterOnce()
  
  XrayPrimaryPerimeterCount = 0     
      
  --Xray
  SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(XrayPrimaryAirbase.." Perimeter Zone"), function ( GroupObject )
    XrayPrimaryPerimeterCount = XrayPrimaryPerimeterCount + 1
    end
  ) 
  
  --////Xray
  if ( XrayPrimaryPerimeterCount > 0 ) then   
    XrayStatus = XrayPrimaryAirbase.." - Xray Squadron\nAirspace Is Being Contested By Iran\n"
    
    --Ras Al Khaimah Intl -> Khasab -> Qeshm Island -> Havadarya -> Lar

    if ( XrayPrimaryAirbase == AIRBASE.PersianGulf.Lar_Airbase ) then
      
      KishPerimeterCount = 0
      SirriPerimeterCount = 0
      LiwaPerimeterCount = 0
          
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Kish_International_Airport.." Perimeter Zone"), function ( GroupObject )
        KishPerimeterCount = KishPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Sirri_Island.." Perimeter Zone"), function ( GroupObject )
        SirriPerimeterCount = SirriPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Liwa_Airbase.." Perimeter Zone"), function ( GroupObject )
        LiwaPerimeterCount = LiwaPerimeterCount + 1   
        end
      )   

      if ( Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 2 and KishPerimeterCount == 0 ) then             
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Kish_International_Airport, XrayDestinationAirbase)  
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 2 and SirriPerimeterCount == 0 ) then      
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Sirri_Island, XrayDestinationAirbase)            
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() == 2 and LiwaPerimeterCount == 0 ) then     
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Liwa_Airbase, XrayDestinationAirbase)     
      else      
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Al_Dhafra_AB, XrayDestinationAirbase)
      end     
    elseif ( XrayPrimaryAirbase == AIRBASE.PersianGulf.Kish_International_Airport ) then
    
      LarPerimeterCount = 0
      SirriPerimeterCount = 0
      LiwaPerimeterCount = 0
          
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Lar_Airbase.." Perimeter Zone"), function ( GroupObject )
        LarPerimeterCount = LarPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Sirri_Island.." Perimeter Zone"), function ( GroupObject )
        SirriPerimeterCount = SirriPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Liwa_Airbase.." Perimeter Zone"), function ( GroupObject )
        LiwaPerimeterCount = LiwaPerimeterCount + 1   
        end
      )   

      if ( Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() == 2 and LarPerimeterCount == 0 ) then      
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, XrayDestinationAirbase)
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 2 and SirriPerimeterCount == 0 ) then      
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Sirri_Island, XrayDestinationAirbase)
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() == 2 and LiwaPerimeterCount == 0 ) then     
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Liwa_Airbase, XrayDestinationAirbase)
      else      
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Al_Dhafra_AB, XrayDestinationAirbase)
      end   
    elseif ( XrayPrimaryAirbase == AIRBASE.PersianGulf.Sirri_Island ) then
    
      LarPerimeterCount = 0
      KishPerimeterCount = 0
      LiwaPerimeterCount = 0
          
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Lar_Airbase.." Perimeter Zone"), function ( GroupObject )
        LarPerimeterCount = LarPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Kish_International_Airport.." Perimeter Zone"), function ( GroupObject )
        KishPerimeterCount = KishPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Liwa_Airbase.." Perimeter Zone"), function ( GroupObject )
        LiwaPerimeterCount = LiwaPerimeterCount + 1   
        end
      )   

      if ( Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() == 2 and LarPerimeterCount == 0 ) then      
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, XrayDestinationAirbase)      
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 2 and KishPerimeterCount == 0 ) then     
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Kish_International_Airport, XrayDestinationAirbase)    
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() == 2 and LiwaPerimeterCount == 0 ) then     
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Liwa_Airbase, XrayDestinationAirbase)     
      else      
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Al_Dhafra_AB, XrayDestinationAirbase)       
      end   
    elseif ( XrayPrimaryAirbase == AIRBASE.PersianGulf.Liwa_Airbase ) then
      
      LarPerimeterCount = 0
      KishPerimeterCount = 0
      SirriPerimeterCount = 0
            
          
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Lar_Airbase.." Perimeter Zone"), function ( GroupObject )
        LarPerimeterCount = LarPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Kish_International_Airport.." Perimeter Zone"), function ( GroupObject )
        KishPerimeterCount = KishPerimeterCount + 1   
        end
      )
      SET_AIRFIELDPERIMETERCLIENTS:ForEachClientInZone(ZONE:FindByName(AIRBASE.PersianGulf.Sirri_Island.." Perimeter Zone"), function ( GroupObject )
        SirriPerimeterCount = SirriPerimeterCount + 1   
        end
      )   

      if ( Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() == 2 and LarPerimeterCount == 0 ) then      
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Lar_Airbase, XrayDestinationAirbase)        
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 2 and KishPerimeterCount == 0 ) then     
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Kish_International_Airport, XrayDestinationAirbase)            
      elseif ( Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 2 and SirriPerimeterCount == 0 ) then      
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Sirri_Island, XrayDestinationAirbase)      
      else      
        SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Al_Dhafra_AB, XrayDestinationAirbase)       
      end   
    elseif ( XrayPrimaryAirbase == AAIRBASE.PersianGulf.Al_Dhafra_AB ) then
      SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Al_Dhafra_AB, XrayDestinationAirbase) 
    else      
      SEF_BLUESQUADRON5_SPAWN(AIRBASE.PersianGulf.Al_Dhafra_AB, XrayDestinationAirbase)
    end   
  else
    XrayStatus = XrayPrimaryAirbase.." - Xray Squadron\nAirspace Is Controlled By Iran\n"
    SEF_BLUESQUADRON5_SPAWN(XrayPrimaryAirbase, XrayDestinationAirbase)  
  end 
end

function SEF_BLUESQUADRON5_DEPLOYMENT()
  
  --Xray
  if ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() == 2 ) then
    --Set Xray To Ras Al Khaimah Intl
    XrayPrimaryAirbase = AIRBASE.PersianGulf.Kish_International_Airport
    XrayDestinationAirbase = AIRBASE.PersianGulf.Lar_Airbase 
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() ~= 2 ) then
    --Set Xray To Khasab And Patrol Ras Al Khaimah Intl
    XrayPrimaryAirbase = AIRBASE.PersianGulf.Kish_International_Airport 
    XrayDestinationAirbase = AIRBASE.PersianGulf.Kish_International_Airport 
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() == 2 ) then
    --Set Xray To Ras Al Khaimah Intl And Patrol Ras Al Khaimah Intl And Leave Khasab For Delta To Patrol
    XrayPrimaryAirbase = AIRBASE.PersianGulf.Sirri_Island
    XrayDestinationAirbase = AIRBASE.PersianGulf.Kish_International_Airport
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() ~= 2 ) then
    --Set Xray To Qeshm And Patrol Khasab, Delta Will Be Doing The Same Here
    XrayPrimaryAirbase = AIRBASE.PersianGulf.Sirri_Island
    XrayDestinationAirbase = AIRBASE.PersianGulf.Sirri_Island
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() == 2 ) then
    --Set Xray To Ras Al Khaimah Intl, Patrol Ras Al Khaimah Intl And Leave Qeshm For Delta
    XrayPrimaryAirbase = AIRBASE.PersianGulf.Liwa_Airbase
    XrayDestinationAirbase = AIRBASE.PersianGulf.Sirri_Island
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() ~= 2 ) then
    --Set Xray To Khasab, Patrol Ras Al Khaimah Intl And Leave Qeshm For Delta
    XrayPrimaryAirbase = AIRBASE.PersianGulf.Liwa_Airbase
    XrayDestinationAirbase = AIRBASE.PersianGulf.Sirri_Island
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() == 2 ) then
    --Set Xray To Ras Al Khaimah Intl, Patrol Ras Al Khaimah Intl And Leave Qeshm And Khasab For Delta
    XrayPrimaryAirbase = AIRBASE.PersianGulf.Liwa_Airbase
    XrayDestinationAirbase = AIRBASE.PersianGulf.Sirri_Island
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() ~= 2 ) then
    --Set Xray To Havadarya, Patrol Qeshm
    XrayPrimaryAirbase = AIRBASE.PersianGulf.Liwa_Airbase
    XrayDestinationAirbase = AIRBASE.PersianGulf.Liwa_Airbase
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() == 2 ) then
    --Set Xray To Qeshm, Patrol Havadarya
    XrayPrimaryAirbase = AIRBASE.PersianGulf.Sirri_Island
    XrayDestinationAirbase = AIRBASE.PersianGulf.Liwa_Airbase
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() ~= 2 ) then
    --Set Xray To Qeshm, Patrol Havadarya
    XrayPrimaryAirbase = AIRBASE.PersianGulf.Sirri_Island
    XrayDestinationAirbase = AIRBASE.PersianGulf.Liwa_Airbase
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() == 2 ) then
    --Set Xray To Qeshm, Patrol Havadarya
    XrayPrimaryAirbase = AIRBASE.PersianGulf.Sirri_Island
    XrayDestinationAirbase = AIRBASE.PersianGulf.Liwa_Airbase
  elseif ( Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() == 2 and Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() ~= 2 and Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() ~= 2 ) then
    --Set Xray To Qeshm, Patrol Havadarya
    XrayPrimaryAirbase = AIRBASE.PersianGulf.Sirri_Island
    XrayDestinationAirbase = AIRBASE.PersianGulf.Liwa_Airbase
  else
    --Set Xray To Lar As We've Lost Both Havadarya And Qeshm, We're On The Defensive
    XrayPrimaryAirbase = AIRBASE.PersianGulf.Al_Dhafra_AB
    XrayDestinationAirbase = AIRBASE.PersianGulf.Liwa_Airbase
  end
end




function SEF_ClearAIFightersFromCarrierDeck()
	if ( GROUP:FindByName(BLUESQUADRON1GROUPNAME) ~= nil and GROUP:FindByName(BLUESQUADRON1GROUPNAME):IsAlive() ) then
		Group.getByName(BLUESQUADRON1GROUPNAME):destroy()
		trigger.action.outText("USN Fighter Squadron Has Been Cleared", 15)
	else
		trigger.action.outText("USN Fighter Squadron Is Not Currently Deployed", 15)
	end	
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------					
--////MAIN

--ParkingData = AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl)
--ParkingData = AIRBASE:FindByName(AIRBASE.PersianGulf.Khasab)
--ParkingData = AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB)
--ParkingData = AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Dhafra_AB)
--ParkingData:MarkParkingSpots()

--:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl), {23,24,25,26}, SPAWN.Takeoff.Hot)

--////RED CAP INITIALISE
timer.scheduleFunction(SEF_REDSQUADRON1_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerInitialMin, RedRespawnTimerInitialMax))
timer.scheduleFunction(SEF_REDSQUADRON2_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerInitialMin, RedRespawnTimerInitialMax))
timer.scheduleFunction(SEF_REDSQUADRON3_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerInitialMin, RedRespawnTimerInitialMax))
timer.scheduleFunction(SEF_REDSQUADRON4_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerInitialMin, RedRespawnTimerInitialMax))
timer.scheduleFunction(SEF_REDSQUADRON5_SCHEDULER, nil, timer.getTime() + math.random(RedRespawnTimerInitialMin, RedRespawnTimerInitialMax))

--////BLUE CAP INITIALISE
timer.scheduleFunction(SEF_BLUESQUADRON1_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerInitialMin, BlueRespawnTimerInitialMax))
timer.scheduleFunction(SEF_BLUESQUADRON2_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerInitialMin, BlueRespawnTimerInitialMax))
timer.scheduleFunction(SEF_BLUESQUADRON3_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerInitialMin, BlueRespawnTimerInitialMax))
timer.scheduleFunction(SEF_BLUESQUADRON4_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerInitialMin, BlueRespawnTimerInitialMax))
timer.scheduleFunction(SEF_BLUESQUADRON5_SCHEDULER, nil, timer.getTime() + math.random(BlueRespawnTimerInitialMin, BlueRespawnTimerInitialMax))


--------------------------------------------------------------------------------------------------------------------------------------------------------------------
env.info("Airforce Complete", false)