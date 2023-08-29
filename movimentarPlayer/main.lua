local bg = display.newImageRect ("imagens/sky.png", 960*2, 240*2)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local chao = display.newImageRect ("imagens/ground.png", 1028, 256)
chao.x = display.contentCenterX
chao.y = 490

local player = display.newImageRect ("imagens/player.png", 532/4, 469/4)
player.x = 50
player.y = 300

-- Andar para a direita
local function direita ()
    player.x = player.x + 2
end

local botaoDireita = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoDireita.x = 310
botaoDireita.y = 420
botaoDireita:addEventListener ("tap", direita)

-- Andar para a esquerda
local function esquerda ()
    player.x = player.x - 2
end

local botaoEsquerda = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoEsquerda.x = 240
botaoEsquerda.y = 420
botaoEsquerda.rotation = 180
botaoEsquerda:addEventListener ("tap", esquerda)

-- Andar para baixo
local function baixo ()
    player.y = player.y + 2
end

local botaoBaixo = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoBaixo.x = 275
botaoBaixo.y = 455
botaoBaixo.rotation = 90
botaoBaixo:addEventListener ("tap", baixo)

-- Andar para cima
local function cima ()
    player.y = player.y - 2
end

local botaoCima = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoCima.x = 275
botaoCima.y = 385
botaoCima.rotation = 270
botaoCima:addEventListener ("tap", cima)

-- Andar para diagonal1
local function diagonal1 ()
    player.y = player.y - 2
    player.x = player.x - 2
end

local botaoDiagonal1 = display.newImageRect ("imagens/button.png", 1280/50, 1279/50)
botaoDiagonal1.x = 235
botaoDiagonal1.y = 380
botaoDiagonal1.rotation = 225
botaoDiagonal1:addEventListener ("tap", diagonal1)

-- Andar para diagonal2
local function diagonal2 ()
    player.y = player.y - 2
    player.x = player.x + 2
end

local botaoDiagonal2 = display.newImageRect ("imagens/button.png", 1280/50, 1279/50)
botaoDiagonal2.x = 315
botaoDiagonal2.y = 380
botaoDiagonal2.rotation = 315
botaoDiagonal2:addEventListener ("tap", diagonal2)

-- Andar para diagonal3
local function diagonal3 ()
    player.y = player.y + 2
    player.x = player.x - 2
end

local botaoDiagonal3 = display.newImageRect ("imagens/button.png", 1280/50, 1279/50)
botaoDiagonal3.x = 235
botaoDiagonal3.y = 460
botaoDiagonal3.rotation = 135
botaoDiagonal3:addEventListener ("tap", diagonal3)

-- Andar para diagonal4
local function diagonal4 ()
    player.y = player.y + 2
    player.x = player.x + 2
end

local botaoDiagonal4 = display.newImageRect ("imagens/button.png", 1280/50, 1279/50)
botaoDiagonal4.x = 315
botaoDiagonal4.y = 460
botaoDiagonal4.rotation = 45
botaoDiagonal4:addEventListener ("tap", diagonal4)