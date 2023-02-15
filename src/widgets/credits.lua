local utils = require 'src.utils'

local Credits = {}

function Credits.init(self, args)
    local text = display.newText({parent = args.parent, text = args.text})
    utils.set(text, {anchorX = 0.5, x = display.contentWidth / 2, anchorY = 1, y = display.contentHeight * 0.98, alpha = args.alpha})

    local url = args.url

    text:addEventListener('touch', function(event)
        if (event.phase == 'ended') then
            system.openURL(url)
        end
    end)
end

return Credits
