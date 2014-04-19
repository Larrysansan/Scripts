require "Button"

function OnLoad()
	PrintChat("Button Tester")
	TestButton = Button(GetSprite("buttonUp.dds"), GetSprite("buttonDown.dds"), 100, 100, 200, 100)
	TestButton:SetAlpha(220)
	TestButton:RemoveToggle(0.100)
	TestButton2 = Button(GetSprite("buttonUp.dds"), GetSprite("buttonDown.dds"), 200, 200, 200, 100)
	TestButton2:SetAlpha(200)
	--TestButton2:RemoveToggle(0.100)
	shiftDown = false
end

function OnDraw()
	TestButton:Draw()
	TestButton2:Draw()
end

function OnWndMsg(msg, key)
	if msg == 256 then -- ShiftDown
		shiftDown = true
	end
	if msg == 257 then -- ShiftUp
		shiftDown = false
	end
	if msg == WM_LBUTTONDOWN and shiftDown == true then
		--PrintChat(""..os.clock())
		TestButton:WndMsg()
		TestButton2:WndMsg()
	end
end
