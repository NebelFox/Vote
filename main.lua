-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require("composer")

local widgets = require 'src.widgets'
widgets.init()
local theme = require 'src.theme'
theme.init()

theme.background("background")

widgets.Credits({
    parent = display.getCurrentStage(),
    text = 'made by @nebelfox',
    url = 'https://github.com/NebelFox/Vote#readme'
})

composer.gotoScene 'src.scenes.setup'