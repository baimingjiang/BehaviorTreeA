--==============================--
    --@file: BehaviorTree.lua
    --@desc: 
    --@time: 2019-06-24 18:12:51
    --@autor: baimingjiang
    --@return 
--==============================--

local BehaviorTree = class('BehaviorTree')

function BehaviorTree:ctor(ctx)
    self._context       = ctx
    
    self._isRunning     = false

    self._root          = nil
    self._task = nil
end

function BehaviorTree:load(treeData, customNodeMap)

    local allNodes = {}

    for k, v in pairs(treeData.nodeMap) do
        local Cls = customNodeMap[v.name] or bt[v.name]
        assert(Cls, "error node:" .. v.name)
        allNodes[v.id] = Cls.new(v)
    end

    for k, v in pairs(treeData.nodeMap) do
        local node = allNodes[v.id]

        if node._type == bt.TYPE_COMPOSITE then
            node:fillChildren(allNodes)
        elseif node._type == bt.TYPE_DECORATOR then

        end
    end

    self._root = allNodes[treeData.root]
end

function BehaviorTree:start(callback)
    self._isRunning = true

    self._callback = callback

    self:tick(0)

    if self._isRunning then
        self._task = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.tick), 1/30.0, false)
    end
end

function BehaviorTree:isRunning()
    return self._isRunning
end

function BehaviorTree:tick(dt)
    local ret = self._root:exec(self._context)
    
    if ret ~= bt.RUNNING then
        self._isRunning = false

        if self._callback then
            self._callback(ret)
        end

        if self._task then
            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._task)
            self._task = nil
        end
    end
end

return BehaviorTree