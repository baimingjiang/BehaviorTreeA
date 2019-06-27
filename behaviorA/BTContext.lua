--==============================--
    --@file: BTContext.lua
    --@desc: 
    --@time: 2019-6-25 19:31:34
    --@autor: baimingjiang
    --@return 
--==============================--

local BTContext = class("BtContext")

function BTContext:ctor()
    
    self._tree = nil
    self._blackboard = nil

    self._nodeList = {}
    self._nodeCount = 0
end

-- 
function BTContext:pushBehavior(node)
    self._nodeCount = self._nodeCount + 1
    table.insert(self._nodeList, node)
end

function BTContext:popBehavior(node)
    if self._nodeCount > 0 then
        table.remove(self._nodeList, self._nodeCount)
        self._nodeCount = self._nodeCount - 1
    end
end

function BTContext:getCurBehavior()
    local ret = nil
    if self._nodeCount > 0 then
        ret = self._nodeList[self._nodeCount]
    end

    return ret
end

return BTContext