local physics = require ("physics")
physics.start ()
physics.setGravity (0, 0)
physics.setDrawMode("normal")

display.setStatusBar (display.HiddenStatusBar)


local spriteOpcoes = {

    frames = {
        {
             --1) Asteroide 1
             x = 0,
             y = 0,
             width=102,
             height=85,
        },
        {
            -- 2) Asteroide 2
            x=0,
            y=85,
            width=90,
            height=83
        },
        { 
            -- 3) Asteirode 3
            x=0,
            y=168,
            width=100,
            height=79,

        },
        {
            -- 4) Nave
            x=0,
            y=265,
            width=98,
            height=79,
        },
        {
            -- 5) Nave-2
            x=0,
            y=342,
            width=110,
            height=85,
        },
        {
            -- 6) Laser
            x=98,
            y=265,
            width=14,
            height=40,
        }
    }
}

local sprite    = graphics.newImageSheet ("imagens/sprite.png", spriteOpcoes)

local backGroup = display.newGroup ()
local mainGroup = display.newGroup ()
local UIGroup   = display.newGroup ()

local bg = display.newImageRect (backGroup, "imagens/bg.png", 800, 1400)
-- local bg = display.newImageRect (backGroup, "imagens/bg.png", 640, display.contentHeight)

bg.x = display.contentCenterX
bg.y = display.contentCenterY

local nave = display.newImageRect (mainGroup, sprite, 5, 98, 79 )
--local nave = display.newImageRect (mainGroup, sprite, 5, 98, 220 )

nave.x = display.contentCenterX
nave.y = display.contentHeight - 100

local vidas = 3
local pontos = 0
local asteroidesTable = {} 
local gameLoopTimer
local morto = false

math.randomseed ( os.time() )

local vidasText = display.newText (UIGroup, "Vidas: " .. vidas, display.contentCenterX-150, display.contentHeight/2*0.1, native.systemFont, 36)
vidasText.alpha = 0.3

local pontosText = display.newText (UIGroup, "Pontos: " .. pontos,display.contentCenterX+30, display.contentHeight/2*0.1, native.systemFont, 36)
pontosText.alpha = 1

local function naveColision(event)
    if ((event.object1.myName == "Asteroide") and (event.object2.myName == "Nave")) or ((event.object1.myName == "Nave") and (event.object2.myName == "Asteroide")) then
    vidas = vidas - 1  
    vidasText.alpha =  string.format("%0.1f",tostring(vidas))

    vidasText.text = "Vidas: " .. vidas
        if (vidas <= 0) then
            print("Suas vidas acabaram.")
        end
    end 
end

physics.addBody (nave, "dynamic", { isSensor=true})
nave.myName = "Nave"
-- Runtime:addEventListener("collision", naveColision)

local function checkAsteroide(event)
    print(event)
    if not (event == nil) then
        if (event.x < 0) or ( event.x  > display.contentWidth ) or ( event.y < 0) or ( event.y > display.contentHeight ) then
        criarAsteroide()
    end
end
end

local function criarAsteroide ()
    local novosAsteroide = display.newImageRect (mainGroup, sprite, 1, 102, 85)

    novosAsteroide.fill = { type="image", filename="imagens/terra.png" }
    --novosAsteroide.fill.scaleX = rectWidth / imageWidth
    --novosAsteroide.fill.scaleY = rectHeight / imageHeight


    -- Incluido o asteroide na tabela
    table.insert (asteroidesTable, novosAsteroide)
    physics.addBody (novosAsteroide, "dynamic", { radius=40, bouce=0.8 })

    novosAsteroide.myName = "Asteroide"
    local localizacao = math.random (3)

    if (localizacao == 1) then
        novosAsteroide.x = -60
        novosAsteroide.y = math.random (500)
        novosAsteroide:setLinearVelocity (math.random(40,120), math.random(20,60))

    elseif (localizacao == 2) then
        novosAsteroide.x = math.random (display.contentWidth)
        novosAsteroide.y = -60
        novosAsteroide:setLinearVelocity (math.random(-40,40), math.random(40, 120))
                
    elseif (localizacao == 3) then
        novosAsteroide.x = display.contentWidth + 60
        novosAsteroide.y = math.random (500)
        novosAsteroide:setLinearVelocity (math.random(-120, -40), math.random(20, 60))
    end

    novosAsteroide:applyTorque (math.random (-6, 6))    
    novosAsteroide:addEventListener("enterFrame", checkAsteroide)
end
   
local function atirar () 
    local laser = display.newImageRect (mainGroup, sprite, 6, 14, 40)
    physics.addBody (laser, "dynamic", { isSensor=true })
    laser.isBullet = true
    laser.myName = "Laser"
    laser.x, laser.y = nave.x, nave.y
    laser:toBack ()

    transition.to (laser, {y=-40, time=500, onComplete = function () display.remove (laser) end })

end
nave:addEventListener ("tap", atirar)

local function moverNave (event)

    local nave = event.target
    local phase = event.phase

    if ("began"  == phase) then
        display.currentStage:setFocus (nave)
        nave.touchOffsetX = event.x - nave.x
    elseif ("moved" == phase) then
        nave.x = event.x - nave.touchOffsetX
    elseif ("ended" == phase or "cancelled" == phase) then
        display.currentStage:setFocus (nil)
    end
        return true
end
nave:addEventListener("touch", moverNave)  

local function gameLoop ()
    criarAsteroide()
    if not (laser == nil) then
        laser:addEventListener("onCollision", onCollision)
    end
    for i = #asteroidesTable, 1, -1 do
        local thisAsteroide = asteroidesTable [i]

        if (thisAsteroide.x < -100 or thisAsteroide.x > display.contentWidth + 100 or thisAsteroide.y < -100 or thisAsteroide.y > display.contentHeight + 100) then

            display.remove (thisAsteroide)
            table.remove (asteroidesTable, i)
        end
    end
end

gameLoopTimer = timer.performWithDelay (700, gameLoop, 0)

local function restauraNave()
    nave.isBodyActive = false
    nave.x = display.contentCenterX
    nave.y = display.contentHeight - 100

    transition.to (nave, { alpha=1, time=4000, onComplete = function ()    nave.isBodyActive = true 
    morto = false 
    end })
end

local function onCollision(event)
    if (event.phase == "began") then
        local obj1 = event.object1
        local obj2 = event.object2

        if ((obj1.myName == "Laser" and obj2.myName == "Asteroide") or  (obj1.myName == "Asteroide" and obj2.myName == "Laser")) then

            display.remove(obj1)
            display.remove(obj2)

            for i = #asteroidesTable, 1, -1 do
                if (asteroidesTable[i] == obj1 or asteroidesTable[i] == obj2) then
                    table.remove (asteroidesTable, i)
                    break
                end
            end
        pontos = pontos + 100
        pontosText.text = "Pontos: " .. pontos
        elseif ((obj1.myName == "Nave" and obj2.myName == "Asteroide") or (obj1.myName == "Asteroide" and obj2.myName == "Nave")) then

            if (morto == false) then
                morto = true

            vidas = vidas - 1
            vidasText.text = "Vidas : " .. vidas

            if  (vidas == 0) then
                display.remove (nave)
            else
                nave.alpha = 0

                timer.performWithDelay(1000, restauraNave)
            end
        end
    end
end
end
Runtime:addEventListener ("collision", onCollision)

