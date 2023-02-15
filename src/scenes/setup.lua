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

local selector

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create(event)
    local sceneGroup = self.view

    selector = widgets.NumberSelector({
        parent = sceneGroup,
        x = WIDTH / 2,
        y = HEIGHT / 2,
        min = 4,
        max = 11,
        size = 200,
        padding = 10
    })

    local button = utils.createButton(sceneGroup, WIDTH / 2, HEIGHT * 0.75, WIDTH / 3, WIDTH / 6, "START", 60, 10)

    button:addEventListener('tap', function(event)
        composer.gotoScene('src.scenes.voting', {params = {n = selector:get()}})
    end)
end
 
 
-- show()
function scene:show(event)
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if (phase == "will") then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        
 
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
    selector:destroy()
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