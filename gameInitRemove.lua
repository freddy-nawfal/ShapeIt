function initBagRandomShape()
  bag = {}
  math.randomseed(os.time())
  for n=1,nbShape do
    table.insert(bag,n)
    table.insert(bag,n)
    table.insert(bag,n)
    table.insert(bag,n)
  end
end

function tirageBagRandomShape()
  local nBag = math.random(1,#bag)
  local numero = bag[nBag]
  table.remove(bag,nBag)
  if #bag == 0 then
    initBagRandomShape()
  end
  return numero
end

function createButtons()  
  RectBtn = display.newImage("assets/images/rect.png", display.contentCenterX/3, display.contentHeight)
  RectBtn.width=shapeSize*2
  RectBtn.height=shapeSize*2
  RectBtn.y = display.contentHeight - RectBtn.height*2/3
  RectBtn:addEventListener( "tap", tapRect )
  RectBtn:toFront()
  
  CircleBtn = display.newImage("assets/images/rond.png", display.contentCenterX, RectBtn.y)
  CircleBtn.width=shapeSize*2
  CircleBtn.height=shapeSize*2
  CircleBtn:addEventListener( "tap", tapCircle )
  CircleBtn:toFront()

  RoundedRectBtn = display.newImage("assets/images/arrondi.png", display.contentCenterX/3 * 5, RectBtn.y)
  RoundedRectBtn.width=shapeSize*2
  RoundedRectBtn.height=shapeSize*2
  RoundedRectBtn:addEventListener( "tap", tapRoundedRect ) 
  RoundedRectBtn:toFront()
end

function createPlayButton()
  playButton = display.newText( groups.uiGroup, "Play", display.contentCenterX, display.contentCenterY, native.systemFont, shapeSize*2 )
	playButton:setFillColor( 1, 1, 1)
  playButton:addEventListener("tap",launchGame)
end

function createGameOver()
  GameOverBtn = display.newImage("assets/images/oops.png", display.contentCenterX, display.contentCenterY)
  GameOverBtn.isVisible = false
  GameOverBtn.width = GameOverBtn.width*0.5
  GameOverBtn.height = GameOverBtn.height*0.5
  scoreEnd = display.newText("", display.contentCenterX, display.contentCenterY, "Arial", shapeSize/2)
  scoreEnd.isVisible = false
end

function setCenterShapeThings()
  local sheetOptions =
  {
    width = 300,
    height = 300,
    numFrames = 18
  }
  local sequences_center = {
    -- consecutive frames sequence
    {
        name = "clignement",
        start = 1,
        count = 18,
        time = 2000,
        loopCount = 0,
        loopDirection = "forward"
    }
}
  local rectImageSheet = graphics.newImageSheet( "assets/sprites/rect_clignement.png", sheetOptions )
  local circleImageSheet = graphics.newImageSheet( "assets/sprites/rond_clignement.png", sheetOptions )
  local roundedImageSheet = graphics.newImageSheet( "assets/sprites/rounded_clignement.png", sheetOptions )
  
  centerShape = {}
  centerShape.x = shapeSize
  centerShape.y = display.contentHeight - shapeSize*4.5
  centerShape.yDefault = display.contentHeight - shapeSize*4.5
  centerShape.currentShape = "rect"
  centerShape.isJumping = false
  centerShape.object = {}
    centerShape.object[1] = display.newSprite(groups.mainGroup, rectImageSheet, sequences_center)
    centerShape.object[1].isVisible = true
    centerShape.object[1]:play()
    centerShape.object[2] = display.newSprite(groups.mainGroup, circleImageSheet, sequences_center)
    centerShape.object[2].isVisible = false
    centerShape.object[2]:play()
    centerShape.object[3] = display.newSprite(groups.mainGroup, roundedImageSheet, sequences_center)
    centerShape.object[3].isVisible = false
    centerShape.object[3]:play()
  for i,object in ipairs(centerShape.object) do
    --object.width = shapeSize
    --object.height = shapeSize
    object.x = centerShape.x
    object.y = centerShape.y+10
    object:scale(0.15, 0.15)
  end
  centerShape.size = shapeSize
end

function removeCenterShapeThings()
  for i,object in ipairs(centerShape.object) do
    object.isVisible = false
  end
end
  

  
function setWallShapeThings()
  wallShape = {}
  wallShape.x = display.contentWidth*2
  wallShape.y = display.contentHeight - shapeSize*4.5
  wallShape.vx = 300
  wallShape.vxLimit = 1000
  wallShape.currentShape = "rect"
  wallShape.object = {};
    wallShape.object[1] = display.newImage(groups.mainGroup, "assets/images/barriere_rect.png",wallShape.x,wallShape.y)
    wallShape.object[1].isVisible = true
    wallShape.object[2] = display.newImage(groups.mainGroup, "assets/images/barriere_rond.png",wallShape.x,wallShape.y)
    wallShape.object[2].isVisible = false
    wallShape.object[3] = display.newImage(groups.mainGroup, "assets/images/barriere_rounded.png",wallShape.x,wallShape.y)
    wallShape.object[3].isVisible = false
  for i,object in ipairs(wallShape.object) do
    object.width = shapeSize*3
    object.height = shapeSize*3
  end
  wallShape.width = wallShape.object[1].width
  wallShape.height = wallShape.object[1].height
  wallShape.xDefault = display.contentWidth + wallShape.width
  getNeededShape()
  showGoodShape(wallShape)
end

function removeWallShapeThings()
  for i,object in ipairs(wallShape.object) do
    object.isVisible = false
  end
end

function setScoreThings()
  score = 0
  scoreDisplay = display.newText(groups.uiGroup, "SCORE: 0", display.contentCenterX, shapeSize, "assets/fonts/GillSansUltraBold.ttf", (shapeSize/3)*2)
  scoreDisplay:setFillColor(0, 0, 0)
end

function removeScoreThings()
  display.remove(scoreDisplay)
end

function setDecorsThings()
  decors = {}
    decors.nuages = {}
    for i=1,nbNuageMax do
      table.insert(decors.nuages,generateNuageRandom(display.contentWidth*0.1,display.contentWidth*1.5,0,display.contentHeight*0.3))
    end
end

function removeDecorsThings()
  for i, decor in pairs(decors) do
    for j, nuage in ipairs(decor) do
      display.remove(nuage)
    end
    table.remove(decor)
  end
end
  
function initAllThings()
  initBagRandomShape()
  setCenterShapeThings()
  setWallShapeThings()
  setScoreThings()
end

function removeAllThings()
  removeCenterShapeThings()
  removeWallShapeThings()
  removeScoreThings()
end