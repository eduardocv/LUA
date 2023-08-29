-- Evento mulitoque:
-- Para utilizar o multitouch precisamos habilitar (ativar) primeiro
system.activate ("multitouch")

local retangulo = display.newRect (display.contentCenterX, display.contentCenterY, 280, 440)
retangulo:setFillColor (1, 0, 0.3)

local function eventoTouch (event)
    print ("fase de toque: " .. event.phase)
    print ("Localização x: " .. tostring(event.x) .. "Localização y: " .. tostring(event.y) )
    print ("ID de toque exclusivo: " .. tostring(event.id) )
    print ("------------")
    return true
end

retangulo:addEventListener ("touch", eventoTouch)