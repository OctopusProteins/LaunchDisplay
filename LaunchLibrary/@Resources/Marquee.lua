--LuaMarquee v6.2 by Smurfier (smurfier20@gmail.com)
--This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License.

function Initialize()
	Vars = SELF:GetOption('Variable')
	Pos = SELF:GetOption('Position', 'right'):lower()
	Pause = SELF:GetNumberOption('Pause', 1)
	Measures, Timer = {}, 0
	for w in SELF:GetOption('MeasureName'):gmatch('[^%|]+') do
		table.insert(Measures, SKIN:GetMeasure(w))
	end
end -- Initialize

function Update()
	local Values, Text = {}
	for i, v in ipairs(Measures) do
		table.insert(Values, v:GetStringValue())
	end
	for w in Vars:gmatch('[^%|]+') do
		table.insert(Values, SKIN:GetVariable(w))
	end
	local nText = SELF:GetOption('Text')
	if nText ~= '' then
		table.insert(Values, nText)
	end
	if #Values == 0 then
		return 'Input Error!'
	else
		Text = table.concat(Values, SELF:GetOption('Delimiter', '  ')):gsub('\n', ' ')
	end
	--Marquee
	if (not OldText) or Text ~= (OldText or '') then
		Timer, Length, OldText = 0, Text:len(), Text
	end
	local Width = SELF:GetNumberOption('Width', 10)
	if Length <= Width and SELF:GetNumberOption('ForceScroll', 0) == 0 then
		return Text
	else
		Timer = Timer % (Length + Width) + 1 * Pause
		return ((Pos == 'left' and Text or '') .. string.rep(' ', Width) .. Text):sub(Timer, Timer + Width - 1)
	end
end -- Update