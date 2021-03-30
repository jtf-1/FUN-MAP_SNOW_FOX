env.info("Helo Loading", false)

--NAVY SEALS							USA
--DELTA FORCE							USA
--UAE Presidential Guard				UAE
--Sultans Special Forces				Oman

--table missionCommands.addCommandForGroup(number groupId, string name, table/nil path, function functionToRun , any anyArguement)

-- https://wiki.hoggitworld.com/view/DCS_func_addCommandForGroup

--trigger.action.outText("Helo Script Starting", 15)

--------------------------------------------------------------------------------------------------------------------------------------------------
--////VARIABLES

HeloWeightingEnabled = true

NavySEALTeam = nil 		
DELTATeam = nil 		
SSFTeam = nil			
UAEPGTeam = nil			
USACETeam1 = nil
USACETeam2 = nil		
USACE1GROUPNAME = ""
USACE2GROUPNAME = ""
NAVYSEALSGROUPNAME = ""
DELTAFORCEGROUPNAME = ""
SSFGROUPNAME = ""
UAEPGGROUPNAME = ""		
CargoContainer = nil	

SEALPickupZone = ZONE:New( "Navy SEALS Pickup Zone" )
SEALPickupZoneSmokeLockout = 0
SEALExtractionZoneSmokeLockout = 0
SEALTeamExtractionZone = nil

DELTAPickupZone = ZONE:New( "DELTA Force Pickup Zone" )
DELTAPickupZoneSmokeLockout = 0
DELTAExtractionZoneSmokeLockout = 0
DELTATeamExtractionZone = nil

SSFPickupZone = ZONE:New( "SSF Pickup Zone" )
SSFPickupZoneSmokeLockout = 0
SSFExtractionZoneSmokeLockout = 0
SSFTeamExtractionZone = nil

UAEPGPickupZone = ZONE:New( "UAEPG Pickup Zone" )
UAEPGPickupZoneSmokeLockout = 0
UAEPGExtractionZoneSmokeLockout = 0
UAEPGTeamExtractionZone = nil

CargoContainerPickupZone = {}
CargoContainerPickupZone[1] = {				
		ZoneName = "Cargo Loading Zone London"
		
}
CargoContainerPickupZone[2] = {				
		ZoneName = "Cargo Loading Zone Paris"		
}
CargoContainerPickupZone[3] = {				
		ZoneName = "Cargo Loading Zone Al Minhad AFB"		
}
CargoContainerPickupZone[4] = {				
		ZoneName = "Cargo Loading Zone Ras Al Khaimah Intl"		
}
CargoContainerPickupZone[5] = {				
		ZoneName = "Cargo Loading Zone Khasab"		
}

CargoContainerSmokeLockout = 0
CargoContainerNumber = 0
CargoContainerTable = {}
USACEM818Table = {}
USACEHAWKTable = {}
USACEROLANDTable = {}
USACEM1A2ABRAMSTable = {}

ConstructionZone = nil
USACETeam1PickupZone = ZONE:New( "USACE 1st Squad Pickup Zone" )
USACETeam2PickupZone = ZONE:New( "USACE 2nd Squad Pickup Zone" )
USACETeam1ConstructionZone = nil
USACETeam2ConstructionZone = nil
USACETeam1PickupZoneSmokeLockout = 0
USACETeam1ConstructionZoneSmokeLockout = 0
USACETeam2PickupZoneSmokeLockout = 0
USACETeam2ConstructionZoneSmokeLockout = 0

USACEM818 = SPAWN:New("USACE M818"):OnSpawnGroup(
										function( SpawnGroup )	
											USACEM818SpawnGroup = SpawnGroup
											USACEM818GroupName = SpawnGroup.GroupName											
											USACEM818TableNextElement = #USACEM818Table + 1					
											USACEM818Table[USACEM818TableNextElement] = USACEM818GroupName																					
										end 
									)
USACEHAWK = SPAWN:New("bSAM-Hawk-USACE "):OnSpawnGroup(
										function( SpawnGroup )	
											USACEHAWKSpawnGroup = SpawnGroup
											USACEHAWKGroupName = SpawnGroup.GroupName											
											USACEHAWKTableNextElement = #USACEHAWKTable + 1					
											USACEHAWKTable[USACEHAWKTableNextElement] = USACEHAWKGroupName																					
										end 
									)
									
USACEROLAND = SPAWN:New("bSAM-Roland-USACE"):OnSpawnGroup(
										function( SpawnGroup )	
											USACEROLANDSpawnGroup = SpawnGroup
											USACEROLANDGroupName = SpawnGroup.GroupName											
											USACEROLANDTableNextElement = #USACEROLANDTable + 1					
											USACEROLANDTable[USACEROLANDTableNextElement] = USACEROLANDGroupName																					
										end 
									)

USACEM1A2ABRAMS = SPAWN:New("USACE M1A2 Abrams"):OnSpawnGroup(
										function( SpawnGroup )	
											USACEM1A2ABRAMSSpawnGroup = SpawnGroup
											USACEM1A2ABRAMSGroupName = SpawnGroup.GroupName											
											USACEM1A2ABRAMSTableNextElement = #USACEM1A2ABRAMSTable + 1					
											USACEM1A2ABRAMSTable[USACEM1A2ABRAMSTableNextElement] = USACEM1A2ABRAMSGroupName																					
										end 
									)									
									
CargoContainerMaximumCrates = 16									
CargoContainerWeight = 250
									
USACEHawkRequiredCrates = 4
USACEHawkBuildTime = 120
USACEHawkMaximumSites = 3

USACEM818RequiredCrates = 2
USACEM818BuildTime = 60
USACEM818MaximumTrucks = 6

USACERolandRequiredCrates = 3
USACERolandBuildTime = 90
USACERolandMaximumUnits = 2

USACEM1A2AbramsRequiredCrates = 3
USACEM1A2AbramsBuildTime = 100
USACEM1A2AbramsMaximumUnits = 4

--------------------------------------------------------------------------------------------------------------------------------------------------
--NAVY SEALS

function SEF_SEAL_SpawnTeam(_Args)

	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]
	
	--trigger.action.outText("Group ID "..HeloGroupID.." Is Attempting To Spawn SEALS, Group Name Is "..HeloGroupName,15)
	
	if ( NavySEALTeam == nil or NavySEALTeam:IsAlive() == false or NavySEALTeam:IsDestroyed() == true ) then
		NAVYSEALS = SPAWN
			:New( "Navy SEALS")
			:InitLimit( 5, 5 )			
			:OnSpawnGroup(
				function( SpawnGroup )								
					NAVYSEALSGROUPNAME = SpawnGroup.GroupName
					NAVYSEALSGROUPID = Group.getByName(NAVYSEALSGROUPNAME):getID()
					NavySEALTeam = CARGO_GROUP:New( GROUP:FindByName( NAVYSEALSGROUPNAME ), "Navy SEALS", "Navy SEALS", 250 )						
				end
			)				
			:Spawn()			
			trigger.action.outTextForGroup(HeloGroupID, "Navy SEAL Team Is Waiting At London FARP And Is Ready For Deployment",15)
			SEF_SEAL_SmokePickupZone()
			SEALTeamExtractionZone = nil				
	elseif ( NavySEALTeam:IsAlive() == true ) then
		trigger.action.outTextForGroup(HeloGroupID, "Navy SEALS Are Currently Active, Further Support Is Unavailable",15)	
	else			
	end	
end

function SEF_SEAL_SpawnTeamPersistent(Vec2Point)

	if ( NavySEALTeam == nil or NavySEALTeam:IsAlive() == false or NavySEALTeam:IsDestroyed() == true ) then
		NAVYSEALS = SPAWN
			:New( "Navy SEALS")
			:InitLimit( 5, 5 )			
			:OnSpawnGroup(
				function( SpawnGroup )								
					NAVYSEALSGROUPNAME = SpawnGroup.GroupName
					NAVYSEALSGROUPID = Group.getByName(NAVYSEALSGROUPNAME):getID()
					NavySEALTeam = CARGO_GROUP:New( GROUP:FindByName( NAVYSEALSGROUPNAME ), "Navy SEALS", "Navy SEALS", 250 )						
				end
			)				
			:SpawnFromVec2(Vec2Point)
			trigger.action.outText("Navy SEALS Are In The Field", 15)	
			timer.scheduleFunction(SEF_SEAL_SetExtractionZone, 53, timer.getTime() + 2)				
	elseif ( NavySEALTeam:IsAlive() == true ) then
		trigger.action.outText("Navy SEALS Are Currently Active, Further Support Is Unavailable",15)	
	else			
	end	
end

function SEF_SEAL_PickupZoneSmokeLock()
	SEALPickupZoneSmokeLockout = 1
end

function SEF_SEAL_PickupZoneSmokeUnlock()
	SEALPickupZoneSmokeLockout = 0
end

function SEF_SEAL_ExtractionZoneSmokeLock()
	SEALExtractionZoneSmokeLockout = 1
end

function SEF_SEAL_ExtractionZoneSmokeUnlock()
	SEALExtractionZoneSmokeLockout = 0
end

function SEF_SEAL_SmokePickupZone()
	
	if ( SEALPickupZoneSmokeLockout == 0 ) then
		SEALPickupZoneCoord = SEALPickupZone:GetCoordinate()
		SEALPickupZoneCoord:SmokeBlue()
		SEF_SEAL_PickupZoneSmokeLock()
		timer.scheduleFunction(SEF_SEAL_PickupZoneSmokeUnlock, 53, timer.getTime() + 300)
		trigger.action.outText( "Navy SEAL Team Has Been Marked With Blue Smoke", 15 )
	else
		trigger.action.outText( "Navy SEAL Pickup Zone Is Already Smoked", 15 )
	end
end

function SEF_SEAL_SmokeExtractionZone()
	
	if ( SEALTeamExtractionZone ~= nil ) then
		if ( SEALExtractionZoneSmokeLockout == 0 ) then
			SEALTeamExtractionZoneCoord = SEALTeamExtractionZone:GetCoordinate()
			SEALTeamExtractionZoneCoord:SmokeOrange()
			SEF_SEAL_ExtractionZoneSmokeLock()
			timer.scheduleFunction(SEF_SEAL_ExtractionZoneSmokeUnlock, 53, timer.getTime() + 300)
			trigger.action.outText( "Navy SEAL Extraction Zone Has Been Marked With Orange Smoke", 15 )
		else
			trigger.action.outText( "Navy SEAL Extraction Zone Is Already Smoked", 15 )
		end
	else
		trigger.action.outText("Navy SEALS Do Not Currently Have An Extraction Zone Set", 15)
	end
end

function SEF_SEAL_SetExtractionZone()

	SEALTeamExtract = GROUP:FindByName(NavySEALTeam:GetObjectName())
	SEALTeamExtractCoord = SEALTeamExtract:GetCoordinate()
	SEALTeamExtractCoordVec2 = SEALTeamExtract:GetCoordinate():GetVec2()
	SEALTeamExtractionZone = ZONE_RADIUS:New("SEALExtractionZone", SEALTeamExtractCoordVec2, 250)	
	trigger.action.outText( "Navy SEAL Team Extraction Zone Has Been Set", 15 )	
end

function SEF_SEAL_PickupZoneLoadTeam(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]
		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()
	
	--Check the SEAL Team
	if ( GROUP:FindByName(NavySEALTeam:GetObjectName()):GetSize() > 0 and GROUP:FindByName(NavySEALTeam:GetObjectName()):IsInZone(SEALPickupZone) == true and NavySEALTeam:IsLoaded() == false ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == true ) then
			--Check Client Is Stationary On The Ground And In Zone
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 and TransPlayerUnit:IsInZone(SEALPickupZone) == true ) then
				NavySEALTeam:Load( TransPlayerUnit )
				trigger.action.outTextForGroup(HeloGroupID, "Navy SEAL Team Has Boarded "..TransClientUnitName, 15 )
				TransPlayerUnit:AddCargo(NavySEALTeam)
				SEALTeamExtractionZone = nil
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Either Not Stationary On The Ground, Or Not In The Pickup Zone",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Already Has Cargo On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "Navy SEAL Team Is Either Dead Or Not In The Pickup Zone", 15)
	end	
end

function SEF_SEAL_Insertion(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()
	
	--Check Navy SEALS 
	if ( NavySEALTeam:IsLoadedInCarrier(TransPlayerUnit) == true and GROUP:FindByName(NavySEALTeam:GetObjectName()):GetSize() > 0 and NavySEALTeam:IsLoaded() == true ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == false ) then
			--Check Client Is Stationary On The Ground
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 ) then
								
				local ZonePointVec2 = TransPlayerUnit:GetPointVec2()								
				local x = ZonePointVec2:GetLat() 
				local y = ZonePointVec2:GetLon() 
				local offsety = y + 25
				local TeamSpawnPointVec2 = POINT_VEC2:New( x, offsety )								
																	
				NavySEALTeam:UnLoad(TeamSpawnPointVec2)							
				trigger.action.outTextForGroup(HeloGroupID, "Navy SEAL Team Is Disembarking From "..TransClientUnitName, 15 )
				TransPlayerUnit:RemoveCargo(NavySEALTeam)							
				timer.scheduleFunction(SEF_SEAL_SetExtractionZone, 53, timer.getTime() + 2)														
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Not Stationary On The Ground",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Does Not Have The Navy SEAL Team On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "Navy SEAL Team Is Either Dead Or Not Loaded On "..TransClientUnitName, 15 )
	end	
end

function SEF_SEAL_Extraction(_Args)
		
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()		
	
	--Check Navy SEALS
	if ( GROUP:FindByName(NavySEALTeam:GetObjectName()):GetSize() > 0 and GROUP:FindByName(NavySEALTeam:GetObjectName()):IsInZone(SEALTeamExtractionZone) == true and NavySEALTeam:IsLoaded() == false ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == true ) then	
			--Check Client Is Stationary On The Ground And In Extraction Zone
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 and TransPlayerUnit:IsInZone(SEALTeamExtractionZone) == true ) then
				NavySEALTeam:Load( TransPlayerUnit )
				trigger.action.outTextForGroup(HeloGroupID, "Navy SEAL Team Has Boarded "..TransClientUnitName, 15 )
				TransPlayerUnit:AddCargo(NavySEALTeam)			
				SEALTeamExtractionZone = nil
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Not Stationary On The Ground In The Extraction Zone",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Already Has Cargo On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "Navy SEAL Team Is Either Dead Or Not In The Extraction Zone", 15 )
	end	
end

--END NAVY SEALS
--------------------------------------------------------------------------------------------------------------------------------------------------
--DELTA FORCE

