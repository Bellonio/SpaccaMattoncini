Livello = Class{}

	--ALL'INTERNO DEL FILE ZIP CHE HO SCARICATO PER GLI SPRITES, C'ERA ANCHE UN FILE.xml CHE CONTENEVA LE POSIZIONI E LE DIMENSIONI DI OGNI SPRITE NELL'IMMAGINE, NON SAPENDO COME FAR LEGGERE IL FILE DAL PROGRAMMA HO COPIATO MANUALMENTE IO I VALORI


local LARGH_BLOCCHI = 385
local ALT_BLOCCHI = 130

local X_BLOCCHI = {
	[1] = LARGH_BLOCCHI*2,			--BLOCCO_ARANCIO
	[2] = 0,					--BLOCCO_VERDINO
	[3] = LARGH_BLOCCHI,			--BLOCCO_VERDE
	[4] = LARGH_BLOCCHI*2,		--BLOCCO_ROSSO
	[5] = 0,						--BLOCCO_VIOLA
	[6] = LARGH_BLOCCHI,		--BLOCCO_GIALLO
	[7] = LARGH_BLOCCHI*2,			--BLOCCO_BLU
	[8] = LARGH_BLOCCHI*2,		--BLOCCO_GRIGIO
	[9] = LARGH_BLOCCHI,			--BLOCCO_AZZURRO
	[10] = LARGH_BLOCCHI		--BLOCCO_MARRONE
}

local Y_BLOCCHI = {
	[1] = 0,					--BLOCCO_ARANCIO
	[2] = ALT_BLOCCHI,				--BLOCCO_VERDINO
	[3] = ALT_BLOCCHI,			--BLOCCO_VERDE
	[4] = ALT_BLOCCHI*2,			--BLOCCO_ROSSO
	[5] = ALT_BLOCCHI*3,		--BLOCCO_VIOLA
	[6] = ALT_BLOCCHI*3,			--BLOCCO_GIALLO
	[7] = ALT_BLOCCHI*3,		--BLOCCO_BLU
	[8] = ALT_BLOCCHI*4,			--BLOCCO_GRIGIO
	[9] = ALT_BLOCCHI*5,		--BLOCCO_AZZURRO
	[10] = ALT_BLOCCHI*6			--BLOCCO_MARRONE
}

local blocchi = {}
contatoreBloccoColpito = 0

function Livello:init() 
	NUM_VITTORIE = 0
	
	self.scale = 3/10
	self.scalePann = 4/10
end

function Livello:creaLivello()
	local righe = NUM_VITTORIE+1				--ad ogni vittoria aumenta il numero di righe
	
	local xBlocco
	local yBlocco = ALT_BLOCCHI*2*self.scale
	local y
	local x
	local index = 1
	
	for y=1, righe do
		xBlocco = 100
		for x=1, 9 do
			
			numBlocco = math.random(1,10)				--sceglie casualmente il colore del blocco
			
								--posX e posY dell'immagine, largh e altezza Quad da prendere dall'imamgine, dimensioni dell'immagine
			quad = love.graphics.newQuad(X_BLOCCHI[numBlocco], Y_BLOCCHI[numBlocco], LARGH_BLOCCHI, ALT_BLOCCHI, immagine:getDimensions())
			
			blocchi[index] = Blocco(xBlocco, yBlocco, LARGH_BLOCCHI*self.scale, ALT_BLOCCHI*self.scale, self.scale, quad)
			index = index+1			
			
			xBlocco = xBlocco+LARGH_BLOCCHI*self.scale
		end
		yBlocco = yBlocco+ALT_BLOCCHI*self.scale
	end	
end

function Livello:update()
	if contatoreBloccoColpito == #blocchi and statoGioco ~= "vittoria" then
		contatoreBloccoColpito = 0
		blocchi = {}
		NUM_VITTORIE = NUM_VITTORIE+1
		suoni["vittoria"]:play()
		statoGioco = "vittoria"
	end
end

function Livello:punteggio()
	
		--ho scaricato l'unico font al mondo che non ha lo 0 ma un simbolo strano al posto
	cont_Bl_stringa = tostring(contatoreBloccoColpito)
	cont_Bl_stringa = string.gsub(cont_Bl_stringa, "0", "O")
	
	qtaBlocchi_stringa = tostring(#blocchi)	
	qtaBlocchi_stringa = string.gsub(qtaBlocchi_stringa, "0", "O")	
		
	return cont_Bl_stringa.."/"..qtaBlocchi_stringa
end

function Livello:renderBlocchi(dt)
	local index = #blocchi
	while index>=1 do
		if statoGioco == "start" then palla:update(dt) end
		if blocchi[index].colpito == false then blocchi[index]:render() end
		index = index-1
	end
end
