Palla = Class{}

function Palla:init(x, y, w, h, s)
	
	self.x = x
	self.y = y
	self.width = w
	self.height = h
	self.scale = s
	
	self.dx = math.random(1,2) == 1 and -30 or 30
	self.dy = math.random(-35, -25)
	
										--posX e posY dell'immagine, largh e altezza Quad da prendere dall'imamgine, dimensioni dell'immagine
	self.framePalla = love.graphics.newQuad(1403, 652, 64,64, immagine:getDimensions())
	
end

function Palla:reset()
	palla.x = love.graphics.getWidth()/2-(64*livello.scale)/2
	palla.y = love.graphics.getHeight()-130
	self.dx = math.random(1,2) == 1 and -30 or 30
	self.dy = math.random(-20, -10)
end

function Palla:update(dt)
	
	self:collisionePannello()
	self:collisioneMuri()	
	
	self.x = self.x+self.dx*dt
	self.y = self.y+self.dy*dt
	
end

function Palla:collisioneMuri()
		
		--anche qui vado a controllare se la palla superasse il muro, quindi non controllo che la x o y sia == al limite
	
	if self.x <= 0 then
		self.dx = self.dx*-1
	elseif self.x+self.width >= love.graphics.getWidth() then
		self.dx = self.dx*-1
	end
	
	if self.y <= 0 then
		self.dy = self.dy*-1
	elseif self.y >= pannello.y+pannello.height then
		self.dx = 0
		self.dy = 0
		statoGioco = "perso"
		suoni["gameOver"]:play()
	end
	
end

function Palla:collisionePannello()
	
	if (math.floor(self.y) == math.floor(pannello.y-self.height)) and ((math.floor(self.x) >= pannello.x and math.floor(self.x) <= pannello.x+pannello.width) or (math.floor(self.x)+self.width >= pannello.x and math.floor(self.x)+self.width <= pannello.x+pannello.width)) then
		
			--aumento la velocita della palla, per far cio' pero' devo AUMENTARE o DIMINUIRE il valore in base al segno di quel valore
		self.dy = self.dy < 0 and (self.dy-2)*-1 or (self.dy+2)*-1
		self.dx = self.dx < 0 and (self.dx-2) or (self.dx+2)
	end
end

function Palla:render()
	
	if statoGioco ~= "perso" then
		love.graphics.draw(immagine, self.framePalla, self.x, self.y, 0, self.scale, self.scale)
	end
end