function SEF_DELTA_SpawnTeam(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]
	
	--trigger.action.outText("Group ID "..HeloGroupID.." Is Attempting To Spawn DELTA Force, Group Name Is "..HeloGroupName,15)	
	
	if ( DELTATeam == nil or DELTATeam:IsAlive() == false or DELTATeam:IsDestroyed() == true ) then
		DELTAFORCE = SPAWN
			:New( "DELTA Force")
			:InitLimit( 5, 5 )			
			:OnSpawnGroup(
				function( SpawnGroup )								
					DELTAFORCEGROUPNAME = SpawnGroup.GroupName
					DELTAFORCEGROUPID = Group.getByName(DELTAFORCEGROUPNAME):getID()
					DELTATeam = CARGO_GROUP:New( GROUP:FindByName( DELTAFORCEGROUPNAME ), "DELTA Force", "DELTA Force", 250 )						
				end
			)				
			:Spawn()			
			trigger.action.outTextForGroup(HeloGroupID, "DELTA Force Is Waiting At Paris FARP And Is Ready For Deployment",15)
			SEF_DELTA_SmokePickupZone()
			DELTATeamExtractionZone = nil				
	elseif ( DELTATeam:IsAlive() == true ) then
		trigger.action.outTextForGroup(HeloGroupID, "DELTA Force Are Currently Active, Further Support Is Unavailable",15)	
	else			
	end		
end

function SEF_DELTA_SpawnTeamPersistent(Vec2Point)

	if ( DELTATeam == nil or DELTATeam:IsAlive() == false or DELTATeam:IsDestroyed() == true ) then
		DELTAFORCE = SPAWN
			:New( "DELTA Force")
			:InitLimit( 5, 5 )			
			:OnSpawnGroup(
				function( SpawnGroup )								
					DELTAFORCEGROUPNAME = SpawnGroup.GroupName
					DELTAFORCEGROUPID = Group.getByName(DELTAFORCEGROUPNAME):getID()
					DELTATeam = CARGO_GROUP:New( GROUP:FindByName( DELTAFORCEGROUPNAME ), "DELTA Force", "DELTA Force", 250 )						
				end
			)				
			:SpawnFromVec2(Vec2Point)									
			trigger.action.outText("DELTA Force Are In The Field", 15)
			timer.scheduleFunction(SEF_DELTA_SetExtractionZone, 53, timer.getTime() + 2)				
	elseif ( DELTATeam:IsAlive() == true ) then
		trigger.action.outText("DELTA Force Are Currently Active, Further Support Is Unavailable",15)	
	else			
	end	
end

function SEF_DELTA_PickupZoneSmokeLock()
	DELTAPickupZoneSmokeLockout = 1
end

function SEF_DELTA_PickupZoneSmokeUnlock()
	DELTAPickupZoneSmokeLockout = 0
end

function SEF_DELTA_ExtractionZoneSmokeLock()
	DELTAExtractionZoneSmokeLockout = 1
end

function SEF_DELTA_ExtractionZoneSmokeUnlock()
	DELTAExtractionZoneSmokeLockout = 0
end

function SEF_DELTA_SmokePickupZone()
	
	if ( DELTAPickupZoneSmokeLockout == 0 ) then
		DELTAPickupZoneCoord = DELTAPickupZone:GetCoordinate()
		DELTAPickupZoneCoord:SmokeBlue()
		SEF_DELTA_PickupZoneSmokeLock()
		timer.scheduleFunction(SEF_DELTA_PickupZoneSmokeUnlock, 53, timer.getTime() + 300)
		trigger.action.outText( "DELTA Force Has Been Marked With Blue Smoke", 15 )
	else
		trigger.action.outText( "DELTA Force Pickup Zone Is Already Smoked", 15 )
	end
end

function SEF_DELTA_SmokeExtractionZone()
	
	if ( DELTATeamExtractionZone ~= nil ) then
		if ( DELTAExtractionZoneSmokeLockout == 0 ) then
			DELTATeamExtractionZoneCoord = DELTATeamExtractionZone:GetCoordinate()
			DELTATeamExtractionZoneCoord:SmokeOrange()
			SEF_DELTA_ExtractionZoneSmokeLock()
			timer.scheduleFunction(SEF_DELTA_ExtractionZoneSmokeUnlock, 53, timer.getTime() + 300)
			trigger.action.outText( "DELTA Force Extraction Zone Has Been Marked With Orange Smoke", 15 )
		else
			trigger.action.outText( "DELTA Force Extraction Zone Is Already Smoked", 15 )
		end
	else
		trigger.action.outText("DELTA Force Do Not Currently Have An Extraction Zone Set", 15)
	end
end

function SEF_DELTA_SetExtractionZone()

	DELTATeamExtract = GROUP:FindByName(DELTATeam:GetObjectName())
	DELTATeamExtractCoord = DELTATeamExtract:GetCoordinate()
	DELTATeamExtractCoordVec2 = DELTATeamExtract:GetCoordinate():GetVec2()
	DELTATeamExtractionZone = ZONE_RADIUS:New("DELTAExtractionZone", DELTATeamExtractCoordVec2, 250)	
	trigger.action.outText( "DELTA Force Extraction Zone Has Been Set", 15 )	
end

function SEF_DELTA_PickupZoneLoadTeam(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()
	
	--Check DELTA Force Team
	if ( GROUP:FindByName(DELTATeam:GetObjectName()):GetSize() > 0 and GROUP:FindByName(DELTATeam:GetObjectName()):IsInZone(DELTAPickupZone) == true and DELTATeam:IsLoaded() == false ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == true ) then
			--Check Client Is Stationary On The Ground And In Zone
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 and TransPlayerUnit:IsInZone(DELTAPickupZone) == true ) then
				DELTATeam:Load( TransPlayerUnit )
				trigger.action.outTextForGroup(HeloGroupID, "DELTA Force Team Has Boarded "..TransClientUnitName, 15 )
				TransPlayerUnit:AddCargo(DELTATeam)
				DELTATeamExtractionZone = nil
			else
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Already Has Cargo On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "DELTA Force Team Is Either Dead Or Not In The Pickup Zone", 15 )
	end	
end

function SEF_DELTA_Insertion(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()
	
	--Check DELTA Force Team
	if ( DELTATeam:IsLoadedInCarrier(TransPlayerUnit) == true and GROUP:FindByName(DELTATeam:GetObjectName()):GetSize() > 0 and DELTATeam:IsLoaded() == true ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == false ) then
			--Check Client Is Stationary On The Ground
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 ) then
								
				local ZonePointVec2 = TransPlayerUnit:GetPointVec2()								
				local x = ZonePointVec2:GetLat() 
				local y = ZonePointVec2:GetLon() 
				local offsety = y + 25
				local TeamSpawnPointVec2 = POINT_VEC2:New( x, offsety )								
																	
				DELTATeam:UnLoad(TeamSpawnPointVec2)							
				trigger.action.outTextForGroup(HeloGroupID, "DELTA Force Team Is Disembarking From "..TransClientUnitName, 15 )
				TransPlayerUnit:RemoveCargo(DELTATeam)							
				timer.scheduleFunction(SEF_DELTA_SetExtractionZone, 53, timer.getTime() + 2)														
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Not Stationary On The Ground",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Does Not Have The DELTA Force Team On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "DELTA Force Team Is Either Dead Or Not Loaded On "..TransClientUnitName, 15 )
	end	
end

function SEF_DELTA_Extraction(_Args)	
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()		
	
	--Check DELTA Force Team
	if ( GROUP:FindByName(DELTATeam:GetObjectName()):GetSize() > 0 and GROUP:FindByName(DELTATeam:GetObjectName()):IsInZone(DELTATeamExtractionZone) == true and DELTATeam:IsLoaded() == false ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == true ) then	
			--Check Client Is Stationary On The Ground And In Extraction Zone
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 and TransPlayerUnit:IsInZone(DELTATeamExtractionZone) == true ) then
				DELTATeam:Load( TransPlayerUnit )
				trigger.action.outTextForGroup(HeloGroupID, "DELTA Force Team Has Boarded "..TransClientUnitName, 15 )
				TransPlayerUnit:AddCargo(DELTATeam)			
				DELTATeamExtractionZone = nil
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Not Stationary On The Ground In The Extraction Zone",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Already Has Cargo On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "DELTA Force Team Is Either Dead Or Not In The Extraction Zone", 15 )
	end	
end

--END DELTA FORCE
--------------------------------------------------------------------------------------------------------------------------------------------------
--SULTAN's SPECIAL FORCES

function SEF_SSF_SpawnTeam(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]
	
	--trigger.action.outText("Group ID "..HeloGroupID.." Is Attempting To Spawn Sultan's Special Forces, Group Name Is "..HeloGroupName,15)
	
	if ( SSFTeam == nil or SSFTeam:IsAlive() == false or SSFTeam:IsDestroyed() == true ) then
		SSF = SPAWN
			:New( "Sultans Special Forces") --Sultan Special Forces
			:InitLimit( 3, 3 )			
			:OnSpawnGroup(
				function( SpawnGroup )								
					SSFGROUPNAME = SpawnGroup.GroupName
					SSFGROUPID = Group.getByName(SSFGROUPNAME):getID()
					SSFTeam = CARGO_GROUP:New( GROUP:FindByName( SSFGROUPNAME ), "Sultans Special Forces", "Sultans Special Forces", 250 )						
				end
			)				
			:Spawn()			
			trigger.action.outTextForGroup(HeloGroupID, "Sultan's Special Forces Are Waiting At Paris FARP And Are Ready For Deployment",15)
			SEF_SSF_SmokePickupZone()
			SSFTeamExtractionZone = nil				
	elseif ( SSFTeam:IsAlive() == true ) then
		trigger.action.outTextForGroup(HeloGroupID, "Sultan's Special Forces Are Currently Active, Further Support Is Unavailable",15)	
	else			
	end		
end

function SEF_SSF_SpawnTeamPersistent(Vec2Point)

	if ( SSFTeam == nil or SSFTeam:IsAlive() == false or SSFTeam:IsDestroyed() == true ) then
		SSF = SPAWN
			:New( "Sultans Special Forces")
			:InitLimit( 3, 3 )			
			:OnSpawnGroup(
				function( SpawnGroup )								
					SSFGROUPNAME = SpawnGroup.GroupName
					SSFGROUPID = Group.getByName(SSFGROUPNAME):getID()
					SSFTeam = CARGO_GROUP:New( GROUP:FindByName( SSFGROUPNAME ), "Sultans Special Forces", "Sultans Special Forces", 250 )						
				end
			)				
			:SpawnFromVec2(Vec2Point)
			trigger.action.outText("Sultan's Special Forces Are In The Field", 15)	
			timer.scheduleFunction(SEF_SSF_SetExtractionZone, 53, timer.getTime() + 2)				
	elseif ( SSFTeam:IsAlive() == true ) then
		trigger.action.outText("Sultan's Special Forces Are Currently Active, Further Support Is Unavailable",15)	
	else			
	end	
end

function SEF_SSF_PickupZoneSmokeLock()
	SSFPickupZoneSmokeLockout = 1
end

function SEF_SSF_PickupZoneSmokeUnlock()
	SSFPickupZoneSmokeLockout = 0
end

function SEF_SSF_ExtractionZoneSmokeLock()
	SSFExtractionZoneSmokeLockout = 1
end

function SEF_SSF_ExtractionZoneSmokeUnlock()
	SSFExtractionZoneSmokeLockout = 0
end

function SEF_SSF_SmokePickupZone()
	
	if ( SSFPickupZoneSmokeLockout == 0 ) then
		SSFPickupZoneCoord = SSFPickupZone:GetCoordinate()
		SSFPickupZoneCoord:SmokeBlue()
		SEF_SSF_PickupZoneSmokeLock()
		timer.scheduleFunction(SEF_SSF_PickupZoneSmokeUnlock, 53, timer.getTime() + 300)
		trigger.action.outText( "Sultan's Special Forces Have Been Marked With Blue Smoke", 15 )
	else
		trigger.action.outText( "Sultan's Special Forces Pickup Zone Is Already Smoked", 15 )
	end
end

function SEF_SSF_SmokeExtractionZone()
	
	if ( SSFTeamExtractionZone ~= nil ) then
		if ( SSFExtractionZoneSmokeLockout == 0 ) then
			SSFTeamExtractionZoneCoord = SSFTeamExtractionZone:GetCoordinate()
			SSFTeamExtractionZoneCoord:SmokeOrange()
			SEF_SSF_ExtractionZoneSmokeLock()
			timer.scheduleFunction(SEF_SSF_ExtractionZoneSmokeUnlock, 53, timer.getTime() + 300)
			trigger.action.outText( "Sultan's Special Forces Have Been Marked With Orange Smoke", 15 )
		else
			trigger.action.outText( "Sultan's Special Forces Extraction Zone Is Already Smoked", 15 )
		end
	else
		trigger.action.outText("Sultan's Special Forces Do Not Currently Have An Extraction Zone Set", 15)
	end
end

function SEF_SSF_SetExtractionZone()

	SSFTeamExtract = GROUP:FindByName(SSFTeam:GetObjectName())
	SSFTeamExtractCoord = SSFTeamExtract:GetCoordinate()
	SSFTeamExtractCoordVec2 = SSFTeamExtract:GetCoordinate():GetVec2()
	SSFTeamExtractionZone = ZONE_RADIUS:New("SSFExtractionZone", SSFTeamExtractCoordVec2, 250)	
	trigger.action.outText( "Sultan's Special Forces Extraction Zone Has Been Set", 15 )	
end

function SEF_SSF_PickupZoneLoadTeam(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()
	
	--Check SSF Team
	if ( GROUP:FindByName(SSFTeam:GetObjectName()):GetSize() > 0 and GROUP:FindByName(SSFTeam:GetObjectName()):IsInZone(SSFPickupZone) == true and SSFTeam:IsLoaded() == false ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == true ) then
			--Check Client Is Stationary On The Ground And In Zone
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 and TransPlayerUnit:IsInZone(SSFPickupZone) == true ) then
				SSFTeam:Load( TransPlayerUnit )
				trigger.action.outTextForGroup(HeloGroupID, "Sultan's Special Forces Have Boarded "..TransClientUnitName, 15 )
				TransPlayerUnit:AddCargo(SSFTeam)
				SSFTeamExtractionZone = nil
			else
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Already Has Cargo On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "Sultan's Special Forces Are Either Dead Or Not In The Pickup Zone", 15 )
	end	
end

function SEF_SSF_Insertion(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()
	
	--Check SSF Team 
	if ( SSFTeam:IsLoadedInCarrier(TransPlayerUnit) == true and GROUP:FindByName(SSFTeam:GetObjectName()):GetSize() > 0 and SSFTeam:IsLoaded() == true ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == false ) then
			--Check Client Is Stationary On The Ground
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 ) then
								
				local ZonePointVec2 = TransPlayerUnit:GetPointVec2()								
				local x = ZonePointVec2:GetLat() 
				local y = ZonePointVec2:GetLon() 
				local offsety = y + 25
				local TeamSpawnPointVec2 = POINT_VEC2:New( x, offsety )								
																	
				SSFTeam:UnLoad(TeamSpawnPointVec2)							
				trigger.action.outText("Sultan's Special Forces Are Disembarking From "..TransClientUnitName, 15 )
				TransPlayerUnit:RemoveCargo(SSFTeam)							
				timer.scheduleFunction(SEF_SSF_SetExtractionZone, 53, timer.getTime() + 2)														
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Not Stationary On The Ground",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Does Not Have The Sultan's Special Forces Team On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "Sultan's Special Forces Are Either Dead Or Not Loaded On "..TransClientUnitName, 15 )
	end	
end

