-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
json = require("json")
saveSystem = require("save")


display.setStatusBar( display.HiddenStatusBar )

GlobalUserInfo = {highscore= "0", coins = "0"}

loadedData = saveSystem.load("save.shapeit")

local retrievingAttempts = 0 
function loadData(data)
  if (loadedData == nil) then
    print("saving")
    loadedData = saveSystem.save(data, "save.shapeit")
    if retrievingAttempts <= 3 then
      loadData()
      retrievingAttempts = retrievingAttempts+1
    else
      print("cannot retrieve shit")
      native.showAlert( "ERROR", "Cannot retrieve data")
      return false
    end
  else
    GlobalUserInfo = loadedData
  end
end


loadData(GlobalUserInfo)



math.randomseed( os.time() )
composer.gotoScene( "splash" )