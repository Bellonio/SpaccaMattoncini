push = require "push"
Class = require "class"
require "Pannello"
require "Palla"
require "Blocco"
require "Livello"


local WINDOW_WIDTH = 1260
local WINDOW_HEIGHT = 690

local VIRTUAL_WIDTH = 426
local VIRTUAL_HEIGHT = 243

suoni = {}
function love.load()
	
	math.randomseed(os.time())
	
	fontVittSconf = love.graphics.newFont("font/nuovoFont.ttf", 70)
	fontPt = love.graphics.newFont("font/nuovoFont.ttf", 30)
	love.graphics.setFont(fontVittSconf)
	
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		resizable = false,
		vsync = true,
		fullscreen = true
	})
	
	love.graphics.setDefaultFilter("nearest", "nearest")	
		
	immagine = love.graphics.newImage("immMattoni.png")			--prendo l'intera immagine con tutti i vari sprites'
	
	suoni["punto"] = love.audio.newSource("/suoni/punto.wav", "static")
	suoni["vittoria"] = love.audio.newSource("/suoni/vittoria.wav", "static")
	suoni["gameOver"] = love.audio.newSource("/suoni/gameOver.wav", "static")
	
	livello = Livello()
	livello:creaLivello()
	
	pannello = Pannello(love.graphics.getWidth()/2-(347*0.4/2), love.graphics.getHeight()-64, 347*livello.scalePann, 64*livello.scalePann, livello.scalePann)
	
	palla = Palla(love.graphics.getWidth()/2-(64*livello.scale)/2, love.graphics.getHeight()-130, 64*livello.scale, 64*livello.scale, livello.scale)
	
	statoGioco = "fermo"
end

function love.keypressed(key)
	if key == "escape" then love.event.quit() 
	elseif key == "return" then 
		if statoGioco == "fermo" then
			statoGioco = "start"
		elseif statoGioco == "vittoria" then
			statoGioco = "fermo"
			suoni["vittoria"]:stop()
			
			math.randomseed(os.time())
			livello:creaLivello()
			palla:reset()
			pannello:reset()
		end
	end
end

local delta

function love.update(dt)
	
	delta = dt
	if statoGioco ~= "perso" then pannello:update(dt) end
	livello:update() 
	
end

function love.draw()
	
	love.graphics.clear(40/255, 45/255, 52/255, 1)
	
	livello:renderBlocchi(delta)
	if statoGioco ~= "vittoria" then palla:render() end
	if statoGioco ~= "vittoria" then pannello:render() end

	if statoGioco == "perso" then
		love.graphics.setColor(1,0,0,1)
		love.graphics.print("GAME OVER", love.graphics.getWidth()/2-105, love.graphics.getHeight()/2-10)
		love.graphics.setFont(fontPt)
		love.graphics.print("Press ESC to quit.", love.graphics.getWidth()/2-80, love.graphics.getHeight()/2+90)
		love.graphics.setFont(fontVittSconf)
		love.graphics.setColor(1,1,1,1)
	elseif statoGioco == "vittoria" then
		love.graphics.setColor(0,1,0,1)
		love.graphics.print("VITTORIA !!!", love.graphics.getWidth()/2-110, love.graphics.getHeight()/2-10)
		love.graphics.setFont(fontPt)
		love.graphics.print("Press ENTER to play another level.", love.graphics.getWidth()/2-140, love.graphics.getHeight()/2+80)
		love.graphics.setFont(fontVittSconf)
		love.graphics.setColor(1,1,1,1)
	elseif statoGioco == "start" then
		love.graphics.setFont(fontPt)
		love.graphics.setColor(0,1,0,1)
		love.graphics.print(livello:punteggio(), love.graphics.getWidth()-50, love.graphics.getHeight()-50)	
		love.graphics.setColor(1,1,1,1)
		love.graphics.setFont(fontVittSconf)
	else
		love.graphics.setColor(0,1,0,1)
		love.graphics.setFont(fontPt)
		love.graphics.print("Press ENTER to play.", love.graphics.getWidth()/2-90, love.graphics.getHeight()/2-10)
		love.graphics.setFont(fontVittSconf)
		love.graphics.setColor(1,1,1,1)
	end
	
end
