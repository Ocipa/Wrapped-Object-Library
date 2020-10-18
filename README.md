# **Wraped Object Moudle**

>### WARNING:
>#### 1. This module was primarily made for personal use.
>#### 2. This is a new module, it may have bugs or unintended behavior, you can report anything at [github](https://github.com/Ocipa/Wrapped-Object-Library/tree/master) or [Roblox Developer Forum](https://www.google.com/).

## **_Table Of Contents_**

1. Information
    1. Why was this module created?
    2. Why should I use this module?
        1. Pros
        2. Cons
    3. Why is this module open source
    4. Setup Guide
2. How to use this module
    1. module()
    2. Templates
    3. Custom Properties
    4. Custom Methods
3. Documentation
4. Errors & Warnings
5. Update Log


# **1. Information**
### 1.1 Why was this module created?
- This module was created to make creating instances easier with nicer syntax.

### 1.2 Why should I use this module?
- Since this module was primarly created for personal use, it comes down to if you think the features of this module are usefull enough.
    #### **Pros**
    - Clean and easier to read insteance creation
    - Using templates, potentially less lines of code
    - Custom methods and properties
    #### **Cons**
    - Creating a instance takes longer (about 2x longer)

### 1.3 Why is this module open source
- I made this module open source since I believe more modules and libraries should be made open source in the roblox devlopment scene to reduce developers reinventing the wheel. For people thinking 'I can make this script', well now you don't have to.

### 1.4 Setup Guide
>### **setup guide is a work in progress.**
![Image of Yaktocat](https://gyazo.com/e543e365d1e228ea6f89008d79eadd45.png)





# **2. How to use this module**
## **2.1 module()**
```lua
local create = require(module)

local instance = create(Properties) --if properties contains Class Name
local instance = create(Class Name, Properties)
local instance = create(Template, Properties) --if template or properties contains Class Name
local instance = create(Class Name, Template, Properties)
```
- Class Name: Expects a string, or nil when it is set in template or properties
- Template: Expects a string (name of a template), or a table of properties
- Properties: Expects a table of properties

```lua
--EXAMPLE OF CREATE()
local create = require(module)

local instance = create(ScreenGui, {
    ["Name"] = "mainScreengui",
    ["ResetOnSpawn"] = false
})
```
## **2.2 Templates**
```lua
local create = require(module)

create.template:New(Template Name)
create.template:New(Template Name, Properties)
create.template:New(Template Name, Class Name, Properties)
```
- Template Name: Expects a string, the name of the template
- Class Name: Expects a string, or nil
- Properties: Expects a table, or nil
```lua
--EXAMPLE OF TEMPLATE:NEW AND CREATE()
local create = require(module)

local template = create.template:New("testTemplate", {
    ["ClassName"] = "Frame",
    ["Size"] = UDim2.new(0.5, 0, 0.5, 0),
    ["BackgroundTransparency"] = 0.5
})

local frame = create("testTemplate")
local frame = create("testTemplate", {
    ["Size"] = UDim2.new(0.25, 0, 0.25, 0)
})
```
## **2.3 Custom Properties**
```lua
local create = require(module)

local instance = create(ScreenGui)

instance:AddProperty(Name of Property, Value of Property)
instance:RemoveProperty(Name of Property) --Cannot remove default values of objects
```
- Name of Property: Expects a string, the name of the property
- Value of Property: Expects any type of value, the value of property
```lua
--EXAMPLE OF :AddProperty() AND :RemoveProperty()
local create = require(module)

local instance = create(ScreenGui, {
    ["Name"] = "mainScreengui",
    ["ResetOnSpawn"] = false
})

instance:AddProperty("testProperty", 5)
print(instance.testProperty) --> prints 5

instance.testProperty = 10
print(instance.testProperty) --> prints 10

instance:RemoveProperty("testProperty")
print(instance.testProperty) --> errors: attempt to index a invalid property
```
## **2.4 Custom Methods**
```lua
local create = require(module)

local instance = create(ScreenGui)

instance:AddMethod(Name of Method, Callback Function)
instance:RemoveMethod(Name of Method) --Cannot remove default methods of objects
```
- Name of Method: Expects string, the name of the method
- Callback Function: Expects function, the function called by method
```lua
--EXAMPLE OF :AddMethod() AND :RemoveMethod()
local create = require(module)

local instance = create(ScreenGui, {
    ["Name"] = "mainScreengui",
    ["ResetOnSpawn"] = false
})

instance:AddMethod("testMethod", function()
    print(5)
end)
instance:testMethod() --> prints 5

instance:RemoveMethod("testMethod")
instance:testMethod() --> errors: attempt to index a invalid method
```
# 3. Documentation
>### **documentation is a work in progress.**


## **module()**

### **Parameters**
|Name|Value Type|Default Value|Description
|:-|:-:|:-:|:-:|
|Class Name|Class Index|nil|Must be defined as first paramiter or as Properties["ClassName"]
|Template|String or Table|nil|
|Properties|Table|Table

<br/>

### **Returns**
|Return Type|Description|
|:-|:-:|
|"Wrapped" Instance|

<br/>

### **Code Samples**
```lua
local create = require(module)
```
The following examples all do the same thing
```lua
create("Frame", {
    ["ClassName"] = "ImageLabel",
    ["Size"] = UDim2.new(0.25, 0, 0.5, 0),
    ["BackgroundTransparency"] = 0.5,
    ["AnchorPoint"] = Vector2.new(0.5, 0)
})
--The class name will be frame since class name in parameters take priority over class name in properties
```
```lua
create({
    ["ClassName"] = "Frame",
    ["Size"] = UDim2.new(0.25, 0, 0.5, 0),
    ["BackgroundTransparency"] = 0.5,
    ["AnchorPoint"] = Vector2.new(0.5, 0)
})
```
```lua
create.template:New("testTemplate", {
    ["Size"] = UDim2.new(0.5, 0, 0.5, 0)
})

create("Frame", "testTemplate", {
    ["ClassName"] = "Frame",
    ["Size"] = UDim2.new(0.25, 0, 0.5, 0),
    ["BackgroundTransparency"] = 0.5,
    ["AnchorPoint"] = Vector2.new(0.5, 0)
})
--The size of the frame will be UDim2.new(0.25, 0, 0.5, 0) since properties take priority over template
```

# 4. Errors & Warnings

## Errors

### **error:1 Attempt to create a instance witha invalid class index**
- Is caused when not passed a class name

### **error:2  className is not a valid class index**
- Is caused when passed a class name, but is not a valid class name.

## Warnings

# 5. Update Log

[10/##/2020] Initial Release