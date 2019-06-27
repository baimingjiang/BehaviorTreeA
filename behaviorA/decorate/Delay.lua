--==============================--
    --@file: Delay.lua
    --@desc: 
    --@time: 2019-6-26 15:31:57
    --@autor: baimingjiang
    --@return 
--==============================--


local Delay = class('Delay', bt.Decorator)
function Delay:ctor(conf)
    Delay.super.ctor(self, conf)

end

return Delay
