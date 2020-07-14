Pannello = Class{}

local VELOCITA_SPOST = 450

function Pannello:init(x, y, w, h, s)
	
	self.x = x
	self.y = y
	self.width = w
	self.height = h
	self.scale = s
	
	self.dx = 0
	
									--posX e posY dell'immagine, largh e altezza Quad da prendere dall'imamgine, dimensioni dell'immagine
	self.framePannello = love.graphics.newQuad(0, 910, 347, 64, immagine:getDimensions())
	
end

function Pannello:reset()
	
	self.x = love.graphics.getWidth()/2-(347*0.4/2)
	self.y = love.graphics.getHeight()-64
	self.dx = 0
	
end

function Pannello:update(dt)
	
	if love.keyboard.isDown("a") then
		self.dx = -VELOCITA_SPOST-(150*NUM_VITTORIE)
	elseif love.keyboard.isDown("d") then
		self.dx = VELOCITA_SPOST+(150*NUM_VITTORIE)
	else
		self.dx = 0
	end
	
		--controllo che non superi il limite dello schermo
	if self.x+self.dx*dt > 0 and self.x+self.dx*dt+self.width < love.graphics.getWidth() then
		self.x = self.x+self.dx*dt
	end
	
end

function Pannello:render()
	love.graphics.draw(immagine, self.framePannello, self.x, self.y, 0, self.scale, self.scale)
end
