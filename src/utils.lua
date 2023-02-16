local string_len, string_sub, string_find = string.len, string.sub, string.find

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

function utils.convert.str2table(s)
    local t = {}
    for i=1, string_len(s) do
        t[i] = string_sub(s, i, i)
    end
    return t
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

function utils.split(s, separator)
    local separator = separator or " "
    tokens = {}
    for match in (s..separator):gmatch("(.-)"..separator) do
        if match ~= "" then table.insert(tokens, match) end
    end
    return tokens
end

utils.table = {}
function utils.table.indices(n)
    local t = {}
    for i=1, n do
        t[i] = i
    end
    return t
end
function utils.table.iclear(t)
    for i=1, #t do
        t[i] = nil
    end
end
function utils.table.clear(t)
    for key in pairs(t) do
        t[key] = nil
    end
end
function utils.table.fill(t, start, count, value)
    local f =(type(value) ~= 'function') and function() return value end or value
    for i=start, start+count-1 do
        t[i] = f()
    end
end
function utils.table.extend(t, count, value)
    local f =(type(value) ~= 'function') and function() return value end or value
    for i=1, count do
        t[#t+1] = f()
    end
end

function utils.table.print(t, title)
    local title = title or ""
    local parts = {}
    local numberType = 'number'
    local stringType = 'string'
    local tableType = 'table'
    local separator = ", "
    for k, v in pairs(t) do
        parts[#parts+1] = 
           (type(k) ~= numberType
                and(tostring(k) .. ":")
            or "") 
            ..
           (type(v) == stringType
                and('"'..tostring(v)..'"')
            -- or type(v) == tableType
            --     and()
            or tostring(v))
    end
    print(title .. "[" .. table.concat(parts, ", ") .. "]")
end

function utils.table.ifind(t, v)
    for i=1, #t do
        if(t[i] == v) then
            return i
        end
    end
    return nil
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