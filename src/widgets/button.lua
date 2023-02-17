local theme = require 'theme'
local utils = require 'utils'

local Button = {}

function Button.init(self, args)
    self._group = display.newGroup()
    args.parent:insert(self._group)
    self._group.x = args.x
    self._group.y = args.y
    self._group.anchorX = args.anchorX == nil and 0.5 or args.anchorX
    self._group.anchorY = args.anchorY == nil and 0.5 or args.anchorY
    
    self._rect = display.newRoundedRect(self._group, 0, 0, args.width, args.height, args.cornerRadius)

    theme.fill(self._rect, "background")

    self._text = display.newText({parent = self._group, text = args.text, fontSize = args.fontSize})
    self._text.anchorX = 0.5
    self._text.anchorY = 0.5
    theme.fill(self._text, args.textColorKey or "foreground")

    self._group:addEventListener('touch', function(event)
        if(event.phase == 'began') then
            display.getCurrentStage():setFocus(self._group)
            theme.fill(self._rect, "highlight")
        elseif(event.phase == 'ended') then
            display.getCurrentStage():setFocus(nil)
            theme.fill(self._rect, "background")
        end
    end)

    if args.onTouchEnded then
        local listener = args.onTouchEnded
        self._group:addEventListener('touch', function(event)
            if (event.phase == 'ended') then
                listener()
            end
        end)
    end

    if args.onTap then
        self._group:addEventListener('tap', args.onTap)
    end
end

function Button.getPos(self)
    return self._group.x, self._group.y
end

function Button.setPos(self, x, y)
    utils.set(self._group, {x = x, y = y})
end

function Button.destroy(self)
    display.remove(self._text)
    self._text = nil
    display.remove(self._rect)
    self._rect = nil
    display.remove(self._group)
    self._group = nil
end

return Button
