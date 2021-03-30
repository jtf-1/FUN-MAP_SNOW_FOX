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
    local TargetZoneVec2  = DestinationZone:GetVec2()
          
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

