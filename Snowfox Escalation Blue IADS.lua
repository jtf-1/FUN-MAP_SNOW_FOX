env.info("Blue IADS Loading", false)
--[[

--Editable part v
local bPatriotpc = 100
local bHawkpc = 100
local bBASECAPpc = 100
local bRolandpc = 100
local bEWRpc = 100



--Editable part ^

bPatriot=SET_GROUP:New():FilterPrefixes("bSAM-Patriot"):FilterActive(true):FilterOnce()
bHawk=SET_GROUP:New():FilterPrefixes("bSAM-Hawk"):FilterActive(true):FilterOnce()
bBASECAP=SET_GROUP:New():FilterPrefixes("bSAM-BASECAP#"):FilterActive(true):FilterOnce()
bRoland=SET_GROUP:New():FilterPrefixes("bSAM-Roland"):FilterActive(true):FilterStart()
bEWR=SET_GROUP:New():FilterPrefixes("bEWR-"):FilterActive(true):FilterStart()

All=SET_GROUP:New():FilterActive(true):FilterStart()

local bPatriotcount=bPatriot:Count()
local bHawkcount=bHawk:Count()
local bBASECAPcount=bBASECAP:Count()
local bRolandcount=bRoland:Count()
local bEWRcount=bEWR:Count()


--We will reduce the complement of the SAM's by the fixed percentage requested above by removing some


local PatriottoKeep = UTILS.Round(bPatriotcount/100*bPatriotpc, 0)

--if SA2toKeep>0 then
local PatriottoDestroy = bPatriotcount - PatriottoKeep
  for i = 1, PatriottoDestroy do
   local grpObj = bPatriot:GetRandom()
    --env.info(grpObj:GetName())
    grpObj:Destroy(true)

  end
--end 

local HawktoKeep = UTILS.Round(bHawkcount/100*bHawkpc, 0)

--if SA3toKeep>0 then
local HawktoDestroy = bHawkcount - HawktoKeep
  for i = 1, HawktoDestroy do
    local grpObj = bHawk:GetRandom()
    --env.info(grpObj:GetName())
    grpObj:Destroy(true)

  end
--end 

local BASECAPtoKeep = UTILS.Round(bBASECAPcount/100*bBASECAPpc, 0)

--if SA6toKeep>0 then
local BASECAPtoDestroy = bBASECAPcount - BASECAPtoKeep
  for i = 1, BASECAPtoDestroy do
    local grpObj = bBASECAP:GetRandom()
    --env.info(grpObj:GetName())
    grpObj:Destroy(true)

  end
--end 

local bRolandtoKeep = UTILS.Round(bRolandcount/100*bRolandpc, 0)

--if EWRtoKeep>0 then
local bRolandtoDestroy = bRolandcount - bRolandtoKeep
  for i = 1, bRolandtoDestroy do
    local grpObj = bRoland:GetRandom()
    --env.info(grpObj:GetName())
    grpObj:Destroy(true)

  end
--end 

local bEWRtoKeep = UTILS.Round(bEWRcount/100*bEWRpc, 0)

--if EWRtoKeep>0 then
local bEWRtoDestroy = bEWRcount - bEWRtoKeep
  for i = 1, bEWRtoDestroy do
    local grpObj = bEWR:GetRandom()
    --env.info(grpObj:GetName())
    grpObj:Destroy(true)

  end
--end 
-----------------
-- BLUE IADS --
-----------------
blueIADS = SkynetIADS:create('US SAMs')
blueIADS:setUpdateInterval(5)
blueIADS:addEarlyWarningRadarsByPrefix('bEWR')
blueIADS:addSAMSitesByPrefix('bSAM')
blueIADS:getSAMSitesByNatoName('Patriot str'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE)
blueIADS:getSAMSitesByNatoName('Hawk str'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE)
blueIADS:addRadioMenu()  

blueIADS:activate()    
]]--

function SEF_ReaddIADS ()
  env.info("Adding Respawns to IADS", false)
  blueIADS = SkynetIADS:create('US SAMs')
  blueIADS:deactivate()
  blueIADS:setUpdateInterval(5)
  blueIADS:addEarlyWarningRadarsByPrefix('bEWR')
  blueIADS:addSAMSitesByPrefix('bSAM')
  blueIADS:getSAMSitesByNatoName('Patriot'):setActAsEW(true)
  blueIADS:getSAMSitesByNatoName('Hawk'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE)
  --blueIADS:addRadioMenu()  
  blueIADS:activate()  
  env.info("Respawns integrated into IADS", false)
  timer.scheduleFunction(SEF_ReaddIADS, nil, timer.getTime() + 1800)  --1800
  end

timer.scheduleFunction(SEF_ReaddIADS, nil, timer.getTime() + 45)



env.info("Blue IADS Complete", false)