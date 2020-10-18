--K.E. (Ocipa), October 2020

local module = {}

local cachedTemplates = {}


function module:New(...)
    t = table.pack(...)

    local name = typeof(t[1]) == "string" and t[1]
    local className = typeof(t[2]) == "string" and t[2]
    local properties = (typeof(t[2]) == "table" and t[2]) or (typeof(t[3]) == "table" and t[3])

    assert(name, "attempted to create a template without a name")
    
    if not properties then
        warn("created template "..name.." without properties table")
        properties = {}
    end

    addTemplate(name, className, properties)
end

function module:Remove(name)
    assert(name, "attempt to remove a template without a name")

    removeTemplate(name)
end

function module:Get(name)
    assert(name, "attempt to get a template without a name")

    local template = getTemplate(name)
    return template
end

function module:RemoveAll()
    removeAllTemplates()
end


function addTemplate(name, className, properties)
    properties["ClassName"] = className or properties["ClassName"] or nil

    cachedTemplates[name] = properties
end

function removeTemplate(name)
    if not cachedTemplates[name] then
        warn("attempt to remove a template. template "..name.." does not exist")
    else
        cachedTemplates[name] = nil
    end
end

function getTemplate(name)
    if cachedTemplates[name] then
        return cachedTemplates[name]
    else
        warn("attempt to get a template. template "..name.." does not exist")
    end

    return
end

function removeAllTemplates()
    cachedTemplates = {}
end

return module