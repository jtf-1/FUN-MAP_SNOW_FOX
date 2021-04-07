function SEF_BASECAP ()
  env.info("BASECAP Starting", false)
  
  BlueBaseCAP=SET_GROUP:New():FilterPrefixes("bSAM-BASECAP#"):FilterOnce() 
  --All=SET_GROUP:New():FilterActive(true):FilterStart()
  
  --=====================================================================================
  
  local BlueBaseCAPcount=BlueBaseCAP:Count()
  local BlueBaseCAPtoDestroy = BlueBaseCAPcount
    for i = 1, BlueBaseCAPtoDestroy do
      local grpObj = BlueBaseCAP:GetRandom()
      --env.info(grpObj:GetName())
      grpObj:Destroy(true)
    end
  
  BlueBaseCAP=SET_GROUP:New():FilterPrefixes("bSAM-BASECAP#"):FilterOnce() 
    
  local BlueBaseCAPcount=BlueBaseCAP:Count()
  local BlueBaseCAPtoDestroy = BlueBaseCAPcount
    for i = 1, BlueBaseCAPtoDestroy do
      local grpObj = BlueBaseCAP:GetRandom()
      --env.info(grpObj:GetName())
      grpObj:Destroy(true)
    end 
  --end 
   
  if file_exists("SnowfoxMkIIAirbases.lua") then
  
    dofile("SnowfoxMkIIAirbases.lua")
    
    AirbaseTableLength = SEF_GetTableLength(SnowfoxMkIIAirbases)
    
    for i = 1, AirbaseTableLength do
      BaseName = SnowfoxMkIIAirbases[i].Airbase
      BaseCoalition = SnowfoxMkIIAirbases[i].Coalition
      
      if ( BaseCoalition == 1) then     
      elseif ( BaseCoalition == 2 ) then      
        SEF_CAPAIRBASE(BaseName, 2)     
      else      
      end
    end
  else
    SnowfoxMkIIAirbases = {}
    AirbaseTableLength = 0
  end
  env.info("BASECAP Complete", false)
 
end

timer.scheduleFunction(SEF_BASECAP, nil, timer.getTime() + 3600) --3600

