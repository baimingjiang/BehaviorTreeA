--==============================--
    --@file: Selector.lua
    --@desc: 
    --@time: 2019-6-26 11:51:38
    --@autor: baimingjiang
    --@return 
--==============================--

local Selector = class('Selector', bt.Composite)

function Selector:onEnter(ctx)
    Selector.super.onEnter(self, ctx)

    self._curIndex = 1
end

function Selector:onExit(ctx)
    Selector.super.onExit(self, ctx)
end

function Selector:onProcess(ctx)
    local startIndex = self._curIndex

    local finish = false
    for i = startIndex, #self._children do
        local ret = self._children[i]:exec(ctx)

        if ret == bt.SUCCESS then
            self._state = bt.SUCCESS
            break
        end
        
        if ret == bt.RUNNING then
            break
        end

        self._curIndex = self._curIndex + 1
    end

    if self._state == bt.RUNNING 
    and self._curIndex > #self._children then
        self._state = bt.FAILURE
    end
end

return Selector
