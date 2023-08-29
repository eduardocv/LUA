local Teclado = {} -- armazena todos os dados do script

function Teclado.novo (player) 

local function verificarTecla (event)
    -- se a fase de evento for down (tecla pressionada) então
    if event.phase == "down" then
    -- se a tecla pressionado for D então
        if event.keyName == "d" then
            player.direcao = "direita"
            player:setSequence ("correndo")
            player:play()
            player.xScale = 1 -- pra que fique virado pra direita
    -- se for A então    
        elseif event.keyName == "a" then
            player.direcao = "esquerda"
            player:setSequence ("correndo")
            player:play()
            player.xScale = -1
    -- se for o "espaço" então
        elseif event.keyName == "space" then        
            player.numeroPulo = player.numeroPulo + 1
    -- se for 1 clique então
                if player.numeroPulo == 1 then
                    player:applyLinearImpulse (0, -0.4, player.x, player.y)
    -- se for "duplo espaço" entao
                elseif player.numeroPulo == 2 then
    -- transição para girar 360 graus em torno do próprio eixo
                    transition.to (player, {rotation=player.rotation+360, time=750})
                    player:applyLinearImpulse (0, -0.4, player.x, player.y)
                end
        end
    -- quando a fase de evento for UP (soltar a tecla) então
    elseif event.phase == "up" then
        if event.keyName == "d" then
            player.direcao = "parado"
            player:setSequence("parado")
            player:play()
        elseif event.keyName == "a" then
            player.direcao = "parado"
            player:setSequence("parado")
            player:play()
        end
    end
end
    Runtime:addEventListener ("key", verificarTecla)
-- função para a movimentação
    local function verificarDirecao ()
-- variáveis x e y 
        local velocidadeX, velocidadeY = player:getLinearVelocity()
--        print ("Velocidade x: " .. velocidadeX .. "Velocidade y: " .. velocidadeY) -- SÓ PRA VER OS VALORES 
        if player.direcao == "direita" and velocidadeX <= 200 then
            player:applyLinearImpulse (0.2, 0, player.x, player.y)
        elseif player.direcao == "esquerda" and velocidadeX >= -200 then
            player:applyLinearImpulse (-0.2, 0, player.x, player.y)
        end
    end
    Runtime:addEventListener ("enterFrame", verificarDirecao)
end

return Teclado

        