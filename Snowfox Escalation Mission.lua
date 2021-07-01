env.info("Mission Loading", false)

--////VARIABLES

USAEFCAPGROUPNAME = ""
USAEFSEADGROUPNAME = ""
USAEFCASGROUPNAME = ""
USAEFASSGROUPNAME = ""
USAEFPINGROUPNAME = ""
USAEFDRONEGROUPNAME = ""
USAFAWACSGROUPNAME = ""
TEXACOGROUPNAME = ""
SHELLGROUPNAME = ""
ARCOGROUPNAME = ""

--////MISSION LOGIC FUNCTIONS
function SEF_MissionSelector()	
	
	if ( NumberOfCompletedMissions >= TotalScenarios ) then
			
		OperationComplete = true
		trigger.action.outText("Operation Snowfox Escalation - Operation Has Been Successful", 60)
		--WRITE PROGRESS TABLES TO EMPTY AND SAVE WITH NO ARGUMENTS
		SnowfoxMkIIUnitInterment = {}
		SEF_SaveUnitIntermentTableNoArgs()
		SnowfoxMkIIStaticInterment = {}
		SEF_SaveStaticIntermentTableNoArgs()
		SnowfoxMkIIAirbases = {}
		SEF_SaveAirbasesTableNoArgs()
		--VICTORY -- SET FLAG FOR MISSION EDITOR TRIGGER RESTART
		trigger.action.setUserFlag(1337,1)
		--trigger.action.outText("Operation Snowfox Escalation - Server Will Restart In 5 Minutes", 60)
	else
		Randomiser = math.random(1,TotalScenarios)
		if ( trigger.misc.getUserFlag(Randomiser) > 0 ) then
			--SELECTED MISSION [Randomiser] ALREADY DONE, FLAG VALUE >=1, SELECT ANOTHER ONE
			SEF_MissionSelector()
		elseif ( trigger.misc.getUserFlag(Randomiser) == 0 ) then
			--SELECTED MISSION [Randomiser] IS AVAILABLE TO START, SET TO STARTED AND VALIDATE
			trigger.action.setUserFlag(Randomiser,1)
			SEF_RetrieveMissionInformation(Randomiser)
			--trigger.action.outText("Validating Mission Number "..Randomiser.." For Targeting", 15)
			SEF_ValidateMission()										
		else
			trigger.action.outText("Mission Selection Error", 15)
		end
	end		
end

function SEF_RetrieveMissionInformation ( MissionNumber )
	
	--SET GLOBAL VARIABLES TO THE SELECTED MISSION
	ScenarioNumber = MissionNumber
	AGMissionTarget = OperationSnowfox_AG[MissionNumber].TargetName
	AGTargetTypeStatic = OperationSnowfox_AG[MissionNumber].TargetStatic
	AGMissionBriefingText = OperationSnowfox_AG[MissionNumber].TargetBriefing		
end

function SEF_ValidateMission()
	
	--CHECK TARGET TO SEE IF IT IS ALIVE OR NOT
	if ( AGTargetTypeStatic == false and AGMissionTarget ~= nil ) then
		--TARGET IS NOT STATIC					
		if ( GROUP:FindByName(AGMissionTarget):IsAlive() == true ) then
			--GROUP VALID
			if ( CustomSoundsEnabled == 1) then
				trigger.action.outSound('That Is Our Target.ogg')
			else
			end
			trigger.action.outText(AGMissionBriefingText,15)			
		elseif ( GROUP:FindByName(AGMissionTarget):IsAlive() == false or GROUP:FindByName(AGMissionTarget):IsAlive() == nil ) then
			--GROUP NOT VALID
			trigger.action.setUserFlag(ScenarioNumber,4)
			NumberOfCompletedMissions = NumberOfCompletedMissions + 1
			AGMissionTarget = nil
			AGMissionBriefingText = nil
			SEF_MissionSelector()						
		else			
			trigger.action.outText("Mission Validation Error - Unexpected Result In Group Size", 15)						
		end		
	elseif ( AGTargetTypeStatic == true and AGMissionTarget ~= nil ) then		
		--TARGET IS STATIC		
		if ( StaticObject.getByName(AGMissionTarget) ~= nil and StaticObject.getByName(AGMissionTarget):isExist() == true ) then
			--STATIC IS VALID
			if ( CustomSoundsEnabled == 1) then
				trigger.action.outSound('That Is Our Target.ogg')
			else
			end	
			trigger.action.outText(AGMissionBriefingText,15)								
		elseif ( StaticObject.getByName(AGMissionTarget) == nil or StaticObject.getByName(AGMissionTarget):isExist() == false ) then
			--STATIC TARGET NOT VALID, ASSUME TARGET ALREADY DESTROYED			
			trigger.action.setUserFlag(ScenarioNumber,4)
			NumberOfCompletedMissions = NumberOfCompletedMissions + 1	
			AGMissionTarget = nil
			AGMissionBriefingText = nil
			SEF_MissionSelector()
		else
			trigger.action.outText("Mission Validation Error - Unexpected Result In Static Test", 15)	
		end		
	elseif ( OperationComplete == true ) then
		trigger.action.outText("The Operation Is Complete - No Further Targets To Validate For Mission Assignment", 15)
	else		
		trigger.action.outText("Mission Validation Error - Mission Validation Unavailable, No Valid Targets", 15)
	end
end

function SEF_SkipScenario()	
	--CHECK MISSION IS NOT SUDDENLY FLAGGED AS STATE 4 (COMPLETED)
	if ( trigger.misc.getUserFlag(ScenarioNumber) >= 1 and trigger.misc.getUserFlag(ScenarioNumber) <= 3 ) then
		--RESET MISSION TO STATE 0 (NOT STARTED), CLEAR TARGET INFORMATION AND REROLL A NEW MISSION
		trigger.action.setUserFlag(ScenarioNumber,0) 
		AGMissionTarget = nil
		AGMissionBriefingText = nil
		SEF_MissionSelector()
	elseif ( OperationComplete == true ) then
		trigger.action.outText("The Operation Has Been Completed, All Objectives Have Been Met", 15)
	else		
		trigger.action.outText("Unable To Skip As Current Mission Is In A Completion State", 15)
	end
end

function MissionSuccess()
	
	--SET GLOBALS TO NIL
	AGMissionTarget = nil
	AGMissionBriefingText = nil
	
	if ( CustomSoundsEnabled == 1) then
		local RandomMissionSuccessSound = math.random(1,5)
		trigger.action.outSound('AG Kill ' .. RandomMissionSuccessSound .. '.ogg')
	else
	end	
end

function SEF_MissionTargetStatus(TimeLoop, time)

	if (AGTargetTypeStatic == false and AGMissionTarget ~= nil) then
		--TARGET IS NOT STATIC
					
		if (GROUP:FindByName(AGMissionTarget):IsAlive() == true) then
			--GROUP STILL ALIVE
						
			return time + 10			
		elseif (GROUP:FindByName(AGMissionTarget):IsAlive() == false or GROUP:FindByName(AGMissionTarget):IsAlive() == nil) then 
			--GROUP DEAD
			trigger.action.outText("Mission Update - Mission Successful", 15)
			trigger.action.setUserFlag(ScenarioNumber,4)
			NumberOfCompletedMissions = NumberOfCompletedMissions + 1
			MissionSuccess()
			timer.scheduleFunction(SEF_MissionSelector, {}, timer.getTime() + 20)
			
			return time + 30			
		else			
			trigger.action.outText("Mission Target Status - Unexpected Result, Monitor Has Stopped", 15)						
		end		
	elseif (AGTargetTypeStatic == true and AGMissionTarget ~= nil) then
		--TARGET IS STATIC
		if ( StaticObject.getByName(AGMissionTarget) ~= nil and StaticObject.getByName(AGMissionTarget):isExist() == true ) then 
			--STATIC ALIVE
			
			return time + 10				
		else				
			--STATIC DESTROYED
			trigger.action.outText("Mission Update - Mission Successful", 15)
			trigger.action.setUserFlag(ScenarioNumber,4)
			NumberOfCompletedMissions = NumberOfCompletedMissions + 1
			MissionSuccess()
			timer.scheduleFunction(SEF_MissionSelector, {}, timer.getTime() + 20)
			
			return time + 30				
		end		
	else		
		return time + 10
	end	
end

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////MISSION TARGET TABLE

