local sub = string.sub

local json = require "json"

local theme = {}

local themesJsonFile = system.pathForFile("assets/theme.json", system.ResourceDirectory)

local values = {}

function theme.init()
    local hex2rgb = require("utils").convert.hex2rgb
    for key, value in pairs(json.decodeFile(themesJsonFile)) do
        -- print(value, sub(value, 0, 1), sub(value, 2))
        if(sub(value, 0, 1) == '#') then
            values[key] = hex2rgb(sub(value, 2))
        else
            values[key] = value
        end
    end
end

function theme.fill(object, colorkey)
    object:setFillColor(unpack(values[colorkey]))
end

function theme.stroke(object, colorkey)
    object:setStrokeColor(unpack(values[colorkey]))
end

function theme.background(colorkey)
    display.setDefault("background", unpack(values[colorkey]))
end

function theme.get(colorkey)
    return values[colorkey]
end

return theme