function SEF_SSF_Extraction(_Args)	
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()	
		
	--Check SSF Team
	if ( GROUP:FindByName(SSFTeam:GetObjectName()):GetSize() > 0 and GROUP:FindByName(SSFTeam:GetObjectName()):IsInZone(SSFTeamExtractionZone) == true and SSFTeam:IsLoaded() == false ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == true ) then	
			--Check Client Is Stationary On The Ground And In Extraction Zone
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 and TransPlayerUnit:IsInZone(SSFTeamExtractionZone) == true ) then
				SSFTeam:Load( TransPlayerUnit )
				trigger.action.outText("Sultan's Special Forces Have Boarded "..TransClientUnitName, 15 )
				TransPlayerUnit:AddCargo(SSFTeam)			
				SSFTeamExtractionZone = nil
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Not Stationary On The Ground In The Extraction Zone",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Already Has Cargo On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "Sultan's Special Forces Are Either Dead Or Not In The Extraction Zone", 15 )
	end	
end

--END SULTAN'S SPECIAL FORCES
--------------------------------------------------------------------------------------------------------------------------------------------------
--UAE PRESIDENTIAL GUARD

function SEF_UAEPG_SpawnTeam(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]
	
	--trigger.action.outText("Group ID "..HeloGroupID.." Is Attempting To Spawn UAE Presidential Guard, Group Name Is "..HeloGroupName,15)
	
	if ( UAEPGTeam == nil or UAEPGTeam:IsAlive() == false or UAEPGTeam:IsDestroyed() == true ) then
		UAEPG = SPAWN
			:New( "UAE Presidential Guard")
			:InitLimit( 3, 3 )			
			:OnSpawnGroup(
				function( SpawnGroup )								
					UAEPGGROUPNAME = SpawnGroup.GroupName
					UAEPGGROUPID = Group.getByName(UAEPGGROUPNAME):getID()
					UAEPGTeam = CARGO_GROUP:New( GROUP:FindByName( UAEPGGROUPNAME ), "UAE Presidential Guard", "UAE Presidential Guard", 250 )						
				end
			)				
			:Spawn()			
			trigger.action.outText("UAE Presidential Guard Team Is Waiting At London FARP And Is Ready For Deployment",60)
			SEF_UAEPG_SmokePickupZone()
			UAEPGTeamExtractionZone = nil				
	elseif ( UAEPGTeam:IsAlive() == true ) then
		trigger.action.outTextForGroup(HeloGroupID, "UAE Presidential Guard Team Is Currently Active, Further Support Is Unavailable",60)	
	else			
	end	
end

function SEF_UAEPG_SpawnTeamPersistent(Vec2Point)

	if ( UAEPGTeam == nil or UAEPGTeam:IsAlive() == false or UAEPGTeam:IsDestroyed() == true ) then
		UAEPG = SPAWN
			:New( "UAE Presidential Guard")
			:InitLimit( 3, 3 )			
			:OnSpawnGroup(
				function( SpawnGroup )								
					UAEPGGROUPNAME = SpawnGroup.GroupName
					UAEPGGROUPID = Group.getByName(UAEPGGROUPNAME):getID()
					UAEPGTeam = CARGO_GROUP:New( GROUP:FindByName( UAEPGGROUPNAME ), "UAE Presidential Guard", "UAE Presidential Guard", 250 )						
				end
			)				
			:SpawnFromVec2(Vec2Point)
			trigger.action.outText("UAE Presidential Guard Are In The Field", 15)	
			timer.scheduleFunction(SEF_UAEPG_SetExtractionZone, 53, timer.getTime() + 2)				
	elseif ( UAEPGTeam:IsAlive() == true ) then
		trigger.action.outText("UAE Presidential Guard Are Currently Active, Further Support Is Unavailable",15)	
	else			
	end	
end

function SEF_UAEPG_PickupZoneSmokeLock()
	UAEPGPickupZoneSmokeLockout = 1
end

function SEF_UAEPG_PickupZoneSmokeUnlock()
	UAEPGPickupZoneSmokeLockout = 0
end

function SEF_UAEPG_ExtractionZoneSmokeLock()
	UAEPGExtractionZoneSmokeLockout = 1
end

function SEF_UAEPG_ExtractionZoneSmokeUnlock()
	UAEPGExtractionZoneSmokeLockout = 0
end

function SEF_UAEPG_SmokePickupZone()
	
	if ( UAEPGPickupZoneSmokeLockout == 0 ) then
		UAEPGPickupZoneCoord = UAEPGPickupZone:GetCoordinate()
		UAEPGPickupZoneCoord:SmokeBlue()
		SEF_UAEPG_PickupZoneSmokeLock()
		timer.scheduleFunction(SEF_UAEPG_PickupZoneSmokeUnlock, 53, timer.getTime() + 300)
		trigger.action.outText( "UAE Presidential Guard Have Been Marked With Blue Smoke", 15 )
	else
		trigger.action.outText( "UAE Presidential Guard Pickup Zone Is Already Smoked", 15 )
	end
end

function SEF_UAEPG_SmokeExtractionZone()
	
	if ( UAEPGTeamExtractionZone ~= nil ) then
		if ( UAEPGExtractionZoneSmokeLockout == 0 ) then
			UAEPGTeamExtractionZoneCoord = UAEPGTeamExtractionZone:GetCoordinate()
			UAEPGTeamExtractionZoneCoord:SmokeOrange()
			SEF_UAEPG_ExtractionZoneSmokeLock()
			timer.scheduleFunction(SEF_UAEPG_ExtractionZoneSmokeUnlock, 53, timer.getTime() + 300)
			trigger.action.outText( "UAE Presidential Guard Extraction Zone Has Been Marked With Orange Smoke", 15 )
		else
			trigger.action.outText( "UAE Presidential Guard Extraction Zone Is Already Smoked", 15 )
		end
	else
		trigger.action.outText("UAE Presidential Guard Do Not Currently Have An Extraction Zone Set", 15)
	end
end

function SEF_UAEPG_SetExtractionZone()

	UAEPGTeamExtract = GROUP:FindByName(UAEPGTeam:GetObjectName())
	UAEPGTeamExtractCoord = UAEPGTeamExtract:GetCoordinate()
	UAEPGTeamExtractCoordVec2 = UAEPGTeamExtract:GetCoordinate():GetVec2()
	UAEPGTeamExtractionZone = ZONE_RADIUS:New("UAEPGExtractionZone", UAEPGTeamExtractCoordVec2, 250)	
	trigger.action.outText( "UAE Presidential Guard Extraction Zone Has Been Set", 15 )	
end

function SEF_UAEPG_PickupZoneLoadTeam(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()
	
	--Check the UAEPG Team
	if ( GROUP:FindByName(UAEPGTeam:GetObjectName()):GetSize() > 0 and GROUP:FindByName(UAEPGTeam:GetObjectName()):IsInZone(UAEPGPickupZone) == true and UAEPGTeam:IsLoaded() == false ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == true ) then
			--Check Client Is Stationary On The Ground And In Zone
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 and TransPlayerUnit:IsInZone(UAEPGPickupZone) == true ) then
				UAEPGTeam:Load( TransPlayerUnit )
				trigger.action.outText("UAE Presidential Guard Team Has Boarded "..TransClientUnitName, 15 )
				TransPlayerUnit:AddCargo(UAEPGTeam)
				UAEPGTeamExtractionZone = nil
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Either Not Stationary On The Ground, Or Not In The Pickup Zone",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Already Has Cargo On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "UAE Presidential Guard Team Is Either Dead Or Not In The Pickup Zone", 15 )
	end	
end

function SEF_UAEPG_Insertion(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()
	
	--Check UAEPG Team 
	if ( UAEPGTeam:IsLoadedInCarrier(TransPlayerUnit) == true and GROUP:FindByName(UAEPGTeam:GetObjectName()):GetSize() > 0 and UAEPGTeam:IsLoaded() == true ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == false ) then
			--Check Client Is Stationary On The Ground
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 ) then
								
				local ZonePointVec2 = TransPlayerUnit:GetPointVec2()								
				local x = ZonePointVec2:GetLat() 
				local y = ZonePointVec2:GetLon() 
				local offsety = y + 25
				local TeamSpawnPointVec2 = POINT_VEC2:New( x, offsety )								
																	
				UAEPGTeam:UnLoad(TeamSpawnPointVec2)							
				trigger.action.outText("UAE Presidential Guard Are Disembarking From "..TransClientUnitName, 15 )
				TransPlayerUnit:RemoveCargo(UAEPGTeam)							
				timer.scheduleFunction(SEF_UAEPG_SetExtractionZone, 53, timer.getTime() + 2)														
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Not Stationary On The Ground",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Does Not Have The UAE Presidential Guard Team On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "UAE Presidential Guard Team Is Either Dead Or Not Loaded On "..TransClientUnitName, 15 )
	end		
end

function SEF_UAEPG_Extraction(_Args)	
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()	
		
	--Check UAEPG Team
	if ( GROUP:FindByName(UAEPGTeam:GetObjectName()):GetSize() > 0 and GROUP:FindByName(UAEPGTeam:GetObjectName()):IsInZone(UAEPGTeamExtractionZone) == true and UAEPGTeam:IsLoaded() == false ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == true ) then	
			--Check Client Is Stationary On The Ground And In Extraction Zone
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 and TransPlayerUnit:IsInZone(UAEPGTeamExtractionZone) == true ) then
				UAEPGTeam:Load( TransPlayerUnit )
				trigger.action.outText("UAE Presidential Guard Have Boarded "..TransClientUnitName, 15 )
				TransPlayerUnit:AddCargo(UAEPGTeam)			
				UAEPGTeamExtractionZone = nil
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Not Stationary On The Ground In The Extraction Zone",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Already Has Cargo On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "UAE Presidential Guard Team Is Either Dead Or Not In The Extraction Zone", 15 )
	end	
end

--END UAE PRESIDENTIAL GUARD
--------------------------------------------------------------------------------------------------------------------------------------------------
--USACE ENGINEERS

function SEF_USACETeam1_SpawnTeam(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]
	
	--trigger.action.outText("Group ID "..HeloGroupID.." Is Attempting To Spawn USACE 1st Squad, Group Name Is "..HeloGroupName,15)	
	
	if ( USACETeam1 == nil or USACETeam1:IsAlive() == false or USACETeam1:IsDestroyed() == true ) then
		USACE1 = SPAWN
			:New( "USACE 1st Squad")
			:InitLimit( 5, 5 )			
			:OnSpawnGroup(
				function( SpawnGroup )								
					USACE1GROUPNAME = SpawnGroup.GroupName
					USACE1GROUPID = Group.getByName(USACE1GROUPNAME):getID()
					USACETeam1 = CARGO_GROUP:New( GROUP:FindByName( USACE1GROUPNAME ), "USACE 1st Squad", "USACE 1st Squad", 250 )						
				end
			)				
			:Spawn()			
			trigger.action.outTextForGroup(HeloGroupID, "USACE 1st Squad Is Waiting At London FARP And Is Ready For Deployment",15)
			SEF_USACETeam1_SmokePickupZone()			
			USACETeam1ConstructionZone = nil			
	elseif ( USACETeam1:IsAlive() == true ) then
		trigger.action.outTextForGroup(HeloGroupID, "USACE 1st Squad Are Currently Active, Further Support Is Unavailable",15)		
	else			
	end		
end

function SEF_USACETeam1_SpawnTeamPersistent(Vec2Point)
	
	if ( USACETeam1 == nil or USACETeam1:IsAlive() == false or USACETeam1:IsDestroyed() == true ) then
		USACE1 = SPAWN
			:New( "USACE 1st Squad")
			:InitLimit( 5, 5 )			
			:OnSpawnGroup(
				function( SpawnGroup )								
					USACE1GROUPNAME = SpawnGroup.GroupName
					USACE1GROUPID = Group.getByName(USACE1GROUPNAME):getID()
					USACETeam1 = CARGO_GROUP:New( GROUP:FindByName( USACE1GROUPNAME ), "USACE 1st Squad", "USACE 1st Squad", 250 )						
				end
			)				
			:SpawnFromVec2(Vec2Point)			
			trigger.action.outText("USACE 1st Squad Are In The Field", 15)
			timer.scheduleFunction(SEF_USACETeam1_SetConstructionZone, 53, timer.getTime() + 2)			
	elseif ( USACETeam1:IsAlive() == true ) then
		trigger.action.outTextForGroup(HeloGroupID, "USACE 1st Squad Are Currently Active, Further Support Is Unavailable",15)		
	else			
	end		
end

function SEF_USACETeam1_PickupZoneSmokeLock()
	USACETeam1PickupZoneSmokeLockout = 1
end

function SEF_USACETeam1_PickupZoneSmokeUnlock()
	USACETeam1PickupZoneSmokeLockout = 0
end

function SEF_USACETeam1_ConstructionZoneSmokeLock()
	USACETeam1ConstructionZoneSmokeLockout = 1
end

function SEF_USACETeam1_ConstructionZoneSmokeUnlock()
	USACETeam1ConstructionZoneSmokeLockout = 0
end

function SEF_USACETeam1_SmokePickupZone()
	
	if ( USACETeam1PickupZoneSmokeLockout == 0 ) then
		USACETeam1PickupZoneCoord = USACETeam1PickupZone:GetCoordinate()
		USACETeam1PickupZoneCoord:SmokeBlue()
		SEF_USACETeam1_PickupZoneSmokeLock()
		timer.scheduleFunction(SEF_USACETeam1_PickupZoneSmokeUnlock, 53, timer.getTime() + 300)
		trigger.action.outText( "USACE 1st Squad Has Been Marked With Blue Smoke", 15 )
	else
		trigger.action.outText( "USACE 1st Squad Pickup Zone Is Already Smoked", 15 )
	end
end

function SEF_USACETeam1_SmokeConstructionZone()
	
	if ( USACETeam1ConstructionZone ~= nil ) then
		if ( USACETeam1ConstructionZoneSmokeLockout == 0 ) then
			USACETeam1ConstructionZoneCoord = USACETeam1ConstructionZone:GetCoordinate()
			USACETeam1ConstructionZoneCoord:SmokeWhite()
			SEF_USACETeam1_ConstructionZoneSmokeLock()
			timer.scheduleFunction(SEF_USACETeam1_ConstructionZoneSmokeUnlock, 53, timer.getTime() + 300)
			trigger.action.outText( "USACE 1st Squad Construction Zone Has Been Marked With White Smoke", 15 )
		else
			trigger.action.outText( "USACE 1st Squad Construction Zone Is Already Smoked", 15 )
		end
	else
		trigger.action.outText( "USACE 1st Squad Does Not Have A Construction Zone Set", 15 )
	end
end

function SEF_USACETeam1_SetConstructionZone()

	USACETeam1Construction = GROUP:FindByName(USACETeam1:GetObjectName())
	USACETeam1ConstructionCoord = USACETeam1Construction:GetCoordinate()
	USACETeam1ConstructionCoordVec2 = USACETeam1Construction:GetCoordinate():GetVec2()
	USACETeam1ConstructionZone = ZONE_RADIUS:New("USACETeam1ConstructionZone", USACETeam1ConstructionCoordVec2, 150)	
	trigger.action.outText( "USACE 1st Squad Construction Zone Has Been Set", 15 )
