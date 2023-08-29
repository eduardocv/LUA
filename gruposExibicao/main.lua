-- Criando grupos de exibição (BackGroup, MainGroup e UiGroup)
local backGroup = display.newGroup () -- usado para plano de fundo, decorações que não terão interação com o jogo

local mainGroup = display.newGroup () -- usado para os objetos que terão interação dentro do jogo (grupo principal)

local uiGroup = display.newGroup () -- utilizado para placar, vidas, texto que ficar na frente do jogo, porém sem interação

-- Método embutido:
-- Inclui o objeto n grupo já na sua criação
local bg = display.newImageRect (backGroup, "imagens/bg.jpg", 509*2, 339*2)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

--local chao = display.newImageRect ("imagens/chao.png", 4503/5, 613/5) --incluindo no grupo direto na criação da variável
--chao.x = display.contentCenterX
--chao.y = 430
--mainGroup:insert (chao) -- incluindo no grupo
--chao:toFront ()

-- Exercícios:
-- Colocar o Sol e Nuvem (um direto e outro embutido pelo método no BackGroup)
local sun = display.newImageRect (backGroup, "imagens/sun.png", 256/2, 256/2)
sun.x = 300
sun.y = 80

local cloud = display.newImageRect ("imagens/cloud.png", 2360/5, 984/5)
cloud.x = 80
cloud.y = 80
backGroup:insert (cloud)

-- Adicionar 2 Árvores (um direto e outro embutido pelo método no MainGroup)
local tree1 = display.newImageRect (mainGroup, "imagens/tree.png", 1024/6, 1024/6)
tree1.x = display.contentCenterX
tree1.y = 330
local tree2 = display.newImageRect ("imagens/tree.png", 1024/6, 1024/6)
tree2.x = 40
tree2.y = 330
mainGroup:insert (tree2)
local chao = display.newImageRect ("imagens/chao.png", 4503/5, 613/5) --incluindo no grupo direto na criação da variável
chao.x = display.contentCenterX
chao.y = 430
mainGroup:insert (chao) -- incluindo no grupo
--chao:toFront ()