--==============================--
    --@file: Parallel.lua
    --@desc: 
    --@time: 2019-6-26 14:52:57
    --@autor: baimingjiang
    --@return 
--==============================--

local Parallel = class('Parallel', bt.Composite)

function Parallel:onEnter(ctx)
    Parallel.super.onEnter(self, ctx)
end

function Parallel:onExit(ctx)
    Parallel.super.onExit(self, ctx)
end

function Parallel:onProcess(ctx)
    local failureNum = 0
    local successNum = 0
    for i = 1, #self._children do
        local child = self._children[i]
        local ret = child:getState()
        if ret == bt.RUNNING or ret == bt.NONE then
            ret = self._children[i]:exec(ctx)
        end

        if ret == bt.SUCCESS then
            successNum = successNum + 1
        elseif ret == bt.FAILURE then
            failureNum = failureNum + 1
        end
    end

    if (successNum + failureNum) == #self._children then
        self:setResult((failureNum == 0) and bt.SUCCESS or bt.FAILURE)
    end
end

return Parallel