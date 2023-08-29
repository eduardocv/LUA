-- Incluindo funções:

-- Evento de clique (tap)

local function detectarTap (event) -- determina que a função é de evento
    -- código que é executado quando o botão for acionado
    -- tostring: para sequenciar as ações (utilizado junto à concatenação)
    -- event.target: nomear o objeto do evento, ou o objeto tocado
    print ("Objeto tocado: " .. tostring (event.target))

    return true -- "zerar" todos os dados depois da função executada

end -- fecha a funcão

local botaoTap = display.newRect (200, 200, 200, 50)
botaoTap:addEventListener ("tap", detectarTap) -- adicionar um ouvinte "tap" ao objeto

local function tapDuplo (event)
    -- se (nº de taps do evento for = a 2) então 
    if (event.numTaps == 2) then
        print ("Objeto tocado duas vezes: " .. tostring (event.target))

    else -- se não 
        return true
    end -- fecha a condição (if/else)
end -- fecha a função

local botaoDuplo = display.newRect (100, 300, 200, 50)
botaoDuplo:setFillColor (0.7, 0, 0.5)
botaoDuplo:addEventListener ("tap", tapDuplo)

-- Evento de toque (touch)

-- Fases de toque:
    -- began = Quando o usuário encosta na tela (Primeira fase de toque);
    -- moved = Quando o usuário mantém o toque e move pela tela;
    -- ended = Quando o usuário retira o dedo da tela;
    -- cancelled = Quando o evento de toque é cancelado do sistema;

    local function fasesToque (event)
        -- Se a fase de toque for = began então 
        if (event.phase == "began") then
            print ("Objeto tocado: " .. tostring(event.target))
        -- Porém se a fase de toque for = moved então    
        elseif (event.phase == "moved") then
            print ("Localização de toque nas seguintes coordenadas: x= " .. event.x .. ", y= " .. event.y)
        -- Entretanto se a fase de toque for = ended ou cancelled então
        elseif (event.phase == "ended" or "cancelled") then
            print ("Touch terminado no objeto: " .. tostring(event.target))

        end

        return true
    end

    local botaoTouch = display.newRect (200, 400, 200, 50)
    botaoTouch:setFillColor (0.9, 0.2, 0)
    botaoTouch:addEventListener ("touch", fasesToque)
    