function SEF_InitializeMissionTable()
	
	OperationSnowfox_AG = {}	
	
	--ABU MUSA ISLAND
	OperationSnowfox_AG[1] = {				
		TargetName = "Abu Musa Island - AAA",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets located on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}				
	OperationSnowfox_AG[2] = {
		TargetName = "Abu Musa Island - Artillery",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Artillery assets located on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}	
	OperationSnowfox_AG[3] = {
		TargetName = "Abu Musa Island - West Bunker",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Western Bunker on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}						
	OperationSnowfox_AG[4] = {
		TargetName = "Abu Musa Island - East Bunker",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Eastern Bunker on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}					
	OperationSnowfox_AG[5] = {
		TargetName = "Abu Musa Island - Cargo Ship",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Cargo Ships North-East of Abu Musa Island \nAbu Musa Island Sector - Grid CP27",
	}			
	OperationSnowfox_AG[6] = {
		TargetName = "Abu Musa Island - Communications",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}			
	OperationSnowfox_AG[7] = {						
		TargetName = "Abu Musa Island - Weapons Research",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Missile Research And Development Facility on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}					
	OperationSnowfox_AG[8] = {
		TargetName = "rSAM-Hawk-Abu Musa Island",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Hawk Site On Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}					
	OperationSnowfox_AG[9] = {
		TargetName = "rSAM-SA-15-Abu Musa Island",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-15 on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}					
	OperationSnowfox_AG[10] = {
		TargetName = "Abu Musa Island - Silkworm",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Silkworm Site on Abu Musa Island \nAbu Musa Island Sector - Grid CP06",
	}
	--////BANDAR ABBAS
	OperationSnowfox_AG[11] = {
		TargetName = "Bandar Abbas - Power Plant West",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Western Power Plant Facility at Bandar Abbas\nBandar Abbas Sector - Grid DR20",
	}
	OperationSnowfox_AG[12] = {
		TargetName = "Bandar Abbas - Power Plant East",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Eastern Power Plant Facility at Bandar Abbas\nBandar Abbas Sector - Grid DR31",
	}
	OperationSnowfox_AG[13] = {
		TargetName = "Bandar Abbas - Communications East",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Eastern Communications Tower at Bandar Abbas\nBandar Abbas Sector - Grid DR30",
	}
	OperationSnowfox_AG[14] = {
		TargetName = "Bandar Abbas - Communications West",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Western Communications Tower at Bandar Abbas\nBandar Abbas Sector - Grid DR30",
	}
	OperationSnowfox_AG[15] = {
		TargetName = "rSAM-SA-15-Bandar Abbas",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-15 located at Bandar Abbas \nBandar Abbas Sector - Grid DR30",
	}
	OperationSnowfox_AG[16] = {
		TargetName = "rSAM-Hawk-Bandar Abbas",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Hawk Site at Bandar Abbas \nBandar Abbas Sector - Grid DR31",
	}
	OperationSnowfox_AG[17] = {
		TargetName = "rSAM-SA-10-Bandar Abbas",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-5/SA-10 Site at Bandar Abbas \nBandar Abbas Sector - Grid DR31",
	}
	OperationSnowfox_AG[18] = {
		TargetName = "Bandar Abbas - Military Base",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Military Base Barracks at Bandar Abbas\nBandar Abbas Sector - Grid DR31",	
	}
	OperationSnowfox_AG[19] = {
		TargetName = "Bandar Abbas - Military HQ",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Military HQ at Bandar Abbas \nBandar Abbas Sector - Grid DR30",
	}
	OperationSnowfox_AG[20] = {
		TargetName = "Bandar Abbas - Missile Bunker West",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Western Missile Bunker at the Bandar Abbas Underground Missile Facility\nBandar Abbas Sector - Grid DR22",
	}
	OperationSnowfox_AG[21] = {
		TargetName = "Bandar Abbas - Missile Bunker East",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Eastern Missile Bunker at the Bandar Abbas Underground Missile Facility\nBandar Abbas Sector - Grid DR22",
	}
	OperationSnowfox_AG[22] = {
		TargetName = "Bandar Abbas - Missile Barracks",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Missile Barracks at the Bandar Abbas Missile Facility\nBandar Abbas Sector - Grid DR32",
	}
	OperationSnowfox_AG[23] = {
		TargetName = "Bandar Abbas - Missile Storage",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Missile Storage Hangar at the Bandar Abbas Missile Facility\nBandar Abbas Sector - Grid DR32",
	}
	OperationSnowfox_AG[24] = {
		TargetName = "Bandar Abbas - Scud Launcher",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Scud Launchers at the Bandar Abbas Missile Facility\nBandar Abbas Sector - Grid DR32",
	}
	OperationSnowfox_AG[25] = {
		TargetName = "Bandar Abbas - Supply Truck",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Supply Trucks at the Military Base Barracks at Bandar Abbas\nBandar Abbas Sector - Grid DR31",
	}
	--////BANDAR LENGEH
	OperationSnowfox_AG[26] = {
		TargetName = "Bandar Lengeh - Communications West",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Western Communications Tower located West of Bandar Lengeh \nBandar Lengeh Sector - Grid BQ63",
	}
	OperationSnowfox_AG[27] = {
		TargetName = "Bandar Lengeh - Communications East",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Eastern Communications Tower located West of Bandar Lengeh \nBandar Lengeh Sector - Grid BQ63",
	}
	OperationSnowfox_AG[28] = {
		TargetName = "Bandar Lengeh - Navy",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Naval Vessels patrolling South of Bandar Lengeh \nBandar Lengeh Sector - No Fixed Grid Position Available",
	}
	OperationSnowfox_AG[29] = {
		TargetName = "Bandar Lengeh - Power Plant West",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Power Plant Facility North-West of Kang \nBandar Lengeh Sector - Grid BQ94",
	}
	OperationSnowfox_AG[30] = {
		TargetName = "Bandar Lengeh - Power Plant East",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Power Plant Facility At Bandar Khamir \nBandar Lengeh Sector - Grid CQ68",
	}
	OperationSnowfox_AG[31] = {
		TargetName = "rSAM-SA-11-Bandar Lengeh",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-11 SAM site at Bandar Lengeh airfield \nBandar Lengeh Sector - Grid BQ83",
	}
	OperationSnowfox_AG[32] = {
		TargetName = "rSAM-SA-15-Bandar Lengeh",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-15 at Bandar Lengeh airfield \nBandar Lengeh Sector - Grid BQ83",
	}
	OperationSnowfox_AG[33] = {
		TargetName = "Bandar Lengeh - Cargo Ship",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Cargo Ships docked at Bandar Lengeh \nBandar Lengeh Sector - Grid BQ83",
	}
	OperationSnowfox_AG[34] = {
		TargetName = "Bandar Lengeh - Boat Bunker",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Boat Bunker at Bandar Lengeh \nBandar Lengeh Sector - Grid BQ83",
	}
	OperationSnowfox_AG[35] = {
		TargetName = "Bandar Lengeh - Armor",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Armored Column located at Bandar Lengeh \nBandar Lengeh Sector - Grid BQ94",
	}
	OperationSnowfox_AG[36] = {
		TargetName = "Bandar Lengeh - Scud Launcher",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Scud Launchers located at Bandar Lengeh \nBandar Lengeh Sector - Grid BQ94",
	}			
	--////FUJAIRAH
	OperationSnowfox_AG[37] = {
		TargetName = "rSAM-SA-15-Fujairah",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-15 located at Fujairah \nFujairah Sector - Grid DN37",
	}
	OperationSnowfox_AG[38] = {
		TargetName = "rSAM-SA-6-Fujairah",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-6 site located at Fujairah \nFujairah Sector - Grid DN37",
	}
	OperationSnowfox_AG[39] = {
		TargetName = "Fujairah - AAA",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA Assets located at Fujairah \nFujairah Sector - Grid DN37",
	}
	OperationSnowfox_AG[40] = {
		TargetName = "Fujairah - Armor",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Armored Column located at Fujairah \nFujairah Sector - Grid DN37",
	}		
	--////HAVADARYA	
	OperationSnowfox_AG[41] = {
		TargetName = "Havadarya - AAA",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets protecting the Havadarya Naval Base \nHavadarya Sector - Grid DR20",	
	}
	OperationSnowfox_AG[42] = {
		TargetName = "EWR-Tazeyan-e-Zir",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Early Warning Radar North of Tazeyan-e Zir\nHavadarya Sector - Grid DR13",
	}
	OperationSnowfox_AG[43] = {
		TargetName = "EWR-Havadarya",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Early Warning Radar at Havadarya\nHavadarya Sector - Grid DR20",
	}
	OperationSnowfox_AG[44] = {
		TargetName = "rSAM-SA-2-Havadarya",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the HQ-2/SA-2 site at Havadarya \nHavadarya Sector - Grid DR10",
	}
	OperationSnowfox_AG[45] = {
		TargetName = "Havadarya - Submarine",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Submarines docked at the Havadarya Naval Base \nHavadarya Sector - Grid DR20",
	}
	OperationSnowfox_AG[46] = {
		TargetName = "Havadarya - Navy",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Naval Vessels docked at the Havadarya Naval Base \nHavadarya Sector - Grid DR20",
	}
	OperationSnowfox_AG[47] = {
		TargetName = "Havadarya - Silkworm",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Silkworm Site at the Havadarya Naval Base \nHavadarya Sector - Grid DR20",
	}
	OperationSnowfox_AG[48] = {
		TargetName = "Havadarya - Cargo Ship",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Cargo Ships docked at the Havadarya Port \nHavadarya Sector - Grid DR20",	
	}
	OperationSnowfox_AG[49] = {
		TargetName = "Havadarya - Uranium Mine",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Uranium Mine West of Havadarya \nHavadarya Sector - Grid CQ99",
	}	
	OperationSnowfox_AG[50] = {
		TargetName = "Havadarya - Armor",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Armored Vehicles located at Havadarya \nHavadarya Sector - Grid DR10",
	}		
	--////BANDAR-E-JASK	
	OperationSnowfox_AG[51] = {
		TargetName = "Jask - Communications",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower at Bandar-e-Jask \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[52] = {
		TargetName = "EWR-Jask",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Early Warning Radar at Bandar-e-Jask\nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[53] = {
		TargetName = "rSAM-Hawk-Jask",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Hawk Site at Bandar-e-Jask \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[54] = {
		TargetName = "Jask - Navy",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Naval Vessels docked at Bandar-e-Jask Port \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[55] = {
		TargetName = "rSAM-A-15-Jask",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-15 at Bandar-e-Jask \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[56] = {
		TargetName = "Jask - Cargo Ship",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Cargo Ships docked at Bandar-e-Jask Port \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[57] = {
		TargetName = "Jask - Armor",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Armored Column located at Bandar-e-Jask \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[58] = {
		TargetName = "Jask - Supply Truck",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Supply Trucks at Bandar-e-Jask Port \nBandar-e-Jask Sector - Grid EP73",
	}
	OperationSnowfox_AG[59] = {
		TargetName = "Jask - Scud Launcher",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Scud Launchers located at Bandar-e-Jask \nBandar-e-Jask Sector - Grid EP73",
	}	
	--////KHASAB	
	OperationSnowfox_AG[60] = {
		TargetName = "rSAM-Hawk-Khasab",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Hawk Site located at Khasab \nKhasab Sector - Grid DP29",
	}
	OperationSnowfox_AG[61] = {
		TargetName = "rSAM-SA-15-Khasab",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-15 located at Khasab \nKhasab Sector - Grid DP29",
	}
	OperationSnowfox_AG[62] = {
		TargetName = "Khasab - AAA",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA Assets located at Khasab \nKhasab Sector - Grid DP29",
	}
	OperationSnowfox_AG[63] = {
		TargetName = "Khasab - Armor",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Armored Vehicles located at Khasab \nKhasab Sector - Grid DP29",
	}
	OperationSnowfox_AG[64] = {
		TargetName = "Khasab - Navy",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Naval Vessels patrolling North-West of Khasab \nKhasab Sector - No Fixed Grid Position Available",
	}	
	--////KISH ISLAND
	OperationSnowfox_AG[65] = {
		TargetName = "EWR-Kish Island",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Early Warning Radar on Kish Island\nKish Island Sector - Grid YK93",
	}
	OperationSnowfox_AG[66] = {
		TargetName = "Kish Island - Communications",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower on Kish Island\nKish Island Sector - Grid YK94",
	}	
	--////LARAK ISLAND
	OperationSnowfox_AG[67] = {
		TargetName = "Larak Island - Communications",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower at Larak Island \nLarak Island Sector - Grid DQ37",
	}
	OperationSnowfox_AG[68] = {
		TargetName = "Larak Island - Silkworm",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Silkworm Site at Larak Island \nLarak Island Sector - Grid DQ36",
	}	
	--////LAVAN ISLAND
	OperationSnowfox_AG[69] = {
		TargetName = "rSAM-Hawk-Lavan Island",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Hawk Site at Lavan Island \nLavan Island Sector - Grid YK26",
	}	
	--////MINAB
	OperationSnowfox_AG[70] = {
		TargetName = "Minab - AAA",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets at Minab Dam \nMinab Sector - Grid ER10",
	}
	OperationSnowfox_AG[71] = {
		TargetName = "Minab - CH-47D",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Transport Helicopter at the Minab Drone Base \nMinab Sector - Grid EQ09",
	}
	OperationSnowfox_AG[72] = {
		TargetName = "Minab - Communications",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower South-East of the Minab Drone Base \nMinab Sector - Grid EQ09",	
	}
	OperationSnowfox_AG[73] = {
		TargetName = "Minab - Drone Hangar",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Drone Hangar at the Minab Drone Base \nMinab Sector - Grid EQ09",
	}
	OperationSnowfox_AG[74] = {
		TargetName = "Minab - Drone Control Tower",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Drone Control Tower at the Minab Drone Base \nMinab Sector - Grid EQ09",
	}
	OperationSnowfox_AG[75] = {
		TargetName = "Minab - Igla",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Anti-Air Infantry at Minab Dam \nMinab Sector - Grid ER10",
	}
	OperationSnowfox_AG[76] = {
		TargetName = "Minab - Armor",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the BMP's located at the Minab Dam \nMinab Sector - Grid ER10",
	}	
	--////QESHM ISLAND	
	OperationSnowfox_AG[77] = {
		TargetName = "Qeshm Island - AAA",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets on Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[78] = {
		TargetName = "Qeshm Island - Drone Control Tower",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The Drone Control Tower on Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[79] = {
		TargetName = "Qeshm Island - Drone Hangar",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The Drone Hangar on Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[80] = {
		TargetName = "Qeshm Island - Naval Warehouse",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Warehouse at the Qeshm Island Naval Base \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[81] = {
		TargetName = "Qeshm Island - Power Plant",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Power Plant Facility South of Dargahan\nQeshm Island Sector - Grid DQ08",
	}	
	OperationSnowfox_AG[82] = {
		TargetName = "rSAM-SA-15-Qeshm Island",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The SA-15's on Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[83] = {
		TargetName = "Qeshm Island - Submarine",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Submarines docked at Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[84] = {
		TargetName = "Qeshm Island - Speedboat",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Armed Speedboats docked at Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[85] = {
		TargetName = "Qeshm Island - Silkworm",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The Silkworm Site on Qeshm Island \nQeshm Island Sector - Grid DQ17",
	}
	OperationSnowfox_AG[86] = {
		TargetName = "rSAM-SA-6-Qeshm Island",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The SA-6 Site on Qeshm Island \nQeshm Island Sector - Grid CQ95",
	}
	OperationSnowfox_AG[87] = {
		TargetName = "Qeshm Island - Armor",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The Armored Vehicles on Qeshm Island \nQeshm Island Sector - Grid CQ95-CQ96",
	}		
	--////RAS AL KHAIMAH
	OperationSnowfox_AG[88] = {				
		TargetName = "rSAM-SA-6-Ras Al Khaimah",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The SA-6 Site At Ras Al Khaimah\nRas Al Khaimah Sector - Grid CP93",
	}
	OperationSnowfox_AG[89] = {				
		TargetName = "rSAM-SA-15-Ras Al Khaimah",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy The SA-15 At Ras Al Khaimah\nRas Al Khaimah Sector - Grid CP93",
	}
	OperationSnowfox_AG[90] = {				
		TargetName = "Ras Al Khaimah - AAA",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA Assets located at Ras Al Khaimah\nRas Al Khaimah Sector - Grid CP93",
	}
	OperationSnowfox_AG[91] = {				
		TargetName = "Ras Al Khaimah - Armor",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Armored Column located at Ras Al Khaimah\nRas Al Khaimah Sector - Grid CP93",
	}	
	--////SEERIK-GEROUK
	OperationSnowfox_AG[92] = {
		TargetName = "Seerik - Communications",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower located South-East of Seerik \nSeerik Sector - Grid EQ12",
	}
	OperationSnowfox_AG[93] = {
		TargetName = "rSAM-SA-10-Seerik",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-10 Site North of Seerik \nSeerik Sector - Grid EQ05",
	}
	OperationSnowfox_AG[94] = {
		TargetName = "Seerik - Navy",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Naval Vessels located North-West of Seerik\nSeerik Sector - Grid DQ94",
	}
	OperationSnowfox_AG[95] = {
		TargetName = "rSAM-SA-15-Seerik",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-15 located North of Seerik \nSeerik Sector - Grid EQ05",
	}
	OperationSnowfox_AG[96] = {
		TargetName = "Seerik - Armor",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Armored Column located at Seerik \nSeerik Sector - Grid EQ13",	
	}		
	--////SIR ABU NUAYR
	OperationSnowfox_AG[97] = {
		TargetName = "Sir Abu Nuayr - Communications",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower located on Sir Abu Nuayr Island \nSir Abu Nuayr Sector - Grid BN29",
	}
	OperationSnowfox_AG[98] = {
		TargetName = "rSAM-SA-15-Sir Abu Nuayr",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-15 on Sir Abu Nuayr Island \nSir Abu Nuayr Sector - Grid BN29",
	}
	OperationSnowfox_AG[99] = {
		TargetName = "rSAM-SA-6-Sir Abu Nuayr",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-6 Site located on Sir Abu Nuayr Island \nSir Abu Nuayr Sector - Grid BN29",
	}
	OperationSnowfox_AG[100] = {
		TargetName = "Sir Abu Nuayr - Speedboat",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Armed Speedboats located at Sir Abu Nuayr Island \nSir Abu Nuayr Sector - Grid BN29",
	}
	OperationSnowfox_AG[101] = {
		TargetName = "Sir Abu Nuayr - AAA",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA Assets located at Sir Abu Nuayr Island \nSir Abu Nuayr Sector - Grid BN29",
	}		
	--////SIRRI ISLAND
	OperationSnowfox_AG[102] = {
		TargetName = "Sirri Island - AAA",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets on Sirri Island \nSirri Island Sector - Grid BP56",
	}
	OperationSnowfox_AG[103] = {
		TargetName = "Sirri Island - Communications",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower on Sirri Island \nSirri Island Sector - Grid BP56",
	}
	OperationSnowfox_AG[104] = {
		TargetName = "Sirri Island - Navy",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Naval Vessels patrolling Sirri Island and Abu Musa Island \nSirri Island Sector - No Fixed Grid Position Available",
	}
	OperationSnowfox_AG[105] = {
		TargetName = "Sirri Island - Oil Processing",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Oil Processing Facility on Sirri Island \nSirri Island Sector - Grid BP56",
	}
	OperationSnowfox_AG[106] = {
		TargetName = "Sirri Island - Oil Refinery",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Oil Refinery Facility on Sirri Island \nSirri Island Sector - Grid BP56",
	}
	OperationSnowfox_AG[107] = {
		TargetName = "Sirri Island - Cargo Ship",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy Cargo Ships docked at Sirri Island \nSirri Island Sector - Grid BP56",
	}
	OperationSnowfox_AG[108] = {
		TargetName = "rSAM-SA-8-Sirri Island",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-8 on Sirri Island \nSirri Island Sector - Grid BP56",
	}		
	--////TUNB ISLAND
	OperationSnowfox_AG[109] = {
		TargetName = "Tunb Island - AAA",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy AAA assets on Tunb Island \nTunb Islands Sector - Grid CQ30",
	}
	OperationSnowfox_AG[110] = {
		TargetName = "Tunb Island - Communications",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower On Tunb Island \nTunb Islands Sector - Grid CQ30",
	}
	OperationSnowfox_AG[111] = {
		TargetName = "rSAM-SA-8-Tunb Island",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-8 on Tunb Island \nTunb Islands Sector - Grid CQ30",
	}
	OperationSnowfox_AG[112] = {
		TargetName = "Tunb Island - Speedboat",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Armed Speedboats docked at Tunb Island \nTunb Islands Sector - Grid CQ30",
	}			
	--////TUNB KOCHAK
	OperationSnowfox_AG[113] = {
		TargetName = "Tunb Kochak - AAA",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the AAA assets on Tunb Kochak Island \nTunb Kochak Sector - Grid CQ10",
	}
	OperationSnowfox_AG[114] = {
		TargetName = "Tunb Kochak - Artillery",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Artillery Assets on Tunb Kochak Island \nTunb Kochak Sector - Grid CQ10",
	}
	OperationSnowfox_AG[115] = {
		TargetName = "Tunb Kochak - Communications",
		TargetStatic = true,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Communications Tower on Tunb Kochak Island \nTunb Kochak Sector - Grid CQ10",
	}
	OperationSnowfox_AG[116] = {
		TargetName = "rSAM-SA-8-Tunb Kochak",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the SA-8 on Tunb Kochak Island \nTunb Kochak Sector - Grid CQ10",
	}
	--////OTHERS
	OperationSnowfox_AG[117] = {
		TargetName = "Dibba Al Hisn - Navy",
		TargetStatic = false,
		TargetBriefing = "Mission Update \nPrimary Objective - Destroy the Warships located North-East of Dibba Al Hisn \nRas Al Khaimah Sector - Grid DP33",
	}	
end

--////End Mission Target Table
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////ON DEMAND MISSION INFORMATION

local function CheckObjectiveRequest()
	
	if ( AGMissionBriefingText ~= nil ) then
		trigger.action.outText(AGMissionBriefingText, 15)
		if ( CustomSoundsEnabled == 1) then
			trigger.action.outSound('That Is Our Target.ogg')
		else
		end	
	elseif ( OperationComplete == true ) then
		trigger.action.outText("The Operation Has Been Completed, There Are No Further Objectives", 15)
	elseif ( AGMissionBriefingText == nil and OperationComplete == false ) then
		trigger.action.outText("Check Objective Request Error - No Briefing Available And Operation Is Not Completed", 15)
	else
		trigger.action.outText("Check Objective Request Error - Unexpected Result Occured", 15)
	end	
end

function TargetReport()
			
	if (AGTargetTypeStatic == false and AGMissionTarget ~=nil) then
		TargetGroup = GROUP:FindByName(AGMissionTarget)	
		
		if (GROUP:FindByName(AGMissionTarget):IsAlive() == true) then
		
			TargetRemainingUnits = Group.getByName(AGMissionTarget):getSize()	
			
			MissionPlayersBlue = SET_CLIENT:New():FilterCoalitions("blue"):FilterActive():FilterOnce()
			
			MissionPlayersBlue:ForEachClient(
				function(Client)
					if Client:IsAlive() == true then
						ClientPlayerName = Client:GetPlayerName()	  
						ClientUnitName = Client:GetName()			  
						ClientGroupName = Client:GetClientGroupName() 			
						ClientGroupID = Client:GetClientGroupID()	   	
				
						PlayerUnit = UNIT:FindByName(ClientUnitName)		
					
						PlayerCoord = PlayerUnit:GetCoordinate()
						TargetCoord = TargetGroup:GetCoordinate()
						TargetHeight = math.floor(TargetGroup:GetCoordinate():GetLandHeight() * 100)/100
						TargetHeightFt = math.floor(TargetHeight * 3.28084)
						PlayerDistance = PlayerCoord:Get2DDistance(TargetCoord)

						TargetVector = PlayerCoord:GetDirectionVec3(TargetCoord)
						TargetBearing = PlayerCoord:GetAngleRadians (TargetVector)	
					
						PlayerBR = PlayerCoord:GetBRText(TargetBearing, PlayerDistance, SETTINGS:SetImperial())
					
						--List the amount of units remaining in the group
						if (TargetRemainingUnits > 1) then
							SZMessage = "There are "..TargetRemainingUnits.." targets remaining for this mission" 
						elseif (TargetRemainingUnits == 1) then
							SZMessage = "There is "..TargetRemainingUnits.." target remaining for this mission" 
						elseif (TargetRemainingUnits == nil) then					
							SZMessage = "Unable To Determine Group Size"
						else			
							SZMessage = "Nothing to report"		
						end		
					
						BRMessage = "Target bearing "..PlayerBR
						ELEMessage = "Elevation "..TargetHeight.."m".." / "..TargetHeightFt.."ft"
					
						_SETTINGS:SetLL_Accuracy(0)
						CoordStringLLDMS = TargetCoord:ToStringLLDMS(SETTINGS:SetImperial())
						_SETTINGS:SetLL_Accuracy(3)
						CoordStringLLDDM = TargetCoord:ToStringLLDDM(SETTINGS:SetImperial())
						_SETTINGS:SetLL_Accuracy(2)
						CoordStringMGRS = TargetCoord:ToStringMGRS(SETTINGS:SetImperial())
						
						trigger.action.outTextForGroup(ClientGroupID, "Target Report For "..ClientPlayerName.."\n".."\n"..AGMissionBriefingText.."\n"..BRMessage.."\n"..SZMessage.."\n"..CoordStringLLDMS.."\n"..CoordStringLLDDM.."\n"..CoordStringMGRS.."\n"..ELEMessage, 30)							
					else						
					end				
				end
			)
		else
			trigger.action.outText("Target Report Unavailable", 15)
		end
		
	elseif (AGTargetTypeStatic == true and AGMissionTarget ~=nil) then
		TargetGroup = STATIC:FindByName(AGMissionTarget, false)
		
		MissionPlayersBlue = SET_CLIENT:New():FilterCoalitions("blue"):FilterActive():FilterOnce()

		MissionPlayersBlue:ForEachClient(
			function(Client)
				if Client:IsAlive() == true then
					ClientPlayerName = Client:GetPlayerName()	
					ClientUnitName = Client:GetName()			
					ClientGroupName = Client:GetClientGroupName()				
					ClientGroupID = Client:GetClientGroupID()
				
					PlayerUnit = UNIT:FindByName(ClientUnitName)		
					
					PlayerCoord = PlayerUnit:GetCoordinate()
					TargetCoord = TargetGroup:GetCoordinate()
					TargetHeight = math.floor(TargetGroup:GetCoordinate():GetLandHeight() * 100)/100
					TargetHeightFt = math.floor(TargetHeight * 3.28084)
					PlayerDistance = PlayerCoord:Get2DDistance(TargetCoord)
					
					TargetVector = PlayerCoord:GetDirectionVec3(TargetCoord)
					TargetBearing = PlayerCoord:GetAngleRadians (TargetVector)	
										
					PlayerBR = PlayerCoord:GetBRText(TargetBearing, PlayerDistance, SETTINGS:SetImperial())

					BRMessage = "Target bearing "..PlayerBR
					ELEMessage = "Elevation "..TargetHeight.."m".." / "..TargetHeightFt.."ft"
					
					_SETTINGS:SetLL_Accuracy(0)
					CoordStringLLDMS = TargetCoord:ToStringLLDMS(SETTINGS:SetImperial())
					_SETTINGS:SetLL_Accuracy(3)
					CoordStringLLDDM = TargetCoord:ToStringLLDDM(SETTINGS:SetImperial())
					_SETTINGS:SetLL_Accuracy(2)
					CoordStringMGRS = TargetCoord:ToStringMGRS(SETTINGS:SetImperial())
					
					trigger.action.outTextForGroup(ClientGroupID, "Target Report For "..ClientPlayerName.."\n".."\n"..AGMissionBriefingText.."\n"..BRMessage.."\n"..CoordStringLLDMS.."\n"..CoordStringLLDDM.."\n"..CoordStringMGRS.."\n"..ELEMessage, 30)							
				else
				end				
			end
		)		
	elseif ( OperationComplete == true ) then
		trigger.action.outText("The Operation Has Been Completed, There Are No Further Targets", 15)	
	else
		trigger.action.outText("No Target Information Available", 15)
	end
end

--////End On Demand Mission Information
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////AI SUPPORT FLIGHT FUNCTIONS

--////COMBAT AIR PATROL FIGHTER SCREEN
function AbortCAPMission()

	if ( GROUP:FindByName(USAEFCAPGROUPNAME) ~= nil and GROUP:FindByName(USAEFCAPGROUPNAME):IsAlive() ) then
		--If Alive, Perform RTB command
		local RTB = {}
		--RTB.fromWaypointIndex = 2
		RTB.goToWaypointIndex = 5
								
		local RTBTask = {id = 'SwitchWaypoint', params = RTB}
		Group.getByName(USAEFCAPGROUPNAME):getController():setOption(0, 3) -- (0, 4) is weapons hold, (0, 3) is return fire
		Group.getByName(USAEFCAPGROUPNAME):getController():setCommand(RTBTask)	
			
		trigger.action.outText("Fighter Screen Is Returning To Base",15)
	else
		trigger.action.outText("Fighter Screen Does Not Have Fighters To Recall",15)
	end	
end
--////CLOSE AIR SUPPORT
function AbortCASMission()

	if ( GROUP:FindByName(USAEFCASGROUPNAME) ~= nil and GROUP:FindByName(USAEFCASGROUPNAME):IsAlive() ) then
		--If Alive, Perform RTB command
		local RTB = {}
		--RTB.fromWaypointIndex = 2
		RTB.goToWaypointIndex = 5
								
		local RTBTask = {id = 'SwitchWaypoint', params = RTB}
		Group.getByName(USAEFCASGROUPNAME):getController():setOption(0, 3) -- (0, 4) is weapons hold, (0, 3) is return fire
		Group.getByName(USAEFCASGROUPNAME):getController():setCommand(RTBTask)	
			
		trigger.action.outText("Close Air Support Is Returning To Base",15)
	else
		trigger.action.outText("Close Air Support Does Not Have Planes To Recall",15)
	end	
end
--////ANTI-SHIPPING
function AbortASSMission()

	if ( GROUP:FindByName(USAEFASSGROUPNAME) ~= nil and GROUP:FindByName(USAEFASSGROUPNAME):IsAlive() ) then
		--If Alive, Perform RTB command
		local RTB = {}
		--RTB.fromWaypointIndex = 2
		RTB.goToWaypointIndex = 5
								
		local RTBTask = {id = 'SwitchWaypoint', params = RTB}
		Group.getByName(USAEFASSGROUPNAME):getController():setOption(0, 3) -- (0, 4) is weapons hold, (0, 3) is return fire
		Group.getByName(USAEFASSGROUPNAME):getController():setCommand(RTBTask)	
			
		trigger.action.outText("Anti-Shipping Support Is Returning To Base",15)
	else
		trigger.action.outText("Anti-Shipping Support Does Not Have Planes To Recall",15)
	end	
end
--////SEAD
function AbortSEADMission()

	if ( GROUP:FindByName(USAEFSEADGROUPNAME) ~= nil and GROUP:FindByName(USAEFSEADGROUPNAME):IsAlive() ) then
		--If Alive, Perform RTB command
		local RTB = {}
		--RTB.fromWaypointIndex = 2
		RTB.goToWaypointIndex = 4
								
		local RTBTask = {id = 'SwitchWaypoint', params = RTB}
		Group.getByName(USAEFSEADGROUPNAME):getController():setOption(0, 3) -- (0, 4) is weapons hold, (0, 3) is return fire
		Group.getByName(USAEFSEADGROUPNAME):getController():setCommand(RTBTask)	
			
		trigger.action.outText("SEAD Support Is Returning To Base",15)
	else
		trigger.action.outText("SEAD Support Does Not Have Planes To Recall",15)
	end	
end

function AbortPINMission()

	if ( GROUP:FindByName(USAEFPINGROUPNAME) ~= nil and GROUP:FindByName(USAEFPINGROUPNAME):IsAlive() ) then
		--If Alive, Perform RTB command
		local RTB = {}
		--RTB.fromWaypointIndex = 2
		RTB.goToWaypointIndex = 5
								
		local RTBTask = {id = 'SwitchWaypoint', params = RTB}
		Group.getByName(USAEFPINGROUPNAME):getController():setOption(0, 3) -- (0, 4) is weapons hold, (0, 3) is return fire
		Group.getByName(USAEFPINGROUPNAME):getController():setCommand(RTBTask)	
			
		trigger.action.outText("Pinpoint Strike Support Is Returning To Base",15)
	else
		trigger.action.outText("Pinpoint Strike Support Does Not Have Planes To Recall",15)
	end	
end

function SEF_PinpointStrikeTargetAcquisition()
	
	--See https://wiki.hoggitworld.com/view/DCS_task_bombing for further details
	--CHECK TARGET IS WITHIN THE SAME GENERAL AREA THE FLIGHT WAS CALLED TO, GET DETAILS IF IT IS AND ABORT IF NOT
	if ( AGMissionTarget ~= nil ) then
		if ( AGTargetTypeStatic == true ) then
			if ( StaticObject.getByName(AGMissionTarget):isExist() == true ) then
				TargetGroupPIN = STATIC:FindByName(AGMissionTarget, false)
				TargetCoordForStrike = TargetGroupPIN:GetCoordinate():GetVec2()
					
				local StrikeGroup = GROUP:FindByName(USAEFPINGROUPNAME):GetCoordinate()
				local StrikeCoord = TargetGroupPIN:GetCoordinate()
				local StrikeDistanceToTarget = StrikeGroup:Get2DDistance(StrikeCoord)
				
				if ( StrikeDistanceToTarget < 75000 ) then				
					local target = {}
					target.point = TargetCoordForStrike
					target.expend = "Two"
					target.weaponType = 14
					target.attackQty = 1
					target.groupAttack = true
					local engage = {id = 'Bombing', params = target}
					Group.getByName(USAEFPINGROUPNAME):getController():pushTask(engage)
					trigger.action.outText("The Pinpoint Strike Flight Reports Target Coordinates Are Locked In", 15)
				else
					trigger.action.outText("Pinpoint Strike Reports Target Is Too Far Away, Aborting Mission", 15)
					AbortPINMission()
				end	
			else
				trigger.action.outText("Pinpoint Strike Mission Unable To Locate Target, Aborting Mission", 15)
				AbortPINMission()
			end
		elseif ( AGTargetTypeStatic == false ) then
			if ( GROUP:FindByName(AGMissionTarget):IsAlive() == true ) then
				TargetGroupPIN = GROUP:FindByName(AGMissionTarget, false)
				TargetCoordForStrike = TargetGroupPIN:GetCoordinate():GetVec2()
					
				local StrikeGroup = GROUP:FindByName(USAEFPINGROUPNAME):GetCoordinate()
				local StrikeCoord = TargetGroupPIN:GetCoordinate()
				local StrikeDistanceToTarget = StrikeGroup:Get2DDistance(StrikeCoord)
				
				if ( StrikeDistanceToTarget < 50000 ) then
					local target = {}
					target.point = TargetCoordForStrike
					target.expend = "Two"
					target.weaponType = 14 -- See https://wiki.hoggitworld.com/view/DCS_enum_weapon_flag for other weapon launch codes
					target.attackQty = 1
					target.groupAttack = true
					local engage = {id = 'Bombing', params = target}
					Group.getByName(USAEFPINGROUPNAME):getController():pushTask(engage)
					trigger.action.outText("The Pinpoint Strike Flight Reports Target Coordinates Are Locked In", 15)
				else
					trigger.action.outText("Pinpoint Strike Reports Target Is Too Far Away, Aborting Mission", 15)
					AbortPINMission()
				end		
			else
				trigger.action.outText("Pinpoint Strike Mission Unable To Locate Target", 15)
				AbortPINMission()
			end
		else
			trigger.action.outText("Pinpoint Strike Mission Unable To Locate Target", 15)
			AbortPINMission()
		end
	else
		trigger.action.outText("The Pinpoint Strike Flight Reports They Have Not Been Given Any Target Information From High Command, Aborting Mission", 15)
		AbortPINMission()		
	end	
end

--////MQ-9 Aerial Drone
function AbortDroneMission()

	if ( GROUP:FindByName(USAEFDRONEGROUPNAME) ~= nil and GROUP:FindByName(USAEFDRONEGROUPNAME):IsAlive() ) then
			
		Group.getByName(USAEFDRONEGROUPNAME):destroy()
			
		trigger.action.outText("MQ-9 Reaper Aerial Drone Self-Destruct Engaged",15)
	else
		trigger.action.outText("MQ-9 Reaper Aerial Drone Is Unable To Be Recalled",15)
	end	
end

function SEF_USAEFCAPSPAWN(DepartureAirbaseName, DestinationAirbaseName)
	
	if ( GROUP:FindByName(USAEFCAPGROUPNAME) ~= nil and GROUP:FindByName(USAEFCAPGROUPNAME):IsAlive() ) then
		trigger.action.outText("Fighter Screen Is Currently Active, Further Support Is Unavailable",15)	
	else
		USAEFCAP_DATA[1].Vec2 = nil
		USAEFCAP_DATA[1].TimeStamp = nil
		USAEFCAP_DATA[2].Vec2 = nil
		USAEFCAP_DATA[2].TimeStamp = nil
		
		local SpawnZone = AIRBASE:FindByName(DepartureAirbaseName):GetZone()
		local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		
		USAEFCAP = SPAWN
			:New("USAEF F-15C")
			:InitLimit( 2, 2 )					
			:OnSpawnGroup(
				function( SpawnGroup )						
					USAEFCAPGROUPNAME = SpawnGroup.GroupName
					USAEFCAPGROUP = GROUP:FindByName(SpawnGroup.GroupName)							
					
					local DepartureZoneVec2 = SpawnZone:GetVec2()
					local TargetZoneVec2 	= DestinationZone:GetVec2()
					local WP0X = DepartureZoneVec2.x
					local WP0Y = DepartureZoneVec2.y
					
					local WP1X = DepartureZoneVec2.x + 1000
					local WP1Y = DepartureZoneVec2.y
					
					--Orbit Start Point (offset Y to 12.5km West of the zone midpoint)
					local WP2X = TargetZoneVec2.x
					local WP2Y = TargetZoneVec2.y - 12500
					
					--Orbit End Point (offset Y to 12.5km East of the zone midpoint)
					local WP3X = TargetZoneVec2.x
					local WP3Y = TargetZoneVec2.y + 12500
					
					local WP4X = DepartureZoneVec2.x
					local WP4Y = DepartureZoneVec2.y				
								
							--////CAP Mission Profile, Engage Targets Along Route Within 50km, With Orbit For 20 Minutes Between WP2 and WP3
							Mission = {
								["id"] = "Mission",
								["params"] = {		
									["route"] = 
									{
										["points"] = 
										{
											[1] = 
											{
												["alt"] = 7000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 222.22222222222,
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
												["ETA"] = 0,
												["ETA_locked"] = true,
												["y"] = WP0Y,
												["x"] = WP0X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [1]
											[2] = 
											{
												["alt"] = 7000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 222.22222222222,
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
																["auto"] = false,
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
																			["groupId"] = 0,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [1]
															[2] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "EngageTargets",
																["number"] = 2,
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
																	["maxDist"] = 50000,
																}, -- end of ["params"]
															}, -- end of [2]
															[3] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "WrappedAction",
																["number"] = 3,
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
																			["value"] = 264241152,
																			["name"] = 10,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [4]
															[5] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "WrappedAction",
																["number"] = 5,
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
																			["variantIndex"] = 1,
																			["name"] = 5,
																			["formationIndex"] = 6,
																			["value"] = 393217,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [6]
														}, -- end of ["tasks"]
													}, -- end of ["params"]
												}, -- end of ["task"]
												["type"] = "Turning Point",
												["ETA"] = 46.425096732112,
												["ETA_locked"] = false,
												["y"] = WP1Y,
												["x"] = WP1X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [2]
											[3] = 
											{
												["alt"] = 7000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 222.22222222222,
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
																["auto"] = false,
																["id"] = "ControlledTask",
																["number"] = 1,
																["params"] = 
																{
																	["task"] = 
																	{
																		["id"] = "Orbit",
																		["params"] = 
																		{
																			["altitude"] = 7000,
																			["pattern"] = "Race-Track",
																			["speed"] = 222.22222222222,
																			["speedEdited"] = true,
																		}, -- end of ["params"]
																	}, -- end of ["task"]
																	["stopCondition"] = 
																	{
																		["duration"] = 1200,
																	}, -- end of ["stopCondition"]
																}, -- end of ["params"]
															}, -- end of [1]
														}, -- end of ["tasks"]
													}, -- end of ["params"]
												}, -- end of ["task"]
												["type"] = "Turning Point",
												["ETA"] = 382.40941284629,
												["ETA_locked"] = false,
												["y"] = WP2Y,
												["x"] = WP2X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [3]
											[4] = 
											{
												["alt"] = 7000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 222.22222222222,
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
												["ETA"] = 467.40499648103,
												["ETA_locked"] = false,
												["y"] = WP3Y,
												["x"] = WP3X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [4]
											[5] = 
											{
												["alt"] = 7000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 222.22222222222,
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
												["ETA"] = 806.47990963086,
												["ETA_locked"] = false,
												["y"] = WP4Y,
												["x"] = WP4X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [5]
										}, -- end of ["points"]
									}, -- end of ["route"]
								}, --end of ["params"]
							}--end of Mission				
					USAEFCAPGROUP:SetTask(Mission)				
				end
			)
		if ( DepartureAirbaseName == AIRBASE.PersianGulf.Al_Minhad_AB ) then			
			USAEFCAP:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB), {25,26}, SPAWN.Takeoff.Hot)
		else
			USAEFCAP:SpawnAtAirbase(AIRBASE:FindByName(DepartureAirbaseName), SPAWN.Takeoff.Hot)
		end		
		--:SpawnInZone( SpawnZone, false, 7000, 7000 )
		--:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot ) --SPAWN.Takeoff.Hot SPAWN.Takeoff.Cold SPAWN.Takeoff.Runway
		trigger.action.outText("Fighter Screen Launched",15)	
	end
end

function SEF_USAEFSEADSPAWN(DepartureAirbaseName, DestinationAirbaseName)
	
	if ( GROUP:FindByName(USAEFSEADGROUPNAME) ~= nil and GROUP:FindByName(USAEFSEADGROUPNAME):IsAlive() ) then
		trigger.action.outText("SEAD Is Currently Active, Further Support Is Unavailable",15)	
	else
		USAEFSEAD_DATA[1].Vec2 = nil
		USAEFSEAD_DATA[1].TimeStamp = nil
		USAEFSEAD_DATA[2].Vec2 = nil
		USAEFSEAD_DATA[2].TimeStamp = nil
		
		local SpawnZone = AIRBASE:FindByName(DepartureAirbaseName):GetZone()
		local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		
		USAEFSEAD = SPAWN
			:New("USAEF F-16C")
			:InitLimit( 2, 2 )		
			:OnSpawnGroup(
				function( SpawnGroup )						
					USAEFSEADGROUPNAME = SpawnGroup.GroupName
					USAEFSEADGROUP = GROUP:FindByName(SpawnGroup.GroupName)							
					
					local DepartureZoneVec2 = SpawnZone:GetVec2()
					local TargetZoneVec2 	= DestinationZone:GetVec2()
					local WP0X = DepartureZoneVec2.x
					local WP0Y = DepartureZoneVec2.y
					
					local WP1X = DepartureZoneVec2.x + 1000
					local WP1Y = DepartureZoneVec2.y 
					
					local WP2X = TargetZoneVec2.x
					local WP2Y = TargetZoneVec2.y
					
					local WP3X = DepartureZoneVec2.x
					local WP3Y = DepartureZoneVec2.y				
								
							--////SEAD Mission Profile, Engage Targets Along Route Within 50km
							Mission = {
								["id"] = "Mission",
								["params"] = {		
									["route"] = 
									{
										["points"] = 
										{
											[1] = 
											{
												["alt"] = 6000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 219.44444444444,
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
												["ETA"] = 0,
												["ETA_locked"] = true,
												["y"] = WP0Y,
												["x"] = WP0X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [1]
											[2] = 
											{
												["alt"] = 6000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 219.44444444444,
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
																["auto"] = false,
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
																			["groupId"] = 0,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [1]
															[2] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "EngageTargets",
																["number"] = 2,
																["params"] = 
																{
																	["targetTypes"] = 
																	{
																		[1] = "Air Defence",
																	}, -- end of ["targetTypes"]
																	["priority"] = 0,
																	["value"] = "Air Defence;",
																	["noTargetTypes"] = 
																	{
																	}, -- end of ["noTargetTypes"]
																	["maxDistEnabled"] = true,
																	["maxDist"] = 50000,
																}, -- end of ["params"]
															}, -- end of [2]
															[3] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "WrappedAction",
																["number"] = 3,
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
																			["value"] = 4161536,
																			["name"] = 10,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [4]
															[5] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "WrappedAction",
																["number"] = 5,
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
																			["variantIndex"] = 1,
																			["name"] = 5,
																			["formationIndex"] = 6,
																			["value"] = 393217,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [6]
														}, -- end of ["tasks"]
													}, -- end of ["params"]
												}, -- end of ["task"]
												["type"] = "Turning Point",
												["ETA"] = 56.032485482896,
												["ETA_locked"] = false,
												["y"] = WP1Y,
												["x"] = WP1X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [2]
											[3] = 
											{
												["alt"] = 6000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 219.44444444444,
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
												["ETA"] = 507.63523208217,
												["ETA_locked"] = false,
												["y"] = WP2Y,
												["x"] = WP2X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [3]
											[4] = 
											{
												["alt"] = 6000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 219.44444444444,
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
												["ETA"] = 957.4992496166,
												["ETA_locked"] = false,
												["y"] = WP3Y,
												["x"] = WP3X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [4]
										}, -- end of ["points"]
									}, -- end of ["route"]
								}, --end of ["params"]
							}--end of Mission				
					USAEFSEADGROUP:SetTask(Mission)				
				end
			)
		if ( DepartureAirbaseName == AIRBASE.PersianGulf.Al_Minhad_AB ) then			
			USAEFSEAD:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB), {2,16}, SPAWN.Takeoff.Hot)
		else
			USAEFSEAD:SpawnAtAirbase(AIRBASE:FindByName(DepartureAirbaseName), SPAWN.Takeoff.Hot)
		end		
		--:SpawnInZone( SpawnZone, false, 6000, 6000 )
		--:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )
		trigger.action.outText("SEAD Mission Launched",15)	
	end	
end

function SEF_USAEFCASSPAWN(DepartureAirbaseName, DestinationAirbaseName)
	
	if ( GROUP:FindByName(USAEFCASGROUPNAME) ~= nil and GROUP:FindByName(USAEFCASGROUPNAME):IsAlive() ) then
		trigger.action.outText("Close Air Support Is Currently Active, Further Support Is Unavailable",15)	
	else		
		USAEFCAS_DATA[1].Vec2 = nil
		USAEFCAS_DATA[1].TimeStamp = nil
		USAEFCAS_DATA[2].Vec2 = nil
		USAEFCAS_DATA[2].TimeStamp = nil
		
		local SpawnZone = AIRBASE:FindByName(DepartureAirbaseName):GetZone()
		local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		
		USAEFCAS = SPAWN
			:New("USAEF A-10C")
			:InitLimit( 2, 2 )		
			:OnSpawnGroup(
				function( SpawnGroup )						
					USAEFCASGROUPNAME = SpawnGroup.GroupName
					USAEFCASGROUP = GROUP:FindByName(SpawnGroup.GroupName)							
					
					local DepartureZoneVec2 = SpawnZone:GetVec2()
					local TargetZoneVec2 	= DestinationZone:GetVec2()
					local WP0X = DepartureZoneVec2.x
					local WP0Y = DepartureZoneVec2.y
					
					local WP1X = DepartureZoneVec2.x + 1000
					local WP1Y = DepartureZoneVec2.y
					
					--Orbit Start Point (offset Y to 12.5km West of the zone midpoint)
					local WP2X = TargetZoneVec2.x
					local WP2Y = TargetZoneVec2.y - 12500
					
					--Orbit End Point (offset Y to 12.5km East of the zone midpoint)
					local WP3X = TargetZoneVec2.x
					local WP3Y = TargetZoneVec2.y + 12500
					
					local WP4X = DepartureZoneVec2.x
					local WP4Y = DepartureZoneVec2.y				
								
							--////SEAD Mission Profile, Engage Targets Along Route Within 50km
							Mission = {
								["id"] = "Mission",
								["params"] = {		
									["route"] = 
									{
										["points"] = 
										{
											[1] = 
											{
												["alt"] = 3500,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["properties"] = 
												{
													["vnav"] = 1,
													["scale"] = 0,
													["vangle"] = 0,
													["angle"] = 0,
													["steer"] = 2,
												}, -- end of ["properties"]
												["speed"] = 155.55555555556,
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
												["ETA"] = 0,
												["ETA_locked"] = true,
												["y"] = WP0Y,
												["x"] = WP0X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [1]
											[2] = 
											{
												["alt"] = 3500,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["properties"] = 
												{
													["vnav"] = 1,
													["scale"] = 0,
													["vangle"] = 0,
													["angle"] = 0,
													["steer"] = 2,
												}, -- end of ["properties"]
												["speed"] = 155.55555555556,
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
																["auto"] = false,
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
																			["groupId"] = 0,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [1]
															[2] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "EngageTargets",
																["number"] = 2,
																["params"] = 
																{
																	["targetTypes"] = 
																	{
																		[1] = "All",
																	}, -- end of ["targetTypes"]
																	["priority"] = 0,
																	["value"] = "All;",
																	["noTargetTypes"] = 
																	{
																	}, -- end of ["noTargetTypes"]
																	["maxDistEnabled"] = true,
																	["maxDist"] = 25000,
																}, -- end of ["params"]
															}, -- end of [2]
															[3] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "WrappedAction",
																["number"] = 3,
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
																			["value"] = true,
																			["name"] = 15,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [4]
															[5] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "WrappedAction",
																["number"] = 5,
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
																			["variantIndex"] = 1,
																			["name"] = 5,
																			["formationIndex"] = 6,
																			["value"] = 393217,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [6]
														}, -- end of ["tasks"]
													}, -- end of ["params"]
												}, -- end of ["task"]
												["type"] = "Turning Point",
												["ETA"] = 50.97769941928,
												["ETA_locked"] = false,
												["y"] = WP1Y,
												["x"] = WP1X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [2]
											[3] = 
											{
												["alt"] = 2000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["properties"] = 
												{
													["vnav"] = 1,
													["scale"] = 0,
													["vangle"] = 0,
													["angle"] = 0,
													["steer"] = 2,
												}, -- end of ["properties"]
												["speed"] = 155.55555555556,
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
																["auto"] = false,
																["id"] = "ControlledTask",
																["number"] = 1,
																["params"] = 
																{
																	["task"] = 
																	{
																		["id"] = "Orbit",
																		["params"] = 
																		{
																			["altitude"] = 3500,
																			["pattern"] = "Race-Track",
																			["speed"] = 155.55555555556,
																			["speedEdited"] = true,
																		}, -- end of ["params"]
																	}, -- end of ["task"]
																	["stopCondition"] = 
																	{
																		["duration"] = 900,
																	}, -- end of ["stopCondition"]
																}, -- end of ["params"]
															}, -- end of [1]
														}, -- end of ["tasks"]
													}, -- end of ["params"]
												}, -- end of ["task"]
												["type"] = "Turning Point",
												["ETA"] = 265.03232675467,
												["ETA_locked"] = false,
												["y"] = WP2Y,
												["x"] = WP2X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [3]
											[4] = 
											{
												["alt"] = 2000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["properties"] = 
												{
													["vnav"] = 1,
													["scale"] = 0,
													["vangle"] = 0,
													["angle"] = 0,
													["steer"] = 2,
												}, -- end of ["properties"]
												["speed"] = 155.55555555556,
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
												["ETA"] = 349.12890903278,
												["ETA_locked"] = false,
												["y"] = WP3Y,
												["x"] = WP3X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [4]
											[5] = 
											{
												["alt"] = 3500,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["properties"] = 
												{
													["vnav"] = 1,
													["scale"] = 0,
													["vangle"] = 0,
													["angle"] = 0,
													["steer"] = 2,
												}, -- end of ["properties"]
												["speed"] = 155.55555555556,
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
												["ETA"] = 564.44241411897,
												["ETA_locked"] = false,
												["y"] = WP4Y,
												["x"] = WP4X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [5]
										}, -- end of ["points"]
									}, -- end of ["route"]
								}, --end of ["params"]
							}--end of Mission				
					USAEFCASGROUP:SetTask(Mission)				
				end
			)
		if ( DepartureAirbaseName == AIRBASE.PersianGulf.Al_Minhad_AB ) then			
			USAEFCAS:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB), {37,38}, SPAWN.Takeoff.Hot)
		else
			USAEFCAS:SpawnAtAirbase(AIRBASE:FindByName(DepartureAirbaseName), SPAWN.Takeoff.Hot)
		end		
		--:SpawnInZone( SpawnZone, false, 3500, 3500 )
		--:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )
		trigger.action.outText("Close Air Support Mission Launched",15)	
	end
