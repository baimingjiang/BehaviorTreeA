--==============================--
    --@file: Decorator.lua
    --@desc: 
    --@time: 2019-6-26 13:32:8
    --@autor: baimingjiang
    --@return 
--==============================--


local Decorator = class('Decorator', bt.BaseBehavior)

function Decorator:ctor(conf)
    Decorator.super.ctor(self, conf)
    
    self._type  = bt.TYPE_DECORATOR
    self._child = nil
end

return Decorator