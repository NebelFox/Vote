-- widget.lua
local function silence(self) end

local Widget = {
    init = function(self, args) end,
    destroy = silence
}

local function new(class)
    return setmetatable({}, {
        __index = setmetatable(class, {__index=Widget}),
        __call = function(_, args)
            local self = setmetatable({}, {__index=class})
            class.init(self, args or {})
            return self
        end
    })
end

return new
