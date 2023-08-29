-- variável global (deve ser evitado)
vidas = 2 
print (vidas)
print ("Quantidade de Vidas é: " .. vidas)
----------------------------------------------
-- variável locais (só é lida dentro do script)
local pontos = 10 
print ("O valor de pontos :" .. pontos)
-----------------------------------------------
---------- operações aritiméticas
-- soma
local laranjas = 10
laranjas = laranjas + 5
print ("O total de laranjas é: " .. laranjas)
-- soma entre variáveis
local bergamota = 13
local banana = 6
totalFrutas = bergamota + banana
print ("O total de frutas é: " .. totalFrutas)
print ("sendo " .. bergamota .. " bergamota(s) e " .. banana .. " banana(s)")
-- subtração
local ganhos = 50
local perdas = 100
saldo = ganhos - perdas
print (" Sobrou R$ " .. saldo .. " do salario") 
-- multiplicação
local carro = 8
carro = carro * 2
print ("Quantidade de carros: " .. carro)
-- divisão com multiplicação
carro = carro * 0.5
print ("A metade de carros é " .. carro)
-- divisão
local ab = 8
local ba = 2
div = ab / ba
print ("O resultado da divisão é: " .. div)