end

function SEF_USAEFASSSPAWN(DepartureAirbaseName, DestinationAirbaseName)
	
	if ( GROUP:FindByName(USAEFASSGROUPNAME) ~= nil and GROUP:FindByName(USAEFASSGROUPNAME):IsAlive() ) then
		trigger.action.outText("Anti-Shipping Support Is Currently Active, Further Support Is Unavailable",15)	
	else
		USAEFASS_DATA[1].Vec2 = nil
		USAEFASS_DATA[1].TimeStamp = nil
		USAEFASS_DATA[2].Vec2 = nil
		USAEFASS_DATA[2].TimeStamp = nil
		
		local SpawnZone = AIRBASE:FindByName(DepartureAirbaseName):GetZone()
		local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		
		USAEFASS = SPAWN
			:New("USAEF F/A-18C")
			:InitLimit( 2, 2 )					
			:OnSpawnGroup(
				function( SpawnGroup )						
					USAEFASSGROUPNAME = SpawnGroup.GroupName
					USAEFASSGROUP = GROUP:FindByName(SpawnGroup.GroupName)							
					
					local DepartureZoneVec2 = SpawnZone:GetVec2()
					local TargetZoneVec2 	= DestinationZone:GetVec2()
					--Spawn Point
					local WP0X = DepartureZoneVec2.x
					local WP0Y = DepartureZoneVec2.y
					--Initialisation Point
					local WP1X = DepartureZoneVec2.x + 1000
					local WP1Y = DepartureZoneVec2.y 
					--Ingress Point
					local WP2X = TargetZoneVec2.x - 50000
					local WP2Y = TargetZoneVec2.y
					--Target Zone Flyover Point
					local WP3X = TargetZoneVec2.x
					local WP3Y = TargetZoneVec2.y
					--Return Point
					local WP4X = DepartureZoneVec2.x
 					local WP4Y = DepartureZoneVec2.y
								
							--////Anti-Ship Mission Profile, Standard Anti-Ship Behaviour At Ingress Point
							Mission = {
								["id"] = "Mission",
								["params"] = {		
									["route"] = {
										["points"] = {
											[1] = 
											{
												["alt"] = 3000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 231.59317779244,
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
												["ETA"] = 0,
												["ETA_locked"] = true,
												["y"] = WP0Y,
												["x"] = WP0X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [1]
											[2] = 
											{
												["alt"] = 3000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 231.59317779244,
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
																		["id"] = "EPLRS",
																		["params"] = 
																		{
																			["value"] = true,
																			["groupId"] = 0,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [1]
															[2] = 
															{
																["number"] = 2,
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
																			["value"] = 2,
																			["name"] = 1,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [2]
															[3] = 
															{
																["number"] = 3,
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
																			["value"] = true,
																			["name"] = 15,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [3]
															[4] = 
															{
																["number"] = 4,
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
																			["value"] = 65536,
																			["name"] = 10,
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
																			["value"] = true,
																			["name"] = 19,
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
																			["variantIndex"] = 1,
																			["name"] = 5,
																			["formationIndex"] = 6,
																			["value"] = 393217,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [6]
														}, -- end of ["tasks"]
													}, -- end of ["params"]
												}, -- end of ["task"]
												["type"] = "Turning Point",
												["ETA"] = 7.8583458925594,
												["ETA_locked"] = false,
												["y"] = WP1Y,
												["x"] = WP1X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [2]
											[3] = 
											{
												["alt"] = 3000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 231.59317779244,
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
																["key"] = "AntiShip",
																["id"] = "EngageTargets",
																["auto"] = false,
																["enabled"] = true,
																["params"] = 
																{
																	["targetTypes"] = 
																	{
																		[1] = "Ships",
																	}, -- end of ["targetTypes"]
																	["priority"] = 0,
																}, -- end of ["params"]
															}, -- end of [1]
														}, -- end of ["tasks"]
													}, -- end of ["params"]
												}, -- end of ["task"]
												["type"] = "Turning Point",
												["ETA"] = 32.788983863136,
												["ETA_locked"] = false,
												["y"] = WP2Y,
												["x"] = WP2X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [3]
											[4] = 
											{
												["alt"] = 3000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 231.59317779244,
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
												["ETA"] = 70.734853282445,
												["ETA_locked"] = false,
												["y"] = WP3Y,
												["x"] = WP3X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [4]
											[5] = 
											{
												["alt"] = 3000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 231.59317779244,
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
												["ETA"] = 136.09696113708,
												["ETA_locked"] = false,
												["y"] = WP4Y,
												["x"] = WP4X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [5]
										}, -- end of ["points"]
									}, -- end of ["route"]
								}, --end of ["params"]
							}--end of Mission				
					USAEFASSGROUP:SetTask(Mission)				
				end
			)
		if ( DepartureAirbaseName == AIRBASE.PersianGulf.Al_Minhad_AB ) then			
			USAEFASS:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB), {53,54}, SPAWN.Takeoff.Hot)
		else
			USAEFASS:SpawnAtAirbase(AIRBASE:FindByName(DepartureAirbaseName), SPAWN.Takeoff.Hot)
		end		
		--:SpawnInZone( SpawnZone, false, 3000, 3000 )
		--:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )
		trigger.action.outText("Anti-Shipping Mission Launched",15)	
	end
