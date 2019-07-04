# BehaviorTreeA



### usage

1. clone and then copy it to your project, for example, "./app/common/behaviorA".

2. insert follow code in your main file:

```lua
    require 'app.common.behaviorA.init'
```

### demo

```lua
    -- tree struct
    local treeData = {
        root = "1001",
        nodeMap = {
            ["1001"] = {
                id = "1001",
                name = "Sequence",
                children = {"1002", "1003", "1004"}
            },
            ["1002"] = {
                id = "1002",
                name = "Test1Action"
            },
            ["1003"] = {
                id = "1003",
                name = "Test2Action"
            },
            ["1004"] = {
                id = "1004",
                name = "Test3Action"
            }
        }
    }

    -- custom action
    local customNodesMap = {
        ["Test1Action"] = require('app.actions.Test1Action'),
        ["Test2Action"] = require('app.actions.Test2Action'),
        ["Test3Action"] = require('app.actions.Test3Action'),
    }
    
    local blackboard	= bt.Blackboard:new()
    local tree 			= bt.BehaviorTree.new()
	local context 		= bt.BTContext.new(tree, blackboard)
    
    tree:load(treeData, customNodesMap)  -- load and create tree struct
    tree:start(context, function( ret )  -- start running, then callback when finish
        local result = ret
    end)

```
