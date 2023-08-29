-- Revisão 30/05
-- chamar a biblioteca de física
local physics = require ("physics")
-- iniciar o motor de física
physics.start ()
-- definir a gravidade
physics.setGravity (0, 0)
-- definir o mod de renderização
physics.setDrawMode ("hybrid")
--physics.setDrawMode ("normal")
--physics.setDrawMode ("debug")
-- remover a barra de notificações
display.setStatusBar (display.HiddenStatusBar)

-- criar os grupos de exibição
-- usado para plano de fundo, decorações que não terão interação com o jogo
local grupoBg = display.newGroup()
-- usado para os objetos que terão interação dentro do jogo (grupo principal)
local grupoMain = display.newGroup()
-- utilizado para placar, vidas, texto que ficar na frente do jogo, porém sem interação
local grupoUI = display.newGroup()

-- criar variáveis de pontos e vidas para atribuição de valor
local pontos = 0
local vidas = 5

-- adicionar background
local bg = display.newImageRect (grupoBg, "imagens/background.png", 360, 570)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

-- adicionar placar na tela
local pontosText = display.newText (grupoUI, "Pontos: " .. pontos, 100, 30, native.systemFont, 20)
pontosText:setFillColor (255/255, 0/255, 0/255)

-- adicionar vida na tela
local vidasText = display.newText (grupoUI, "Vidas: " .. vidas, 200, 30, native.systemFont, 20)
vidasText:setFillColor (255/255, 0/255, 0/255)

-- chão
local chao = display.newRect (grupoMain, display.contentCenterX, 480, 500, 50)
physics.addBody (chao, "static")
chao.myName = "Chão"

local ground = display.newImageRect (grupoBg, "imagens/ground.png", 4503/10, 613/20) 
ground.x = display.contentCenterX
ground.y = 460
ground:toFront ()

-- teto
local teto = display.newRect (grupoMain, 100, 10, 500, 20)
physics.addBody (teto, "static")
teto.myName = "Teto"

-- paredes
local paredeE = display.newRect (grupoMain, -10, display.contentCenterY, 20, 500)
physics.addBody (paredeE, "static")
paredeE.myName = "Parede Esquerda"

local paredeD = display.newRect (grupoMain, 330, display.contentCenterY, 20, 500)
physics.addBody (paredeD, "static")
paredeD.myName = "Parede Direita"

-- player
local player = display.newImageRect (grupoMain, "imagens/player_h.png", 514/6, 300/6)
--physics.addBody (player, "dynamic", {bounce=0.8, radius=40})
physics.addBody (player, "kinematic", {bounce=0.8, radius=40})
player.x = 50
player.y = 390
player.myName = "Jogador"


-- movimentação do player
-- Andar para baixo
local function baixo ()
    player.y = player.y + 10
end

local botaoBaixo = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoBaixo.x = 120
botaoBaixo.y = 450
botaoBaixo.rotation = 90
botaoBaixo:addEventListener ("tap", baixo)

-- Andar para cima
local function cima ()
    player.y = player.y - 10
end

local botaoCima = display.newImageRect ("imagens/button.png", 1280/35, 1279/35)
botaoCima.x = 200
botaoCima.y = 450
botaoCima.rotation = 270
botaoCima:addEventListener ("tap", cima)

-- função tiro do player
local function atirar ()
    local tiroPlayer = display.newImageRect (grupoMain, "imagens/projetil.png", 187/4, 45/4)
    tiroPlayer.x = player.x +40
    tiroPlayer.y = player.y 
    physics.addBody (tiroPlayer, "dynamic", {isSensor=true})
    transition.to (tiroPlayer, {x=500, time=500, onComplete = function () display.remove (tiroPlayer) end})
    tiroPlayer.myName = "Tiro do Player"
    tiroPlayer:toBack ()
end

local botaoTiro = display.newImageRect (grupoMain, "imagens/botaoTiro.png", 1280/35, 1279/35)
botaoTiro.x = display.contentCenterX
botaoTiro.y = 450
botaoTiro:addEventListener ("tap", atirar)

