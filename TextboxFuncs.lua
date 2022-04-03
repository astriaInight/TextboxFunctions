local function Char(s, p)
	return string.sub(s, p, p)
end

local function GetWord(Textbox)
	local CursorPos = Textbox.CursorPosition
	
	local s = CursorPos
	local e = CursorPos
	
	while true do
		s -= 1
		
		local c = Char(Textbox.Text, s)
		
		if c == " " or c == "\n" or c == "" then
			break
		end
	end
	
	while true do
		e += 1
		
		local c = Char(Textbox.Text, e)

		if c == " " or c == "\n" or c == "" then
			break
		end
	end
	
	return string.sub(Textbox.Text, s, e)
end

local function GetLine(Textbox)
	local CursorPos = Textbox.CursorPosition
	
	local cursor = 0

	local l = 1
	
	while true do
		cursor += 1
		
		local c = Char(Textbox.Text, cursor)
		
		if c == "\n" then
			l += 1
			
		-- Subtract 1 to prevent it counting the end of lines
		elseif cursor >= CursorPos - 1 then
			break
		end
	end
	
	return l
end

local function GetLineText(Textbox)
	local CursorPos = Textbox.CursorPosition
	
	local TargetLine = GetLine(Textbox)

	local cursor = 0
	
	local Content = ""

	local l = 1

	while true do
		cursor += 1

		local c = Char(Textbox.Text, cursor)

		if c == "\n" then
			l += 1
		elseif cursor >= CursorPos then
			break
		end
		
		if l == TargetLine then
			Content = Content .. c
		end
	end

	return Content
end

local function GetCursorPos(Textbox)
	local CurrentLine = GetLine(Textbox)
	local LineText = GetLineText(Textbox)
	local TextSize = Textbox.TextSize
	local TextFont = Textbox.Font
	
	local LineWidth = TextService:GetTextSize(LineText, TextSize, TextFont, Textbox.AbsoluteSize).X
	local LineHeight = CurrentLine * TextSize
	
	return UDim2.new(0, LineWidth,0, LineHeight)
end
