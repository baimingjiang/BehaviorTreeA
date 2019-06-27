--==============================--
    --@file: Sequence.lua
    --@desc: 
    --@time: 2019-6-26 11:51:22
    --@autor: baimingjiang
    --@return 
--==============================--

local Sequence = class('Sequence', bt.Composite)

function Sequence:onEnter(ctx)
    Sequence.super.onEnter(self, ctx)

    self._curIndex = 1
end

function Sequence:onExit(ctx)
    Sequence.super.onExit(self, ctx)
end

function Sequence:onProcess(ctx)
    local startIndex = self._curIndex

    for i = startIndex, #self._children do
        local ret = self._children[i]:exec(ctx)

        if ret ~= bt.SUCCESS then
            self._state = ret
            break
        end

        self._curIndex = self._curIndex + 1
    end
    
    if self._state == bt.RUNNING 
    and self._curIndex > #self._children then
        self._state = bt.SUCCESS
    end
end

return Sequence