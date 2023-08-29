-- Retângulo => display.newRect (x, y, largura, altura)
local retangulo = display.newRect (120, 80, 200, 140)
-- Círculo => display.newCircle (x, y, raio)
local circulo = display.newCircle (330, 80, 80)
-- Quadrado => display.newRect (x, y, largura, altura)
local quadrado = display.newRect (530, 80, 140, 140)
-- Retângulo arredondado => display.newRoudedRect (x, y, largura, altura, raio da borda)
local retanguloArredondado = display.newRoundedRect (730, 80, 200, 140, 30)
-- Adicionar uma linha => display.newLine (x inicial, y inicial, x final, y final)
local linha = display.newLine (0, 230, 1200, 230)
-- Criar um polígono => display.newPolygon (x, y, vertices)
local localizacaoX = 200
local localizacaoY = 350
local vertices = {0, -110, 27, -35, 105, -35, 43, 16, 65, 90, 0, 45, -65, 90, -43, 15, -105, -35, -27, -35}
local estrela = display.newPolygon (localizacaoX, localizacaoY, vertices)
-- Criar um novo texto => display.newText ("Texto", x, y, font, fontSize)
local helloWorld = display.newText ("Hello World!", 500, 350, native.systemFont, 50)
-- Variável com parâmetro
local parametros = {
    text = "Olá Mundo!",
    x = 500,
    y = 450,
    font = "Arial",
    fontSize = 50,
    align = "right"
}
local olaMundo = display.newText (parametros)
-- Adicionar texto em relevo => display.newEmbossedText ("texto", x, y, font, fontSize)
local opcoes = {
    text = "Eduardo",
    x = 730,
    y = 450,
    font = "Times New Roman",
    fontSize = 50
}
local textoRelevo = display.newEmbossedText (opcoes)
-- Adicionar cor ao objeto/texto => variável:setFillColor (cinza, vermelho, verde, azul, alfa) "RGB"
textoRelevo:setFillColor (0.9, 0.2, 0.3)
textoRelevo.alpha = 0.9

local color = {
    -- destaque
    highlight = {r = 0.1, g = 0.1, b = 0.1},
    -- sombra
    shadow = {r = 0.4, g = 0.9, b = 0.2}
}
textoRelevo:setEmbossColor (color)
-- Gradiente (degradê) => variável = {type =, color1 = { , , }, color2 = { , , }, direction = ""}
local gradiente = {
    type = "gradient",
    color1 = {1, 0.1, 0.9},
    color2 = {0.8, 0.8, 0.8},
    direction = "down"
}
circulo:setFillColor (gradiente)