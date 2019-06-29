--==============================--
    --@file: BTContext.lua
    --@desc: 
    --@time: 2019-6-25 19:31:34
    --@autor: baimingjiang
    --@return 
--==============================--

local BTContext = class("BtContext")

function BTContext:ctor(tree, blackboard)
    assert(tree, "The tree cannot be nil.")

    self._tree          = tree
    self._blackboard    = blackboard

    self._nodeList = {}
    self._nodeCount = 0

    self._modules = {}
end

function BTContext:getTree()
    return self._tree
end

function BTContext:getBlackboard()
    return self._blackboard
end

function BTContext:set(name, module)
    assert(self._modules[name] == nil, "duplication module, name is " .. name)
    self._modules[name] = module
end

function BTContext:get(name)
    return self._modules[name]
end

return BTContext