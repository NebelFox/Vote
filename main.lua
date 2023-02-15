-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require("composer")

local widgets = require 'src.widgets'
widgets.init()

composer.gotoScene 'src.scenes.setup'