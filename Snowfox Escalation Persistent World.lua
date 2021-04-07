env.info("Persistent World Loading", false)

----------------------------------------------------------
SaveScheduleUnits = 300 --Seconds between each table write
----------------------------------------------------------
  
function IntegratedbasicSerialize(s)
    if s == nil then
		return "\"\""
    else
		if ((type(s) == 'number') or (type(s) == 'boolean') or (type(s) == 'function') or (type(s) == 'table') or (type(s) == 'userdata') ) then
			return tostring(s)
		elseif type(s) == 'string' then
			return string.format('%q', s)
		end
    end
end
  
-- imported slmod.serializeWithCycles (Speed)
function IntegratedserializeWithCycles(name, value, saved)
    local basicSerialize = function (o)
		if type(o) == "number" then
			return tostring(o)
		elseif type(o) == "boolean" then
			return tostring(o)
		else -- assume it is a string
			return IntegratedbasicSerialize(o)
		end
	end

    local t_str = {}
    saved = saved or {}       -- initial value
    if ((type(value) == 'string') or (type(value) == 'number') or (type(value) == 'table') or (type(value) == 'boolean')) then
		table.insert(t_str, name .. " = ")
			if type(value) == "number" or type(value) == "string" or type(value) == "boolean" then
				table.insert(t_str, basicSerialize(value) ..  "\n")
			else
				if saved[value] then    -- value already saved?
					table.insert(t_str, saved[value] .. "\n")
				else
					saved[value] = name   -- save name for next time
					table.insert(t_str, "{}\n")
						for k,v in pairs(value) do      -- save its fields
							local fieldname = string.format("%s[%s]", name, basicSerialize(k))
							table.insert(t_str, IntegratedserializeWithCycles(fieldname, v, saved))
						end
				end
			end
		return table.concat(t_str)
    else
		return ""
    end
end

function file_exists(name) --check if the file already exists for writing
	if lfs.attributes(name) then
    return true
    else
    return false end 
end

function writemission(data, file)--Function for saving to file (commonly found)
	File = io.open(file, "w")
	File:write(data)
	File:close()
end

function SEF_GetTableLength(Table)
	local TableLengthCount = 0
	for _ in pairs(Table) do TableLengthCount = TableLengthCount + 1 end
	return TableLengthCount
end

--////SAVE FUNCTION FOR UNITS
function SEF_SaveUnitIntermentTable(timeloop, time)
	IntermentMissionStr = IntegratedserializeWithCycles("SnowfoxMkIIUnitInterment", SnowfoxMkIIUnitInterment)
	writemission(IntermentMissionStr, "SnowfoxMkIIUnitInterment.lua")
	--trigger.action.outText("Progress Has Been Saved", 15)	
	return time + SaveScheduleUnits
end

function SEF_SaveUnitIntermentTableNoArgs()
	IntermentMissionStr = IntegratedserializeWithCycles("SnowfoxMkIIUnitInterment", SnowfoxMkIIUnitInterment)
	writemission(IntermentMissionStr, "SnowfoxMkIIUnitInterment.lua")		
end

--////SAVE FUNCTION FOR STATICS
function SEF_SaveStaticIntermentTable(timeloop, time)
	IntermentMissionStrStatic = IntegratedserializeWithCycles("SnowfoxMkIIStaticInterment", SnowfoxMkIIStaticInterment)
	writemission(IntermentMissionStrStatic, "SnowfoxMkIIStaticInterment.lua")
	--trigger.action.outText("Progress Has Been Saved", 15)	
	return time + SaveScheduleUnits
end

function SEF_SaveStaticIntermentTableNoArgs()
	IntermentMissionStrStatic = IntegratedserializeWithCycles("SnowfoxMkIIStaticInterment", SnowfoxMkIIStaticInterment)
	writemission(IntermentMissionStrStatic, "SnowfoxMkIIStaticInterment.lua")	
end

function SEF_SaveAirbasesTable(timeloop, time)
	SEF_PERSISTENTAIRBASES(PersistentAirbases)
	AirbaseStr = IntegratedserializeWithCycles("SnowfoxMkIIAirbases", SnowfoxMkIIAirbases)
	writemission(AirbaseStr, "SnowfoxMkIIAirbases.lua")
	return time + SaveScheduleUnits
end

function SEF_SaveAirbasesTableNoArgs()
	SEF_PERSISTENTAIRBASES(PersistentAirbases)
	AirbaseStr = IntegratedserializeWithCycles("SnowfoxMkIIAirbases", SnowfoxMkIIAirbases)
	writemission(AirbaseStr, "SnowfoxMkIIAirbases.lua")	
end

PersistentAirbases = {

	"Abu Dhabi Intl",
	"Abu Musa Island",
	"Al Ain Intl",
	"Al-Bateen",
	"Al Dhafra AFB",
	"Al Maktoum Intl",
	"Al Minhad AFB",
	"Bandar Abbas Intl",
	"Bandar Lengeh",
	"Bandar-e-Jask",
	"Dubai Intl",
	"Fujairah Intl",
	"Havadarya",
	"Jiroft",
	--"Kerman",
	"Khasab",
	"Kish Intl",
	"Lar",
	"Lavan Island",
	"Liwa AFB",
	"Qeshm Island",
	"Ras Al Khaimah Intl",
	"Sas Al Nakheel",
	"Sharjah Intl",
	--"Shiraz Intl",
	"Sir Abu Nuayr",
	"Sirri Island",
	"Tunb Island AFB",
	"Tunb Kochak",
}

