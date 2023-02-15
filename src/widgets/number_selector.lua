local display, random = display, math.random

local utils = require 'src.utils'

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
    self:_updateText()
    self._text.anchorY = 0.5
    self._text.anchorX = 1

    self._increment = utils.createButton(self._group, args.size , -(args.size + args.padding) / 2, args.size, args.size, "+", args.size * 0.75, args.padding, 0, 1)
    self._decrement = utils.createButton(self._group, args.size, (args.size + args.padding) / 2, args.size, args.size, "-", args.size * 0.75, args.padding, 0, 0)

    self._increment:addEventListener('touch', self:_makeListener(1))
    self._decrement:addEventListener('touch', self:_makeListener(-1))
end

function NumberSelector._makeListener(self, delta)
    return function(event)
        if (event.phase == 'ended') then
            self:_update(delta)
        end
    end
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
    display.remove(self._increment)
    self._increment = nil
    display.remove(self._decrement)
    self._decrement = nil
    display.remove(self._text)
    self._text = nil
end

return NumberSelector