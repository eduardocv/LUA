local scriptPlayer = require ("Player")
local perspective = require ("perspective")
local physics = require ("physics")

local physics = require ("physics")
physics.start ()
physics.setGravity (2, 9.8)
physics.setDrawMode ("normal")

--cria a camera
local camera = perspective.createView  ()
camera:prependLayer () -- prepara os layers da camera

display.setStatusBar (display.HiddenStatusBar)

local player = scriptPlayer.novo (240, 0)
camera:add (player, 1)

camera:setParallax (1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.1, 0)

camera.damping = 10 
camera:setFocus (player) 
camera:track() 


-- Escadas
local retangulo = display.newRect (120, 80, 100, 40)
physics.addBody (retangulo, "static")
camera:add (retangulo, 1)
local retangulo1 = display.newRect (250, 380, 100, 40)
physics.addBody (retangulo1, "static")
camera:add (retangulo1, 1)
local retangulo2 = display.newRect (180, 300, 100, 40)
physics.addBody (retangulo2, "static")
camera:add (retangulo2, 1)
local retangulo3 = display.newRect (380, 200, 100, 40)
physics.addBody (retangulo3, "static")
camera:add (retangulo3, 1)
local retangulo4 = display.newRect (480, 400, 100, 40)
physics.addBody (retangulo4, "static")
camera:add (retangulo4, 1)
local retangulo5 = display.newRect (580, 600, 100, 40)
physics.addBody (retangulo5, "static")
camera:add (retangulo5, 1)
local retangulo6 = display.newRect (580, 500, 100, 40)
physics.addBody (retangulo6, "static")
camera:add (retangulo6, 1)
local retangulo7 = display.newRect (780, 500, 100, 40)
physics.addBody (retangulo7, "static")
camera:add (retangulo7, 1)
retangulo7:setFillColor (0.3, 0.1, 0.3)
local retangulo8 = display.newRect (880, 500, 100, 40)
physics.addBody (retangulo8, "static")
camera:add (retangulo8, 1)
retangulo8:setFillColor (0.3, 0.1, 0.3)

