local display, random, vibrate = display, math.random, system.vibrate

local utils = require 'utils'
local theme = require 'theme'
local widgets = require 'widgets'

local Voting = {}

function Voting.init(self, args)
    self._group = display.newGroup()
    if(args.parent) then
        self._parent = args.parent
        self._parent:insert(self._group)
    end

    self._maxVotes = args.maxVotes
    self._votes = {}

    self._onComplete = args.onComplete or function(event) end

    self._text = display.newText({parent = self._group, text = "", x = args.width / 2, y = args.height * 0.15, fontSize = 100})
    theme.fill(self._text, "foreground")
    self:_updateText()
    self._text.anchorY = 0
    self._text.anchorX = 0.5

    self._accept = widgets.Button({
        parent = self._group, 
        x = args.width / 4, 
        y = args.height / 2, 
        width = args.width / 2.5, 
        height = args.width / 4, 
        text = "ACCEPT", 
        fontSize = 60, 
        cornerRadius = 10, 
        textColorKey = "positive",
        onTouchEndedInside = function() self:_vote(true) end
    })
    self._decline = widgets.Button({
        parent = self._group, 
        x = (args.width / 4) * 3, 
        y = args.height / 2, 
        width = args.width / 2.5, 
        height = args.width / 4, 
        text = "DECLINE", 
        fontSize = 60, 
        cornerRadius = 10, 
        textColorKey = "negative",
        onTouchEndedInside = function() self:_vote(false) end
    })

    self:shuffle()

    self._undoButton = widgets.Button({
        parent = self._group, 
        x = args.width / 2, 
        y = args.height * 0.75, 
        width = args.width / 3, 
        height = args.width / 5, 
        text = "UNDO", 
        fontSize = 60, 
        cornerRadius = 10,
        onTouchEndedInside = function (event) self:undo() end
    })
end

function Voting._updateText(self)
    self._text.text = ("%s / %s voted"):format(#self._votes, self._maxVotes)
end

function Voting._vote(self, decision)
    if(#self._votes < self._maxVotes) then
        self._votes[#self._votes + 1] = decision
        self:_updateText()
        vibrate("impact", "light")
        self:shuffle()
        if (#self._votes == self._maxVotes) then
            self._onComplete(self:_get())
        end
    end
end

function Voting.undo(self)
    if(#self._votes > 0) then
        table.remove(self._votes, #self._votes)
        self:_updateText()
        vibrate("impact", "heavy")
        self:shuffle()
    end
end

function Voting._get(self)
    local total = 0
    for i, vote in ipairs(self._votes) do
        if vote then
            total = total + 1
        end
    end

    return {accepted = total, declined = self._maxVotes - total}
end

function Voting.shuffle(self)
    if (random(0, 1) == 1) then
        local acceptX = self._accept:getPos()
        self._accept:setPos(self._decline:getPos())
        self._decline:setPos(acceptX)
    end
end

function Voting.reset(self)
    self._votes = {}
    self:_updateText()
end

function Voting.destroy(self)
    display.remove(self._undoButton)
    self._undoButton = nil
    display.remove(self._accept)
    self._accept = nil
    display.remove(self._decline)
    self._decline = nil
    display.remove(self._text)
    self._text = nil
end

return Voting