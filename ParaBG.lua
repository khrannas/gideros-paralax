--[[
	This class will handle a parallax background as a sprite that is 
	self contained and should be useful to the game designers.
	
	The original code is from: http://giderosmobile.com/forum/discussion/387/parallax-background
	and all credit should go to Adnaan, I just cleaned it up a little and made a Sprite class out of it :)
]]
ParaBG = Core.class(Sprite)

function ParaBG:init(bgs, bgspeed)

	self.bgs1 = {}
	self.bgs2 = {}

	i = 0;
	
	for key, value in pairs(bgs) do
		i = i+1
		print(value)
		self.bgs1[i] = Bitmap.new(Texture.new(value),true)
		self.bgs2[i] = Bitmap.new(Texture.new(value),true)
		-- Set the starting points.
		self.bgs1[i].bgFarY=0
		--self.bgs1.bgNearY=0
		self:addChild(self.bgs1[i])
		self:addChild(self.bgs2[i])
	end
	self.bgspeed = bgspeed
		
	--Event--
	self:addEventListener(Event.ENTER_FRAME, self.DrawParaBG, self)
end

-- Do the actual drawing of the backgrounds and update based on speed.
function ParaBG:DrawParaBG(event, container)

	for i=1, #self.bgs1 do
		self.bgs1[i].bgFarY = (self.bgs1[i].bgFarY or 0) - ((self.bgspeed or 4.0) / ((#self.bgs1-i)*4+1))
		--self.bgNearY = (self.bgNearY or 0) - ((self.bgspeed or 4.0))
 
		self.bgs1[i].newFarY = self.bgs1[i]:getWidth() -(-self.bgs1[i].bgFarY)
		if self.bgs1[i].newFarY <=0 then
			self.bgs1[i].bgFarY = 0
			self.bgs1[i]:setX(self.bgs1[i].bgFarY)
		else
			self.bgs1[i]:setX(self.bgs1[i].bgFarY)
			self.bgs2[i]:setX(self.bgs1[i].newFarY)
		end
	end

end

-- Allows game to dynamically change the background speed--useful for say power ups.
function ParaBG:setSpeed(bgspeed)
	self.bgspeed = bgspeed
end

-- Get the current speed, useful if you need to store the speed and reset it later in the game.
function ParaBG:getSpeed()
	return self.bgspeed
end