end

function SEF_USACETeam1_PickupZoneLoadTeam(_Args)	
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()
			
	--Check the USACE 1st Squad
	if ( GROUP:FindByName(USACETeam1:GetObjectName()):GetSize() > 0 and GROUP:FindByName(USACETeam1:GetObjectName()):IsInZone(USACETeam1PickupZone) == true and USACETeam1:IsLoaded() == false ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == true ) then
			--Check Client Is Stationary On The Ground And In Zone
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 and TransPlayerUnit:IsInZone(USACETeam1PickupZone) == true ) then
				USACETeam1:Load( TransPlayerUnit )
				trigger.action.outTextForGroup(HeloGroupID, "USACE 1st Squad Has Boarded "..TransClientUnitName, 15 )
				TransPlayerUnit:AddCargo(USACETeam1)
				USACETeam1ConstructionZone = nil
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Either Not Stationary On The Ground, Or Not In The Pickup Zone",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Already Has Cargo On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "USACE 1st Squad Are Either Dead Or Not In The Pickup Zone", 15 )
	end	
end

function SEF_USACETeam1_SetupConstruction(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()
	
	--Check USACE 1st Squad 
	if ( USACETeam1:IsLoadedInCarrier(TransPlayerUnit) == true and GROUP:FindByName(USACETeam1:GetObjectName()):GetSize() > 0 and USACETeam1:IsLoaded() == true ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == false ) then
			--Check Client Is Stationary On The Ground
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 ) then
								
				local ZonePointVec2 = TransPlayerUnit:GetPointVec2()								
				local x = ZonePointVec2:GetLat() 
				local y = ZonePointVec2:GetLon() 
				local offsety = y + 25
				local TeamSpawnPointVec2 = POINT_VEC2:New( x, offsety )								
																	
				USACETeam1:UnLoad(TeamSpawnPointVec2)							
				trigger.action.outTextForGroup(HeloGroupID, "USACE 1st Squad Is Disembarking From "..TransClientUnitName, 15 )
				TransPlayerUnit:RemoveCargo(USACETeam1)							
				timer.scheduleFunction(SEF_USACETeam1_SetConstructionZone, 53, timer.getTime() + 2)														
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Not Stationary On The Ground",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Does Not Have The USACE 1st Squad On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "USACE 1st Squad Is Either Dead Or Not Loaded On "..TransClientUnitName, 15 )
	end		
end

function SEF_USACETeam1_Extraction(_Args)		
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()		
		
	--Check USACE Team
	if ( GROUP:FindByName(USACETeam1:GetObjectName()):GetSize() > 0 and GROUP:FindByName(USACETeam1:GetObjectName()):IsInZone(USACETeam1ConstructionZone) == true and USACETeam1:IsLoaded() == false ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == true ) then	
			--Check Client Is Stationary On The Ground And In Extraction Zone
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 and TransPlayerUnit:IsInZone(USACETeam1ConstructionZone) == true ) then
				USACETeam1:Load( TransPlayerUnit )
				trigger.action.outTextForGroup(HeloGroupID, "USACE 1st Squad Has Boarded "..TransClientUnitName, 15 )
				TransPlayerUnit:AddCargo(USACETeam1)			
				USACETeam1ConstructionZone = nil
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Not Stationary On The Ground In The Extraction Zone",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Already Has Cargo On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "USACE 1st Squad Are Either Dead Or Not In The Extraction Zone", 15 )
	end	
end

function SEF_USACETeam2_SpawnTeam(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]
	
	--trigger.action.outText("Group ID "..HeloGroupID.." Is Attempting To Spawn USACE 2nd Squad, Group Name Is "..HeloGroupName,15)	
	
	if ( USACETeam2 == nil or USACETeam2:IsAlive() == false or USACETeam2:IsDestroyed() == true ) then
		USACE2 = SPAWN
			:New( "USACE 2nd Squad")
			:InitLimit( 5, 5 )			
			:OnSpawnGroup(
				function( SpawnGroup )								
					USACE2GROUPNAME = SpawnGroup.GroupName
					USACE2GROUPID = Group.getByName(USACE2GROUPNAME):getID()
					USACETeam2 = CARGO_GROUP:New( GROUP:FindByName( USACE2GROUPNAME ), "USACE 2nd Squad", "USACE 2nd Squad", 250 )						
				end
			)				
			:Spawn()			
			trigger.action.outTextForGroup(HeloGroupID, "USACE 2nd Squad Is Waiting At Paris FARP And Is Ready For Deployment",15)
			SEF_USACETeam2_SmokePickupZone()			
			USACETeam2ConstructionZone = nil			
	elseif ( USACETeam2:IsAlive() == true ) then
		trigger.action.outTextForGroup(HeloGroupID, "USACE 2nd Squad Are Currently Active, Further Support Is Unavailable",15)		
	else			
	end		
end

function SEF_USACETeam2_SpawnTeamPersistent(Vec2Point)
	
	if ( USACETeam2 == nil or USACETeam2:IsAlive() == false or USACETeam2:IsDestroyed() == true ) then
		USACE2 = SPAWN
			:New( "USACE 2nd Squad")
			:InitLimit( 5, 5 )			
			:OnSpawnGroup(
				function( SpawnGroup )								
					USACE2GROUPNAME = SpawnGroup.GroupName
					USACE2GROUPID = Group.getByName(USACE2GROUPNAME):getID()
					USACETeam2 = CARGO_GROUP:New( GROUP:FindByName( USACE2GROUPNAME ), "USACE 2nd Squad", "USACE 2nd Squad", 250 )						
				end
			)				
			:SpawnFromVec2(Vec2Point)			
			trigger.action.outText("USACE 2nd Squad Are In The Field", 15)
			timer.scheduleFunction(SEF_USACETeam2_SetConstructionZone, 53, timer.getTime() + 2)			
	elseif ( USACETeam2:IsAlive() == true ) then
		trigger.action.outTextForGroup(HeloGroupID, "USACE 2nd Squad Are Currently Active, Further Support Is Unavailable",15)		
	else			
	end		
end

function SEF_USACETeam2_PickupZoneSmokeLock()
	USACETeam2PickupZoneSmokeLockout = 1
end

function SEF_USACETeam2_PickupZoneSmokeUnlock()
	USACETeam2PickupZoneSmokeLockout = 0
end

function SEF_USACETeam2_ConstructionZoneSmokeLock()
	USACETeam2ConstructionZoneSmokeLockout = 1
end

function SEF_USACETeam2_ConstructionZoneSmokeUnlock()
	USACETeam2ConstructionZoneSmokeLockout = 0
end

function SEF_USACETeam2_SmokePickupZone()
	
	if ( USACETeam2PickupZoneSmokeLockout == 0 ) then
		USACETeam2PickupZoneCoord = USACETeam2PickupZone:GetCoordinate()
		USACETeam2PickupZoneCoord:SmokeBlue()
		SEF_USACETeam2_PickupZoneSmokeLock()
		timer.scheduleFunction(SEF_USACETeam2_PickupZoneSmokeUnlock, 53, timer.getTime() + 300)
		trigger.action.outText( "USACE 2nd Squad Has Been Marked With Blue Smoke", 15 )
	else
		trigger.action.outText( "USACE 2nd Squad Pickup Zone Is Already Smoked", 15 )
	end
end

function SEF_USACETeam2_SmokeConstructionZone()
	
	if ( USACETeam2ConstructionZone ~= nil ) then
		if ( USACETeam2ConstructionZoneSmokeLockout == 0 ) then
			USACETeam2ConstructionZoneCoord = USACETeam2ConstructionZone:GetCoordinate()
			USACETeam2ConstructionZoneCoord:SmokeWhite()
			SEF_USACETeam2_ConstructionZoneSmokeLock()
			timer.scheduleFunction(SEF_USACETeam2_ConstructionZoneSmokeUnlock, 53, timer.getTime() + 300)
			trigger.action.outText( "USACE 2nd Squad Construction Zone Has Been Marked With White Smoke", 15 )
		else
			trigger.action.outText( "USACE 2nd Squad Construction Zone Is Already Smoked", 15 )
		end
	else
		trigger.action.outText( "USACE 2nd Squad Does Not Have A Construction Zone Set", 15 )
	end
end

function SEF_USACETeam2_SetConstructionZone()

	USACETeam2Construction = GROUP:FindByName(USACETeam2:GetObjectName())
	USACETeam2ConstructionCoord = USACETeam2Construction:GetCoordinate()
	USACETeam2ConstructionCoordVec2 = USACETeam2Construction:GetCoordinate():GetVec2()
	USACETeam2ConstructionZone = ZONE_RADIUS:New("USACETeam2ConstructionZone", USACETeam2ConstructionCoordVec2, 150)	
	trigger.action.outText( "USACE 2nd Squad Construction Zone Has Been Set", 15 )
end

function SEF_USACETeam2_PickupZoneLoadTeam(_Args)	
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()	
	
	--Check the USACE 2nd Squad
	if ( GROUP:FindByName(USACETeam2:GetObjectName()):GetSize() > 0 and GROUP:FindByName(USACETeam2:GetObjectName()):IsInZone(USACETeam2PickupZone) == true and USACETeam2:IsLoaded() == false ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == true ) then
			--Check Client Is Stationary On The Ground And In Zone
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 and TransPlayerUnit:IsInZone(USACETeam2PickupZone) == true ) then
				USACETeam2:Load( TransPlayerUnit )
				trigger.action.outTextForGroup(HeloGroupID, "USACE 2nd Squad Has Boarded "..TransClientUnitName, 15 )
				TransPlayerUnit:AddCargo(USACETeam2)
				USACETeam2ConstructionZone = nil
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Either Not Stationary On The Ground, Or Not In The Pickup Zone",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Already Has Cargo On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "USACE 2nd Squad Are Either Dead Or Not In The Pickup Zone", 15 )
	end	
end

function SEF_USACETeam2_SetupConstruction(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()
	
	--Check USACE 2nd Squad 
	if ( USACETeam2:IsLoadedInCarrier(TransPlayerUnit) == true and GROUP:FindByName(USACETeam2:GetObjectName()):GetSize() > 0 and USACETeam2:IsLoaded() == true ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == false ) then
			--Check Client Is Stationary On The Ground
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 ) then
								
				local ZonePointVec2 = TransPlayerUnit:GetPointVec2()								
				local x = ZonePointVec2:GetLat() 
				local y = ZonePointVec2:GetLon() 
				local offsety = y + 25
				local TeamSpawnPointVec2 = POINT_VEC2:New( x, offsety )								
																	
				USACETeam2:UnLoad(TeamSpawnPointVec2)							
				trigger.action.outTextForGroup(HeloGroupID, "USACE 2nd Squad Is Disembarking From "..TransClientUnitName, 15 )
				TransPlayerUnit:RemoveCargo(USACETeam2)							
				timer.scheduleFunction(SEF_USACETeam2_SetConstructionZone, 53, timer.getTime() + 2)														
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Not Stationary On The Ground",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Does Not Have The USACE 2nd Squad On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "USACE 2nd Squad Is Either Dead Or Not Loaded On "..TransClientUnitName, 15 )
	end		
end

function SEF_USACETeam2_Extraction(_Args)		
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()		
		
	--Check USACE Team
	if ( GROUP:FindByName(USACETeam2:GetObjectName()):GetSize() > 0 and GROUP:FindByName(USACETeam2:GetObjectName()):IsInZone(USACETeam2ConstructionZone) == true and USACETeam2:IsLoaded() == false ) then
		--Check Client's Cargo Hold
		if ( TransPlayerUnit:IsCargoEmpty() == true ) then	
			--Check Client Is Stationary On The Ground And In Extraction Zone
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 and TransPlayerUnit:IsInZone(USACETeam2ConstructionZone) == true ) then
				USACETeam2:Load( TransPlayerUnit )
				trigger.action.outTextForGroup(HeloGroupID, "USACE 2nd Squad Has Boarded "..TransClientUnitName, 15 )
				TransPlayerUnit:AddCargo(USACETeam2)			
				USACETeam2ConstructionZone = nil
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Is Not Stationary On The Ground In The Extraction Zone",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Already Has Cargo On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, "USACE 2nd Squad Are Either Dead Or Not In The Extraction Zone", 15 )
	end	
end

--END ENGINEERS
--------------------------------------------------------------------------------------------------------------------------------------------------
--CARGO CONTAINERS

