function Unicode(inString)
	if inString == '' then return end
   newString = string.gsub(inString, '\\u(%w+)%s', '\[\\x%1\] ')
   return newString
end

function VersionCheck()
   LatestVersion = SKIN:GetMeasure('MeasureLatestVersion'):GetStringValue()
   CurrentVersion = SKIN:GetVariable('Version')
   if (CurrentVersion=="" or CurrentVersion==LatestVersion) then
      return 1
   else
      return 0
   end
   
end

function VideoCheck(video)
   videoURL = SKIN:GetMeasure(video):GetStringValue()
   if (videoURL=="") then
      return 0
   else
      return 1
   end
end

function Timezone(StartDate)
   local UTC = os.date('!*t')
   local LocalTime = os.date('*t')
   local DaylightSavings = 0
   if LocalTime.isdst then
      DaylightSavings = 3600
   end
   
   local LocalOffset = os.time(LocalTime) - os.time(UTC) + DaylightSavings
   -- Month XX, XXXX XX:XX:XX UTC
   -- ".* \d{1,2}, (\d{4}) \d{1,2}:\d{2}:\d{2} .*":"\1"
   local _, _, StrMonth, StrDay, StrYear, StrHour, StrMinute, StrSecond = string.find(StartDate, '(%a+)%s*(%d+),%s*(%d+) (%d+):(%d+):(%d+)%s*')
   MMonth = MonthToNumber(StrMonth)
Year, Month, Day, Hour, Minute, Second = tonumber(StrYear), MMonth, tonumber(StrDay), tonumber(StrHour), tonumber(StrMinute), tonumber(StrSecond) 
  local Tim = (os.time({year=Year, month=Month, day=Day, hour=Hour, min=Minute, sec=Second}) + LocalOffset)
   local YearM, MonthM, DayM, HourM, MinuteM, SecondM, APM	 = os.date("%Y", Tim), os.date("%m", Tim), os.date("%d", Tim), os.date("%I", Tim), os.date("%M", Tim), os.date("%S", Tim), os.date("%p", Tim)
   return MonthM..'.'..DayM..'.'..YearM..' '..HourM..':'..MinuteM..':'..SecondM..' '..APM
end

function MonthToNumber(month)
	if (month=="January") then
		return 1
	elseif (month=="February") then
		return 2
	elseif (month=="March") then
		return 3
	elseif (month=="April") then
		return 4
	elseif (month=="May") then
		return 5
	elseif (month=="June") then
		return 6
	elseif (month=="July") then
		return 7
	elseif (month=="August") then
		return 8
	elseif (month=="September") then
		return 9
	elseif (month=="October") then
		return 10
	elseif (month=="November") then
		return 11
	else
		return 12
	end
end