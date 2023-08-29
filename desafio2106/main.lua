-- Desafio 21/06
-- 20 min. para adicionar uma junta física que tenha alguma utilidade
local physics = require ("physics")
physics.start ()
physics.setGravity (0, 9.8)
physics.setDrawMode ("normal")

display.setStatusBar (display.HiddenStatusBar)

local grupoBg = display.newGroup()
local grupoMain = display.newGroup()
local grupoUI = display.newGroup()

local vidas = 10

local vidasText = display.newText (grupoUI, "Vidas: " .. vidas, 100, 30, native.systemFont, 20)
vidasText:setFillColor (255/255, 255/255, 0/255)

local chao = display.newRect (grupoMain, display.contentCenterX, 480, 500, 50)
physics.addBody (chao, "static")
chao.myName = "Chão"

local teto = display.newRect (grupoMain, 100, 10, 500, 20)
physics.addBody (teto, "static")
teto.myName = "Teto"

local paredeE = display.newRect (grupoMain, -10, display.contentCenterY, 20, 500)
physics.addBody (paredeE, "static")
paredeE.myName = "Parede Esquerda"

local paredeD = display.newRect (grupoMain, 330, display.contentCenterY, 20, 500)
physics.addBody (paredeD, "static")
paredeD.myName = "Parede Direita"

physics.setGravity (0, 9.8)
-- player
local player = display.newImageRect (grupoMain, "imagens/player.png", 532/7, 469/7)
physics.addBody (player, "dynamic", {bounce=0.3, radius=40, friction=0.5})
--physics.addBody (player, "kinematic", {bounce=0.8, radius=40, friction=0.5, density=0})
player.x = 150
player.y = 50
player.myName = "Jogador"

-- Andar para a direita
local function direita ()
    player.x = player.x + 10
end

local botaoDireita = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoDireita.x = 310
botaoDireita.y = 420
botaoDireita:addEventListener ("tap", direita)

-- Andar para a esquerda
local function esquerda ()
    player.x = player.x - 10
end

local botaoEsquerda = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoEsquerda.x = 240
botaoEsquerda.y = 420
botaoEsquerda.rotation = 180
botaoEsquerda:addEventListener ("tap", esquerda)

local joint

-- Junta de pistão
local static staticBox = display.newRect (0, 0 , 60, 60)
staticBox:setFillColor (0.2, 0.2, 1)
physics.addBody (staticBox, "static", {isSensor=true})
staticBox.x, staticBox.y = display.contentCenterX, 360

local shape = display.newRect (0, 0, 140, 30)
shape:setFillColor (1, 0.2, 0.4)
physics.addBody (shape, "dynamic", {bounce=1,})
shape.x, shape.y = display.contentCenterX, 310
-- ("tipo de junta", objA, objB, ancorax, ancoraY, eixoX, eixoY)
local jointPiston = physics.newJoint ("piston", staticBox, shape, shape.x, shape.y, 0, 1)
jointPiston.isMotorEnabled = true -- ativa o motor da junta
jointPiston.motorSpeed = -40 -- define a velocidade do motor (valor negativo faz a movimentação inversa)
jointPiston.maxMotorForce = 500 -- define o valor máximo da força do motor
jointPiston.isLimitEnabled = true -- define que a junta possui limites de movimentação
jointPiston:setLimits (-100, 0)

local function movimentarPlataforma ()
    if (shape.y <= 210) then
        jointPiston.motorSpeed = 40
        print ("baixo")
    elseif (shape.y >= 350) then
        jointPiston.motorSpeed = -40
        print ("cima")
    end
end
Runtime:addEventListener ("enterFrame", movimentarPlataforma)