end

function SEF_USAEFPINSPAWN(DepartureAirbaseName, DestinationAirbaseName)
	
	if ( GROUP:FindByName(USAEFPINGROUPNAME) ~= nil and GROUP:FindByName(USAEFPINGROUPNAME):IsAlive() ) then
		trigger.action.outText("Pinpoint Strike Support Is Currently Active, Further Support Is Unavailable",15)	
	else
		USAEFPIN_DATA[1].Vec2 = nil
		USAEFPIN_DATA[1].TimeStamp = nil
		USAEFPIN_DATA[2].Vec2 = nil
		USAEFPIN_DATA[2].TimeStamp = nil
		
		local SpawnZone = AIRBASE:FindByName(DepartureAirbaseName):GetZone()
		local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		
		local TypeSelection = math.random(1,4)
		
		if ( TypeSelection == 1 ) then		
			USAEFPIN = SPAWN
				:New("USAEF F-15E")			
				:InitLimit( 2, 2 )				
				:OnSpawnGroup(
					function( SpawnGroup )						
						USAEFPINGROUPNAME = SpawnGroup.GroupName
						USAEFPINGROUP = GROUP:FindByName(SpawnGroup.GroupName)							
						
						local DepartureZoneVec2 = SpawnZone:GetVec2()
						local TargetZoneVec2 	= DestinationZone:GetVec2()
						
						--Spawn Point
						local WP0X = DepartureZoneVec2.x
						local WP0Y = DepartureZoneVec2.y
						--WP1
						local WP1X = DepartureZoneVec2.x + 1000
						local WP1Y = DepartureZoneVec2.y 
						--Target Acquisition Point --Offset from Target Vector By 25km
						local WP2X = TargetZoneVec2.x - 25000
						local WP2Y = TargetZoneVec2.y
						--Target Flyover Point
						local WP3X = TargetZoneVec2.x
						local WP3Y = TargetZoneVec2.y
						--Return Point	
						local WP4X = DepartureZoneVec2.x
						local WP4Y = DepartureZoneVec2.y		
									
								--////Anti-Ship Mission Profile, Standard Anti-Ship Behaviour
								Mission = {
									["id"] = "Mission",
									["params"] = {		
										["route"] = {
											["points"] = {
												[1] = {
													["alt"] = 5000,
													["action"] = "Turning Point",
													["alt_type"] = "BARO",
													["speed"] = 242.16987839118,
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
													["ETA"] = 0,
													["ETA_locked"] = true,
													["y"] = WP0Y,
													["x"] = WP0X,
													["formation_template"] = "",
													["speed_locked"] = true,
												}, -- end of [1]
												[2] = 
												{
													["alt"] = 5000,
													["action"] = "Turning Point",
													["alt_type"] = "BARO",
													["speed"] = 242.16987839118,
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
																	["auto"] = false,
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
																				["groupId"] = 0,
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
																				["value"] = 2,
																				["name"] = 1,
																			}, -- end of ["params"]
																		}, -- end of ["action"]
																	}, -- end of ["params"]
																}, -- end of [2]
																[3] = 
																{
																	["enabled"] = true,
																	["auto"] = false,
																	["id"] = "WrappedAction",
																	["number"] = 3,
																	["params"] = 
																	{
																		["action"] = 
																		{
																			["id"] = "Option",
																			["params"] = 
																			{
																				["value"] = true,
																				["name"] = 15,
																			}, -- end of ["params"]
																		}, -- end of ["action"]
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
																				["value"] = 14,
																				["name"] = 10,
																			}, -- end of ["params"]
																		}, -- end of ["action"]
																	}, -- end of ["params"]
																}, -- end of [4]
																[5] = 
																{
																	["enabled"] = true,
																	["auto"] = false,
																	["id"] = "WrappedAction",
																	["number"] = 5,
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
																				["variantIndex"] = 1,
																				["name"] = 5,
																				["formationIndex"] = 6,
																				["value"] = 393217,
																			}, -- end of ["params"]
																		}, -- end of ["action"]
																	}, -- end of ["params"]
																}, -- end of [6]
															}, -- end of ["tasks"]
														}, -- end of ["params"]
													}, -- end of ["task"]
													["type"] = "Turning Point",
													["ETA"] = 5.9436704052568,
													["ETA_locked"] = false,
													["y"] = WP1Y,
													["x"] = WP1X,
													["formation_template"] = "",
													["speed_locked"] = true,
												}, -- end of [2]
												[3] = 
												{
													["alt"] = 5000,
													["action"] = "Turning Point",
													["alt_type"] = "BARO",
													["speed"] = 242.16987839118,
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
																	["auto"] = false,
																	["id"] = "WrappedAction",
																	["number"] = 1,
																	["params"] = 
																	{
																		["action"] = 
																		{
																			["id"] = "Script",
																			["params"] = 
																			{
																				["command"] = "SEF_PinpointStrikeTargetAcquisition()",
																			}, -- end of ["params"]
																		}, -- end of ["action"]
																	}, -- end of ["params"]
																}, -- end of [1]
															}, -- end of ["tasks"]
														}, -- end of ["params"]
													}, -- end of ["task"]
													["type"] = "Turning Point",
													["ETA"] = 29.768321504821,
													["ETA_locked"] = false,
													["y"] = WP2Y,
													["x"] = WP2X,
													["formation_template"] = "",
													["speed_locked"] = true,
												}, -- end of [3]
												[4] = 
												{
													["alt"] = 5000,
													["action"] = "Turning Point",
													["alt_type"] = "BARO",
													["speed"] = 242.16987839118,
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
													["ETA"] = 67.432273852435,
													["ETA_locked"] = false,
													["y"] = WP3Y,
													["x"] = WP3X,
													["formation_template"] = "",
													["speed_locked"] = true,
												}, -- end of [4]
												[5] = 
												{
													["alt"] = 5000,
													["action"] = "Turning Point",
													["alt_type"] = "BARO",
													["speed"] = 242.16987839118,
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
													["ETA"] = 131.71119538513,
													["ETA_locked"] = false,
													["y"] = WP4Y,
													["x"] = WP4X,
													["formation_template"] = "",
													["speed_locked"] = true,
												}, -- end of [5]
											}, -- end of ["points"]
										}, -- end of ["route"]
									}, --end of ["params"]
								}--end of Mission				
						USAEFPINGROUP:SetTask(Mission)				
					end
				)
			if ( DepartureAirbaseName == AIRBASE.PersianGulf.Al_Minhad_AB ) then			
				USAEFPIN:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB), {5,15}, SPAWN.Takeoff.Hot)
			else
				USAEFPIN:SpawnAtAirbase(AIRBASE:FindByName(DepartureAirbaseName), SPAWN.Takeoff.Hot)
			end			
			--:SpawnInZone( SpawnZone, false, 5000, 5000 )
			--:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )
		elseif ( TypeSelection == 2 ) then		
			USAEFPIN = SPAWN
			:New("USAEF F-117A")			
			:InitLimit( 2, 2 )			
			:OnSpawnGroup(
				function( SpawnGroup )						
					USAEFPINGROUPNAME = SpawnGroup.GroupName
					USAEFPINGROUP = GROUP:FindByName(SpawnGroup.GroupName)							
					
					local DepartureZoneVec2 = SpawnZone:GetVec2()
					local TargetZoneVec2 	= DestinationZone:GetVec2()
					
					--Spawn Point
					local WP0X = DepartureZoneVec2.x
					local WP0Y = DepartureZoneVec2.y
					--WP1
					local WP1X = DepartureZoneVec2.x + 1000
					local WP1Y = DepartureZoneVec2.y 
					--Target Acquisition Point --Offset from Target Vector By 25km
					local WP2X = TargetZoneVec2.x - 25000
					local WP2Y = TargetZoneVec2.y
					--Target Flyover Point
					local WP3X = TargetZoneVec2.x
					local WP3Y = TargetZoneVec2.y
					--Return Point	
					local WP4X = DepartureZoneVec2.x
					local WP4Y = DepartureZoneVec2.y		
								
							--////Anti-Ship Mission Profile, Standard Anti-Ship Behaviour
							Mission = {
								["id"] = "Mission",
								["params"] = {		
									["route"] = {
										["points"] = {
											[1] = {
												["alt"] = 5000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 242.16987839118,
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
												["ETA"] = 0,
												["ETA_locked"] = true,
												["y"] = WP0Y,
												["x"] = WP0X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [1]
											[2] = 
											{
												["alt"] = 5000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 242.16987839118,
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
																["auto"] = false,
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
																			["groupId"] = 0,
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
																			["value"] = 2,
																			["name"] = 1,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [2]
															[3] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "WrappedAction",
																["number"] = 3,
																["params"] = 
																{
																	["action"] = 
																	{
																		["id"] = "Option",
																		["params"] = 
																		{
																			["value"] = true,
																			["name"] = 15,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
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
																			["value"] = 14,
																			["name"] = 10,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [4]
															[5] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "WrappedAction",
																["number"] = 5,
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
																			["variantIndex"] = 1,
																			["name"] = 5,
																			["formationIndex"] = 6,
																			["value"] = 393217,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [6]
														}, -- end of ["tasks"]
													}, -- end of ["params"]
												}, -- end of ["task"]
												["type"] = "Turning Point",
												["ETA"] = 5.9436704052568,
												["ETA_locked"] = false,
												["y"] = WP1Y,
												["x"] = WP1X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [2]
											[3] = 
											{
												["alt"] = 5000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 242.16987839118,
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
																["auto"] = false,
																["id"] = "WrappedAction",
																["number"] = 1,
																["params"] = 
																{
																	["action"] = 
																	{
																		["id"] = "Script",
																		["params"] = 
																		{
																			["command"] = "SEF_PinpointStrikeTargetAcquisition()",
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [1]
														}, -- end of ["tasks"]
													}, -- end of ["params"]
												}, -- end of ["task"]
												["type"] = "Turning Point",
												["ETA"] = 29.768321504821,
												["ETA_locked"] = false,
												["y"] = WP2Y,
												["x"] = WP2X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [3]
											[4] = 
											{
												["alt"] = 5000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 242.16987839118,
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
												["ETA"] = 67.432273852435,
												["ETA_locked"] = false,
												["y"] = WP3Y,
												["x"] = WP3X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [4]
											[5] = 
											{
												["alt"] = 5000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 242.16987839118,
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
												["ETA"] = 131.71119538513,
												["ETA_locked"] = false,
												["y"] = WP4Y,
												["x"] = WP4X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [5]
										}, -- end of ["points"]
									}, -- end of ["route"]
								}, --end of ["params"]
							}--end of Mission				
					USAEFPINGROUP:SetTask(Mission)				
				end
			)
			if ( DepartureAirbaseName == AIRBASE.PersianGulf.Al_Minhad_AB ) then			
				USAEFPIN:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB), {5,15}, SPAWN.Takeoff.Hot)
			else
				USAEFPIN:SpawnAtAirbase(AIRBASE:FindByName(DepartureAirbaseName), SPAWN.Takeoff.Hot)
			end			
			--:SpawnInZone( SpawnZone, false, 5000, 5000 )
			--:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )
------------------------------------------------------------------------------------------------------------------		
    elseif ( TypeSelection == 3 ) then    
      USAEFPIN = SPAWN
      :New("USAEF B-2")      
      :InitLimit( 2, 2 )      
      :OnSpawnGroup(
        function( SpawnGroup )            
          USAEFPINGROUPNAME = SpawnGroup.GroupName
          USAEFPINGROUP = GROUP:FindByName(SpawnGroup.GroupName)              
          
          local DepartureZoneVec2 = SpawnZone:GetVec2()
          local TargetZoneVec2  = DestinationZone:GetVec2()
          
          --Spawn Point
          local WP0X = DepartureZoneVec2.x
          local WP0Y = DepartureZoneVec2.y
          --WP1
          local WP1X = DepartureZoneVec2.x + 1000
          local WP1Y = DepartureZoneVec2.y 
          --Target Acquisition Point --Offset from Target Vector By 25km
          local WP2X = TargetZoneVec2.x - 25000
          local WP2Y = TargetZoneVec2.y
          --Target Flyover Point
          local WP3X = TargetZoneVec2.x
          local WP3Y = TargetZoneVec2.y
          --Return Point  
          local WP4X = DepartureZoneVec2.x
          local WP4Y = DepartureZoneVec2.y    
                
              --////Anti-Ship Mission Profile, Standard Anti-Ship Behaviour
              Mission = {
                ["id"] = "Mission",
                ["params"] = {    
                  ["route"] = {
                    ["points"] = {
                      [1] = {
                        ["alt"] = 5000,
                        ["action"] = "Turning Point",
                        ["alt_type"] = "BARO",
                        ["speed"] = 242.16987839118,
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
                        ["ETA"] = 0,
                        ["ETA_locked"] = true,
                        ["y"] = WP0Y,
                        ["x"] = WP0X,
                        ["formation_template"] = "",
                        ["speed_locked"] = true,
                      }, -- end of [1]
                      [2] = 
                      {
                        ["alt"] = 5000,
                        ["action"] = "Turning Point",
                        ["alt_type"] = "BARO",
                        ["speed"] = 242.16987839118,
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
                                ["auto"] = false,
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
                                      ["groupId"] = 0,
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
                                      ["value"] = 2,
                                      ["name"] = 1,
                                    }, -- end of ["params"]
                                  }, -- end of ["action"]
                                }, -- end of ["params"]
                              }, -- end of [2]
                              [3] = 
                              {
                                ["enabled"] = true,
                                ["auto"] = false,
                                ["id"] = "WrappedAction",
                                ["number"] = 3,
                                ["params"] = 
                                {
                                  ["action"] = 
                                  {
                                    ["id"] = "Option",
                                    ["params"] = 
                                    {
                                      ["value"] = true,
                                      ["name"] = 15,
                                    }, -- end of ["params"]
                                  }, -- end of ["action"]
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
                                      ["value"] = 14,
                                      ["name"] = 10,
                                    }, -- end of ["params"]
                                  }, -- end of ["action"]
                                }, -- end of ["params"]
                              }, -- end of [4]
                              [5] = 
                              {
                                ["enabled"] = true,
                                ["auto"] = false,
                                ["id"] = "WrappedAction",
                                ["number"] = 5,
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
                                      ["variantIndex"] = 1,
                                      ["name"] = 5,
                                      ["formationIndex"] = 6,
                                      ["value"] = 393217,
                                    }, -- end of ["params"]
                                  }, -- end of ["action"]
                                }, -- end of ["params"]
                              }, -- end of [6]
                            }, -- end of ["tasks"]
                          }, -- end of ["params"]
                        }, -- end of ["task"]
                        ["type"] = "Turning Point",
                        ["ETA"] = 5.9436704052568,
                        ["ETA_locked"] = false,
                        ["y"] = WP1Y,
                        ["x"] = WP1X,
                        ["formation_template"] = "",
                        ["speed_locked"] = true,
                      }, -- end of [2]
                      [3] = 
                      {
                        ["alt"] = 5000,
                        ["action"] = "Turning Point",
                        ["alt_type"] = "BARO",
                        ["speed"] = 242.16987839118,
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
                                ["auto"] = false,
                                ["id"] = "WrappedAction",
                                ["number"] = 1,
                                ["params"] = 
                                {
                                  ["action"] = 
                                  {
                                    ["id"] = "Script",
                                    ["params"] = 
                                    {
                                      ["command"] = "SEF_PinpointStrikeTargetAcquisition()",
                                    }, -- end of ["params"]
                                  }, -- end of ["action"]
                                }, -- end of ["params"]
                              }, -- end of [1]
                            }, -- end of ["tasks"]
                          }, -- end of ["params"]
                        }, -- end of ["task"]
                        ["type"] = "Turning Point",
                        ["ETA"] = 29.768321504821,
                        ["ETA_locked"] = false,
                        ["y"] = WP2Y,
                        ["x"] = WP2X,
                        ["formation_template"] = "",
                        ["speed_locked"] = true,
                      }, -- end of [3]
                      [4] = 
                      {
                        ["alt"] = 5000,
                        ["action"] = "Turning Point",
                        ["alt_type"] = "BARO",
                        ["speed"] = 242.16987839118,
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
                        ["ETA"] = 67.432273852435,
                        ["ETA_locked"] = false,
                        ["y"] = WP3Y,
                        ["x"] = WP3X,
                        ["formation_template"] = "",
                        ["speed_locked"] = true,
                      }, -- end of [4]
                      [5] = 
                      {
                        ["alt"] = 5000,
                        ["action"] = "Turning Point",
                        ["alt_type"] = "BARO",
                        ["speed"] = 242.16987839118,
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
                        ["ETA"] = 131.71119538513,
                        ["ETA_locked"] = false,
                        ["y"] = WP4Y,
                        ["x"] = WP4X,
                        ["formation_template"] = "",
                        ["speed_locked"] = true,
                      }, -- end of [5]
                    }, -- end of ["points"]
                  }, -- end of ["route"]
                }, --end of ["params"]
              }--end of Mission       
          USAEFPINGROUP:SetTask(Mission)        
        end
      )
      if ( DepartureAirbaseName == AIRBASE.PersianGulf.Al_Minhad_AB ) then      
        USAEFPIN:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB), {5,15}, SPAWN.Takeoff.Hot)
      else
        USAEFPIN:SpawnAtAirbase(AIRBASE:FindByName(DepartureAirbaseName), SPAWN.Takeoff.Hot)
      end     
      --:SpawnInZone( SpawnZone, false, 5000, 5000 )
      --:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )		
