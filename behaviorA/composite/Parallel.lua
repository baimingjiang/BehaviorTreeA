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

    self._curIndex = 1
end

function Parallel:onExit(ctx)
    Parallel.super.onExit(self, ctx)
end

function Parallel:onProcess(ctx)

end

return Parallel