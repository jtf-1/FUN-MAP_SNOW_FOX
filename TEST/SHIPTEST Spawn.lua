--[[ZoneTable = { ZONE:New( "Zone1" ), ZONE:New( "Zone2" ) }

Spawn_Ship_1 = SPAWN:New( "SHIPTEST" )
  :InitLimit( 2, 2 )
  :InitRandomizeZones( ZoneTable )
  :InitRandomizeRoute(0,1,1000)
  :SpawnScheduled( 5, .5 )
  :PatrolRoute()
  ]]--
  
  
  
  
   SHIP = NAVYGROUP:New("SHIPTEST")
   SHIP:InitWaypoints()
   SHIP:Activate()