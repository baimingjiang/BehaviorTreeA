--==============================--
    --@file: Repeat.lua
    --@desc: 
    --@time: 2019-6-26 15:31:47
    --@autor: baimingjiang
    --@return 
--==============================--

local Repeat = class('Repeat', bt.Decorator)

function Repeat:ctor(conf)
    Repeat.super.ctor(self, conf)
end

return Repeat