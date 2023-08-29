-- Carregando áudio de fundo (Stream indicado para áudios longos)
-- ("pasta/arquivo.formato")
local bgAudio = audio.loadStream ("Audio/audio_bg.mp3")
-- Reservando um canal de áudio para o som de fundo
audio.reserveChannels (1)
-- Especificar o volume do canal
audio.setVolume (0.6, {channel=1})
-- Reproduzir o áudio
-- (áudio, {canal, loopins (-1 = infinito)})
audio.play (bgAudio, {channel=1, loops=-1})
-- loadSound é melhor utilizado com sons curtos
local audioTiro = audio.loadSound ("Audio/tiro.wav")
-- Informações de como o áudio deve ser reproduzido
local parametros = {time = 2000, fadein = 200}

local botaoTiro = display.newCircle (display.contentCenterX-100, display.contentCenterY, 32)
botaoTiro:setFillColor (1, 0, 0)

local function tocarTiro ()
    audio.play (audioTiro, parametros)
end

botaoTiro:addEventListener ("tap", tocarTiro)

-- Colocar o áudio da moeda
local audioMoeda = audio.loadSound ("Audio/moeda.wav")
local botaoMoeda = display.newCircle (display.contentCenterX, display.contentCenterY, 32)
botaoMoeda:setFillColor (1, 1, 0)
local function tocarMoeda ()
    audio.play (audioMoeda, parametros)
end

botaoMoeda:addEventListener ("tap", tocarMoeda)