bt = {}

bt.NONE     = -1
bt.SUCCESS  = 0
bt.FAILURE  = 1
bt.RUNNING  = 2
bt.ERROR    = 3

bt.TYPE_COMPOSITE   = 1
bt.TYPE_DECORATOR   = 2
bt.TYPE_ACTION      = 3
bt.TYPE_CONDITION   = 4

bt.___base_path = "app.common"

bt.log = function(str)
    local date = os.date("%Y-%m-%d %H:%M:%S");
    _G.print(string.format("[BehaviorTreeA] [%s] %s", date, str))
end

local __load = function(module_path)
    local path = string.format( "%s.%s", bt.___base_path, module_path)
    return require(path)
end

bt.Blackboard       = __load('behaviorA.Blackboard')
bt.BTContext        = __load('behaviorA.BTContext')
bt.BaseBehavior     = __load('behaviorA.BaseBehavior')

bt.Composite        = __load('behaviorA.composite.Composite')
bt.Selector         = __load('behaviorA.composite.Selector')
bt.Sequence         = __load('behaviorA.composite.Sequence')
bt.Parallel         = __load('behaviorA.composite.Parallel')

bt.Decorator        = __load('behaviorA.decorate.Decorator')
bt.Delay            = __load('behaviorA.decorate.Delay')
bt.Repeat           = __load('behaviorA.decorate.Repeat')

bt.Condition        = __load('behaviorA.condition.Condition')

bt.Action           = __load('behaviorA.action.Action')

bt.BehaviorTree     = __load('behaviorA.BehaviorTree')