-- DESAFIO 07/06: Eduardo C. Vieira
-- Criar um jogo que tenha todas as funções (física, colisão, timer)
-- não pode ser igual aos projetos já realizados

local physics = require ("physics")
physics.start ()
physics.setGravity (0, 0)
physics.setDrawMode ("hybrid")
--physics.setDrawMode ("normal")
--physics.setDrawMode ("debug")
display.setStatusBar (display.HiddenStatusBar)

-- Grupos de exibição
local grupoBg = display.newGroup()
local grupoMain = display.newGroup()
local grupoUI = display.newGroup()

-- Variáveis de acertos e erros
local acertos = 0
local erros = 0

-- Background
local bg = display.newImageRect (grupoBg, "imagens/fundo.png", 390, 550)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

-- Acertos
local acertosText = display.newText (grupoUI, "Acertos: " .. acertos, 100, 40, native.systemFont, 20)
acertosText:setFillColor (255/0, 255/0, 0/255)

-- Erros
local errosText = display.newText (grupoUI, "Erros: " .. erros, 200, 40, native.systemFont, 20)
errosText:setFillColor (255/255, 0/255, 0/255)

-- Chão
local chao = display.newRect (grupoMain, display.contentCenterX, 480, 500, 50)
physics.addBody (chao, "static")
chao.myName = "Chão"

-- Teto
local teto = display.newRect (grupoMain, 100, 10, 500, 20)
physics.addBody (teto, "static")
teto.myName = "Teto"

-- Paredes
local paredeE = display.newRect (grupoMain, -10, display.contentCenterY, 20, 500)
physics.addBody (paredeE, "static")
paredeE.myName = "Parede Esquerda"

local paredeD = display.newRect (grupoMain, 330, display.contentCenterY, 20, 500)
physics.addBody (paredeD, "static")
paredeD.myName = "Parede Direita"

-- Arco
local arco = display.newImageRect (grupoMain, "imagens/arco.png", 221/3, 228/3)
physics.addBody (arco, "kinematic", {bounce=0.8, radius=40})
arco.x = 50
arco.y = 390
arco.myName = "Arco"
local direcaoArco = "esquerda"

-- Função da movimentação do arco
local function movimentoArco ()
    if not (arco.y == nil) then
        if (direcaoArco == "esquerda" ) then
            arco.x = arco.x - 1
        if (arco.x <= 50 ) then
            direcaoArco = "direita"
        end
        elseif (direcaoArco == "direita" ) then
            arco.x = arco.x + 1
            if (arco.x >= 270 ) then
              direcaoArco = "esquerda"
            end
        end
    else
        Runtime:removeEventListener ("enterFrame", movimentoArco)
    end
end

Runtime:addEventListener ("enterFrame", movimentoArco)


-- Função da flechada do arco
local function flechada ()
    local flecha = display.newImageRect (grupoMain, "imagens/flecha.png", 25/4, 188/4)
    flecha.x = arco.x 
    flecha.y = arco.y 
    physics.addBody (flecha, "dynamic", {isSensor=true})
    transition.to (flecha, {y=-500, time=1500, onComplete = function () display.remove (flecha) end})
    flecha.myName = "Flechada do Arco"
    flecha:toBack ()
end

local botaoFlecha = display.newImageRect (grupoMain, "imagens/botaoFlecha.png", 1280/35, 1279/35)
botaoFlecha.x = display.contentCenterX
botaoFlecha.y = 450
botaoFlecha:addEventListener ("tap", flechada)

-- Alvo
local alvo = display.newImageRect (grupoMain, "imagens/alvo.png", 154/1.5, 154/1.5)
physics.addBody (alvo, "kinematic", {bounce=0.8, radius=20})
alvo.x = 270
alvo.y = 120
alvo.myName = "Alvo"
local direcaoAlvo = "direita"

-- Função da movimentação do alvo
local function movimentoAlvo ()
    if not (alvo.y == nil) then
        if (direcaoAlvo == "esquerda" ) then
            alvo.x = alvo.x - 2
        if (alvo.x <= 50 ) then
            direcaoAlvo = "direita"
        end
        elseif (direcaoAlvo == "direita" ) then
            alvo.x = alvo.x + 2
            if (alvo.x >= 270 ) then
              direcaoAlvo = "esquerda"
            end
        end
    else
        Runtime:removeEventListener ("enterFrame", movimentoAlvo)
    end
end

Runtime:addEventListener ("enterFrame", movimentoAlvo)

-- Função de colisão
local function onCollision (event)
    if (event.phase == "began") then
        local obj1 = event.object1
        local obj2 = event.object2
        if ((obj1.myName == "Flechada do Arco" and obj2.myName == "Alvo") or (obj1.myName == "Alvo" and obj2.myName == "Flechada do Arco")) then
            if (obj1.myName == "Flechada do Arco") then
                display.remove (obj1)
            else
                display.remove (obj2)
            end

            acertos = acertos + 1
            acertosText.text = "Acertos: " .. acertos

            if (acertos >= 10) then
                acertosText:setFillColor (0/255, 255/0, 0/255)
-- -- Função da movimentação do alvo mais rápido após 10 acertos
-- local function movimentoAlvo ()
--     if not (alvo.y == nil) then
--         if (direcaoAlvo == "esquerda" ) then
--             alvo.x = alvo.x - 6
--         if (alvo.x <= 50 ) then
--             direcaoAlvo = "direita"
--         end
--         elseif (direcaoAlvo == "direita" ) then
--             alvo.x = alvo.x + 6
--             if (alvo.x >= 270 ) then
--               direcaoAlvo = "esquerda"
--             end
--         end
--     else
--         Runtime:removeEventListener ("enterFrame", movimentoAlvo)
--     end
-- end

-- Runtime:addEventListener ("enterFrame", movimentoAlvo)
                --erros = erros - 1 (pensando ainda em como fazer certinho)
            end
        elseif ((obj1.myName == "Flechada do Arco" and obj2.myName == "Teto") or (obj1.myName == "Teto" and obj2.myName == "Flechada do Arco")) then 
            erros = erros + 1
            errosText.text = "Erros: " .. erros
-- GAME OVER (Caso os erros ultrapassem os acertos)
            if (erros > acertos) then
                Runtime:removeEventListener ("collision", onCollision)
                Runtime:removeEventListener ("enterFrame", movimentoAlvo) 
                Runtime:removeEventListener ("enterFrame", movimentoArco)
                botaoFlecha:removeEventListener ("tap", flechada)
                local gameOver = display.newImageRect (grupoUI, "imagens/gameover.png", 1080/5, 1080/5)
                gameOver.x = display.contentCenterX
                gameOver.y = display.contentCenterY
            end
        end      
    end
end

Runtime:addEventListener ("collision", onCollision)

