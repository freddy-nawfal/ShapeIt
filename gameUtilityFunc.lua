function generateNuageRandom(xGauche,xDroite,yHaut,yBas)
  local xRandom = math.random(xGauche,xDroite)
  local yRandom = math.random(yHaut,yBas)
  local nuage = display.newImage(groups.backGroup,"assets/images/nuage.png",xRandom,yRandom)
  local scaleRandom = math.random(4,10)/10
  nuage.width = nuage.width*scaleRandom/3
  nuage.height = nuage.height*scaleRandom/3
  nuage.alpha = 0.7
  nuage.vx = scaleRandom/4
  return nuage
end

function clearMainObject()
  display.remove(groups.mainGroup)
  groups.mainGroup = display.newGroup()
end

function clearUI(object)
  display.remove(groups.uiGroup)
  groups.uiGroup = display.newGroup()
end

function tapRect( event )
    centerShape.currentShape = "rect"
    return true
end

function tapCircle( event )
    centerShape.currentShape = "circle"
    return true
end

function tapRoundedRect( event )
    centerShape.currentShape = "rounded"
    return true
end

function showGoodShape(shape)
  if shape.currentShape == "rect" then
    shape.object[1].isVisible = true
    shape.object[2].isVisible = false
    shape.object[3].isVisible = false
  elseif shape.currentShape == "circle" then
    shape.object[1].isVisible = false
    shape.object[2].isVisible = true
    shape.object[3].isVisible = false
  elseif shape.currentShape == "rounded" then
    shape.object[1].isVisible = false
    shape.object[2].isVisible = false
    shape.object[3].isVisible = true
  end
end

function getNeededShape()
  local random = tirageBagRandomShape()
  if random == 1 then
    wallShape.currentShape = "rect"
  elseif random == 2 then
    wallShape.currentShape = "circle"
  elseif random == 3 then
    wallShape.currentShape = "rounded"
  end
end

function checkCollision(x1,y1,w1,h1,x2,y2,w2,h2)
  -- x1,y1 - x2,y2 top left corner
  -- w1,w2 : width - h1,h2 : height
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end