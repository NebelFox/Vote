-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require("composer")

local widgets = require 'widgets'
widgets.init()
local theme = require 'theme'
theme.init()

theme.background("background")

WIDTH = display.contentWidth
HEIGHT = display.contentHeight
CENTERX = WIDTH * 0.5
CENTERY = HEIGHT * 0.5

widgets.Credits({
    parent = display.getCurrentStage(),
    text = 'made by @nebelfox',
    url = 'https://github.com/NebelFox/Vote#readme'
})

EFFECT = 'fade'
TIME = 200

OPTIONS = {
    effect = EFFECT,
    time = TIME
}

composer.gotoScene 'scenes.setup'