-- Desafio 29/05/2023 Eduardo C. Vieira
local physics = require ("physics")
physics.start ()
physics.setGravity (2, 9.8)
--physics.setDrawMode ("hybrid")

display.setStatusBar (display.HiddenStatusBar)

-- Teto, Chão e Paredes
local cima = display.newRect (display.contentCenterX, 0, 500, 50)
physics.addBody (cima, "static")
cima.myName = "Teto"

local baixo = display.newRect (display.contentCenterX, 480, 500, 50)
physics.addBody (baixo, "static")
baixo.myName = "Chão"

local esquerda = display.newRect (-15, display.contentCenterY, 50, 500)
physics.addBody (esquerda, "static")
esquerda.myName = "Parede Esquerda"

local direita = display.newRect (330, display.contentCenterY, 50, 500)
physics.addBody (direita, "static")
direita.myName = "Parede Direita"

-- Objetos que vão colidir
local ovo = display.newImageRect ("imagens/ovo.png", 301, 167)
ovo.x = display.contentCenterX
ovo.y = display.contentCenterY
physics.addBody (ovo, "dynamic", {bounce=0.8, radius=48})
ovo.myName = "Ovo"

local circulo = display.newCircle (300, 50, 30)
physics.addBody (circulo, "dynamic", {radius=30})

-- Colisão local:
local function colisaoLocal (event)
    if (event.phase == "began") then
        circulo:setFillColor (0.1, 0.4, 0.1)
    else
        circulo:setFillColor (0.1, 0.2, 0.3)
    end
end
circulo:addEventListener ("collision", colisaoLocal)
