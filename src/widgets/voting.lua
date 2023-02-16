local display, random, vibrate = display, math.random, system.vibrate

local utils = require 'src.utils'

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

    self._text = display.newText({parent = self._group, text = "", x = args.width / 2, y = 100, fontSize = 100})
    self:_updateText()
    self._text.anchorY = 0
    self._text.anchorX = 0.5

    self._accept = utils.createButton(self._group, args.width / 4, args.height / 2, args.width / 3, args.width / 4, "ACCEPT", 60, 10, nil, nil, {0, 1 ,0})
    self._decline = utils.createButton(self._group, (args.width / 4) * 3, args.height / 2, args.width / 3, args.width / 4, "DECLINE", 60, 10, nil, nil, {1, 0, 0})

    self._accept:addEventListener('touch', self:_makeVoteListener(true))
    self._decline:addEventListener('touch', self:_makeVoteListener(false))
    self:shuffle()

    self._undoButton = utils.createButton(self._group, args.width / 2, args.height * 0.8, 
        args.width / 3, args.width / 5, "UNDO", 60, 10)
    self._undoButton:addEventListener('tap', function (event) self:undo() end)
end

function Voting._makeVoteListener(self, decision)
    return function(event)
        if(event.phase == 'ended') then
            self:_vote(decision)
        end
    end
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
        vibrate("notification", "warning")
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
        local acceptX = self._accept.x
        self._accept.x = self._decline.x
        self._decline.x = acceptX
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