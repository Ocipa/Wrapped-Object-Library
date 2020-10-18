--K.E. (Ocipa), October 2020

local module = {
    config = require(script.Parent:FindFirstChild("config"))
}

local debug_mode = false

local wrappedCache = {} --{[rObject] = wObject}

function module:Wrap(rObject) --rObject == real object
    if wrappedCache[rObject] then
        return wrappedCache[rObject]
    end

    if type(rObject) == "userdata" then
        local fObject = newproxy(true) --fObject == fake object
        local mt = getmetatable(fObject)

        local properties = {}

        mt.methods = {} --{[method name] = function}
        mt.methods["AddMethod"] = function(_, mName, func) --mName = method name, func = function
            if not mt.methods[mName] then
                mt.methods[mName] = func
            else
                error("Attempt to overwrite method: "..mName)
            end
        end

        mt.methods["RemoveMethod"] = function(_, mName) --mName = method name
            if mt.methods[mName] then
                mt.methods[mName] = nil
            else
                error("Attempt to remove invalid method: "..mName)
            end
        end

        mt.methods["AddProperty"] = function(_, pName, value) --pName = property name, value = value
            if properties[pName] or properties[pName] == false then
                error("Attempt to overwrite property: "..pName)
            else
                properties[pName] = value or false
            end
        end

        mt.methods["RemoveProperty"] = function(_, pName) --pName = property name
            if properties[pName] or properties[pName] == false then
                properties[pName] = nil
            else
                error("Attempt to remove invalid property: "..pName)
            end
        end

        mt.methods["GetRealObject"] = function()
            return rObject
        end

        mt.__index = function(s, k, ...)
            if mt.methods[k] then
                return mt.methods[k]
            end

            if properties[k] then
                return properties[k]
            end

            local a
            local success, errorResponse = pcall(function()
                if rObject[k] then
                    a = rObject[k]
                end
            end)

            return a
        end

        mt.__newindex = function(_, k, v)
            local success, response = pcall(function()
                if properties[k] or properties[k] == false then
                    properties[k] = v
                elseif rObject[k] or rObject[k] == false then
                    rObject[k] = v
                end
            end)

            if module.config.debug then
                print("pcall Success: "..tostring(success) or ""..", response: "..response or "")
            end
        end

        mt.__tostring = function()
            return rObject.ClassName
        end

        wrappedCache[rObject] = fObject
        return fObject
    else
        error("Wrapper Module: wrapper can only wrap userdata values, was passed a "..type(rObject)..".")
    end
end

function module:Unwrap(wObject) --wObject == wrapped object
    cachedObject = wrappedCache[wObject]
    if not cachedObject then
        return wObject
    end

    return cachedObject
end


return module