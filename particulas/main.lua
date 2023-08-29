local physics = require ("physics")
physics.start ()
physics.setDrawMode ("hybrid")

display.setStatusBar (display.HiddenStatusBar)

local chao = display.newRect (display.contentCenterX, 470, 500, 50)
physics.addBody (chao, "static")

local paredeEsq = display.newRect (-20, display.contentCenterY, 70, 410)
physics.addBody (paredeEsq, "static")

local paredeDir = display.newRect (320, display.contentCenterY, 50, 500)
physics.addBody (paredeDir, "static")

local testeParticula = physics.newParticleSystem (
    {
        -- nome do arquivo de particula
        filename = "imagens/liquidParticle.png",
        -- radius físico da particula
        radius = 2,
        -- radius da imagem (usar sempre valor maior que o radius da particula para que elas se sobreponham e tragam um efeito visual mais satisfatório)
        imageRadius = 4
    }
)

local function onTimer (event)
    testeParticula:createParticle (
        {-- determina onde a nova partícula é gerada
        x= 0,
        y= 0,
        -- valores iniciais de velocidade para a partícula
        velocityX= 256,
        velocityY= 480,
        -- define a cor da partícula RGBA (primeiro valor é o alpha)
        color= {1, 0.2, 0.4, 1},
        -- define o tempo de vida da partícula (em segundos)
        lifeTime= 32.0,
        -- define o comportamento da partícula
        flags= {"water", "colorMixing"}
    })
end
timer.performWithDelay (20, onTimer, 0)

testeParticula:createGroup (
    {
        x= 50,
        y= 0,
        color= {0, 0.3, 1, 1},
        -- metade da largura do grupo
        halfWidth= 64,
        -- metade da altura do grupo
        halfHeight= 32,
        flags= {"water", "colorMixing"}
    }
)
testeParticula:applyForce (0, -9.8*testeParticula.particleMass)