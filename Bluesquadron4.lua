
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