------------------------------------------------------------------------------------------------------------------		
		else		
			USAEFPIN = SPAWN
			:New("RAF Tornado GR4")			
			:InitLimit( 2, 2 )			
			:OnSpawnGroup(
				function( SpawnGroup )						
					USAEFPINGROUPNAME = SpawnGroup.GroupName
					USAEFPINGROUP = GROUP:FindByName(SpawnGroup.GroupName)							
					
					local DepartureZoneVec2 = SpawnZone:GetVec2()
					local TargetZoneVec2 	= DestinationZone:GetVec2()
					
					--Spawn Point
					local WP0X = DepartureZoneVec2.x
					local WP0Y = DepartureZoneVec2.y					
					--WP1
					local WP1X = DepartureZoneVec2.x + 1000
					local WP1Y = DepartureZoneVec2.y					
					--Target Acquisition Point --Offset from Target Vector By 25km
					local WP2X = TargetZoneVec2.x - 25000
					local WP2Y = TargetZoneVec2.y					
					--Target Flyover Point
					local WP3X = TargetZoneVec2.x
					local WP3Y = TargetZoneVec2.y
					--Return Point	
					local WP4X = DepartureZoneVec2.x
					local WP4Y = DepartureZoneVec2.y		
								
							--////Anti-Ship Mission Profile, Standard Anti-Ship Behaviour
							Mission = {
								["id"] = "Mission",
								["params"] = {		
									["route"] = {
										["points"] = {
											[1] = {
												["alt"] = 5000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 242.16987839118,
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
												["ETA"] = 0,
												["ETA_locked"] = true,
												["y"] = WP0Y,
												["x"] = WP0X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [1]
											[2] = 
											{
												["alt"] = 5000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 242.16987839118,
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
																["auto"] = false,
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
																			["groupId"] = 0,
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
																			["value"] = 2,
																			["name"] = 1,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [2]
															[3] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "WrappedAction",
																["number"] = 3,
																["params"] = 
																{
																	["action"] = 
																	{
																		["id"] = "Option",
																		["params"] = 
																		{
																			["value"] = true,
																			["name"] = 15,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
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
																			["value"] = 14,
																			["name"] = 10,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [4]
															[5] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "WrappedAction",
																["number"] = 5,
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
																			["variantIndex"] = 1,
																			["name"] = 5,
																			["formationIndex"] = 6,
																			["value"] = 393217,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [6]
														}, -- end of ["tasks"]
													}, -- end of ["params"]
												}, -- end of ["task"]
												["type"] = "Turning Point",
												["ETA"] = 5.9436704052568,
												["ETA_locked"] = false,
												["y"] = WP1Y,
												["x"] = WP1X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [2]
											[3] = 
											{
												["alt"] = 5000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 242.16987839118,
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
																["auto"] = false,
																["id"] = "WrappedAction",
																["number"] = 1,
																["params"] = 
																{
																	["action"] = 
																	{
																		["id"] = "Script",
																		["params"] = 
																		{
																			["command"] = "SEF_PinpointStrikeTargetAcquisition()",
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [1]
														}, -- end of ["tasks"]
													}, -- end of ["params"]
												}, -- end of ["task"]
												["type"] = "Turning Point",
												["ETA"] = 29.768321504821,
												["ETA_locked"] = false,
												["y"] = WP2Y,
												["x"] = WP2X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [3]
											[4] = 
											{
												["alt"] = 5000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 242.16987839118,
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
												["ETA"] = 67.432273852435,
												["ETA_locked"] = false,
												["y"] = WP3Y,
												["x"] = WP3X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [4]
											[5] = 
											{
												["alt"] = 5000,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 242.16987839118,
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
												["ETA"] = 131.71119538513,
												["ETA_locked"] = false,
												["y"] = WP4Y,
												["x"] = WP4X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [5]
										}, -- end of ["points"]
									}, -- end of ["route"]
								}, --end of ["params"]
							}--end of Mission				
					USAEFPINGROUP:SetTask(Mission)				
				end
			)
			if ( DepartureAirbaseName == AIRBASE.PersianGulf.Al_Minhad_AB ) then			
				USAEFPIN:SpawnAtParkingSpot(AIRBASE:FindByName(AIRBASE.PersianGulf.Al_Minhad_AB), {5,15}, SPAWN.Takeoff.Hot)
			else
				USAEFPIN:SpawnAtAirbase(AIRBASE:FindByName(DepartureAirbaseName), SPAWN.Takeoff.Hot)
			end			
			--:SpawnInZone( SpawnZone, false, 5000, 5000 )
			--:SpawnAtAirbase( AIRBASE:FindByName( DepartureAirbaseName ), SPAWN.Takeoff.Hot )
		end
		
		trigger.action.outText("Pinpoint Strike Mission Launched",15)	
	end
end

function SEF_USAEFDRONESPAWN(DepartureAirbaseName, DestinationAirbaseName)
	
	if ( GROUP:FindByName(USAEFDRONEGROUPNAME) ~= nil and GROUP:FindByName(USAEFDRONEGROUPNAME):IsAlive() ) then
		trigger.action.outText("MQ-9 Aerial Drone Is Currently Active, Further Support Is Unavailable",15)	
	else
		USAEFDRONE_DATA[1].Vec2 = nil
		USAEFDRONE_DATA[1].TimeStamp = nil
		
		local SpawnZone = AIRBASE:FindByName(DepartureAirbaseName):GetZone()
		local DestinationZone = AIRBASE:FindByName(DestinationAirbaseName):GetZone()	
		local TargetZoneVec2Point = DestinationZone:GetVec2()
		local SpawnX = TargetZoneVec2Point.x - 10000
		local SpawnY = TargetZoneVec2Point.y		
		local DroneStartVec3 = { x = SpawnX, y = 6448, z = SpawnY }
		
		USAEFDRONE = SPAWN
			:New("USAEF MQ-9 Aerial Drone")
			:InitLimit( 1, 1 )		
			:OnSpawnGroup(
				function( SpawnGroup )						
					USAEFDRONEGROUPNAME = SpawnGroup.GroupName
					USAEFDRONEGROUP = GROUP:FindByName(SpawnGroup.GroupName)							
					
					local DepartureZoneVec2 = SpawnZone:GetVec2()
					local TargetZoneVec2 	= DestinationZone:GetVec2()
					
					local WP0X = TargetZoneVec2.x - 10000
					local WP0Y = TargetZoneVec2.y										
					local WP1X = WP0X + 1000
					local WP1Y = WP0Y					
					--Orbit Start Point
					local WP2X = TargetZoneVec2.x
					local WP2Y = TargetZoneVec2.y								
								
							--////Aerial Drone Mission Profile, Orbit Target Zone For 4 Hours
							Mission = {
								["id"] = "Mission",
								["params"] = {		
									["route"] = 
									{
										["points"] = 
										{
											[1] = 
											{
												["alt"] = 6448,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 86.9444,
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
												["ETA"] = 0,
												["ETA_locked"] = true,
												["y"] = WP0Y,
												["x"] = WP0X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [1]
											[2] = 
											{
												["alt"] = 6448,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 86.9444,
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
																["auto"] = false,
																["id"] = "FAC",
																["number"] = 1,
																["params"] = 
																{
																	["number"] = 9,
																	["designation"] = "Auto",
																	["modulation"] = 0,
																	["callname"] = 8,
																	["datalink"] = true,
																	["frequency"] = 272000000,
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
																		["id"] = "EPLRS",
																		["params"] = 
																		{
																			["value"] = true,
																			["groupId"] = 0,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [2]
															[3] = 
															{
																["enabled"] = true,
																["auto"] = false,
																["id"] = "WrappedAction",
																["number"] = 3,
																["params"] = 
																{
																	["action"] = 
																	{
																		["id"] = "SetInvisible",
																		["params"] = 
																		{
																			["value"] = true,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
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
																			["value"] = 0,
																			["name"] = 1,
																		}, -- end of ["params"]
																	}, -- end of ["action"]
																}, -- end of ["params"]
															}, -- end of [4]
														}, -- end of ["tasks"]
													}, -- end of ["params"]
												}, -- end of ["task"]
												["type"] = "Turning Point",
												["ETA"] = 53.765858988616,
												["ETA_locked"] = false,
												["y"] = WP1Y,
												["x"] = WP1X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [2]
											[3] = 
											{
												["alt"] = 6448,
												["action"] = "Turning Point",
												["alt_type"] = "BARO",
												["speed"] = 86.9444,
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
																["auto"] = false,
																["id"] = "ControlledTask",
																["number"] = 1,
																["params"] = 
																{
																	["task"] = 
																	{
																		["id"] = "Orbit",
																		["params"] = 
																		{
																			["altitude"] = 6448,
																			["pattern"] = "Circle",
																			["speed"] = 66.111111111111,
																			["speedEdited"] = true,
																		}, -- end of ["params"]
																	}, -- end of ["task"]
																	["stopCondition"] = 
																	{
																		["duration"] = 14400,
																	}, -- end of ["stopCondition"]
																}, -- end of ["params"]
															}, -- end of [1]
														}, -- end of ["tasks"]
													}, -- end of ["params"]
												}, -- end of ["task"]
												["type"] = "Turning Point",
												["ETA"] = 269.74317967324,
												["ETA_locked"] = false,
												["y"] = WP2Y,
												["x"] = WP2X,
												["formation_template"] = "",
												["speed_locked"] = true,
											}, -- end of [3]
										}, -- end of ["points"]
									}, -- end of ["route"]
								}, --end of ["params"]
							}--end of Mission				
					USAEFDRONEGROUP:SetTask(Mission)				
				end
			)
		--:SpawnInZone( SpawnZone, false, 6448, 6448 )
		:SpawnFromVec3( DroneStartVec3 )
		--SPAWN:SpawnFromVec3(Vec3, SpawnIndex) --Vec3 point to spawn at(just south of target group) SpawnIndex is optional
		trigger.action.outText("MQ-9 Aerial Drone Launched",15)	
	end
end

--////End Support Functions
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////Radio Menu 

function SEF_RadioMenuSetup()
	--////Set Up Menu
	-- table missionCommands.addSubMenuForCoalition(enum coalition.side, string name , table path)
	-- table missionCommands.addCommand(string name, table/nil path, function functionToRun , any anyArguement)
	-- table missionCommands.addCommandForCoalition(enum coalition.side, string name, table/nil path, function functionToRun , any anyArguement)

	--////Setup Submenu For Support Requests
	SupportMenuMain = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request Support", nil)
	SupportMenuAbort = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Abort Support", nil)
	SupportMenuCAP  = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request Fighter Support", SupportMenuMain)
	SupportMenuCAS  = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request Close Air Support", SupportMenuMain)
	SupportMenuSEAD = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request SEAD Support", SupportMenuMain)
	SupportMenuASS = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request Anti-Shipping Support", SupportMenuMain)
	SupportMenuPIN = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request Pinpoint Strike", SupportMenuMain)
	SupportMenuDrone = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Request MQ-9 Reaper Drone", SupportMenuMain)
	
	--////Objective Options
	ObjectiveInfo = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Objective Info", nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Check Current Objective", ObjectiveInfo, function() CheckObjectiveRequest() end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Target Report", ObjectiveInfo, function() TargetReport() end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Smoke Current Objective", ObjectiveInfo, function() SEF_TargetSmoke() end, nil)
	SnowfoxPhaseCheck  = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Check Battle Phase", ObjectiveInfo, function() SEF_BattlePhaseCheck() end, nil)
	--SnowfoxAWACSCheck  = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Check AWACS Phase", ObjectiveInfo, function() SEF_BattlePhaseCheckAwacsTankers() end, nil)
	SnowfoxSkipScenario  = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Skip This Mission", ObjectiveInfo, function() SEF_SkipScenario() end, nil) 
	
	--////AI Support Flights Mission Abort Codes
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Abort Mission Fighter Screen", SupportMenuAbort, function() AbortCAPMission() end, nil)	
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Abort Mission Close Air Support", SupportMenuAbort, function() AbortCASMission() end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Abort Mission Anti-Shipping", SupportMenuAbort, function() AbortASSMission() end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Abort Mission SEAD", SupportMenuAbort, function() AbortSEADMission() end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Abort Mission Pinpoint Strike", SupportMenuAbort, function() AbortPINMission() end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Abort Mission MQ-9 Reaper Drone", SupportMenuAbort, function() AbortDroneMission() end, nil)	
	
	--////Snowfox Mission Options
	SnowfoxOptions = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Snowfox Options", nil)
	SnowfoxCAPOptions = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Snowfox CAP Options", SnowfoxOptions)
  --SnowfoxSNDOptions = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Snowfox Sound Options", SnowfoxOptions)
	SnowfoxBLUECAPToggle = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Toggle Allied AI CAP Flights", SnowfoxCAPOptions, function() SEF_BLUESQUADRONSTOGGLE() end, nil)
	--SnowfoxInterceptTraining = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Snowfox Spawn Intercept Training", SnowfoxOptions, function() SEF_INTERCEPT_TRAINING() end, nil)
	--SnowfoxInterceptRandom = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Snowfox Spawn Random Intercept", SnowfoxOptions, function() SEF_INTERCEPT_RANDOM() end, nil)
	--SnowfoxToggleCustomSounds = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Toggle Custom Sounds", SnowfoxSNDOptions, function() SEF_ToggleCustomSounds() end, nil)	
	SnowfoxClearCarrierFighters  = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Clear Carrier Deck Of Fighters", SnowfoxOptions, function() SEF_ClearAIFightersFromCarrierDeck() end, nil)
	--SnowfoxClearCarrierTankers  = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Clear Carrier Deck Of Tankers", SnowfoxOptions, function() SEF_ClearAITankersFromCarrierDeck() end, nil)
  AdminOptions = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Admin Options", SnowfoxOptions)
  RemoveBlueBaseCAP  = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Remove BLUE BASECAP", AdminOptions, function() SEF_BASECAP_REMOVE () end, nil)
  RespawnBlueBaseCAP  = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Respawn BLUE BASECAP", AdminOptions, function() SEF_BASECAP_RESPAWN () end, nil)
  --RemoveEjectUnits  = missionCommands.addCommandForCoalition(coalition.side.BLUE, "Remove Ejected Static Units", AdminOptions, function() SEF_EJECT_REMOVE () end, nil)

	
	--////CAP Support Sector List
	
	SupportMenuCAP_UAE = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "UAE And Oman Sectors", SupportMenuCAP)
	SupportMenuCAP_Islands = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Island Sectors", SupportMenuCAP) 
	SupportMenuCAP_Coastal = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Iranian Coastal Sectors", SupportMenuCAP) 
	
	--////UAE and Oman
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Dhabi", SupportMenuCAP_UAE, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Abu_Dhabi_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al-Bateen", SupportMenuCAP_UAE, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Bateen_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Ain", SupportMenuCAP_UAE, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Ain_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Dhafra", SupportMenuCAP_UAE, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Dhafra_AB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Maktoum", SupportMenuCAP_UAE, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Maktoum_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Minhad", SupportMenuCAP_UAE, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Minhad_AB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Dubai", SupportMenuCAP_UAE, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Dubai_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Fujairah", SupportMenuCAP_UAE, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Fujairah_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Khasab", SupportMenuCAP_UAE, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Khasab) end, nil)
	
	SupportMenuCAP_UAEMore = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "More Sectors", SupportMenuCAP_UAE)
	
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Liwa", SupportMenuCAP_UAEMore, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Liwa_Airbase) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sas Al Nakheel", SupportMenuCAP_UAEMore, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sas_Al_Nakheel_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sharjah", SupportMenuCAP_UAEMore, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sharjah_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Ras Al Khaimah", SupportMenuCAP_UAEMore, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Ras_Al_Khaimah) end, nil)
	
	--////Islands
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Musa Island", SupportMenuCAP_Islands, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Abu_Musa_Island_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Kish Island", SupportMenuCAP_Islands, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Kish_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Lavan Island", SupportMenuCAP_Islands, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Lavan_Island_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Qeshm Island", SupportMenuCAP_Islands, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Qeshm_Island) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sir Abu Nuayr Island", SupportMenuCAP_Islands, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sir_Abu_Nuayr) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sirri Island", SupportMenuCAP_Islands, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sirri_Island) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Island", SupportMenuCAP_Islands, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Tunb_Island_AFB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Kochak Island", SupportMenuCAP_Islands, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Tunb_Kochak) end, nil)
	
	--////Iranian Coastal
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Abbas", SupportMenuCAP_Coastal, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_Abbas_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar-e-Jask", SupportMenuCAP_Coastal, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_e_Jask_airfield) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Lengeh", SupportMenuCAP_Coastal, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_Lengeh) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Havadarya", SupportMenuCAP_Coastal, function() SEF_USAEFCAPSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Havadarya) end, nil)
		
		
	--////CAS Support Sector List
	SupportMenuCAS_UAE = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "UAE And Oman Sectors", SupportMenuCAS)
	SupportMenuCAS_Islands = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Island Sectors", SupportMenuCAS) 
	SupportMenuCAS_Coastal = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Iranian Coastal Sectors", SupportMenuCAS) 
	
	--////UAE and Oman
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Dhabi", SupportMenuCAS_UAE, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Abu_Dhabi_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al-Bateen", SupportMenuCAS_UAE, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Bateen_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Ain", SupportMenuCAS_UAE, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Ain_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Dhafra", SupportMenuCAS_UAE, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Dhafra_AB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Maktoum", SupportMenuCAS_UAE, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Maktoum_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Minhad", SupportMenuCAS_UAE, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Minhad_AB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Dubai", SupportMenuCAS_UAE, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Dubai_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Fujairah", SupportMenuCAS_UAE, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Fujairah_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Khasab", SupportMenuCAS_UAE, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Khasab) end, nil)
	
	SupportMenuCAS_UAEMore = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "More Sectors", SupportMenuCAS_UAE)
	
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Liwa", SupportMenuCAS_UAEMore, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Liwa_Airbase) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sas Al Nakheel", SupportMenuCAS_UAEMore, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sas_Al_Nakheel_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sharjah", SupportMenuCAS_UAEMore, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sharjah_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Ras Al Khaimah", SupportMenuCAS_UAEMore, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Ras_Al_Khaimah) end, nil)
	
	--////Islands
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Musa Island", SupportMenuCAS_Islands, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Abu_Musa_Island_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Kish Island", SupportMenuCAS_Islands, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Kish_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Lavan Island", SupportMenuCAS_Islands, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Lavan_Island_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Qeshm Island", SupportMenuCAS_Islands, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Qeshm_Island) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sir Abu Nuayr Island", SupportMenuCAS_Islands, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sir_Abu_Nuayr) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sirri Island", SupportMenuCAS_Islands, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sirri_Island) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Island", SupportMenuCAS_Islands, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Tunb_Island_AFB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Kochak Island", SupportMenuCAS_Islands, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Tunb_Kochak) end, nil)
	
	--////Iranian Coastal
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Abbas", SupportMenuCAS_Coastal, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_Abbas_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar-e-Jask", SupportMenuCAS_Coastal, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_e_Jask_airfield) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Lengeh", SupportMenuCAS_Coastal, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_Lengeh) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Havadarya", SupportMenuCAS_Coastal, function() SEF_USAEFCASSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Havadarya) end, nil)
	
	
	--////SEAD Support Sector List
	SupportMenuSEAD_UAE = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "UAE And Oman Sectors", SupportMenuSEAD)
	SupportMenuSEAD_Islands = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Island Sectors", SupportMenuSEAD) 
	SupportMenuSEAD_Coastal = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Iranian Coastal Sectors", SupportMenuSEAD) 
	
	--////UAE and Oman
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Dhabi", SupportMenuSEAD_UAE, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Abu_Dhabi_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al-Bateen", SupportMenuSEAD_UAE, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Bateen_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Ain", SupportMenuSEAD_UAE, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Ain_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Dhafra", SupportMenuSEAD_UAE, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Dhafra_AB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Maktoum", SupportMenuSEAD_UAE, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Maktoum_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Minhad", SupportMenuSEAD_UAE, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Minhad_AB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Dubai", SupportMenuSEAD_UAE, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Dubai_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Fujairah", SupportMenuSEAD_UAE, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Fujairah_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Khasab", SupportMenuSEAD_UAE, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Khasab) end, nil)
	
	SupportMenuSEAD_UAEMore = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "More Sectors", SupportMenuSEAD_UAE)
	
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Liwa", SupportMenuSEAD_UAEMore, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Liwa_Airbase) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sas Al Nakheel", SupportMenuSEAD_UAEMore, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sas_Al_Nakheel_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sharjah", SupportMenuSEAD_UAEMore, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sharjah_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Ras Al Khaimah", SupportMenuSEAD_UAEMore, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Ras_Al_Khaimah) end, nil)
	
	--////Islands
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Musa Island", SupportMenuSEAD_Islands, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Abu_Musa_Island_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Kish Island", SupportMenuSEAD_Islands, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Kish_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Lavan Island", SupportMenuSEAD_Islands, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Lavan_Island_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Qeshm Island", SupportMenuSEAD_Islands, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Qeshm_Island) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sir Abu Nuayr Island", SupportMenuSEAD_Islands, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sir_Abu_Nuayr) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sirri Island", SupportMenuSEAD_Islands, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sirri_Island) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Island", SupportMenuSEAD_Islands, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Tunb_Island_AFB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Kochak Island", SupportMenuSEAD_Islands, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Tunb_Kochak) end, nil)
	
	--////Iranian Coastal
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Abbas", SupportMenuSEAD_Coastal, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_Abbas_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar-e-Jask", SupportMenuSEAD_Coastal, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_e_Jask_airfield) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Lengeh", SupportMenuSEAD_Coastal, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_Lengeh) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Havadarya", SupportMenuSEAD_Coastal, function() SEF_USAEFSEADSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Havadarya) end, nil)
	
	--////ANTI-SHIP Support Sector List	
	SupportMenuASS_UAE = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "UAE And Oman Sectors", SupportMenuASS)
	SupportMenuASS_Islands = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Island Sectors", SupportMenuASS) 
	SupportMenuASS_Coastal = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Iranian Coastal Sectors", SupportMenuASS) 
		
	--////UAE and Oman
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Dhabi", SupportMenuASS_UAE, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Abu_Dhabi_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al-Bateen", SupportMenuASS_UAE, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Bateen_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Ain", SupportMenuASS_UAE, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Ain_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Dhafra", SupportMenuASS_UAE, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Dhafra_AB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Maktoum", SupportMenuASS_UAE, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Maktoum_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Minhad", SupportMenuASS_UAE, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Minhad_AB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Dubai", SupportMenuASS_UAE, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Dubai_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Fujairah", SupportMenuASS_UAE, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Fujairah_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Khasab", SupportMenuASS_UAE, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Khasab) end, nil)
	
	SupportMenuASS_UAEMore = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "More Sectors", SupportMenuASS_UAE)
	
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Liwa", SupportMenuASS_UAEMore, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Liwa_Airbase) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sas Al Nakheel", SupportMenuASS_UAEMore, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sas_Al_Nakheel_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sharjah", SupportMenuASS_UAEMore, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sharjah_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Ras Al Khaimah", SupportMenuASS_UAEMore, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Ras_Al_Khaimah) end, nil)
	
	--////Islands
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Musa Island", SupportMenuASS_Islands, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Abu_Musa_Island_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Kish Island", SupportMenuASS_Islands, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Kish_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Lavan Island", SupportMenuASS_Islands, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Lavan_Island_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Qeshm Island", SupportMenuASS_Islands, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Qeshm_Island) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sir Abu Nuayr Island", SupportMenuASS_Islands, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sir_Abu_Nuayr) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sirri Island", SupportMenuASS_Islands, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sirri_Island) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Island", SupportMenuASS_Islands, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Tunb_Island_AFB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Kochak Island", SupportMenuASS_Islands, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Tunb_Kochak) end, nil)
	
	--////Iranian Coastal
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Abbas", SupportMenuASS_Coastal, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_Abbas_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar-e-Jask", SupportMenuASS_Coastal, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_e_Jask_airfield) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Lengeh", SupportMenuASS_Coastal, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_Lengeh) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Havadarya", SupportMenuASS_Coastal, function() SEF_USAEFASSSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Havadarya) end, nil)

	--////PIN Support Sector List
	SupportMenuPIN_UAE = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "UAE And Oman Sectors", SupportMenuPIN)
	SupportMenuPIN_Islands = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Island Sectors", SupportMenuPIN) 
	SupportMenuPIN_Coastal = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Iranian Coastal Sectors", SupportMenuPIN) 
		
	--////UAE and Oman
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Dhabi", SupportMenuPIN_UAE, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Abu_Dhabi_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al-Bateen", SupportMenuPIN_UAE, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Bateen_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Ain", SupportMenuPIN_UAE, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Ain_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Dhafra", SupportMenuPIN_UAE, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Dhafra_AB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Maktoum", SupportMenuPIN_UAE, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Maktoum_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Minhad", SupportMenuPIN_UAE, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Minhad_AB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Dubai", SupportMenuPIN_UAE, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Dubai_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Fujairah", SupportMenuPIN_UAE, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Fujairah_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Khasab", SupportMenuPIN_UAE, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Khasab) end, nil)
	
	SupportMenuPIN_UAEMore = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "More Sectors", SupportMenuPIN_UAE)
	
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Liwa", SupportMenuPIN_UAEMore, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Liwa_Airbase) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sas Al Nakheel", SupportMenuPIN_UAEMore, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sas_Al_Nakheel_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sharjah", SupportMenuPIN_UAEMore, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sharjah_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Ras Al Khaimah", SupportMenuPIN_UAEMore, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Ras_Al_Khaimah) end, nil)
	
	--////Islands
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Musa Island", SupportMenuPIN_Islands, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Abu_Musa_Island_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Kish Island", SupportMenuPIN_Islands, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Kish_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Lavan Island", SupportMenuPIN_Islands, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Lavan_Island_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Qeshm Island", SupportMenuPIN_Islands, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Qeshm_Island) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sir Abu Nuayr Island", SupportMenuPIN_Islands, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sir_Abu_Nuayr) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sirri Island", SupportMenuPIN_Islands, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sirri_Island) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Island", SupportMenuPIN_Islands, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Tunb_Island_AFB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Kochak Island", SupportMenuPIN_Islands, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Tunb_Kochak) end, nil)
	
	--////Iranian Coastal
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Abbas", SupportMenuPIN_Coastal, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_Abbas_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar-e-Jask", SupportMenuPIN_Coastal, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_e_Jask_airfield) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Lengeh", SupportMenuPIN_Coastal, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_Lengeh) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Havadarya", SupportMenuPIN_Coastal, function() SEF_USAEFPINSPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Havadarya) end, nil)

	
	--////DRONE Support Sector List	
	SupportMenuDRONE_UAE = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "UAE And Oman Sectors", SupportMenuDrone)
	SupportMenuDRONE_Islands = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Island Sectors", SupportMenuDrone) 
	SupportMenuDRONE_Coastal = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "Iranian Coastal Sectors", SupportMenuDrone) 
	
	--////UAE and Oman
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Dhabi", SupportMenuDRONE_UAE, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Abu_Dhabi_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al-Bateen", SupportMenuDRONE_UAE, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Bateen_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Ain", SupportMenuDRONE_UAE, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Ain_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Dhafra", SupportMenuDRONE_UAE, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Dhafra_AB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Maktoum", SupportMenuDRONE_UAE, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Maktoum_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Al Minhad", SupportMenuDRONE_UAE, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Al_Minhad_AB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Dubai", SupportMenuDRONE_UAE, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Dubai_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Fujairah", SupportMenuDRONE_UAE, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Fujairah_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Khasab", SupportMenuDRONE_UAE, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Khasab) end, nil)
	
	SupportMenuDRONE_UAEMore = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "More Sectors", SupportMenuDRONE_UAE)
	
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Liwa", SupportMenuDRONE_UAEMore, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Liwa_Airbase) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sas Al Nakheel", SupportMenuDRONE_UAEMore, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sas_Al_Nakheel_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sharjah", SupportMenuDRONE_UAEMore, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sharjah_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Ras Al Khaimah", SupportMenuDRONE_UAEMore, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Ras_Al_Khaimah) end, nil)
	
	--////Islands
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Abu Musa Island", SupportMenuDRONE_Islands, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Abu_Musa_Island_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Kish Island", SupportMenuDRONE_Islands, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Kish_International_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Lavan Island", SupportMenuDRONE_Islands, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Lavan_Island_Airport) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Qeshm Island", SupportMenuDRONE_Islands, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Qeshm_Island) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sir Abu Nuayr Island", SupportMenuDRONE_Islands, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sir_Abu_Nuayr) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Sirri Island", SupportMenuDRONE_Islands, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Sirri_Island) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Island", SupportMenuDRONE_Islands, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Tunb_Island_AFB) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Tunb Kochak Island", SupportMenuDRONE_Islands, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Tunb_Kochak) end, nil)
	
	--////Iranian Coastal
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Abbas", SupportMenuDRONE_Coastal, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_Abbas_Intl) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar-e-Jask", SupportMenuDRONE_Coastal, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_e_Jask_airfield) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Bandar Lengeh", SupportMenuDRONE_Coastal, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Bandar_Lengeh) end, nil)
	missionCommands.addCommandForCoalition(coalition.side.BLUE, "Sector Havadarya", SupportMenuDRONE_Coastal, function() SEF_USAEFDRONESPAWN(AIRBASE.PersianGulf.Al_Minhad_AB, AIRBASE.PersianGulf.Havadarya) end, nil)
