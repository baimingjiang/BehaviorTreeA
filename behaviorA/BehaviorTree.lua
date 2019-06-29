--==============================--
    --@file: BehaviorTree.lua
    --@desc: 
    --@time: 2019-06-24 18:12:51
    --@autor: baimingjiang
    --@return 
--==============================--

local BehaviorTree = class('BehaviorTree')

function BehaviorTree:ctor()
    self._context = nil
    
    self._id    = bt.uuid()
    self._root  = nil
    self._task  = nil

    self._isRunning     = false

    self._nodeList = {}
    self._nodeCount = 0
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

function BehaviorTree:start(context, callback)
    self._context = context
    self._callback = callback

    self._isRunning = true
    self:__run()    
end

function BehaviorTree:stop()
    if self._isRunning then
        self._isRunning = false

        local ret = self._root:abort(self._context)
        self:__finish(ret)
    end
end

function BehaviorTree:isRunning()
    return self._isRunning
end

function BehaviorTree:tick(dt)
    local ret = self._root:exec(self._context)
    
    if ret ~= bt.RUNNING then
        self:__finish(ret)
    end
end

function BehaviorTree:__run()
    self:tick(0)

    if self._isRunning then
        self._task = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.tick), 1/30.0, false)
    end
end

function BehaviorTree:__finish(ret)
    self._isRunning = false

    if self._callback then
        self._callback(ret)
    end

    if self._task then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._task)
        self._task = nil
    end
end

function BehaviorTree:enterBehavior(node)
    table.insert(self._nodeList, node)
    self._nodeCount = self._nodeCount + 1
end

function BehaviorTree:exitBehavior(node)
    for i = #self._nodeList, 1 do
        local tmp = self._nodeList[1]
        if tmp == node then
            table.remove(self._nodeList, i)
            break;
        end
    end
end

return BehaviorTree