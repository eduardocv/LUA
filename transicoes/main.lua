-- Transições
-- Comandos: transition. to (variável, {parâmetros})

local circulo = display.newCircle (40, 50, 30)
transition.to (circulo, {time=3000, y=400})
circulo:setFillColor (0.1, 0.3, 0.9) -- AZUL

local circulo1 = display.newCircle (110, 50, 30)
transition.to (circulo1, {time=3000, y=400, delta=true})
circulo1:setFillColor (0.9, 0.3, 0.1) -- VERMELHA

local circulo2 = display.newCircle (180, 50, 30)
transition.to (circulo2, {time=3000, y=400, iterations=4, transition=easing.outElastic})
circulo2:setFillColor (0.1, 0.9, 0.3) -- VERDE

local circulo3 = display.newCircle (250, 50, 30)
transition.to (circulo3, {time=3000, y=400, iterations=3, transition=easing.inElastic})
circulo3:setFillColor (0.6, 0.6, 0.6) -- CINZA

local retangulo = display.newRect (200, 250, 50, 70)
transition.to (retangulo, {time=3000, rotation=90, xScale=3, alpha=0.5, iterations=-1})
retangulo:setFillColor (0.7, 0.2, 0.7) -- ROSA

local quadrado = display.newRect (80, 80, 50, 50)
transition.to (quadrado, {time=1000, rotation=360, y=180, x=110, iterations=2, transition=easing.inExpo})
quadrado:setFillColor( 0.1, 0.8, 0.9 ) -- AZUL CLARO

local quadrado2 = display.newRect (170, 160, 50, 50)
transition.to (quadrado2, {time=5000, xScale=-1, yScale=-1, iterations=3, easing.inQuint})

local elvira = display.newImageRect ("imagens/elvira.png", 579, 431)
elvira.x = 5
elvira.y = 500
transition.to (elvira, {time=2000, xScale=-2, yScale=-2, easing.outInBounce})