end	

--////End Radio Menu Functions
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////OVERRIDE FUNCTIONS

function SEF_ToggleCustomSounds()

	if ( CustomSoundsEnabled == 0 ) then
		CustomSoundsEnabled = 1
		trigger.action.outText("Custom Sounds Are Now Enabled", 15)
	elseif ( CustomSoundsEnabled == 1 ) then
		CustomSoundsEnabled = 0
		trigger.action.outText("Custom Sounds Are Now Disabled", 15)
	else		
	end
end

--[[
function SEF_ClearAITankersFromCarrierDeck()
	if ( GROUP:FindByName(ARCOGROUPNAME) ~= nil and GROUP:FindByName(ARCOGROUPNAME):IsAlive() ) then
		Group.getByName(ARCOGROUPNAME):destroy()
		trigger.action.outText("Tanker Arco Has Been Cleared", 15)
	else
		trigger.action.outText("Tanker Arco Is Not Currently Deployed", 15)
	end	
end
]]--
--////End Override Functions
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////BLUE AWACS/TANKER SPAWN

function SEF_USAFAWACS_SCHEDULER()    
	
	if ( GROUP:FindByName(USAFAWACSGROUPNAME) ~= nil and GROUP:FindByName(USAFAWACSGROUPNAME):IsAlive() ) then				
		timer.scheduleFunction(SEF_USAFAWACS_SCHEDULER, nil, timer.getTime() + 300)			
	else
		SEF_USAFAWACS_SPAWN()		
		timer.scheduleFunction(SEF_USAFAWACS_SCHEDULER, nil, timer.getTime() + 300)
	end		
