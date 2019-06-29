--==============================--
    --@file: Condition.lua
    --@desc: 
    --@time: 2019-6-24 18:32:30
    --@autor: baimingjiang
    --@return 
--==============================--

local Condition = class('Condition', bt.BaseBehavior)

function Condition:ctor(conf)
    Condition.super.ctor(self, conf)

    self._type = bt.TYPE_CONDITION
end

function Condition:onProcess(ctx)

end

return Condition
