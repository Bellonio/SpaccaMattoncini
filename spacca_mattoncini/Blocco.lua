Blocco = Class{}

function Blocco:init(x, y, w, h, s, q)
	
	self.x = x
	self.y = y
	self.width = w
	self.height = h
	self.scale = s
	self.quad = q
	
	self.colpito = false
	
end

function Blocco:render()
				--immagineConSprites, Quad, posX, posY, rotazione(radianti), scalaX, scalaY
	love.graphics.draw(immagine, self.quad, self.x, self.y, 0, self.scale, self.scale)
	
	if palla.y <= love.graphics.getHeight()-250 then			--non tento neanche la collisione se non puo' avvenire
		
			--la y o x della palla non saranno mai == alla y o x del blocco (tentato con print(), leggermente diverso, non uguale), per questo nelle collisioni in realta' vado a vedere se la palla e' "entrata", seppur di poco, nel blocco.
			
			--collisone da sotto
		if (math.floor(palla.y) <= self.y+self.height and math.floor(palla.y) >= self.y+self.height-10) and ((math.floor(palla.x) >= self.x and math.floor(palla.x) <= self.x+self.width) or (math.floor(palla.x)+palla.width >= self.x and math.floor(palla.x)+palla.width <= self.x+self.width)) then

				--puo' capitare che la palla colpisca tra un blocco e un altro, andando a colpirli entrambi la sua dy verrebbe invertita due volte molto velocemente, quindi in pratica la direzione rimarra' la stessa. Per questo, visto che si tratta di collisione da sotto, io vado a invertire direzione solo se essa va dal basso verso l'alto.
				 
			if palla.dy < 0 then palla.dy = -1*palla.dy end
			self.colpito = true
		
			--collisione dai lati. Gestisco entrambi in un unico if
		elseif ((math.floor(palla.y) >= self.y and math.floor(palla.y) <= self.y+self.height) or (math.floor(palla.y)+palla.height >= self.y and math.floor(palla.y)+palla.height <= self.y+self.height)) and ((math.floor(palla.x) <= self.x+self.width and math.floor(palla.x) >= self.x+self.width-10) or (math.floor(palla.x)+palla.width >= self.x and math.floor(palla.x)+palla.width <= self.x+10)) then
		
				palla.dx = -1*palla.dx
				self.colpito = true
			
			--collisione da sopra
		elseif (math.floor(palla.y)+palla.height >= self.y and math.floor(palla.y)+palla.height <= self.y+10) and ((math.floor(palla.x) > self.x and math.floor(palla.x) < self.x+self.width) or (math.floor(palla.x)+palla.width > self.x and math.floor(palla.x)+palla.width < self.x+self.width)) then
			
				--idem di sopra. Devo gestire la doppia collisione con il blocco			
			
			if palla.dy > 0 then palla.dy = -1*palla.dy end
			self.colpito = true
		end
		
		if self.colpito == true then
			suoni["punto"]:play()
			contatoreBloccoColpito = contatoreBloccoColpito+1
		end
	end
end