end

function SEF_USAFAWACS_SPAWN()

	USAFAWACS_DATA[1].Vec2 = nil
	USAFAWACS_DATA[1].TimeStamp = nil
	
	local Phase = SEF_BattlePhaseCheckAwacsTankers()
	
	if ( Phase <= 2 ) then
	
		USAFAWACS = SPAWN
			:New( "USAF AWACS" )
			:InitKeepUnitNames(true)
			:InitRadioFrequency(282.025)
			:OnSpawnGroup(
				function( SpawnGroup )								
					USAFAWACSGROUPNAME = SpawnGroup.GroupName
					--USAFAWACSGROUPID = Group.getByName(USAFAWACSGROUPNAME):getID()												
				end
			)		
		:Spawn()
		env.info("AWACS Spawned Phase 1/2", false)
  elseif ( Phase == 3 or Phase == 4 ) then
		USAFAWACS = SPAWN
			:New( "USAF AWACS P3" )
			:InitKeepUnitNames(true)
			:InitRadioFrequency(282.025)
			:OnSpawnGroup(
				function( SpawnGroup )								
					USAFAWACSGROUPNAME = SpawnGroup.GroupName
					--USAFAWACSGROUPID = Group.getByName(USAFAWACSGROUPNAME):getID()												
				end
			)		
		:Spawn()
		env.info("AWACS Spawned Phase 3/4", false)
  else
    USAFAWACS = SPAWN
    :New( "USAF AWACS P5" )
    :InitKeepUnitNames(true)
    :InitRadioFrequency(282.025)
    :OnSpawnGroup(
      function( SpawnGroup )                
        USAFAWACSGROUPNAME = SpawnGroup.GroupName
          --USAFAWACSGROUPID = Group.getByName(USAFAWACSGROUPNAME):getID()                        
      end
    )   
    :Spawn()
    env.info("AWACS Spawned Phase 5", false)    
	end	
end

function SEF_TEXACO_SCHEDULER()    
	
	if ( GROUP:FindByName(TEXACOGROUPNAME) ~= nil and GROUP:FindByName(TEXACOGROUPNAME):IsAlive() ) then				
		timer.scheduleFunction(SEF_TEXACO_SCHEDULER, nil, timer.getTime() + 300)			
	else
		SEF_TEXACO_SPAWN()		
		timer.scheduleFunction(SEF_TEXACO_SCHEDULER, nil, timer.getTime() + 300)
	end		
end

function SEF_TEXACO_SPAWN()	
			
	TEXACO_DATA[1].Vec2 = nil
	TEXACO_DATA[1].TimeStamp = nil
	
	local Phase = SEF_BattlePhaseCheckAwacsTankers()
	
	if ( Phase <= 2 ) then	
		TEXACO = SPAWN
			:New( "22nd ARW Texaco" )
			:InitKeepUnitNames(true)
			:InitRadioFrequency(317.775)
			:OnSpawnGroup(
				function( SpawnGroup )								
					TEXACOGROUPNAME = SpawnGroup.GroupName
					--TEXACOGROUPID = Group.getByName(TEXACOGROUPNAME):getID()												
				end
			)		
		:Spawn()
		env.info("TEXACO Spawned Phase 1/2", false)
		env.info(Phase, false)
  elseif ( Phase == 3 or Phase == 4 ) then
		TEXACO = SPAWN
			:New( "22nd ARW Texaco P3" )
			:InitKeepUnitNames(true)
			:InitRadioFrequency(317.775)
			:OnSpawnGroup(
				function( SpawnGroup )								
					TEXACOGROUPNAME = SpawnGroup.GroupName
					--TEXACOGROUPID = Group.getByName(TEXACOGROUPNAME):getID()												
				end
			)		
		:Spawn()
		env.info("TEXACO Spawned Phase 3/4", false)
  else
    TEXACO = SPAWN
    :New( "22nd ARW Texaco P5" )
    :InitKeepUnitNames(true)
    :InitRadioFrequency(317.775)
    :OnSpawnGroup(
      function( SpawnGroup )                
        TEXACOGROUPNAME = SpawnGroup.GroupName
          --TEXACOGROUPID = Group.getByName(TEXACOGROUPNAME):getID()                        
      end
    )   
    :Spawn()
    env.info("TEXACO Spawned Phase 5", false)    
	end	
end

function SEF_SHELL_SCHEDULER()    
	
	if ( GROUP:FindByName(SHELLGROUPNAME) ~= nil and GROUP:FindByName(SHELLGROUPNAME):IsAlive() ) then				
		timer.scheduleFunction(SEF_SHELL_SCHEDULER, nil, timer.getTime() + 300)			
	else
		SEF_SHELL_SPAWN()		
		timer.scheduleFunction(SEF_SHELL_SCHEDULER, nil, timer.getTime() + 300)
	end		
end

function SEF_SHELL_SPAWN()	
			
	SHELL_DATA[1].Vec2 = nil
	SHELL_DATA[1].TimeStamp = nil
	
	local Phase = SEF_BattlePhaseCheckAwacsTankers()
	
	if ( Phase <= 2 ) then
		SHELL = SPAWN
			:New( "22nd ARW Shell" )
			:InitKeepUnitNames(true)
			:InitRadioFrequency(317.650)
			:OnSpawnGroup(
				function( SpawnGroup )								
					SHELLGROUPNAME = SpawnGroup.GroupName
					--SHELLGROUPID = Group.getByName(SHELLGROUPNAME):getID()												
				end
			)		
		:Spawn()
		env.info("SHELL Spawned Phase 1/2", false)
  elseif ( Phase == 3 or Phase == 4 ) then
		SHELL = SPAWN
			:New( "22nd ARW Shell P3" )
			:InitKeepUnitNames(true)
			:InitRadioFrequency(317.650)
			:OnSpawnGroup(
				function( SpawnGroup )								
					SHELLGROUPNAME = SpawnGroup.GroupName
					--SHELLGROUPID = Group.getByName(SHELLGROUPNAME):getID()												
				end
			)		
		:Spawn()
		env.info("SHELL Spawned Phase 3/4", false)
  else
    SHELL = SPAWN
    :New( "22nd ARW Shell P5" )
    :InitKeepUnitNames(true)
    :InitRadioFrequency(317.650)
    :OnSpawnGroup(
      function( SpawnGroup )                
        SHELLGROUPNAME = SpawnGroup.GroupName
          --SHELLGROUPID = Group.getByName(SHELLGROUPNAME):getID()                        
      end
    )   
    :Spawn()
    env.info("SHELL Spawned Phase 5", false)		
	end
end

function SEF_ARCO_SCHEDULER()    
  
  if ( GROUP:FindByName(ARCOGROUPNAME) ~= nil and GROUP:FindByName(ARCOGROUPNAME):IsAlive() ) then        
    timer.scheduleFunction(SEF_ARCO_SCHEDULER, nil, timer.getTime() + 300)     
  else
    SEF_ARCO_SPAWN()   
    timer.scheduleFunction(SEF_ARCO_SCHEDULER, nil, timer.getTime() + 300)
  end   
end

function SEF_ARCO_SPAWN()  
      
  ARCO_DATA[1].Vec2 = nil
  ARCO_DATA[1].TimeStamp = nil
  
  local Phase = SEF_BattlePhaseCheckAwacsTankers()
  
  if ( Phase <= 2 ) then
    ARCO = SPAWN
      :New( "22nd ARW ARCO" )
      :InitKeepUnitNames(true)
      :InitRadioFrequency(276.100)
      :OnSpawnGroup(
        function( SpawnGroup )                
          ARCOGROUPNAME = SpawnGroup.GroupName
          --ARCOGROUPID = Group.getByName(ARCOGROUPNAME):getID()                        
        end
      )   
    :Spawn()
    env.info("ARCO Spawned Phase 1/2", false)
  elseif ( Phase == 3 or Phase == 4 ) then
    ARCO = SPAWN
      :New( "22nd ARW ARCO P3" )
      :InitKeepUnitNames(true)
      :InitRadioFrequency(276.100)
      :OnSpawnGroup(
        function( SpawnGroup )                
          ARCOGROUPNAME = SpawnGroup.GroupName
          --ARCOGROUPID = Group.getByName(ARCOGROUPNAME):getID()                        
        end
      )   
    :Spawn()
    env.info("ARCO Spawned Phase 3/4", false)
  else
    ARCO = SPAWN
    :New( "22nd ARW ARCO P5" )
    :InitKeepUnitNames(true)
    :InitRadioFrequency(276.100)
    :OnSpawnGroup(
      function( SpawnGroup )                
        ARCOGROUPNAME = SpawnGroup.GroupName
        --ARCOGROUPID = Group.getByName(ARCOGROUPNAME):getID()                        
      end
    )   
    :Spawn()
    env.info("ARCO Spawned Phase 5", false)
  end
end



