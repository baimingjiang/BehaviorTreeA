--==============================--
    --@file: Action.lua
    --@desc: 
    --@time: 2019-6-26 15:28:6
    --@autor: baimingjiang
    --@return 
--==============================--

local Action = class('Action', bt.BaseBehavior)

function Action:ctor(conf)
    Action.super.ctor(self, conf)

    self._type = bt.TYPE_Action
end

function Action:onProcess(ctx)

end

return Action