REDCAPTURETEAM = SPAWN:New("rSAM-BASECAP")
BLUECAPTURETEAM = SPAWN:New("bSAM-BASECAP")

function SEF_PERSISTENTAIRBASES(AirbaseList)
	SnowfoxMkIIAirbases = {}
	
	for i, ab in ipairs(AirbaseList) do
		local AirbaseObject = Airbase.getByName(ab)
		local AirbaseCoalition = AirbaseObject:getCoalition()
		
		TempAirbaseTable = {
			["Airbase"]=ab,
			["Coalition"]=AirbaseCoalition
		}
		table.insert(SnowfoxMkIIAirbases, TempAirbaseTable )			
	end	
end

function SEF_CAPAIRBASE(Airbase, Coalition)
	
	if ( Coalition == 1 ) then
		RedHeloSpawnVec2 = ZONE:FindByName(Airbase.." LZ Red"):GetVec2()
		REDCAPTURETEAM:SpawnFromVec2(RedHeloSpawnVec2)	
	elseif ( Coalition == 2 ) then
		BlueHeloSpawnVec2 = ZONE:FindByName(Airbase.." LZ Blue"):GetVec2()
		BLUECAPTURETEAM:SpawnFromVec2(BlueHeloSpawnVec2)		
	else
	end
end
-------------------------------------------------------------------------------------------------------------------------------------
--////MAIN

SEFDeletedUnitCount = 0
SEFDeletedStaticCount = 0

--////LOAD UNITS
if file_exists("SnowfoxMkIIUnitInterment.lua") then	
	
	dofile("SnowfoxMkIIUnitInterment.lua")
	
	UnitIntermentTableLength = SEF_GetTableLength(SnowfoxMkIIUnitInterment)	
	--trigger.action.outText("Unit Table Length Is "..UnitIntermentTableLength, 15)
		
	for i = 1, UnitIntermentTableLength do
		--trigger.action.outText("Unit Interment Element "..i.." Is "..SnowfoxUnitInterment[i], 15)		
		
		if ( Unit.getByName(SnowfoxMkIIUnitInterment[i]) ~= nil ) then
			Unit.getByName(SnowfoxMkIIUnitInterment[i]):destroy()
			SEFDeletedUnitCount = SEFDeletedUnitCount + 1
		else
			trigger.action.outText("Unit Interment Element "..i.." Is "..SnowfoxMkIIUnitInterment[i].." And Was Not Found", 15)
		end	
	end			
else			
	SnowfoxMkIIUnitInterment = {}	
	UnitIntermentTableLength = 0	
end
--////LOAD STATICS
if file_exists("SnowfoxMkIIStaticInterment.lua") then
	
	dofile("SnowfoxMkIIStaticInterment.lua")
		
	StaticIntermentTableLength = SEF_GetTableLength(SnowfoxMkIIStaticInterment)	
	--trigger.action.outText("Static Table Length Is "..StaticIntermentTableLength, 15)
	
	for i = 1, StaticIntermentTableLength do
		--trigger.action.outText("Static Interment Element "..i.." Is "..SnowfoxStaticInterment[i], 15)
		
		if ( StaticObject.getByName(SnowfoxMkIIStaticInterment[i]) ~= nil ) then		
			StaticObject.getByName(SnowfoxMkIIStaticInterment[i]):destroy()		
			SEFDeletedStaticCount = SEFDeletedStaticCount + 1
		else
			trigger.action.outText("Static Interment Element "..i.." Is "..SnowfoxMkIIStaticInterment[i].." And Was Not Found", 15)
		end	
	end	
else
	SnowfoxMkIIStaticInterment = {}
	StaticIntermentTableLength = 0	
end

--trigger.action.outText("Persistent World Functions Have Removed "..SEFDeletedUnitCount.." Units and "..SEFDeletedStaticCount.." Static Objects", 15)

--////LOAD AIRBASES
if file_exists("SnowfoxMkIIAirbases.lua") then

	dofile("SnowfoxMkIIAirbases.lua")
	
	AirbaseTableLength = SEF_GetTableLength(SnowfoxMkIIAirbases)
	
	for i = 1, AirbaseTableLength do
		BaseName = SnowfoxMkIIAirbases[i].Airbase
		BaseCoalition = SnowfoxMkIIAirbases[i].Coalition
		
		if ( BaseCoalition == 1) then			
			SEF_CAPAIRBASE(BaseName, 1)
		elseif ( BaseCoalition == 2 ) then			
			SEF_CAPAIRBASE(BaseName, 2)			
		else			
		end
	end
else
	SnowfoxMkIIAirbases = {}
	AirbaseTableLength = 0
end

---------------------------------------------------------------------------------------------------------------------------------------------------

--SCHEDULE
--trigger.action.outText("Persistent World Functions Schedulers Are Currently Disabled", 15)
--timer.scheduleFunction(SEF_SaveUnitIntermentTable, 53, timer.getTime() + SaveScheduleUnits)
--timer.scheduleFunction(SEF_SaveStaticIntermentTable, 53, timer.getTime() + (SaveScheduleUnits + 3))
timer.scheduleFunction(SEF_SaveAirbasesTable, 53, timer.getTime() + (SaveScheduleUnits + 5))
---------------------------------------------------------------------------------------------------------------------------------------------------

env.info("Persistent World Complete", false)
