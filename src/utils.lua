local string_sub = string.sub

local utils = {}

-- converters
utils.convert = {}
function utils.convert.snake2pascal(s)
    return string.gsub(s, "(%a)([%w]*)_*", function(a, b) return string.upper(a) .. b end)
end

function utils.convert.hex2rgb(hex)
    local rgb = {}
    for i = 1, 3 do
        rgb[i] = tonumber("0x"..string_sub(hex, i*2-1, i*2)) / 255
    end
    return rgb
end

-- misc
function utils.set(t, values)
    for k, v in pairs(values) do
        t[k] = v
    end
end

function utils.inside(object, x, y)
    local bounds = object.contentBounds
    return x <= bounds.xMax and x >= bounds.xMin and y <= bounds.yMax and y >= bounds.yMin
end


-- Base for all classes.
-- All classes share this __new function,
-- As it's designed to work without any overriding
local object = {}
function object.__new(cls, args)
    local self = setmetatable({__class = cls}, cls)
    cls.init(self, args or {})
    return self
end

-- Function for creating a new class
-- base - is an optional class the new class inherits from
-- currently only linear inheritance is supported
-- If base == nil, then it's replaced with <object>
function utils.class(base)
    local base = base or object
    local Class = {}

    Class.base = setmetatable({}, {__index=base})

    Class.__index = Class

    return setmetatable(
        Class,
        {
            __index = base,
            __call = base.__new
        }
    )
end

return utils