--[[
function SEF_ARCO_SCHEDULER()    
	
	if ( GROUP:FindByName(ARCOGROUPNAME) ~= nil and GROUP:FindByName(ARCOGROUPNAME):IsAlive() ) then				
		timer.scheduleFunction(SEF_ARCO_SCHEDULER, nil, timer.getTime() + 300)			
	else
		SEF_ARCO_SPAWN()		
		timer.scheduleFunction(SEF_ARCO_SCHEDULER, nil, timer.getTime() + 300)
	end		
end

function SEF_ARCO_SPAWN()	
			
	ARCO_DATA[1].Vec2 = nil
	ARCO_DATA[1].TimeStamp = nil
	
	ARCO = SPAWN
		:New( "22nd ARW Arco" )
		:InitKeepUnitNames(true)
		:OnSpawnGroup(
			function( SpawnGroup )								
				ARCOGROUPNAME = SpawnGroup.GroupName
				--ARCOGROUPID = Group.getByName(ARCOGROUPNAME):getID()												
			end
		)		
	:Spawn()
	env.info("ARCO Spawned", false)
end
]]--
--////End Blue Awacs/Tankers Spawn
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////TARGET SMOKE FUNCTIONS

function SEF_TargetSmokeLock()
	TargetSmokeLockout = 1
end

function SEF_TargetSmokeUnlock()
	TargetSmokeLockout = 0
end

function SEF_TargetSmoke()
	
	if ( TargetSmokeLockout == 0 ) then
		if ( AGTargetTypeStatic == false and AGMissionTarget ~= nil ) then
			--TARGET IS NOT STATIC					
			if ( GROUP:FindByName(AGMissionTarget):IsAlive() == true ) then
				--GROUP VALID
				SEFTargetSmokeGroupCoord = GROUP:FindByName(AGMissionTarget):GetCoordinate()
				SEFTargetSmokeGroupCoord:SmokeRed()
				--SEFTargetSmokeGroupCoord:SmokeBlue()
				--SEFTargetSmokeGroupCoord:SmokeGreen()
				--SEFTargetSmokeGroupCoord:SmokeOrange()
				--SEFTargetSmokeGroupCoord:SmokeWhite()
				
				if ( CustomSoundsEnabled == 1) then
					trigger.action.outSound('Target Smoke.ogg')
				else
				end	
				trigger.action.outText("Target Has Been Marked With Red Smoke", 15)
				SEF_TargetSmokeLock()
				timer.scheduleFunction(SEF_TargetSmokeUnlock, 53, timer.getTime() + 300)				
			else			
				trigger.action.outText("Target Smoke Currently Unavailable - Unable To Acquire Target Group", 15)						
			end		
		elseif ( AGTargetTypeStatic == true and AGMissionTarget ~= nil ) then		
			--TARGET IS STATIC		
			if ( StaticObject.getByName(AGMissionTarget) ~= nil and StaticObject.getByName(AGMissionTarget):isExist() == true ) then
				--STATIC IS VALID
				SEFTargetSmokeStaticCoord = STATIC:FindByName(AGMissionTarget):GetCoordinate()
				SEFTargetSmokeStaticCoord:SmokeRed()
				--SEFTargetSmokeStaticCoord:SmokeBlue()
				--SEFTargetSmokeStaticCoord:SmokeGreen()
				--SEFTargetSmokeStaticCoord:SmokeOrange()
				--SEFTargetSmokeStaticCoord:SmokeWhite()
				if ( CustomSoundsEnabled == 1) then
					trigger.action.outSound('Target Smoke.ogg')
				else
				end		
				trigger.action.outText("Target Has Been Marked With Red Smoke", 15)
				SEF_TargetSmokeLock()
				timer.scheduleFunction(SEF_TargetSmokeUnlock, 53, timer.getTime() + 300)				
			else
				trigger.action.outText("Target Smoke Currently Unavailable - Unable To Acquire Target Building", 15)	
			end			
		else		
			trigger.action.outText("Target Smoke Currently Unavailable - No Valid Targets", 15)
		end
	else
		trigger.action.outText("Target Smoke Currently Unavailable - Smoke Shells Are Being Reloaded", 15)
	end	
end

--////End Target Smoke Functions
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////OTHER FUNCTIONS

function SEF_BattlePhaseCheck()

	-- * AIRBASE.PersianGulf.Abu_Dhabi_International_Airport
	-- * AIRBASE.PersianGulf.Abu_Musa_Island_Airport
	-- * AIRBASE.PersianGulf.Al_Bateen_Airport
	-- * AIRBASE.PersianGulf.Al_Ain_International_Airport
	-- * AIRBASE.PersianGulf.Al_Dhafra_AB
	-- * AIRBASE.PersianGulf.Al_Maktoum_Intl
	-- * AIRBASE.PersianGulf.Al_Minhad_AB
	-- * AIRBASE.PersianGulf.Bandar_e_Jask_airfield
	-- * AIRBASE.PersianGulf.Bandar_Abbas_Intl
	-- * AIRBASE.PersianGulf.Bandar_Lengeh
	-- * AIRBASE.PersianGulf.Dubai_Intl
	-- * AIRBASE.PersianGulf.Fujairah_Intl
	-- * AIRBASE.PersianGulf.Havadarya
	-- * AIRBASE.PersianGulf.Jiroft_Airport
	-- * AIRBASE.PersianGulf.Kerman_Airport
	-- * AIRBASE.PersianGulf.Khasab
	-- * AIRBASE.PersianGulf.Kish_International_Airport
	-- * AIRBASE.PersianGulf.Lar_Airbase
	-- * AIRBASE.PersianGulf.Lavan_Island_Airport
	-- * AIRBASE.PersianGulf.Liwa_Airbase
	-- * AIRBASE.PersianGulf.Qeshm_Island
	-- * AIRBASE.PersianGulf.Ras_Al_Khaimah
	-- * AIRBASE.PersianGulf.Sas_Al_Nakheel_Airport
	-- * AIRBASE.PersianGulf.Sharjah_Intl
	-- * AIRBASE.PersianGulf.Shiraz_International_Airport
	-- * AIRBASE.PersianGulf.Sir_Abu_Nuayr
	-- * AIRBASE.PersianGulf.Sirri_Island
	-- * AIRBASE.PersianGulf.Tunb_Island_AFB
	-- * AIRBASE.PersianGulf.Tunb_Kochak	
	
	if ( 		Airbase.getByName(AIRBASE.PersianGulf.Abu_Dhabi_International_Airport):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Al_Bateen_Airport):getCoalition() ~= 2 or			
				Airbase.getByName(AIRBASE.PersianGulf.Al_Ain_International_Airport):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Al_Dhafra_AB):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Al_Maktoum_Intl):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Al_Minhad_AB):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Dubai_Intl):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Liwa_Airbase):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Sas_Al_Nakheel_Airport):getCoalition() ~= 2 or 
				Airbase.getByName(AIRBASE.PersianGulf.Sharjah_Intl):getCoalition() ~= 2 ) then
			
				--Then we must be in Phase 1
				trigger.action.outText("Mission Objective\n\nPhase 1 - Consolidation\n\nThe Following Territories Must Be Captured And Held:\n\nAbu Dhabi\nAl-Bateen\nAl Ain\nAl Dhafra\nAl Maktoum\nAl Minhad\nDubai\nLiwa\nSharjah\nSas Al Nakheel", 15)
	
	elseif ( 	Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Fujairah_Intl):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 2 ) then
				
				--Then we must be in Phase 2
				trigger.action.outText("Mission Objective\n\nPhase 2 - Liberation\n\nThe Following Territories Must Be Captured And Held:\n\nRas Al Khaimah\nFujairah\nKhasab", 15)
				
	elseif (	Airbase.getByName(AIRBASE.PersianGulf.Abu_Musa_Island_Airport):getCoalition() ~= 2 or
	      Airbase.getByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Sir_Abu_Nuayr):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() ~= 2 or 
				Airbase.getByName(AIRBASE.PersianGulf.Tunb_Island_AFB):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Tunb_Kochak):getCoalition() ~= 2 ) then
	
				--Then we must be in Phase 3
				trigger.action.outText("Mission Objective\n\nPhase 3 - Occupation\n\nThe Following Territories Must Be Captured And Held:\n\nBandar-e-Jask\nAbu Musa Island\nSirri Island\nTunb Island\nTunb Kochak Island\nSir Abu Nuayr", 15)
				
	elseif (	Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Bandar_Lengeh):getCoalition() ~= 2 or 
				Airbase.getByName(AIRBASE.PersianGulf.Qeshm_Island):getCoalition() ~= 2 or 
        Airbase.getByName(AIRBASE.PersianGulf.Kish_International_Airport):getCoalition() ~= 2 or 
        Airbase.getByName(AIRBASE.PersianGulf.Lavan_Island_Airport):getCoalition() ~= 2 or 		
				Airbase.getByName(AIRBASE.PersianGulf.Havadarya):getCoalition() ~= 2 ) then
				
				--Then we must be in Phase 4
				trigger.action.outText("Mission Objective\n\nPhase 4 - Retribution\n\nThe Following Territories Must Be Captured And Held:\n\nBandar Abbas\nBandar Lengeh\nHavadarya\nQeshm Island\nKish Intl\nLavan Island", 15)
				
  elseif (  Airbase.getByName(AIRBASE.PersianGulf.Lar_Airbase):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Jiroft_Airport):getCoalition() ~= 2 or 
        Airbase.getByName(AIRBASE.PersianGulf.Shiraz_International_Airport):getCoalition() ~= 2 or 
        Airbase.getByName(AIRBASE.PersianGulf.Kerman_Airport):getCoalition() ~= 2 ) then
        
        --Then we must be in Phase 4
        trigger.action.outText("Mission Objective\n\nPhase 5 - End Game\n\nThe Following Territories Must Be Captured And Held:\n\nLar\nJiroft\nShiraz\nKerman", 15)				
	else
		trigger.action.outText("Unable to determine phase", 15)
	end
end

function SEF_BattlePhaseCheckAwacsTankers()

	if ( 		Airbase.getByName(AIRBASE.PersianGulf.Abu_Dhabi_International_Airport):getCoalition() ~= 2 or
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
				
	
	elseif ( 	Airbase.getByName(AIRBASE.PersianGulf.Ras_Al_Khaimah):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Fujairah_Intl):getCoalition() ~= 2 or
        Airbase.getByName(AIRBASE.PersianGulf.Khasab):getCoalition() ~= 2 ) then
				
				--trigger.action.outText("Mission Objective\n\nPhase 2", 15)        
				--Then we must be in Phase 2
				return 2
				
	elseif (	Airbase.getByName(AIRBASE.PersianGulf.Abu_Musa_Island_Airport):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Bandar_e_Jask_airfield):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Sir_Abu_Nuayr):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Sirri_Island):getCoalition() ~= 2 or 
				Airbase.getByName(AIRBASE.PersianGulf.Tunb_Island_AFB):getCoalition() ~= 2 or
				Airbase.getByName(AIRBASE.PersianGulf.Tunb_Kochak):getCoalition() ~= 2 ) then
	
				--trigger.action.outText("Mission Objective\n\nPhase 3", 15)
				--Then we must be in Phase 3
				return 3
				
	elseif (	  Airbase.getByName(AIRBASE.PersianGulf.Bandar_Abbas_Intl):getCoalition() ~= 2 or
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

function SEF_TestMissionList()

	--This function should only be run to perform integrity check on the mission list before any targets are killed
	MissionListErrors = 0
	
	for i = 1, #OperationSnowfox_AG do		
		--trigger.action.outText("Looking at element "..i,15)
		if ( OperationSnowfox_AG[i].TargetStatic == true ) then
			if ( StaticObject.getByName(OperationSnowfox_AG[i].TargetName) ~= nil ) then
				--Pass
			else
				trigger.action.outText("Static "..OperationSnowfox_AG[i].TargetName.." Could Not Be Found", 15)
				MissionListErrors = MissionListErrors + 1
			end			
		else
			if ( Group.getByName(OperationSnowfox_AG[i].TargetName) ~=nil ) then
				--Pass
			else
				trigger.action.outText("Group "..OperationSnowfox_AG[i].TargetName.." Could Not Be Found", 15)
				MissionListErrors = MissionListErrors + 1
			end			
		end	
	end
	
	if MissionListErrors > 0 then
		trigger.action.outText("Warning - Mission List "..MissionListErrors.." Errors", 15)
	else
		trigger.action.outText("Mission List Passed Integrity Check", 15)
	end		
end

--////End Other Functions
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--////MAIN

	--////GLOBAL VARIABLE INITIALISATION	
	NumberOfCompletedMissions = 0
	TotalScenarios = 117
	OperationComplete = false
	CustomSoundsEnabled = 0
	SoundLockout = 0
	TargetSmokeLockout = 0	
						
	--////FUNCTIONS
	SEF_InitializeMissionTable()			
	--SEF_TestMissionList()
	timer.scheduleFunction(SEF_MissionSelector, 53, timer.getTime() + 17)
	SEF_RadioMenuSetup()
	
	--////START SUPPORT FLIGHT SCHEDULERS, DELAY ARCO BY 15 MINUTES TO ALLOW CARRIER PLANES TO SPAWN AND CLEAR DECK
	SEF_USAFAWACS_SCHEDULER()	
	SEF_TEXACO_SCHEDULER()
	SEF_SHELL_SCHEDULER()	
	SEF_ARCO_SCHEDULER()
	--timer.scheduleFunction(SEF_ARCO_SCHEDULER, nil, timer.getTime() + 900)
		
	--////SCHEDULERS
	--MISSION TARGET STATUS
	timer.scheduleFunction(SEF_MissionTargetStatus, 53, timer.getTime() + 27)
		
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--[[

--ABU MUSA 								10
Abu Musa Island - AAA
Abu Musa Island - Artillery
Abu Musa Island - Communications
Abu Musa Island - East Bunker
Abu Musa Island - Hawk
Abu Musa Island - SA-15
Abu Musa Island - Silkworm
Abu Musa Island - Weapons Research
Abu Musa Island - West Bunker
Abu Musa Island - Cargo Ship

--BANDAR ABBAS							15
Bandar Abbas - Communications East
Bandar Abbas - Communications West
Bandar Abbas - Hawk
Bandar Abbas - Military Base
Bandar Abbas - Power Plant West
Bandar Abbas - Power Plant East
Bandar Abbas - SA-15
Bandar Abbas - SA-5
Bandar Abbas - Military HQ
Bandar Abbas - Missile Bunker West
Bandar Abbas - Missile Bunker East
Bandar Abbas - Supply Truck		
Bandar Abbas - Scud Launcher
Bandar Abbas - Missile Barracks
Bandar Abbas - Missile Storage

--BANDAR LENGEH							11
Bandar Lengeh - Communications West
Bandar Lengeh - Communications East
Bandar Lengeh - Navy
Bandar Lengeh - Power Plant East
Bandar Lengeh - Power Plant West
Bandar Lengeh - SA-11
Bandar Lengeh - SA-15
Bandar Lengeh - Cargo Ship
Bandar Lengeh - Boat Bunker
Bandar Lengeh - Armor
Bandar Lengeh - Scud Launcher

--FUJAIRAH								4
Fujairah - SA-15
Fujairah - SA-6
Fujairah - AAA
Fujairah - Armor

--HAVADARYA								10
Havadarya - AAA
Havadarya - EWR Havadarya
Havadarya - EWR Tazeyan-e-Zir
Havadarya - HQ-2
Havadarya - Navy
Havadarya - Submarine
Havadarya - Silkworm
Havadarya - Cargo Ship
Havadarya - Uranium Mine
Havadarya - Armor

--BANDAR-E-JASK							9
Jask - Communications
Jask - EWR Jask
Jask - Hawk
Jask - Navy
Jask - SA-15
Jask - Cargo Ship
Jask - Armor
Jask - Supply Truck
Jask - Scud Launcher

--KHASAB								5
Khasab - Hawk
Khasab - SA-15
Khasab - AAA
Khasab - Armor
Khasab - Navy

--KISH ISLAND							2
Kish - EWR Kish
Kish Island - Communications

--LARAK ISLAND							2
Larak Island - Communications
Larak Island - Silkworm

--LAVAN ISLAND							1
Lavan Island - Hawk

--MINAB									7
Minab - AAA
Minab - CH-47D
Minab - Communications
Minab - Drone Control Tower
Minab - Drone Hangar
Minab - Igla
Minab - Armor

--QESHM ISLAND							11
Qeshm Island - AAA
Qeshm Island - Drone Control Tower
Qeshm Island - Drone Hangar
Qeshm Island - Naval Warehouse
Qeshm Island - Power Plant
Qeshm Island - SA-15
Qeshm Island - Submarine
Qeshm Island - Speedboat
Qeshm Island - Silkworm
Qeshm Island - SA-6
Qeshm Island - Armor

--RAS AL KHAIMAH						4
Ras Al Khaimah - SA-15
Ras Al Khaimah - SA-6
Ras Al Khaimah - AAA
Ras Al Khaimah - Armor

--SEERIK								5
Seerik - Communications
Seerik - Khordad
Seerik - Navy 1
Seerik - SA-15
Seerik - Armor

--SIR ABU NUAYR							5
Sir Abu Nuayr - Communications
Sir Abu Nuayr - SA-15
Sir Abu Nuayr - SA-6
Sir Abu Nuayr - Speedboat
Sir Abu Nuayr - AAA

--SIRRI ISLAND							7
Sirri Island - AAA
Sirri Island - Communications
Sirri Island - Navy
Sirri Island - Oil Processing
Sirri Island - Oil Refinery
Sirri Island - Cargo Ship
Sirri Island - SA-8

--TUNB ISLAND							4
Tunb Island - AAA
Tunb Island - Communications
Tunb Island - SA-8
Tunb Island - Speedboat

--TUNB KOCHAK							4
Tunb Kochak - AAA
Tunb Kochak - Artillery
Tunb Kochak - Communications
Tunb Kochak - SA-8

--OTHERS								7
Dibba Al Hisn - Navy

TOTAL									117
]]--
env.info("Mission Complete", false)
