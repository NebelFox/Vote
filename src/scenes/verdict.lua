local composer = require 'composer'
local scene = composer.newScene()

local widgets = require 'src.widgets'
local utils = require 'src.utils'

-- local display = display

local WIDTH = display.contentWidth
local HEIGHT = display.contentHeight
local CENTERX = display.contentCenterX
local CENTERY = display.contentCenterY
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local voter
local accepted
local declined

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create(event)
    local sceneGroup = self.view

    accepted = display.newText({parent = sceneGroup, x = CENTERX, text = "", fontSize = 100})
    accepted.anchorX = 0.5
    accepted.anchorY = 0.5
    declined = display.newText({parent = sceneGroup, x = CENTERX, text = "", fontSize = 100})
    declined.anchorX = 0.5
    declined.anchorY = 0.5

    local restart = utils.createButton(sceneGroup, CENTERX, HEIGHT * 0.8, WIDTH / 3, WIDTH / 6, "RESTART", 60, 10)

    restart:addEventListener('touch', function(event)
        if (event.phase == 'ended') then
            composer.gotoScene('src.scenes.setup')
        end
    end)

end
 
-- show()
function scene:show(event)
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if (phase == "will") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        local prevScene = composer.getSceneName("previous")
        composer.removeScene(prevScene, true)

        local a, d = event.params.accepted, event.params.declined
        accepted.text = ("%s accepted"):format(a)
        declined.text = ("%s declined"):format(d)
        if (a > d) then
            accepted:setFillColor(0, 1, 0)
            accepted.size = 150
            accepted.y = HEIGHT * 0.4
            declined:setFillColor(0.3, 0.3, 0.3)
            declined.size = 100
            declined.y = HEIGHT * 0.5
        else
            accepted:setFillColor(0.3, 0.3, 0.3)
            accepted.size = 100
            accepted.y = HEIGHT * 0.5
            declined:setFillColor(1, 0, 0)
            declined.size = 150
            declined.y = HEIGHT * 0.4
        end
    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide(event)
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if (phase == "will") then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif (phase == "did") then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy(event)
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
-- -----------------------------------------------------------------------------------
 
return scene
