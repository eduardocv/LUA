-- Fisica
-- Chamar a biblioteca: atribui a biblioteca interna de física à variável physics
local physics = require ("physics")
-- Iniciar a fisica no projeto
physics.start ()
-- Define a gravidade do projeto: definir a gravidade x e y do projeto
physics.setGravity (0, 9.8)
-- Define a renderização da visualização da física (usado somente durante o desenvolvimento para testes)
-- Modos --
-- normal: mostra apenas as imagens, corpos físicos invisíveis (padrão sistema);
-- hybrid: mostra as imagens e os corpos físicos;
-- debug: mostra apenas os corpos físicos; 

-- physics.setDrawMode ("debug")
physics.setDrawMode ("hybrid")
-- physics.setDrawMode ("normal")

-- Adicionando objetos físicos:
local retangulo = display.newRect (150, display.contentCenterY, 100, 40)
-- Corpo dinâmico: interage com a gravidade e colide com todos os corpos
physics.addBody (retangulo, "dynamic") -- Laranja em atividade / Cinza em pausa
retangulo.rotation = 35

local chao = display.newRect (display.contentCenterX, 400, 450, 30)
-- Corpo estático: não se movimenta e colide apenas com dinâmico
physics.addBody (chao, "static") -- Verde

local circulo = display.newCircle (300, 50, 30)
-- Corpo cinemático: não interage com a gravidade e colide apenas com dinâmico
physics.addBody (circulo, "kinematic", {radius=30}) -- Lilás

local quadrado = display.newRect (display.contentCenterX, 0, 50, 50)
physics.addBody (quadrado, "dynamic", {bounce=1, friction=0.6, density=0.2}) 
-- torque adiciona uma rotação em torno do próprio eixo
-- valores positivos gira em sentido horário, negativos em anti horário
quadrado:applyTorque (-80)

local parede1 = display.newRect (0, 50, 5, 665)
physics.addBody (parede1, "static")

local parede2 = display.newRect (320, 290, 5, 170)
physics.addBody (parede2, "static")