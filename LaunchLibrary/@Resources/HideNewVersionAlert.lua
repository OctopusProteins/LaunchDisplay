function Update()

   LatestVersion = SKIN:GetMeasure('MeasureLatestVersion'):GetStringValue()
   CurrentVersion = SKIN:GetVariable('Version')
   if (CurrentVersion=="" or CurrentVersion==LatestVersion) then
      return 1
   else
      return 0
   end
   
end -- function Update