-- inimigo
local inimigo = display.newImageRect (grupoMain, "imagens/inimigo_h.png", 514/6, 300/6)
--physics.addBody (inimigo, "dynamic", {bounce=0.8, radius=40})
physics.addBody (inimigo, "kinematic", {bounce=0.8, radius=40})
inimigo.x = 270
inimigo.y = 150
inimigo.myName = "Inimigo"
local direcaoInimigo = "cima"

-- função para o inimigo atirar:
local function inimigoAtirar ()
    local tiroInimigo = display.newImageRect (grupoMain, "imagens/projetil.png", 187/4, 45/4)
    tiroInimigo.rotation = 180
    tiroInimigo.x = inimigo.x -40
    tiroInimigo.y = inimigo.y
    physics.addBody (tiroInimigo, "dynamic", {isSensor=true})
    transition.to (tiroInimigo, {x=-200, time=1000, onComplete = function () display.remove (tiroInimigo) end})
    tiroInimigo.myName = "Tiro do Inimigo"
    tiroInimigo:toBack ()
end
-- criar o timer para disparo do inimigo
-- comandos timer: (tempo repetição, função, quantidade de repetições)
inimigo.timer = timer.performWithDelay (math.random (1000, 1500), inimigoAtirar, 0)

-- função da movimentação do inimigo
local function movimentarInimigo ()
-- se a localização x não for igual a nulo então
    if not (inimigo.x == nil) then
-- quando a direção do inimigo for cima então        
        if (direcaoInimigo == "cima" ) then
            inimigo.y = inimigo.y - 1
-- se a localização y do inimigo for menor ou igual a 70 então        
        if (inimigo.y <= 70 ) then
-- altera a variável para "baixo"
            direcaoInimigo = "baixo"
        end
-- se a direção do inimigo for igual a "baixo" então
        elseif (direcaoInimigo == "baixo" ) then
            inimigo.y = inimigo.y + 1
-- se a localização do inimigo for maior ou igual a 400 então
            if (inimigo.y >= 400 ) then
-- altera a variável para "cima"                
              direcaoInimigo = "cima"
            end
        end

    else
        print ("Inimigo morreu!")
-- Runtime: representa todo o jogo (evento é executado para todos), 
-- enterFrame: está ligado ao valor de FPS do jogo (frames por segundo),
-- no caso, a função vai ser executada 60 vezes por segundo.
        Runtime:removeEventListener ("enterFrame", movimentarInimigo)
    end
end

Runtime:addEventListener ("enterFrame", movimentarInimigo)

-- função de colisão
local function onCollision (event)
-- quando a fase de evento for began então
    if (event.phase == "began") then
-- variáveis criadas para facilitar a escrita do código
        local obj1 = event.object1
        local obj2 = event.object2
-- quando o myName do objeto1 for ... e o nome do objeto2 for ...
        if ((obj1.myName == "Tiro do Player" and obj2.myName == "Inimigo") or (obj1.myName == "Inimigo" and obj2.myName == "Tiro do Player")) then
-- se o objeto1 for ... então            
            if (obj1.myName == "Tiro do Player") then
-- remove o projetil do player                
                display.remove (obj1)
            else
-- remove o                 
                display.remove (obj2)
            end

            pontos = pontos + 10
            pontosText.text = "Pontos: " .. pontos

            if (pontos >= 100) then
                pontosText:setFillColor (255/0, 255/0, 0/255)
                --vidas = vidas + 1
            end
     
        elseif ((obj1.myName == "Jogador" and obj2.myName == "Tiro do Inimigo") or (obj1.myName == "Tiro do Inimigo" and obj2.myName == "Jogador")) then 
            if (obj1.myName == "Tiro do Inimigo") then
            display.remove (obj1)
            else 
            display.remove (obj2)
            end     
-- reduz uma vida do player a cada colisão            
        vidas = vidas - 1
        vidasText.text = "Vidas: " .. vidas
        end      
    end
end

Runtime:addEventListener ("collision", onCollision)

