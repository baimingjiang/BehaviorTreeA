--==============================--
    --@file: BaseBehavior.lua
    --@desc: 
    --@time: 2019-6-25 19:31:58
    --@autor: baimingjiang
    --@return 
--==============================--

local BaseBehavior = class('BaseBehavior')

function BaseBehavior:ctor(conf)
    self._context   = nil

    self._id        = conf.id
    self._desc      = conf.desc or ""

    self._conf      = conf

    self._params    = conf.params or {}

    self._weight    = self._params.weight or 10
    self._sendSignal = self._params.sendSignal

    self._enterSignal    = self._params.enterSignal
    self._exitSignal     = self._params.exitSignal

    self._type      = nil

    self._state         = bt.NONE
    self._cacheState    = nil

    self._tick = 0

    self._isRunning = false
end

function BaseBehavior:setContext(ctx)
    self._context = ctx
end

function BaseBehavior:getContext()
    return self._context
end

function BaseBehavior:setSignal(signal)
    signal = signal or self._sendSignal
    if signal then
        self._context:getBlackboard():set(signal.key, signal.value, self._context:getTree():getId())
    end
end

function BaseBehavior:clearSignal(key)
    self._context:getBlackboard():set(key, nil, self._context:getTree():getId())
end

function BaseBehavior:exec(ctx)

    self:setContext(ctx)

    if self._state == bt.SUCCESS 
    or self._state == bt.FAILURE
    or self._state == bt.ERROR
    or self._state == bt.ABORT then
        return self._state
    end

    self._tick = self._tick + 1

    if not self._isRunning then
        self:__enter(ctx)
    end

    self:__run(ctx)

    if self._state == bt.SUCCESS or self._state == bt.FAILURE then
        self:__exit(ctx)
    end

    return self._state
end

function BaseBehavior:abort(ctx)
    if self._isRunning then
        self:__exit(ctx)
    end
    self._state = bt.ABORT

    return self._state
end

function BaseBehavior:isRunning()
    return self._isRunning
end

function BaseBehavior:getState()
    return self._state
end

function BaseBehavior:reset()
    self._state = bt.NONE
    self._isRunning = false
    self._tick = 0
end

function BaseBehavior:setResult(state)
    self._cacheState = state
end

--- private method ---
function BaseBehavior:__run(ctx)
    self._state = bt.RUNNING

    self:onProcess(ctx)
    self:onHandleState(ctx)
end

function BaseBehavior:__enter(ctx)
    self._tick = 0
    self._isRunning = true

    bt.log(string.format( "node: %s, id:%s, entering, desc: %s", self._conf.name, self._id, self._desc))

    ctx:getTree():enterBehavior(self)
    self:onEnter(ctx)

    if self._enterSignal then
        self:setSignal(self._enterSignal)
    end
end

function BaseBehavior:__exit(ctx)
    self._isRunning = false
    
    if self._exitSignal then
        self:setSignal(self._exitSignal)
    end

    self:onExit(ctx)
    ctx:getTree():exitBehavior(self)

    bt.log(string.format( "node: %s, id:%s, tick:%d, exit", self._conf.name, self._id, self._tick))
end

--
-- public and override

function BaseBehavior:onEnter(ctx)
    
end

function BaseBehavior:onExit(ctx)
    
end

function BaseBehavior:onHandleState(ctx)
    if self._cacheState then
        self._state = self._cacheState
        self._cacheState = nil
    end
end

function BaseBehavior:onProcess(ctx)
    
end

return BaseBehavior