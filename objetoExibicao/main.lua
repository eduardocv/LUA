-- adicionar nova imagem na tela
-- comandos: display.newImageRect ("pasta/arquivo.formato", largura, altura)
local bg = display.newImageRect ("imagens/bg.jpg", 1280*1.25, 720*1.25)
-- definir localização do objeto.
-- comando: variável.linha que vou definir = localização na linha.
bg.x = display.contentCenterX -- colocando no centro da linha X
bg.y = display.contentCenterY -- colocando no centro da linha Y
-- colocando o Pikachu
local pikachu = display.newImageRect ("imagens/pikachu.png", 1191/5, 1254/5)
pikachu.x = display.contentCenterX
pikachu.y = display.contentCenterY
-- colocando o Mystery à direita
local mystery = display.newImageRect ("imagens/mystery.png", 493/2, 506/2)
mystery.x = 780
mystery.y = 580
-- Círculo display.newCircle (x, y, raio)
local kkk = display.newCircle (200, 480, 50)
-- DESAFIO !! Adicionar o Mystery em cima do retângulo e o charmander na diagonal do círculo (para baixo)
-- colocando o Charmander à esquerda
local charmander = display.newImageRect ("imagens/charmander.png", 507/2, 492/2)
charmander.x = 200 
charmander.y = 380
---criar um objeto na tela--
-- Retângulo display.newRect (x, y, largura, altura)
local retangulo = display.newRect (750, 380, 100, 70)
-- Círculo display.newCircle (x, y, raio)
local kkk = display.newCircle (200, 480, 50)
-- DESAFIO !! Adicionar o Mystery em cima do retângulo e o charmander na diagonal do círculo (para baixo)
