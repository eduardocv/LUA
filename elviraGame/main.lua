-- biblioteca de física
local physics = require ("physics")
physics.start ()
physics.setDrawMode ("hybrid")
-- physics.setDrawMode ("debug")
physics.setGravity (0, 9.8)

-- Remover a barra de notificação
display.setStatusBar (display.HiddenStatusBar)

local bg = display.newImageRect ("imagens/sky.png", 960, 240*2)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

-- Chão
local chao = display.newImageRect ("imagens/ground.png", 1028, 256)
chao.x = display.contentCenterX
chao.y = 370
physics.addBody (chao, "static")

-- Jogador
local player = display.newImageRect ("imagens/player.png", 532/4, 469/4)
player.x = 10
player.y = 190
physics.addBody (player, "dynamic", {radius=40, bounce=0, friction=0.5, density=0})

-- Andar para a direita
local function direita ()
    player.x = player.x + 4
end

local botaoDireita = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoDireita.x = 570
botaoDireita.y = 270
botaoDireita:addEventListener ("tap", direita)

-- Andar para a esquerda
local function esquerda ()
    player.x = player.x - 4
end

local botaoEsquerda = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoEsquerda.x = 530
botaoEsquerda.y = 270
botaoEsquerda.rotation = 180
botaoEsquerda:addEventListener ("tap", esquerda)

-- Andar para baixo
local function baixo ()
    player.y = player.y + 4
end

local botaoBaixo = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoBaixo.x = 550
botaoBaixo.y = 300
botaoBaixo.rotation = 90
botaoBaixo:addEventListener ("tap", baixo)

-- Toques de pulo (vai ser transformado em pontos)
local numToques = 0

local toquesText = display.newText (numToques, display.contentCenterX, 50, native.systemFont, 40)
toquesText:setFillColor (0, 0, 0)

-- Andar para cima
-- local function cima ()
--     player.y = player.y - 4
-- end

local function cima ()
    player:applyLinearImpulse (0, -0.40, player.x, player.y)
    numToques = numToques + 1
    toquesText.text = numToques
end

local botaoCima = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoCima.x = 550
botaoCima.y = 240
botaoCima.rotation = 270
botaoCima:addEventListener ("tap", cima)

