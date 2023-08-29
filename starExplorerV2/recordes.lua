
local composer = require( "composer" )

local scene = composer.newScene()

local fundo
audio.setVolume (1, {channel=1})
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local json = require ("json") -- chama biblioteca json para a cena
local pontosTable = {} -- tabela para armazenar os pontos
local filePath = system.pathForFile ("pontos.json", system.DocumentsDirectory) -- cria o arquivo pontos.json e define o caminho para a pasta

local function carregaPontos () 
	-- verifica se o arquivo existe abrindo-o somente para leitura
	local pasta = io.open (filePath, "r") -- "r" == somente leitura

	if pasta then
		local contents = pasta:read ("*a") -- extrai os dados do arquivo e guarda na variável contents (em formato json)
		io.close (pasta) -- fechar o arquivo
		pontosTable = json.decode (contents) -- decodificar a variável contens de json para lua e armazená-los na tabela
	end
	-- se a tabela não existir ou estiver vazia 
	if (pontosTable == nil or #pontosTable == 0) then
		pontosTable = {1000, 500, 250, 125, 50, 25, 15, 10, 5, 1} -- define as pontuações iniciais
	end
end

local function salvaPontos () 
	for i = #pontosTable, 11, -1 do -- define que apenas 10 valores podem ser salvos na pontosTable
		table.remove (pontosTable, i) -- remove os dados 11 acima
	end
	-- abre o arquivo pontos.json para alterações
	local pasta = io.open (filePath, "w") -- "w" == acesso à escrita (gravação)

	if pasta then
		-- inclui os dados da pontosTable no arquivo pontos.json (codificada para json)
		pasta:write (json.encode(pontosTable))
		io.close (pasta) -- fecha o arquivo pontos.json
	end
end

local function gotoMenu ()
	composer.gotoScene ("menu", {time=800, effect="crossFade"})
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	carregaPontos () -- executa a função que extrai as pontuações anteriores

	table.insert (pontosTable, composer.getVariable ("scoreFinal"))

	composer.setVariable ("scoreFinal", 0) -- redefine o valor da variável

	local function compare (a, b) 
		-- organiza os elementos da pontosTable do maior para o menor
		return a > b
	end

	table.sort (pontosTable, compare) -- classificando a orde definida na function compare para a pontosTable

	salvaPontos () -- salva os dados atualizados no arquivo json

	local bg = display.newImageRect (sceneGroup, "imagens/bg.png", 800, 1400)
	bg.x, bg.y = display.contentCenterX, display.contentCenterY

	local cabecalho = display.newText (sceneGroup, "Recordes", display.contentCenterX, 100, native.systemFont, 80)
	cabecalho:setFillColor (0.75, 0.78, 1)

	for i = 1, 10 do
		-- atribui os valores da pontosTable como os do loop
		if (pontosTable[i]) then
			-- define que o espaçamento das pontuações seja uniforme de acordo com o número
			local yPos = 150 + (i*56)

			local ranking = display.newText (sceneGroup, i .. "°", display.contentCenterX-50, yPos, native.systemFont, 44)
			ranking:setFillColor (0.8)

			ranking.anchorX = 1  -- ancora alinhando a direita

			local finalPontos = display.newText (sceneGroup, pontosTable[i], display.contentCenterX-30, yPos, native.systemFont, 44)
			finalPontos.anchorX = 0
		end
	end

	fundo = audio.loadStream ("audio/Midnight-Crawlers_Looping.wav")

	local menu = display.newText (sceneGroup, "Menu", display.contentCenterX, 810, native.systemFont, 50)
	menu:setFillColor (0.75, 0.78, 1)
	menu:addEventListener ("tap", gotoMenu)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		audio.play (fundo, {channel=1, loops=-1})
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		composer.removeScene ("recordes")
		audio.stop (1)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	audio.dispose (fundo)
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
