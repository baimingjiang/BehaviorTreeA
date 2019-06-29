--==============================--
    --@file: Composite.lua
    --@desc: 
    --@time: 2019-06-24 17:48:06
    --@autor: baimingjiang
    --@return 
--==============================--

local Composite = class('Composite', bt.BaseBehavior)

function Composite:ctor(conf)
    Composite.super.ctor(self, conf)

    self._type = bt.TYPE_COMPOSITE
    self._children = {}
end

function Composite:fillChildren(nodeList)
    for i, v in ipairs(self._conf.children) do
        local child = nodeList[v]
        assert(child, "child error:" .. v)
        table.insert(self._children, child)
    end
end

function Composite:abort(ctx)
    for i,v in ipairs(self._children) do
        v:abort(ctx)
    end
    
    return Composite.super.abort(self, ctx)
end

return Composite