--==============================--
    --@file: Blackboard.lua
    --@desc: 
    --@time: 2019-6-26 15:16:43
    --@autor: baimingjiang
    --@return 
--==============================--

local Blackboard = class("Blackboard")

function Blackboard:ctor(  )
    self._g_data = {}
    self._t_data = {}
end

function Blackboard:_getDataCache(tId, nId, nilAndCreate)
    local ret = self._g_data
    if tId then
        local treeData = self._t_data[tId]

        if not treeData and nilAndCreate then
            self._t_data[tId] = {
                node_data = {},
                base_data = {},
            }

            treeData = self._t_data[tId]
        end

        if treeData then
            if nId then
                ret = treeData.node_data[nId]
            else
                ret = treeData.base_data
            end
        else
            ret = {}
        end
    end

    return ret
end

function Blackboard:set(key, value, tId, nId)
    local cache = self:_getDataCache(tId, nId, true)
    cache[key] = value
end

function Blackboard:get(key, tId, nId)
    local cache = self:_getDataCache(tId, nId, false)
    return cache[key]
end

function Blackboard:erase(tId, nId)
    
end


return Blackboard