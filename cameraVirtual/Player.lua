local scriptTeclado = require ("Teclado")

local Player = {}
-- hud está ligado a variável criada no main que executa a função .novo no script HUD
function Player.novo(x, y, hud)
local spritePlayer = graphics.newImageSheet ("imagens/player.png", {width=90, height=95, numFrames=12})

local playerAnimacao = 
{
    {name="parado", start=1, count=3, time=300, loopCount=0},
    {name="correndo", start=5, count=8, time=1000, loopCount=0}
}
local player = display.newSprite (spritePlayer, playerAnimacao)
player.x = x
player.y = y
player.id = "player"
player.direcao = "parado"
player:setSequence ("parado")
player:play {}
player.numeroPulo = 0
physics.addBody (player, "dynamic", {friction=2, box={x=0, y=0, halfWidth=30, halfHeight=40, angle=0}})
player.isFixedRotation = true

scriptTeclado.novo (player)

local function verificarColisao (self, event)
    if event.phase == "began" then
        if event.other.id == "chao" then
            self.numeroPulo = 0
        elseif event.other.id == "inimigo" then 
            local topoInimigo = event.other.y - (event.other.height/2)
            if self.y <= topoInimigo then 
                display.remove (event.other)
                self:setLinearVelocity(0, -300)
            end
        elseif event.other.id == "moeda" then
            display.remove (event.other)
            hud.somar() -- executa a função do script HUD (somar pontos)
        end
    end
end
player.collision = verificarColisao
player:addEventListener ("collision")

return player
end
return Player