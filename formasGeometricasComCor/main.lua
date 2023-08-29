-- Retângulo 
local retangulo = display.newRect (120, 80, 200, 140)
retangulo:setFillColor (0.1, 0.3, 0.9)
retangulo:set
-- Círculo 
local circulo = display.newCircle (330, 80, 80)
local gradiente = {
    type = "gradient",
    color1 = {1, 0.1, 0.9},
    color2 = {0.8, 0.8, 0.8},
    direction = "down"
}
circulo:setFillColor (gradiente)
-- Quadrado 
local quadrado = display.newRect (530, 80, 140, 140)
quadrado:setFillColor (0.3, 0.1, 0.3)
-- Retângulo arredondado 
local retanguloArredondado = display.newRoundedRect (730, 80, 200, 140, 30)
retanguloArredondado:setFillColor (0.4, 0.4, 0.4)
-- Linha 
local linha = display.newLine (0, 230, 1200, 230)
-- Estrela
local localizacaoX = 200
local localizacaoY = 350
local vertices = {0, -110, 27, -35, 105, -35, 43, 16, 65, 90, 0, 45, -65, 90, -43, 15, -105, -35, -27, -35}
local estrela = display.newPolygon (localizacaoX, localizacaoY, vertices)
estrela:setFillColor (0.9, 0.2, 0.3)
-- Hello World 
local helloWorld = display.newText ("Hello World!", 500, 350, native.systemFont, 50)
helloWorld:setFillColor (0.2, 0.6, 0.7)
-- Olá Mundo
local parametros = {
    text = "Olá Mundo!",
    x = 500,
    y = 450,
    font = "Arial",
    fontSize = 50,
    align = "right"
}
local olaMundo = display.newText (parametros)
olaMundo:setFillColor (0.7, 0.6, 0.2)
-- Eduardo (com relevo)
local opcoes = {
    text = "Eduardo",
    x = 730,
    y = 450,
    font = "Times New Roman",
    fontSize = 50
}
local textoRelevo = display.newEmbossedText (opcoes)
textoRelevo:setFillColor (0.9, 0.2, 0.3)
textoRelevo.alpha = 0.9

local color = {
    -- destaque
    highlight = {r = 0.1, g = 0.1, b = 0.1},
    -- sombra
    shadow = {r = 0.4, g = 0.9, b = 0.2}
}
textoRelevo:setEmbossColor (color)

