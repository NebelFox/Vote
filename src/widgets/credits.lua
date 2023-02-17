local utils = require 'src.utils'
local theme = require 'src.theme'

local Credits = {}

function Credits.init(self, args)
    local text = display.newText({parent = args.parent, text = args.text})
    utils.set(text, {anchorX = 0.5, x = CENTERX, anchorY = 1, y = HEIGHT * 0.98})
    theme.fill(text, "secondary")

    local url = args.url

    text:addEventListener('touch', function(event)
        if (event.phase == 'ended') then
            system.openURL(url)
        end
    end)
end

return Credits
