-- globals aliases
local require, unpack, table, display, string = require, unpack, table, display, string

-- required modules
local json = require "json"
local composer = require "composer"
local utils = require "utils"

-- setup file
local names = json.decodeFile(system.pathForFile("assets/widgets.json", system.ResourceDirectory))

-- module table
local widgets = {}

-- registered widget classes
local constructors = {}

-- registers all the components
-- from the linked file
function widgets.init()
    local Widget = require "widgets.widget"
    for _, filename in ipairs(names) do
        local name = utils.convert.snake2pascal(filename)
        constructors[name] = Widget(require("widgets." .. filename))
    end
end

return setmetatable(widgets, {__index=constructors})
