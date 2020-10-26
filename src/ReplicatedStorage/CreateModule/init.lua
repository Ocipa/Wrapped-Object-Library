--K.E. (Ocipa), October 2020

local module = {
    template = require(script:FindFirstChild("template")),
    wrapper = require(script:FindFirstChild("wrapper")),

    config = require(script:FindFirstChild("config")),

    instances = {}
    --instances = {[instance] = custom properties table}
}

local mt = {
    __call = function(t, ...)
        return create(...)
    end
}
setmetatable(module, mt)


function create(...)
    --local className, template, properties = module.argSort(...)

    local t = table.pack(...)

    --I HATE THESE NEXT 3 LINES, SOMEBODY PLEASE REFACTOR THIS, it takes the parameteres and determines what one is className, template and properties
    local template = (t[1] and type(t[1]) == "string" and module.template:Get(t[1])) or (t[2] and type(t[2]) == "string" and module.template:Get(t[2])) or {}
    local properties = (t[3] and type(t[3]) == "table" and t[3]) or (t[2] and type(t[2]) == "table" and t[2]) or (t[1] and type(t[1]) == "table" and t[1]) or {}
    local className = (t[1] and type(t[1]) == "string" and not module.template:Get(t[1]) and t[1]) or (properties and properties["ClassName"]) or (template and template["ClassName"])

    if module.config.show_errors then
        assert(className, "error:1 Attempt to create a instance witha invalid class index")
    end
    if not className then
        return
    end

    for i, v in pairs(template) do
        if not properties[i] then
            properties[i] = v
        end
    end

    local instance
    local success, response = pcall(function()
        instance = Instance.new(className)
    end)

    if not success and module.config.show_errors then
        error("error:2 "..className.." is not a valid class index")
    end
    if not success then
        return
    end
    table.insert(module.instances, instance)

    for i, v in pairs(properties) do
        local success, response = pcall(function()
            instance[i] = v
        end)
    end

    local customInstance = module.wrapper:Wrap(instance)

    return customInstance
end

return module