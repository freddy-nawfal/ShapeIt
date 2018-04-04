function resetGame()
  removeAllThings()
  initAllThings()
  GameOverBtn.isVisible = false
  scoreEnd.isVisible = false
  timer.resume(gameLoopTimer)
  timer.resume(decorLoopTimer) 
end

function gameLost()
  timer.pause( gameLoopTimer )
  timer.pause( decorLoopTimer )
  GameOverBtn.isVisible = true
  
  if score > tonumber(GlobalUserInfo.highscore) then
    GlobalUserInfo.highscore = tostring(score)
    saveSystem.save(GlobalUserInfo, "save.shapeit")
  end
  
  scoreEnd.text = "Score: "..score.."\nBest: "..GlobalUserInfo.highscore
  scoreEnd:setFillColor(1, 1, 1)
  scoreEnd:toFront()
  scoreEnd.isVisible = true
  
  GameOverBtn:addEventListener( "tap", resetGame ) 
end

function decorsUpdate()
  --nuage
  for i,nuage in ipairs(decors.nuages) do
    nuage.x = nuage.x - (wallShape.vx*dt * nuage.vx)/2
    if nuage.x < -(nuage.width) then
      table.remove(decors.nuages,i)
      local randomPercentage = math.random(0,100)
      local pourcentage = 100-#decors.nuages*(100/nbNuageMax)
      if pourcentage > randomPercentage then
        table.insert(decors.nuages,generateNuageRandom(display.contentWidth, display.contentWidth+1,0,display.contentHeight/2))
      end
    end
    if #decors.nuages < nbNuageMax then
      local randomPercentage = math.random(0,100)
      local pourcentage = 100-#decors.nuages*(100/nbNuageMax)
      if pourcentage > randomPercentage then
        table.insert(decors.nuages,generateNuageRandom(display.contentWidth*1.5, display.contentWidth*1.5,0,display.contentHeight/2))
      end
    end
  end
  --IDEM POUR LES AUTRES ENSUITE
end

function wallScoreUpdate()
  -- modify x position of the wall
  -- generate new wall shape and add score if wall reach end
  if wallShape.x < - (wallShape.width) then
    score = score + 1
    scoreDisplay.text = "SCORE: "..score
    wallShape.x = wallShape.xDefault
    if wallShape.vx > wallShape.vxLimit then
      wallShape.vx = wallShape.vx + math.exp(wallShape.vx / wallShape.vxLimit)
    else
      wallShape.vx = wallShape.vx + wallShape.vx*dt
    end
    getNeededShape()
    showGoodShape(wallShape)
  elseif checkCollision(centerShape.x-centerShape.size/2,centerShape.y-centerShape.size/2,centerShape.size,centerShape.size,wallShape.x-wallShape.width/2,wallShape.y-wallShape.height/2,wallShape.width,wallShape.height) then
    if centerShape.currentShape ~= wallShape.currentShape then
      gameLost()
    end
  end
  wallShape.x = wallShape.x - wallShape.vx * dt
  
  for i,objects in ipairs (wallShape.object) do
    objects.x = wallShape.x
  end
end

runCount = 0
runSwitch = 1

function runAnimation()
  if runCount >= 7 then
    runSwitch = 0
  elseif runCount <= 0 then
    runSwitch = 1
  end
  local runSpeed = wallShape.vx/500
  if runSwitch == 0 then
    runCount = runCount - runSpeed
    centerShape.object[1].y = centerShape.object[1].y - runSpeed
    centerShape.object[2].y = centerShape.object[2].y - runSpeed
    centerShape.object[3].y = centerShape.object[3].y - runSpeed
  else
    runCount = runCount + runSpeed
    centerShape.object[1].y = centerShape.object[1].y + runSpeed
    centerShape.object[2].y = centerShape.object[2].y + runSpeed
    centerShape.object[3].y = centerShape.object[3].y + runSpeed
  end
end

function jumpAnimation()
  if not centerShape.isJumping then
    local distance = (wallShape.x - centerShape.x)
    if wallShape.x < display.contentWidth and distance >= wallShape.width then
      centerShape.isJumping = true
      for i,object in ipairs(centerShape.object) do
        local timeNeed = distance / math.abs(wallShape.vx * dt)*20
        local delayNeed = timeNeed*0.6
        local jumpTime = timeNeed*0.4
        transition.to(object,{y=centerShape.y-centerShape.size*2.5,delay=delayNeed, time = jumpTime, transition=easing.inOutCubic,
          onComplete = function(object)
            transition.to(object,{y = centerShape.yDefault, time = timeNeed, transition = easing.inOutCubic,
              onComplete = function(object)
                centerShape.isJumping = false
              end})
            end})
      end
    end
  end
end


function actionUpdate()
  wallScoreUpdate()
  jumpAnimation()
  -- updater for the centershape
  showGoodShape(centerShape)
end
