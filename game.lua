local composer = require( "composer" )
local scene = composer.newScene()

local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )

math.randomseed(os.time())
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
require("gameVariables")
require("gameInitRemove")
require("gameUtilityFunc")
require("gameUpdateFunc")
-- -----------------------------------------------------------------------------------
-- Main game loop and game update functions
-- -----------------------------------------------------------------------------------

function gameLoop()
  actionUpdate()
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function launchGame()
  setScoreThings()
  playButton.isVisible = false
  gameLoopTimer = timer.performWithDelay( refreshRate, gameLoop, 0 )
end

-- create()
function scene:create( event )
	local sceneGroup = self.view
  local blackBackground = display.setDefault("background", 0, 0, 0)
  
  background = display.newImage("assets/images/background_day.png", display.contentCenterX, display.contentCenterY)
  background:toBack()
  background.width = display.contentWidth
  background.height = display.contentHeight
  
  setDecorsThings()
  createButtons()
  createGameOver()
  initAllThings()
  removeScoreThings()
  createPlayButton()
  
  decorLoopTimer = timer.performWithDelay(refreshRate,decorsUpdate,0)
  runAnimationTimer = timer.performWithDelay(refreshRate,runAnimation,0)

end

-- show()
function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
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
	end
end

-- destroy()
function scene:destroy( event )
	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
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