function SEF_CARGO_UPDATECRATETABLE()

	local TempTable = {}
	local TempTableCounter = 1

	for x, Crate in pairs(CargoContainerTable) do					
		if ( Crate:IsAlive() == true and Crate:IsDestroyed() ~= true ) then								
			TempTable[TempTableCounter] = Crate
			TempTableCounter = TempTableCounter + 1
		end	
	end
	
	--trigger.action.outText("Temp table has "..#TempTable.." Elements", 15)
	CargoContainerTable = {}
	CargoContainerTable = TempTable
	--trigger.action.outText("Container table has "..#CargoContainerTable.." Elements", 15)	
end

function SEF_CARGO_COUNTCRATESINCONSTRUCTIONZONE(Zone)
	
	local ZoneCrateCount = 0
	
	if ( Zone ~= nil ) then		
		
		SEF_CARGO_UPDATECRATETABLE()
		
		for x, Crate in pairs(CargoContainerTable) do
			ZoneCargoObject = CARGO:FindByName(Crate.Name)
						
			if ( ZoneCargoObject:IsInZone(Zone) == true and ZoneCargoObject:IsLoaded() == false ) then					
				ZoneCrateCount = ZoneCrateCount + 1
				--trigger.action.outText(Crate.Name.." Is Inside The Construction Zone", 15)
			end	
		end	
		--trigger.action.outText("There Are "..ZoneCrateCount.." Crates Inside The Construction Zone", 15)
		return ZoneCrateCount
	else
		--trigger.action.outText("The Construction Zone You Have Queried Does Not Currently Exist", 15)
		return ZoneCrateCount
	end
end

function SEF_CARGO_GETNEARESTCARGOZONE(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()
	local TransPlayerUnitCoord = TransPlayerUnit:GetCoordinate()
	local PlayerDistanceToZone = nil
	local CargoContainerSpawnZone = nil	
	
	for i = 1, #CargoContainerPickupZone do
		local CargoZoneCandidate = ZONE:FindByName(CargoContainerPickupZone[i].ZoneName)
		local CargoZoneCoord = CargoZoneCandidate:GetCoordinate()
		local PlayerDistanceToZoneTest = TransPlayerUnitCoord:Get2DDistance(CargoZoneCoord)
		
		--trigger.action.outText("Distance from unit "..TransClientUnitName.." To "..CargoContainerPickupZone[i].ZoneName.." Is "..PlayerDistanceToZoneTest,15)
				
		if ( PlayerDistanceToZone == nil ) then
			--Select this zone
			PlayerDistanceToZone = PlayerDistanceToZoneTest
			CargoContainerSpawnZone = CargoContainerPickupZone[i].ZoneName			
		elseif ( PlayerDistanceToZoneTest <= PlayerDistanceToZone ) then
			--Select this zone
			PlayerDistanceToZone = PlayerDistanceToZoneTest
			CargoContainerSpawnZone = CargoContainerPickupZone[i].ZoneName			
		else
			--Continue looking for a closer zone
		end		
	end	
	
	--trigger.action.outText("Nearest Cargo Zone To "..TransClientUnitName.." Is "..CargoContainerSpawnZone.." Distance "..PlayerDistanceToZone,15)

	return CargoContainerSpawnZone
end


function SEF_CARGO_SPAWN(_Args)
	
	SEF_CARGO_UPDATECRATETABLE()
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]
		
	local CargoZoneName = SEF_CARGO_GETNEARESTCARGOZONE({ HeloGroupID, HeloGroupName })
		
	--trigger.action.outTextForGroup(HeloGroupID, "Nearest Cargo Loading Zone Is "..CargoZoneName,15)
		
	if ( #CargoContainerTable >= CargoContainerMaximumCrates ) then
		trigger.action.outTextForGroup(HeloGroupID, "We Have Reached The Maximum Amount Of Cargo Containers Available For Requisition, We Cannot Provide More Containers Right Now", 15)
	else
		ContainerID = CargoContainerNumber + 1
		CargoContainerNextElement = #CargoContainerTable + 1
		
		--local ZonePointVec2 = CargoContainerPickupZone:GetPointVec2()
		local ZonePointVec2 = ZONE:FindByName(CargoZoneName):GetPointVec2()
		local x = ZonePointVec2:GetLat()
		local y = ZonePointVec2:GetLon()
		local offsety = y + ( CargoContainerNextElement * 2.5 )
		local CrateSpawnPointVec2 = POINT_VEC2:New( x, offsety )		
		
		CargoContainer = CARGO_CRATE:New(SPAWNSTATIC:NewFromStatic( "Cargo Container", country.id.USA ):SpawnFromPointVec2( CrateSpawnPointVec2, 0, "Cargo Container "..ContainerID), "Cargo Container "..ContainerID,"Cargo Container "..ContainerID,1000)
		CargoContainerTable[CargoContainerNextElement] = CargoContainer
		CargoContainerNumber = CargoContainerNumber + 1
		trigger.action.outTextForGroup(HeloGroupID, "Cargo Container "..CargoContainer.Name.." Is Ready At "..CargoZoneName, 15)
		
		SEF_CARGO_UPDATECRATETABLE()
	end		
end

function SEF_CARGO_GETNEARESTCONTAINER(_Args)
	
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()
	local TransPlayerUnitCoord = TransPlayerUnit:GetCoordinate()
	local PlayerDistanceToCargo = nil
	local NearestCargoObject = nil
	
	for x, y in pairs(CargoContainerTable) do
		local CargoObject = y
		
		if ( CargoObject:IsLoaded() == false ) then
		
			local CargoObjectName = CargoObject.Name
			local CrateCoord = CargoObject:GetCoordinate()
			local PlayerDistanceToCargoTest = TransPlayerUnitCoord:Get2DDistance(CrateCoord)
		
			if ( PlayerDistanceToCargo == nil ) then
				PlayerDistanceToCargo = PlayerDistanceToCargoTest
				NearestCargoObject = CargoObject
			elseif ( PlayerDistanceToCargoTest <= PlayerDistanceToCargo ) then
				PlayerDistanceToCargo = PlayerDistanceToCargoTest
				NearestCargoObject = CargoObject
			else
				--Continue looking for nearest container
			end
		end	
	end
	
	if NearestCargoObject ~= nil then
		--trigger.action.outTextForGroup(HeloGroupID, "Nearest Container Is "..NearestCargoObject.Name, 15)
		return NearestCargoObject
	else
		trigger.action.outTextForGroup(HeloGroupID, "No Containers To Evaluate", 15)
		return nil
	end	
end

function SEF_CARGO_LOAD(_Args)

	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()		
	
	SEF_CARGO_UPDATECRATETABLE()
	
	local NearestContainer = SEF_CARGO_GETNEARESTCONTAINER({ HeloGroupID, HeloGroupName })
	
	if ( NearestContainer ~= nil ) then
		if ( TransPlayerUnit:IsCargoEmpty() == true ) then
			if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 ) then --and TransPlayerUnit:IsInZone(CargoContainerPickupZone) == true or PlayerDistanceToCargo <= 100
				
				local CargoObject = NearestContainer
				local CargoObjectName = CargoObject.Name				
				
				local TransPlayerUnitCoord = TransPlayerUnit:GetCoordinate()
				local CrateCoord = CargoObject:GetCoordinate()
				local PlayerDistanceToCargo = TransPlayerUnitCoord:Get2DDistance(CrateCoord) 			
				
				if ( PlayerDistanceToCargo <= 100 ) then
					CargoObject:Load( TransPlayerUnit, 10 )
					TransPlayerUnit:AddCargo(CargoObject)																	
					trigger.action.outTextForGroup(HeloGroupID, CargoObjectName.." Loaded Onto "..TransClientUnitName, 15 )
								
					local CargoWeight = CargoContainerWeight
									
					if ( HeloWeightingEnabled == true ) then
						trigger.action.setUnitInternalCargo(TransClientUnitName, CargoWeight )
					end
				else
					trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." You Must Be Within 100m From The Container To Load It",15)		
				end								
			else
				trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." You Must Be Stationary On The Ground To Load A Container",15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Already Has Cargo On Board",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." There Are No Cargo Containers Nearby",15)
	end		
end

function SEF_CARGO_UNLOAD(_Args)
		
	local HeloGroupID 	= _Args[1]
	local HeloGroupName = _Args[2]		
	local TransPlayerUnit = UNIT:FindByName(HeloGroupName)
	local TransClientUnitName = TransPlayerUnit:GetName()	
	
	if ( TransPlayerUnit:IsCargoEmpty() == false ) then							
		if ( TransPlayerUnit:InAir() == false and TransPlayerUnit:GetVelocityKMH() < 8 ) then
							
			SEF_CARGO_UPDATECRATETABLE()
					
			for x, y in pairs(CargoContainerTable) do
				local CargoObject = y
				local CargoObjectName = CargoObject.Name							
							
				if ( CargoObject:IsLoadedInCarrier(TransPlayerUnit) == true ) then
																	
					local ZonePointVec2 = TransPlayerUnit:GetPointVec2()		
					local x = ZonePointVec2:GetLat()
					local y = ZonePointVec2:GetLon()
					local offsety = y + 25
					local CrateSpawnPointVec2 = POINT_VEC2:New( x, offsety )
								
					CargoObject:UnLoad( CrateSpawnPointVec2)
					TransPlayerUnit:RemoveCargo(CargoObject)																	
					trigger.action.outTextForGroup(HeloGroupID, CargoObjectName.." Unloaded From "..TransClientUnitName, 15 )

					local CargoWeight = 0
					
					if ( HeloWeightingEnabled == true ) then
                        trigger.action.setUnitInternalCargo(TransClientUnitName, CargoWeight )
                    end		
				end	
			end													
		else
			trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." You Must Be Stationary On The Ground To Unload A Container",15)
		end
	else
		trigger.action.outTextForGroup(HeloGroupID, TransClientUnitName.." Does Not Have Cargo On Board",15)
	end
end

function SEF_CARGO_PickupZoneSmokeLock()
	CargoContainerSmokeLockout = 1
end

function SEF_CARGO_PickupZoneSmokeUnlock()
	CargoContainerSmokeLockout = 0
end

function SEF_CARGO_SmokePickupZones()
	
	if ( CargoContainerSmokeLockout == 0 ) then		
		for i = 1, #CargoContainerPickupZone do
			local CARGOPickupZoneCoord = ZONE:FindByName(CargoContainerPickupZone[i].ZoneName):GetCoordinate()
			CARGOPickupZoneCoord:SmokeGreen()
			SEF_CARGO_PickupZoneSmokeLock()
			timer.scheduleFunction(SEF_CARGO_PickupZoneSmokeUnlock, 53, timer.getTime() + 300)		
		end
		
		trigger.action.outText( "Cargo Loading Zones Have Been Marked With Green Smoke", 15 )		
	else
		trigger.action.outText( "Cargo Loading Zones Are Already Smoked", 15 )
	end
end

--END CARGO CONTAINERS
--------------------------------------------------------------------------------------------------------------------------------------------------
--////CONSTRUCTION ITEMS

function SEF_USACEM818_SPAWN(Vec2Point)	
	USACEM818:SpawnFromVec2(Vec2Point)
	trigger.action.outText("The M818 Ammunition Truck You Requisitioned Is Ready Now", 15)
end

