class "Button" -- {
	function Button:__init(sprite, spriteTwo, spritePosX, spritePosY, spriteWidth, spriteHeight)		
		self.spriteOne = sprite
		self.spriteAlt = spriteTwo
		self.spriteX = spritePosX
		self.spriteY = spritePosY
		self.spriteW = spriteWidth
		self.spriteH = spriteHeight
		self.spriteAltTime = 0 -- millisecond value.
		self.spriteAltStart = 0
		self.spriteDrawAlt = false
		self.drawButton = true
		self.alpha = 255
		self.isToggle = true
		self.nonToggleState = false
	end
	
	function Button:RemoveToggle(durationDown)
		self.isToggle = false
		self.spriteAltTime = durationDown
	end
	
	function Button:Draw()
		if self.spriteDrawAlt and self.drawButton then
			if self.isToggle then
				self.spriteAlt:Draw(self.spriteX, self.spriteY, self.alpha)
			else
				if os.clock() >= self.spriteAltStart + self.spriteAltTime then
					self.spriteDrawAlt = false
					self.spriteOne:Draw(self.spriteX, self.spriteY, self.alpha)
				else
					self.spriteAlt:Draw(self.spriteX, self.spriteY, self.alpha)
				end
			end
		elseif self.drawButton then
			self.spriteOne:Draw(self.spriteX, self.spriteY, self.alpha)
		end
	end
	
	function Button:WndMsg()
		local curPos = GetCursorPos()
		if curPos.x >= self.spriteX and curPos.y >= self.spriteY and curPos.x <= self.spriteX + self.spriteW and curPos.y <= self.spriteY + self.spriteH then
			if self.spriteDrawAlt then
				if self.isToggle == true then
					self.spriteDrawAlt = false
				end
			else
				self.spriteDrawAlt = true
				if self.isToggle == false then
					self.spriteAltStart = os.clock()
				end
			end
		end
	end
	
	function Button:SetAlpha(value)
		self.alpha = value
	end
	
	function Button:ChangeXY(newX, newY)
		self.spriteX = newX
		self.spriteY = newY
	end
	
	function Button:Display(doDraw)
		self.drawButton = doDraw
	end
	
	 -- If it is a toggle it will return if it is on (pressed) or off (un-pressed)
	 -- If it is not a toggle it will simply return true if it has been toggled the next call to it will return false.
	function Button:GetState()
		if self.isToggle then
			return self.spriteDrawAlt
		end
		if self.isToggle == false then
			if self.nonToggleState == true then
				self.nonToggleState = false
				return true
			else
				return false
			end
		end
	end
	
