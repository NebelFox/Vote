local display, random = display, math.random

local utils = require 'utils'
local widgets = require 'widgets'
local theme = require 'theme'

local NumberSelector = {}

function NumberSelector.init(self, args)
    self._group = display.newGroup()
    if(args.parent) then
        self._parent = args.parent
        self._parent:insert(self._group)
    end

    self._group.x = args.x
    self._group.y = args.y
    self._group.anchorX = 0.5
    self._group.anchorY = 0.5

    self._min = args.min or 0
    self._max = args.max
    self._value = args.value or self._min
    self._step = args.step or 1

    self._text = display.newText({parent = self._group, text = "", -args.padding, 0, fontSize = args.size * 2})
    theme.fill(self._text, "foreground")
    self:_updateText()
    self._text.anchorY = 0.5
    self._text.anchorX = 1

    self._increment = widgets.Button({
        parent = self._group, 
        x = args.size, 
        y = -(args.size + args.padding) / 2, 
        width = args.size, 
        height = args.size, 
        text = "+", 
        fontSize = args.size * 0.75, 
        cornerRadius = args.padding, 
        anchorX = 0, 
        anchorY = 1,
        textColorKey = "foreground",
        onTouchEnded = function() self:_update(1) end
    })
    self._decrement = widgets.Button({
        parent = self._group, 
        x = args.size, 
        y = (args.size + args.padding) / 2, 
        width = args.size, 
        height = args.size, 
        text = "-", 
        fontSize = args.size * 0.75, 
        cornerRadius = args.padding, 
        anchorX = 0, 
        anchorY = 0,
        textColorKey = "foreground",
        onTouchEnded = function() self:_update(-1) end
    })
end

function NumberSelector._updateText(self)
    self._text.text = tostring(self._value)
end

function NumberSelector._update(self, delta)
    local next = self._value + delta
    if(next <= self._max and next >= self._min) then
        self._value = next
        self:_updateText()
    end
end

function NumberSelector.get(self)
    return self._value
end

function NumberSelector.destroy(self)
    self._increment:destroy()
    self._decrement:destroy()
    display.remove(self._text)
    self._text = nil
end

return NumberSelector