function SEF_BUILD_M818(_Args)

	SEF_USACE_UPDATEM818TABLE()
	
	local HeloGroupID 			= _Args[1]
	local HeloGroupName 		= _Args[2]
	local ConstructionTeamName 	= USACE1GROUPNAME
	local ConstructionZone 		= USACETeam1ConstructionZone				
	local TransPlayerUnit 		= UNIT:FindByName(HeloGroupName)
	local TransClientUnitName 	= TransPlayerUnit:GetName()	
		
	if ( #USACEM818Table >= USACEM818MaximumTrucks ) then
		trigger.action.outTextForGroup(HeloGroupID, "We Have Reached The Maximum Amount Of M818 Trucks Available For Requisition, No More Can Be Constructed At This Time", 15)
	else	
		if ( ConstructionTeamName ~= nil and ConstructionZone ~= nil ) then	
			if ( GROUP:FindByName(ConstructionTeamName) ) then
				if ( GROUP:FindByName(USACETeam1:GetObjectName()):IsInZone(ConstructionZone) == true ) then
				
					local CrateCount = SEF_CARGO_COUNTCRATESINCONSTRUCTIONZONE(ConstructionZone)
					
					if ( CrateCount >= USACEM818RequiredCrates ) then						
						--Consume Crates And Spawn The M818											
						local DestroyedCrateCount = 0
						for x, Crate in pairs(CargoContainerTable) do
							ZoneCargoObject = CARGO:FindByName(Crate.Name)								
							if ( ZoneCargoObject:IsInZone(ConstructionZone) == true and ZoneCargoObject:IsLoaded() == false ) then							
								if ( DestroyedCrateCount < USACEM818RequiredCrates ) then
									--trigger.action.outText(Crate.Name.." Is Inside The Construction Zone And Will Be Consumed", 15)
									StaticObject.getByName(Crate.Name):destroy()
									DestroyedCrateCount = DestroyedCrateCount + 1
								end
							end	
						end						
						
						SEF_CARGO_UPDATECRATETABLE()
						
						--////Spawn The M818															
						local ConstructionTeamVec2 = GROUP:FindByName(USACETeam1:GetObjectName()):GetCoordinate():GetVec2()
						local SpawnX = ConstructionTeamVec2.x + 25
						local SpawnY = ConstructionTeamVec2.y + 25				
						local ConstructionZoneSpawnPointVec2 = { x = SpawnX, y = SpawnY }				
						trigger.action.outTextForGroup(HeloGroupID, "We're Unpacking The Containers Now, Give Us A Minute To Get This Done", 15)					
						timer.scheduleFunction(SEF_USACEM818_SPAWN, ConstructionZoneSpawnPointVec2, timer.getTime() + USACEM818BuildTime)														
					else
						trigger.action.outTextForGroup(HeloGroupID, "We Need More Resources To Construct An M818, We Have "..CrateCount.." Crates And Require "..USACEM818RequiredCrates.." Crates To Build It", 15)
					end		
				else
					trigger.action.outTextForGroup(HeloGroupID, "There Are No USACE Engineers In The Construction Zone", 15)
				end	
			else
				trigger.action.outTextForGroup(HeloGroupID, ConstructionTeamName.." Is Not Currently Active", 15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, "Either The Engineering Team Is Dead Or A Construction Zone Is Not Set", 15)
		end		
	end	
end

function SEF_BUILD_M818_2(_Args)

	SEF_USACE_UPDATEM818TABLE()
	
	local HeloGroupID 			= _Args[1]
	local HeloGroupName 		= _Args[2]
	local ConstructionTeamName 	= USACE2GROUPNAME
	local ConstructionZone 		= USACETeam2ConstructionZone				
	local TransPlayerUnit 		= UNIT:FindByName(HeloGroupName)
	local TransClientUnitName 	= TransPlayerUnit:GetName()	
		
	if ( #USACEM818Table >= USACEM818MaximumTrucks ) then
		trigger.action.outTextForGroup(HeloGroupID, "We Have Reached The Maximum Amount Of M818 Trucks Available For Requisition, No More Can Be Constructed At This Time", 15)
	else	
		if ( ConstructionTeamName ~= nil and ConstructionZone ~= nil ) then	
			if ( GROUP:FindByName(ConstructionTeamName) ) then
				if ( GROUP:FindByName(USACETeam2:GetObjectName()):IsInZone(ConstructionZone) == true ) then
				
					local CrateCount = SEF_CARGO_COUNTCRATESINCONSTRUCTIONZONE(ConstructionZone)
					
					if ( CrateCount >= USACEM818RequiredCrates ) then
						
						--Consume Crates And Spawn The M818
						local DestroyedCrateCount = 0
						for x, Crate in pairs(CargoContainerTable) do
							ZoneCargoObject = CARGO:FindByName(Crate.Name)								
							if ( ZoneCargoObject:IsInZone(ConstructionZone) == true and ZoneCargoObject:IsLoaded() == false ) then							
								if ( DestroyedCrateCount < USACEM818RequiredCrates ) then
									--trigger.action.outText(Crate.Name.." Is Inside The Construction Zone And Will Be Consumed", 15)
									StaticObject.getByName(Crate.Name):destroy()
									DestroyedCrateCount = DestroyedCrateCount + 1
								end
							end	
						end
						
						SEF_CARGO_UPDATECRATETABLE()
						
						--////Spawn The M818															
						local ConstructionTeamVec2 = GROUP:FindByName(USACETeam2:GetObjectName()):GetCoordinate():GetVec2()
						local SpawnX = ConstructionTeamVec2.x + 25
						local SpawnY = ConstructionTeamVec2.y + 25				
						local ConstructionZoneSpawnPointVec2 = { x = SpawnX, y = SpawnY }				
						trigger.action.outTextForGroup(HeloGroupID, "We're Unpacking The Containers Now, Give Us A Minute To Get This Done", 15)					
						timer.scheduleFunction(SEF_USACEM818_SPAWN, ConstructionZoneSpawnPointVec2, timer.getTime() + USACEM818BuildTime)														
					else
						trigger.action.outTextForGroup(HeloGroupID, "We Need More Resources To Construct An M818, We Have "..CrateCount.." Crates And Require "..USACEM818RequiredCrates.." Crates To Build It", 15)
					end		
				else
					trigger.action.outTextForGroup(HeloGroupID, "There Are No USACE Engineers In The Construction Zone", 15)
				end	
			else
				trigger.action.outTextForGroup(HeloGroupID, ConstructionTeamName.." Is Not Currently Active", 15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, "Either The Engineering Team Is Dead Or A Construction Zone Is Not Set", 15)
		end		
	end	
end

function SEF_USACE_UPDATEM818TABLE()

	local TempTable = {}
	local TempTableCounter = 1

	for x, M818 in pairs(USACEM818Table) do					
		if ( GROUP:FindByName(M818) ) then
			if ( GROUP:FindByName(M818):IsAlive() == true ) then								
				TempTable[TempTableCounter] = M818
				TempTableCounter = TempTableCounter + 1
			end
		end	
	end
	
	--trigger.action.outText("Temp table has "..#TempTable.." Elements", 15)
	USACEM818Table = {}
	USACEM818Table = TempTable
	--trigger.action.outText("USACEM818 Table Has "..#USACEM818Table.." Elements", 15)	
end

function SEF_USACE_UPDATEHAWKTABLE()

	local TempTable = {}
	local TempTableCounter = 1

	for x, Hawk in pairs(USACEHAWKTable) do					
		if ( GROUP:FindByName(Hawk) ) then
			if ( GROUP:FindByName(Hawk):IsAlive() == true ) then								
				TempTable[TempTableCounter] = Hawk
				TempTableCounter = TempTableCounter + 1
			end
		end	
	end
	
	--trigger.action.outText("Temp table has "..#TempTable.." Elements", 15)
	USACEHAWKTable = {}
	USACEHAWKTable = TempTable
	--trigger.action.outText("USACEM818 Table Has "..#USACEHAWKTable.." Elements", 15)	
end

function SEF_USACEHAWK_SPAWN(Vec2Point)	
	USACEHAWK:SpawnFromVec2(Vec2Point)
	trigger.action.outText("The Hawk System You Requisitioned Is Ready Now", 15)
end

function SEF_BUILD_HAWK(_Args)

	SEF_USACE_UPDATEHAWKTABLE()
			
	local HeloGroupID 			= _Args[1]
	local HeloGroupName 		= _Args[2]
	local ConstructionTeamName 	= USACE1GROUPNAME
	local ConstructionZone 		= USACETeam1ConstructionZone
	local TransPlayerUnit 		= UNIT:FindByName(HeloGroupName)
	local TransClientUnitName 	= TransPlayerUnit:GetName()	
		
	if ( #USACEHAWKTable >= USACEHawkMaximumSites ) then
		trigger.action.outTextForGroup(HeloGroupID, "We Have Reached The Maximum Amount Of Hawk Systems Available For Requisition, No More Can Be Constructed At This Time", 15)
	else	
		if ( ConstructionTeamName ~= nil and ConstructionZone ~= nil ) then
			if ( GROUP:FindByName(ConstructionTeamName) ) then
				if ( GROUP:FindByName(USACETeam1:GetObjectName()):IsInZone(ConstructionZone) == true ) then
					local CrateCount = SEF_CARGO_COUNTCRATESINCONSTRUCTIONZONE(ConstructionZone)
					
					if ( CrateCount >= USACEHawkRequiredCrates ) then
						
						--Consume Crates And Spawn The Hawk System
						local DestroyedCrateCount = 0
						for x, Crate in pairs(CargoContainerTable) do
							ZoneCargoObject = CARGO:FindByName(Crate.Name)								
							if ( ZoneCargoObject:IsInZone(ConstructionZone) == true and ZoneCargoObject:IsLoaded() == false ) then							
								if ( DestroyedCrateCount < USACEHawkRequiredCrates ) then
									--trigger.action.outText(Crate.Name.." Is Inside The Construction Zone And Will Be Consumed", 15)
									StaticObject.getByName(Crate.Name):destroy()
									DestroyedCrateCount = DestroyedCrateCount + 1
								end
							end	
						end
						
						SEF_CARGO_UPDATECRATETABLE()
						
						--////Spawn The Hawk System				
						local ConstructionTeamVec2 = GROUP:FindByName(USACETeam1:GetObjectName()):GetCoordinate():GetVec2()
						local SpawnX = ConstructionTeamVec2.x + 25
						local SpawnY = ConstructionTeamVec2.y + 25				
						local ConstructionZoneSpawnPointVec2 = { x = SpawnX, y = SpawnY }				
						trigger.action.outTextForGroup(HeloGroupID, "We're Unpacking The Containers Now, Give Us A Couple Of Minutes To Get This Done", 15)
						timer.scheduleFunction(SEF_USACEHAWK_SPAWN, ConstructionZoneSpawnPointVec2, timer.getTime() + USACEHawkBuildTime)								
					else
						trigger.action.outTextForGroup(HeloGroupID, "We Need More Resources To Construct A Hawk System, We Have "..CrateCount.." Crates And Require "..USACEHawkRequiredCrates.." Crates To Build It", 15)
					end		
				else
					trigger.action.outTextForGroup(HeloGroupID, "There Are No USACE Engineers In The Construction Zone", 15)
				end	
			else
				trigger.action.outTextForGroup(HeloGroupID, ConstructionTeamName.." Is Not Currently Active", 15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, "Either The Engineering Team Is Dead Or A Construction Zone Is Not Set", 15)
		end	
	end	
end

function SEF_BUILD_HAWK_2(_Args)

	SEF_USACE_UPDATEHAWKTABLE()
	
	local HeloGroupID 			= _Args[1]
	local HeloGroupName 		= _Args[2]
	local ConstructionTeamName 	= USACE2GROUPNAME
	local ConstructionZone 		= USACETeam2ConstructionZone
	local TransPlayerUnit 		= UNIT:FindByName(HeloGroupName)
	local TransClientUnitName 	= TransPlayerUnit:GetName()	
		
	if ( #USACEHAWKTable >= USACEHawkMaximumSites ) then
		trigger.action.outTextForGroup(HeloGroupID, "We Have Reached The Maximum Amount Of Hawk Systems Available For Requisition, No More Can Be Constructed At This Time", 15)
	else	
		if ( ConstructionTeamName ~= nil and ConstructionZone ~= nil ) then
			if ( GROUP:FindByName(ConstructionTeamName) ) then
				if ( GROUP:FindByName(USACETeam2:GetObjectName()):IsInZone(ConstructionZone) == true ) then
					local CrateCount = SEF_CARGO_COUNTCRATESINCONSTRUCTIONZONE(ConstructionZone)
					
					if ( CrateCount >= USACEHawkRequiredCrates ) then
						
						--Consume Crates And Spawn The Hawk System
						local DestroyedCrateCount = 0
						for x, Crate in pairs(CargoContainerTable) do
							ZoneCargoObject = CARGO:FindByName(Crate.Name)								
							if ( ZoneCargoObject:IsInZone(ConstructionZone) == true and ZoneCargoObject:IsLoaded() == false ) then							
								if ( DestroyedCrateCount < USACEHawkRequiredCrates ) then
									--trigger.action.outText(Crate.Name.." Is Inside The Construction Zone And Will Be Consumed", 15)
									StaticObject.getByName(Crate.Name):destroy()
									DestroyedCrateCount = DestroyedCrateCount + 1
								end
							end	
						end
						
						SEF_CARGO_UPDATECRATETABLE()
						
						--////Spawn The Hawk System				
						local ConstructionTeamVec2 = GROUP:FindByName(USACETeam2:GetObjectName()):GetCoordinate():GetVec2()
						local SpawnX = ConstructionTeamVec2.x + 25
						local SpawnY = ConstructionTeamVec2.y + 25				
						local ConstructionZoneSpawnPointVec2 = { x = SpawnX, y = SpawnY }				
						trigger.action.outTextForGroup(HeloGroupID, "We're Unpacking The Containers Now, Give Us A Couple Of Minutes To Get This Done", 15)
						timer.scheduleFunction(SEF_USACEHAWK_SPAWN, ConstructionZoneSpawnPointVec2, timer.getTime() + USACEHawkBuildTime)								
					else
						trigger.action.outTextForGroup(HeloGroupID, "We Need More Resources To Construct A Hawk System, We Have "..CrateCount.." Crates And Require "..USACEHawkRequiredCrates.." Crates To Build It", 15)
					end		
				else
					trigger.action.outTextForGroup(HeloGroupID, "There Are No USACE Engineers In The Construction Zone", 15)
				end	
			else
				trigger.action.outTextForGroup(HeloGroupID, ConstructionTeamName.." Is Not Currently Active", 15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, "Either The Engineering Team Is Dead Or A Construction Zone Is Not Set", 15)
		end	
	end	
end

function SEF_USACE_UPDATEROLANDTABLE()

	local TempTable = {}
	local TempTableCounter = 1

	for x, Roland in pairs(USACEROLANDTable) do					
		if ( GROUP:FindByName(Roland) ) then
			if ( GROUP:FindByName(Roland):IsAlive() == true ) then								
				TempTable[TempTableCounter] = Roland
				TempTableCounter = TempTableCounter + 1
			end
		end	
	end
	
	--trigger.action.outText("Temp table has "..#TempTable.." Elements", 15)
	USACEROLANDTable = {}
	USACEROLANDTable = TempTable
	--trigger.action.outText("USACEM818 Table Has "..#USACEROLANDTable.." Elements", 15)	
end

function SEF_USACEROLAND_SPAWN(Vec2Point)	
	USACEROLAND:SpawnFromVec2(Vec2Point)
	trigger.action.outText("The Roland ADS System You Requisitioned Is Ready Now", 15)
end

function SEF_BUILD_ROLAND(_Args)

	SEF_USACE_UPDATEROLANDTABLE()
			
	local HeloGroupID 			= _Args[1]
	local HeloGroupName 		= _Args[2]
	local ConstructionTeamName 	= USACE1GROUPNAME
	local ConstructionZone 		= USACETeam1ConstructionZone	
	local TransPlayerUnit 		= UNIT:FindByName(HeloGroupName)
	local TransClientUnitName 	= TransPlayerUnit:GetName()	
	
	if ( #USACEROLANDTable >= USACERolandMaximumUnits ) then
		trigger.action.outTextForGroup(HeloGroupID, "We Have Reached The Maximum Amount Of Roland ADS Systems Available For Requisition, No More Can Be Constructed At This Time", 15)
	else	
		if ( ConstructionTeamName ~= nil and ConstructionZone ~= nil ) then
			if ( GROUP:FindByName(ConstructionTeamName) ) then
				if ( GROUP:FindByName(USACETeam1:GetObjectName()):IsInZone(ConstructionZone) == true ) then
					local CrateCount = SEF_CARGO_COUNTCRATESINCONSTRUCTIONZONE(ConstructionZone)
					
					if ( CrateCount >= USACERolandRequiredCrates ) then
						
						--Consume Crates And Spawn The Roland ADS System
						local DestroyedCrateCount = 0
						for x, Crate in pairs(CargoContainerTable) do
							ZoneCargoObject = CARGO:FindByName(Crate.Name)								
							if ( ZoneCargoObject:IsInZone(ConstructionZone) == true and ZoneCargoObject:IsLoaded() == false ) then							
								if ( DestroyedCrateCount < USACERolandRequiredCrates ) then
									--trigger.action.outText(Crate.Name.." Is Inside The Construction Zone And Will Be Consumed", 15)
									StaticObject.getByName(Crate.Name):destroy()
									DestroyedCrateCount = DestroyedCrateCount + 1
								end
							end	
						end					
						
						SEF_CARGO_UPDATECRATETABLE()
						
						--////Spawn The Hawk System				
						local ConstructionTeamVec2 = GROUP:FindByName(USACETeam1:GetObjectName()):GetCoordinate():GetVec2()
						local SpawnX = ConstructionTeamVec2.x + 25
						local SpawnY = ConstructionTeamVec2.y + 25				
						local ConstructionZoneSpawnPointVec2 = { x = SpawnX, y = SpawnY }				
						trigger.action.outTextForGroup(HeloGroupID, "We're Unpacking The Containers Now, Give Us A Couple Of Minutes To Get This Done", 15)
						timer.scheduleFunction(SEF_USACEROLAND_SPAWN, ConstructionZoneSpawnPointVec2, timer.getTime() + USACERolandBuildTime)								
					else
						trigger.action.outTextForGroup(HeloGroupID, "We Need More Resources To Construct A Roland ADS System, We Have "..CrateCount.." Crates And Require "..USACERolandRequiredCrates.." Crates To Build It", 15)
					end		
				else
					trigger.action.outTextForGroup(HeloGroupID, "There Are No USACE Engineers In The Construction Zone", 15)
				end	
			else
				trigger.action.outTextForGroup(HeloGroupID, ConstructionTeamName.." Is Not Currently Active", 15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, "Either The Engineering Team Is Dead Or A Construction Zone Is Not Set", 15)
		end		
	end		
end

function SEF_BUILD_ROLAND_2(_Args)

	SEF_USACE_UPDATEROLANDTABLE()
	
	local HeloGroupID 			= _Args[1]
	local HeloGroupName 		= _Args[2]
	local ConstructionTeamName 	= USACE2GROUPNAME
	local ConstructionZone 		= USACETeam2ConstructionZone	
	local TransPlayerUnit 		= UNIT:FindByName(HeloGroupName)
	local TransClientUnitName 	= TransPlayerUnit:GetName()	
	
	if ( #USACEROLANDTable >= USACERolandMaximumUnits ) then
		trigger.action.outTextForGroup(HeloGroupID, "We Have Reached The Maximum Amount Of Roland ADS Systems Available For Requisition, No More Can Be Constructed At This Time", 15)
	else	
		if ( ConstructionTeamName ~= nil and ConstructionZone ~= nil ) then
			if ( GROUP:FindByName(ConstructionTeamName) ) then
				if ( GROUP:FindByName(USACETeam2:GetObjectName()):IsInZone(ConstructionZone) == true ) then
					local CrateCount = SEF_CARGO_COUNTCRATESINCONSTRUCTIONZONE(ConstructionZone)
					
					if ( CrateCount >= USACERolandRequiredCrates ) then
						
						--Consume Crates And Spawn The Roland ADS System
						local DestroyedCrateCount = 0
						for x, Crate in pairs(CargoContainerTable) do
							ZoneCargoObject = CARGO:FindByName(Crate.Name)								
							if ( ZoneCargoObject:IsInZone(ConstructionZone) == true and ZoneCargoObject:IsLoaded() == false ) then							
								if ( DestroyedCrateCount < USACERolandRequiredCrates ) then
									--trigger.action.outText(Crate.Name.." Is Inside The Construction Zone And Will Be Consumed", 15)
									StaticObject.getByName(Crate.Name):destroy()
									DestroyedCrateCount = DestroyedCrateCount + 1
								end
							end	
						end							
						
						SEF_CARGO_UPDATECRATETABLE()
						
						--////Spawn The Hawk System				
						local ConstructionTeamVec2 = GROUP:FindByName(USACETeam2:GetObjectName()):GetCoordinate():GetVec2()
						local SpawnX = ConstructionTeamVec2.x + 25
						local SpawnY = ConstructionTeamVec2.y + 25				
						local ConstructionZoneSpawnPointVec2 = { x = SpawnX, y = SpawnY }				
						trigger.action.outTextForGroup(HeloGroupID, "We're Unpacking The Containers Now, Give Us A Couple Of Minutes To Get This Done", 15)
						timer.scheduleFunction(SEF_USACEROLAND_SPAWN, ConstructionZoneSpawnPointVec2, timer.getTime() + USACERolandBuildTime)								
					else
						trigger.action.outTextForGroup(HeloGroupID, "We Need More Resources To Construct A Roland ADS System, We Have "..CrateCount.." Crates And Require "..USACERolandRequiredCrates.." Crates To Build It", 15)
					end		
				else
					trigger.action.outTextForGroup(HeloGroupID, "There Are No USACE Engineers In The Construction Zone", 15)
				end	
			else
				trigger.action.outTextForGroup(HeloGroupID, ConstructionTeamName.." Is Not Currently Active", 15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, "Either The Engineering Team Is Dead Or A Construction Zone Is Not Set", 15)
		end		
	end		
end

function SEF_USACE_UPDATEM1A2ABRAMSTABLE()

	local TempTable = {}
	local TempTableCounter = 1

	for x, Abrams in pairs(USACEM1A2ABRAMSTable) do					
		if ( GROUP:FindByName(Abrams) ) then
			if ( GROUP:FindByName(Abrams):IsAlive() == true ) then								
				TempTable[TempTableCounter] = Abrams
				TempTableCounter = TempTableCounter + 1
			end
		end	
	end
	
	--trigger.action.outText("Temp table has "..#TempTable.." Elements", 15)
	USACEM1A2ABRAMSTable = {}
	USACEM1A2ABRAMSTable = TempTable
	--trigger.action.outText("USACEM1A2ABRAMS Table Has "..#USACEM1A2ABRAMSTable.." Elements", 15)	
end

function SEF_USACEM1A2ABRAMS_SPAWN(Vec2Point)	
	USACEM1A2ABRAMS:SpawnFromVec2(Vec2Point)
	trigger.action.outText("The M1A2 Abrams Tank You Requisitioned Is Ready Now", 15)
end

function SEF_BUILD_M1A2ABRAMS(_Args)

	SEF_USACE_UPDATEM1A2ABRAMSTABLE()
			
	local HeloGroupID 			= _Args[1]
	local HeloGroupName 		= _Args[2]
	local ConstructionTeamName 	= USACE1GROUPNAME
	local ConstructionZone 		= USACETeam1ConstructionZone
	local TransPlayerUnit 		= UNIT:FindByName(HeloGroupName)
	local TransClientUnitName 	= TransPlayerUnit:GetName()
		
	if ( #USACEM1A2ABRAMSTable >= USACEM1A2AbramsMaximumUnits ) then
		trigger.action.outTextForGroup(HeloGroupID, "We Have Reached The Maximum Amount Of M1A2 Abrams Tanks Available For Requisition, No More Can Be Constructed At This Time", 15)
	else	
		if ( ConstructionTeamName ~= nil and ConstructionZone ~= nil ) then
			if ( GROUP:FindByName(ConstructionTeamName) ) then
				if ( GROUP:FindByName(USACETeam1:GetObjectName()):IsInZone(ConstructionZone) == true ) then
					local CrateCount = SEF_CARGO_COUNTCRATESINCONSTRUCTIONZONE(ConstructionZone)
					
					if ( CrateCount >= USACEM1A2AbramsRequiredCrates ) then
						
						--Consume Crates And Spawn The Abrams Tank
						local DestroyedCrateCount = 0
						for x, Crate in pairs(CargoContainerTable) do
							ZoneCargoObject = CARGO:FindByName(Crate.Name)								
							if ( ZoneCargoObject:IsInZone(ConstructionZone) == true and ZoneCargoObject:IsLoaded() == false ) then							
								if ( DestroyedCrateCount < USACEM1A2AbramsRequiredCrates ) then
									--trigger.action.outText(Crate.Name.." Is Inside The Construction Zone And Will Be Consumed", 15)
									StaticObject.getByName(Crate.Name):destroy()
									DestroyedCrateCount = DestroyedCrateCount + 1
								end
							end	
						end							
						
						SEF_CARGO_UPDATECRATETABLE()
						
						--////Spawn The Hawk System				
						local ConstructionTeamVec2 = GROUP:FindByName(USACETeam1:GetObjectName()):GetCoordinate():GetVec2()
						local SpawnX = ConstructionTeamVec2.x + 25
						local SpawnY = ConstructionTeamVec2.y + 25				
						local ConstructionZoneSpawnPointVec2 = { x = SpawnX, y = SpawnY }				
						trigger.action.outTextForGroup(HeloGroupID, "We're Unpacking The Containers Now, Give Us A Couple Of Minutes To Get This Done", 15)
						timer.scheduleFunction(SEF_USACEM1A2ABRAMS_SPAWN, ConstructionZoneSpawnPointVec2, timer.getTime() + USACEM1A2AbramsBuildTime)								
					else
						trigger.action.outTextForGroup(HeloGroupID, "We Need More Resources To Construct An M1A2 Abrams Tank, We Have "..CrateCount.." Crates And Require "..USACEM1A2AbramsRequiredCrates.." Crates To Build It", 15)
					end		
				else
					trigger.action.outTextForGroup(HeloGroupID, "There Are No USACE Engineers In The Construction Zone", 15)
				end	
			else
				trigger.action.outTextForGroup(HeloGroupID, ConstructionTeamName.." Is Not Currently Active", 15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, "Either The Engineering Team Is Dead Or A Construction Zone Is Not Set", 15)
		end	
	end		
end

function SEF_BUILD_M1A2ABRAMS_2(_Args)

	SEF_USACE_UPDATEM1A2ABRAMSTABLE()
	
	local HeloGroupID 			= _Args[1]
	local HeloGroupName 		= _Args[2]
	local ConstructionTeamName 	= USACE2GROUPNAME
	local ConstructionZone 		= USACETeam2ConstructionZone
	local TransPlayerUnit 		= UNIT:FindByName(HeloGroupName)
	local TransClientUnitName 	= TransPlayerUnit:GetName()
		
	if ( #USACEM1A2ABRAMSTable >= USACEM1A2AbramsMaximumUnits ) then
		trigger.action.outTextForGroup(HeloGroupID, "We Have Reached The Maximum Amount Of M1A2 Abrams Tanks Available For Requisition, No More Can Be Constructed At This Time", 15)
	else	
		if ( ConstructionTeamName ~= nil and ConstructionZone ~= nil ) then
			if ( GROUP:FindByName(ConstructionTeamName) ) then
				if ( GROUP:FindByName(USACETeam2:GetObjectName()):IsInZone(ConstructionZone) == true ) then
					local CrateCount = SEF_CARGO_COUNTCRATESINCONSTRUCTIONZONE(ConstructionZone)
					
					if ( CrateCount >= USACEM1A2AbramsRequiredCrates ) then
						
						--Consume Crates And Spawn The Abrams Tank
						local DestroyedCrateCount = 0
						for x, Crate in pairs(CargoContainerTable) do
							ZoneCargoObject = CARGO:FindByName(Crate.Name)								
							if ( ZoneCargoObject:IsInZone(ConstructionZone) == true and ZoneCargoObject:IsLoaded() == false ) then							
								if ( DestroyedCrateCount < USACEM1A2AbramsRequiredCrates ) then
									--trigger.action.outText(Crate.Name.." Is Inside The Construction Zone And Will Be Consumed", 15)
									StaticObject.getByName(Crate.Name):destroy()
									DestroyedCrateCount = DestroyedCrateCount + 1
								end
							end	
						end					
						
						SEF_CARGO_UPDATECRATETABLE()
						
						--////Spawn The Hawk System				
						local ConstructionTeamVec2 = GROUP:FindByName(USACETeam2:GetObjectName()):GetCoordinate():GetVec2()
						local SpawnX = ConstructionTeamVec2.x + 25
						local SpawnY = ConstructionTeamVec2.y + 25				
						local ConstructionZoneSpawnPointVec2 = { x = SpawnX, y = SpawnY }				
						trigger.action.outTextForGroup(HeloGroupID, "We're Unpacking The Containers Now, Give Us A Couple Of Minutes To Get This Done", 15)
						timer.scheduleFunction(SEF_USACEM1A2ABRAMS_SPAWN, ConstructionZoneSpawnPointVec2, timer.getTime() + USACEM1A2AbramsBuildTime)								
					else
						trigger.action.outTextForGroup(HeloGroupID, "We Need More Resources To Construct An M1A2 Abrams Tank, We Have "..CrateCount.." Crates And Require "..USACEM1A2AbramsRequiredCrates.." Crates To Build It", 15)
					end		
				else
					trigger.action.outTextForGroup(HeloGroupID, "There Are No USACE Engineers In The Construction Zone", 15)
				end	
			else
				trigger.action.outTextForGroup(HeloGroupID, ConstructionTeamName.." Is Not Currently Active", 15)
			end
		else
			trigger.action.outTextForGroup(HeloGroupID, "Either The Engineering Team Is Dead Or A Construction Zone Is Not Set", 15)
		end	
	end		
end

--END CONSTRUCTION ITEMS
--------------------------------------------------------------------------------------------------------------------------------------------------
--////Menu

function SEF_SetupHeloMenu(HeloGroupID, HeloGroupName)
	
	--trigger.action.outText("Helo Menu Setup For Group ID "..HeloGroupID.." Group Name "..HeloGroupName, 15)
	
	--First Clear The Menu So It Doesn't Duplicate If They Respawned
	missionCommands.removeItemForGroup(HeloGroupID, {[1] = "Helo Operations"})
	
	local HeloMenuMain  	= missionCommands.addSubMenuForGroup(HeloGroupID, "Helo Operations", nil)
	local HeloMenuSEALS 	= missionCommands.addSubMenuForGroup(HeloGroupID, "Navy SEALS", HeloMenuMain)
	local HeloMenuDELTA		= missionCommands.addSubMenuForGroup(HeloGroupID, "DELTA Force", HeloMenuMain)
	local HeloMenuSSF 		= missionCommands.addSubMenuForGroup(HeloGroupID, "Sultan's Special Forces", HeloMenuMain)
	local HeloMenuUAEPG 	= missionCommands.addSubMenuForGroup(HeloGroupID, "UAE Presidential Guard", HeloMenuMain)
	local HeloMenuUSACE 	= missionCommands.addSubMenuForGroup(HeloGroupID, "USACE Engineers 1st Squad", HeloMenuMain)
	local HeloMenuUSACE2 	= missionCommands.addSubMenuForGroup(HeloGroupID, "USACE Engineers 2nd Squad", HeloMenuMain)
	local HeloMenuCargo 	= missionCommands.addSubMenuForGroup(HeloGroupID, "Cargo Containers", HeloMenuMain)	

	--Navy SEAL Team
	missionCommands.addCommandForGroup(HeloGroupID, "Navy SEAL Team Request Team", HeloMenuSEALS, SEF_SEAL_SpawnTeam, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Navy SEAL Team Pickup", HeloMenuSEALS, SEF_SEAL_PickupZoneLoadTeam, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Navy SEAL Team Insertion", HeloMenuSEALS, SEF_SEAL_Insertion, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Navy SEAL Team Extraction", HeloMenuSEALS, SEF_SEAL_Extraction, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Navy SEAL Smoke Pickup Zone", HeloMenuSEALS, SEF_SEAL_SmokePickupZone, nil)	
	missionCommands.addCommandForGroup(HeloGroupID, "Navy SEAL Smoke Extraction Zone", HeloMenuSEALS, SEF_SEAL_SmokeExtractionZone, nil)
		
	--Delta Force
	missionCommands.addCommandForGroup(HeloGroupID, "DELTA Force Request Team", HeloMenuDELTA, SEF_DELTA_SpawnTeam, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "DELTA Force Team Pickup", HeloMenuDELTA, SEF_DELTA_PickupZoneLoadTeam, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "DELTA Force Team Insertion", HeloMenuDELTA, SEF_DELTA_Insertion, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "DELTA Force Extraction", HeloMenuDELTA, SEF_DELTA_Extraction, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "DELTA Force Smoke Pickup Zone", HeloMenuDELTA, SEF_DELTA_SmokePickupZone, nil)	
	missionCommands.addCommandForGroup(HeloGroupID, "DELTA Force Smoke Extraction Zone", HeloMenuDELTA, SEF_DELTA_SmokeExtractionZone, nil)
	
	--Sultan's Special Forces
	missionCommands.addCommandForGroup(HeloGroupID, "Sultan's Special Forces Request Team", HeloMenuSSF, SEF_SSF_SpawnTeam, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Sultan's Special Forces Pickup", HeloMenuSSF, SEF_SSF_PickupZoneLoadTeam, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Sultan's Special Forces Insertion", HeloMenuSSF, SEF_SSF_Insertion, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Sultan's Special Forces Extraction", HeloMenuSSF, SEF_SSF_Extraction, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Sultan's Special Forces Smoke Pickup Zone", HeloMenuSSF, SEF_SSF_SmokePickupZone, nil)	
	missionCommands.addCommandForGroup(HeloGroupID, "Sultan's Special Forces Smoke Extraction Zone", HeloMenuSSF, SEF_SSF_SmokeExtractionZone, nil)
	
	--UAE Presidential Guard
	missionCommands.addCommandForGroup(HeloGroupID, "UAE Presidential Guard Request Team", HeloMenuUAEPG, SEF_UAEPG_SpawnTeam, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "UAE Presidential Guard Pickup", HeloMenuUAEPG, SEF_UAEPG_PickupZoneLoadTeam, { HeloGroupID, HeloGroupName })	
	missionCommands.addCommandForGroup(HeloGroupID, "UAE Presidential Guard Insertion", HeloMenuUAEPG, SEF_UAEPG_Insertion, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "UAE Presidential Guard Extraction", HeloMenuUAEPG, SEF_UAEPG_Extraction, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "UAE Presidential Guard Smoke Pickup Zone", HeloMenuUAEPG, SEF_UAEPG_SmokePickupZone, nil)	
	missionCommands.addCommandForGroup(HeloGroupID, "UAE Presidential Guard Smoke Extraction Zone", HeloMenuUAEPG, SEF_UAEPG_SmokeExtractionZone, nil)	
		
	--USACE 1ST SQUAD
	missionCommands.addCommandForGroup(HeloGroupID, "USACE 1st Squad Request Team", HeloMenuUSACE, SEF_USACETeam1_SpawnTeam, { HeloGroupID, HeloGroupName })				
	missionCommands.addCommandForGroup(HeloGroupID, "USACE 1st Squad Pickup", HeloMenuUSACE, SEF_USACETeam1_PickupZoneLoadTeam, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "USACE 1st Squad Insertion", HeloMenuUSACE, SEF_USACETeam1_SetupConstruction, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "USACE 1st Squad Extraction", HeloMenuUSACE, SEF_USACETeam1_Extraction, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "USACE 1st Squad Smoke Pickup Zone", HeloMenuUSACE, SEF_USACETeam1_SmokePickupZone, nil)	
	missionCommands.addCommandForGroup(HeloGroupID, "USACE 1st Squad Smoke Construction Zone", HeloMenuUSACE, SEF_USACETeam1_SmokeConstructionZone, nil)
		--CONSTRUCTION
	missionCommands.addCommandForGroup(HeloGroupID, "Construct M818", HeloMenuUSACE, SEF_BUILD_M818, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Construct Hawk System", HeloMenuUSACE, SEF_BUILD_HAWK, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Construct Roland ADS System", HeloMenuUSACE, SEF_BUILD_ROLAND, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Construct M1A2 Abrams Tank", HeloMenuUSACE, SEF_BUILD_M1A2ABRAMS, { HeloGroupID, HeloGroupName })
	
	--USACE 2ND SQUAD
	missionCommands.addCommandForGroup(HeloGroupID, "USACE 2nd Squad Request Team", HeloMenuUSACE2, SEF_USACETeam2_SpawnTeam, { HeloGroupID, HeloGroupName })				
	missionCommands.addCommandForGroup(HeloGroupID, "USACE 2nd Squad Pickup", HeloMenuUSACE2, SEF_USACETeam2_PickupZoneLoadTeam, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "USACE 2nd Squad Insertion", HeloMenuUSACE2, SEF_USACETeam2_SetupConstruction, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "USACE 2nd Squad Extraction", HeloMenuUSACE2, SEF_USACETeam2_Extraction, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "USACE 2nd Squad Smoke Pickup Zone", HeloMenuUSACE2, SEF_USACETeam2_SmokePickupZone, nil)	
	missionCommands.addCommandForGroup(HeloGroupID, "USACE 2nd Squad Smoke Construction Zone", HeloMenuUSACE2, SEF_USACETeam2_SmokeConstructionZone, nil)
		--CONSTRUCTION
	missionCommands.addCommandForGroup(HeloGroupID, "Construct M818", HeloMenuUSACE2, SEF_BUILD_M818_2, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Construct Hawk System", HeloMenuUSACE2, SEF_BUILD_HAWK_2, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Construct Roland ADS System", HeloMenuUSACE2, SEF_BUILD_ROLAND_2, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Construct M1A2 Abrams Tank", HeloMenuUSACE2, SEF_BUILD_M1A2ABRAMS_2, { HeloGroupID, HeloGroupName })
	
	--CARGO CONTAINERS
	missionCommands.addCommandForGroup(HeloGroupID, "Requisition Cargo", HeloMenuCargo, SEF_CARGO_SPAWN, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Load Cargo", HeloMenuCargo, SEF_CARGO_LOAD, { HeloGroupID, HeloGroupName })
	missionCommands.addCommandForGroup(HeloGroupID, "Unload Cargo", HeloMenuCargo, SEF_CARGO_UNLOAD, { HeloGroupID, HeloGroupName })	
	missionCommands.addCommandForGroup(HeloGroupID, "Smoke Cargo Loading Zones", HeloMenuCargo, SEF_CARGO_SmokePickupZones, nil)	
end

--////END MENU
--------------------------------------------------------------------------------------------------------------------------------------------------
--////SAVE FUNCTIONS
function SEF_SaveConstructedItemsTable(timeloop, time)
	
	SEF_UPDATECONSTRUCTIONTABLE()
	
	ConstructionStr = IntegratedserializeWithCycles("SnowfoxMkIIConstructions", SnowfoxMkIIConstructions)
	writemission(ConstructionStr, "SnowfoxMkIIConstructions.lua")
	--trigger.action.outText("Progress Has Been Saved", 15)	
	return time + SaveScheduleUnits
end

function SEF_SaveConstructedItemsTableNoArgs()
	ConstructionStr = IntegratedserializeWithCycles("SnowfoxMkIIConstructions", SnowfoxMkIIConstructions)
	writemission(ConstructionStr, "SnowfoxMkIIConstructions.lua")	
end

function SEF_UPDATECONSTRUCTIONTABLE()
	
	--Update Tables
	SEF_USACE_UPDATEHAWKTABLE()
	SEF_USACE_UPDATEM818TABLE()
	SEF_USACE_UPDATEROLANDTABLE()
	SEF_USACE_UPDATEM1A2ABRAMSTABLE()
	
	TableConstructor = 1
	SnowfoxMkIIConstructions = {}	

	if #USACEM818Table > 0 then
		for i = 1, #USACEM818Table do
			local ConstructedGroupVec2 = GROUP:FindByName(USACEM818Table[i]):GetCoordinate():GetVec2()
						
			SnowfoxMkIIConstructions[TableConstructor] = {}
			SnowfoxMkIIConstructions[TableConstructor].Type = "M818"
			SnowfoxMkIIConstructions[TableConstructor].Vec2X = ConstructedGroupVec2.x
			SnowfoxMkIIConstructions[TableConstructor].Vec2Y = ConstructedGroupVec2.y
			
			TableConstructor = TableConstructor + 1
		end
	end
		
	if #USACEROLANDTable > 0 then
		for i = 1, #USACEROLANDTable do
			local ConstructedGroupVec2 = GROUP:FindByName(USACEROLANDTable[i]):GetCoordinate():GetVec2()
						
			SnowfoxMkIIConstructions[TableConstructor] = {}
			SnowfoxMkIIConstructions[TableConstructor].Type = "Roland ADS"
			SnowfoxMkIIConstructions[TableConstructor].Vec2X = ConstructedGroupVec2.x
			SnowfoxMkIIConstructions[TableConstructor].Vec2Y = ConstructedGroupVec2.y
			
			TableConstructor = TableConstructor + 1
		end
	end

	if #USACEM1A2ABRAMSTable > 0 then
		for i = 1, #USACEM1A2ABRAMSTable do
			local ConstructedGroupVec2 = GROUP:FindByName(USACEM1A2ABRAMSTable[i]):GetCoordinate():GetVec2()
						
			SnowfoxMkIIConstructions[TableConstructor] = {}
			SnowfoxMkIIConstructions[TableConstructor].Type = "M1A2 Abrams"
			SnowfoxMkIIConstructions[TableConstructor].Vec2X = ConstructedGroupVec2.x
			SnowfoxMkIIConstructions[TableConstructor].Vec2Y = ConstructedGroupVec2.y
			
			TableConstructor = TableConstructor + 1
		end
	end
	
	if #USACEHAWKTable > 0 then
		for i = 1, #USACEHAWKTable do
			--If The Hawk Had Destroyed Units Skip It So A Replacement Can Be Built Manually?
			if ( GROUP:FindByName(USACEHAWKTable[i]):GetSize() > 7 ) then
			
				local ConstructedGroupVec2 = GROUP:FindByName(USACEHAWKTable[i]):GetCoordinate():GetVec2()
							
				SnowfoxMkIIConstructions[TableConstructor] = {}
				SnowfoxMkIIConstructions[TableConstructor].Type = "Hawk"
				SnowfoxMkIIConstructions[TableConstructor].Vec2X = ConstructedGroupVec2.x
				SnowfoxMkIIConstructions[TableConstructor].Vec2Y = ConstructedGroupVec2.y
				
				TableConstructor = TableConstructor + 1
			end	
		end
	end
	
	if ( NavySEALTeam ~= nil and NavySEALTeam:IsAlive() == true and NavySEALTeam:IsLoaded() == false and GROUP:FindByName(NavySEALTeam:GetObjectName()):GetCoordinate():GetVec2() ~= nil ) then
		local ConstructedGroupVec2 = GROUP:FindByName(NavySEALTeam:GetObjectName()):GetCoordinate():GetVec2()
							
		SnowfoxMkIIConstructions[TableConstructor] = {}
		SnowfoxMkIIConstructions[TableConstructor].Type = "Navy SEALS"
		SnowfoxMkIIConstructions[TableConstructor].Vec2X = ConstructedGroupVec2.x
		SnowfoxMkIIConstructions[TableConstructor].Vec2Y = ConstructedGroupVec2.y
		
		TableConstructor = TableConstructor + 1
	end

	if ( DELTATeam ~= nil and DELTATeam:IsAlive() == true and DELTATeam:IsLoaded() == false and GROUP:FindByName(DELTATeam:GetObjectName()):GetCoordinate():GetVec2() ~= nil ) then
		local ConstructedGroupVec2 = GROUP:FindByName(DELTATeam:GetObjectName()):GetCoordinate():GetVec2()
							
		SnowfoxMkIIConstructions[TableConstructor] = {}
		SnowfoxMkIIConstructions[TableConstructor].Type = "DELTA Force"
		SnowfoxMkIIConstructions[TableConstructor].Vec2X = ConstructedGroupVec2.x
		SnowfoxMkIIConstructions[TableConstructor].Vec2Y = ConstructedGroupVec2.y
		
		TableConstructor = TableConstructor + 1
	end

	if ( SSFTeam ~= nil and SSFTeam:IsAlive() == true and SSFTeam:IsLoaded() == false and GROUP:FindByName(SSFTeam:GetObjectName()):GetCoordinate():GetVec2() ~= nil ) then
		local ConstructedGroupVec2 = GROUP:FindByName(SSFTeam:GetObjectName()):GetCoordinate():GetVec2()
							
		SnowfoxMkIIConstructions[TableConstructor] = {}
		SnowfoxMkIIConstructions[TableConstructor].Type = "SSF"
		SnowfoxMkIIConstructions[TableConstructor].Vec2X = ConstructedGroupVec2.x
		SnowfoxMkIIConstructions[TableConstructor].Vec2Y = ConstructedGroupVec2.y
		
		TableConstructor = TableConstructor + 1
	end
	
	if ( UAEPGTeam ~= nil and UAEPGTeam:IsAlive() == true and UAEPGTeam:IsLoaded() == false and GROUP:FindByName(UAEPGTeam:GetObjectName()):GetCoordinate():GetVec2() ~= nil ) then
		local ConstructedGroupVec2 = GROUP:FindByName(UAEPGTeam:GetObjectName()):GetCoordinate():GetVec2()
							
		SnowfoxMkIIConstructions[TableConstructor] = {}
		SnowfoxMkIIConstructions[TableConstructor].Type = "UAEPG"
		SnowfoxMkIIConstructions[TableConstructor].Vec2X = ConstructedGroupVec2.x
		SnowfoxMkIIConstructions[TableConstructor].Vec2Y = ConstructedGroupVec2.y
		
		TableConstructor = TableConstructor + 1
	end
	
	if ( USACETeam1 ~= nil and USACETeam1:IsAlive() == true and USACETeam1:IsLoaded() == false and GROUP:FindByName(USACETeam1:GetObjectName()):GetCoordinate():GetVec2() ~= nil ) then
		local ConstructedGroupVec2 = GROUP:FindByName(USACETeam1:GetObjectName()):GetCoordinate():GetVec2()
							
		SnowfoxMkIIConstructions[TableConstructor] = {}
		SnowfoxMkIIConstructions[TableConstructor].Type = "USACE 1st Squad"
		SnowfoxMkIIConstructions[TableConstructor].Vec2X = ConstructedGroupVec2.x
		SnowfoxMkIIConstructions[TableConstructor].Vec2Y = ConstructedGroupVec2.y
		
		TableConstructor = TableConstructor + 1
	end

	if ( USACETeam2 ~= nil and USACETeam2:IsAlive() == true and USACETeam2:IsLoaded() == false and GROUP:FindByName(USACETeam2:GetObjectName()):GetCoordinate():GetVec2() ~= nil ) then
		local ConstructedGroupVec2 = GROUP:FindByName(USACETeam2:GetObjectName()):GetCoordinate():GetVec2()
							
		SnowfoxMkIIConstructions[TableConstructor] = {}
		SnowfoxMkIIConstructions[TableConstructor].Type = "USACE 2nd Squad"
		SnowfoxMkIIConstructions[TableConstructor].Vec2X = ConstructedGroupVec2.x
		SnowfoxMkIIConstructions[TableConstructor].Vec2Y = ConstructedGroupVec2.y
		
		TableConstructor = TableConstructor + 1
	end
end

--////END SAVE FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------
--////MAIN

--////LOAD CONSTRUCTED ITEMS
if file_exists("SnowfoxMkIIConstructions.lua") then	
	
	--trigger.action.outText("Requisitioning Previously Constructed Items",15)
	
	dofile("SnowfoxMkIIConstructions.lua")
	
	ConstructedItemsTableLength = SEF_GetTableLength(SnowfoxMkIIConstructions)	
		
	for i = 1, ConstructedItemsTableLength do				
		local ConstructionType = SnowfoxMkIIConstructions[i].Type
		local ConstructionVec2X = SnowfoxMkIIConstructions[i].Vec2X
		local ConstructionVec2Y = SnowfoxMkIIConstructions[i].Vec2Y
		local ConstructionSpawnPointVec2 = { x = ConstructionVec2X, y = ConstructionVec2Y }
		
		if ( ConstructionType == "Hawk" ) then
			SEF_USACEHAWK_SPAWN(ConstructionSpawnPointVec2)
		elseif ( ConstructionType == "M818" ) then
			SEF_USACEM818_SPAWN(ConstructionSpawnPointVec2)
		elseif ( ConstructionType == "Roland ADS" ) then
			SEF_USACEROLAND_SPAWN(ConstructionSpawnPointVec2)
		elseif ( ConstructionType == "M1A2 Abrams" ) then
			SEF_USACEM1A2ABRAMS_SPAWN(ConstructionSpawnPointVec2)
		elseif ( ConstructionType == "Navy SEALS" ) then
			SEF_SEAL_SpawnTeamPersistent(ConstructionSpawnPointVec2)
		elseif ( ConstructionType == "DELTA Force" ) then
			SEF_DELTA_SpawnTeamPersistent(ConstructionSpawnPointVec2)	
		elseif ( ConstructionType == "SSF" ) then
			SEF_SSF_SpawnTeamPersistent(ConstructionSpawnPointVec2)
		elseif ( ConstructionType == "UAEPG" ) then
			SEF_UAEPG_SpawnTeamPersistent(ConstructionSpawnPointVec2)		
		elseif ( ConstructionType == "USACE 1st Squad" ) then
			SEF_USACETeam1_SpawnTeamPersistent(ConstructionSpawnPointVec2)		
		elseif ( ConstructionType == "USACE 2nd Squad" ) then
			SEF_USACETeam2_SpawnTeamPersistent(ConstructionSpawnPointVec2)
		else				
		end			
	end			
else			
	SnowfoxMkIIConstructions = {}	
	ConstructedItemsTableLength = 0		
end

timer.scheduleFunction(SEF_SaveConstructedItemsTable, 53, timer.getTime() + SaveScheduleUnits)

--////END MAIN
--------------------------------------------------------------------------------------------------------------------------------------------------
--////OBSTETRICS AND GYNAECOLOGY

EventHandlerHeloBirth = {}
function EventHandlerHeloBirth:onEvent(Event)
	
	if ( Event.id == world.event.S_EVENT_BIRTH and Event.initiator:getDesc().category == 1 and Event.initiator:getPlayerName() ~= nil ) then				
		local EventGroupName = Event.initiator:getGroup():getName()
		local EventGroupType = Event.initiator:getTypeName()
		local EventGroupID 	 = Event.initiator:getGroup():getID()
		local EventPlayerName = Event.initiator:getPlayerName()
		
		if ( EventGroupType == "UH-1H" or EventGroupType == "Mi-8MT" ) then --or EventGroupType == "SA342L" or EventGroupType == "SA342M" or EventGroupType == "SA342Minigun" or EventGroupType == "SA342Mistral"
			SEF_SetupHeloMenu(EventGroupID, EventGroupName)
		end
	end	  
end
world.addEventHandler(EventHandlerHeloBirth)

--------------------------------------------------------------------------------------------------------------------------------------------------
env.info("Helo Complete", false)