-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require("composer")

local widgets = require 'src.widgets'
widgets.init()

widgets.Credits({
    parent = display.getCurrentStage(),
    text = 'made by @nebelfox',
    url = 'https://github.com/NebelFox/Vote#readme',
    alpha = 0.2
})

composer.gotoScene 'src.scenes.setup'