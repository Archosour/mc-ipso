os.loadAPI("Constants.lua")

function Execute_object(Smart_object)
    local Object    = Smart_object.Object
    local Instance  = Smart_object.Instance
    local Resource  = Smart_object.Resource
    local Value     = Smart_object.Value

    if Object == Object_list.Device then
        return Execute_device(Instance, Resource, Value)

    elseif Object == Object_list.Redstone then
        return Execute_restone(Instance, Resource, Value)

    elseif Object == Object_list.File_system then

    end

    return nil
end

function Execute_device(Instance, Resource, Value)
    if Resource == Resource_list.Set_SW_version then
        if Value == "nil" or Value == nil then
            shell.run("pastebin run ZcfCZWvE")
            return nil
        else 
            shell.run("pastebin run " .. Value)
            return nil
        end

    elseif Resource == Resource_list.Set_sleep then
        sleep(tonumber(Value))
        return nil

    elseif Resource == Resource_list.Set_reboot then
        os.reboot()
        return nil

    elseif Resource == Resource_list.Set_shutdown then
        os.shutdown()
        return nil

    end
end

function Execute_restone(Instance, Resource, Value)
    if Resource == Resource_list.Set_Output_level then
        local Side = Constants.Block_sides[Instance]
        redstone.setAnalogOutput(Side, tonumber(Value))
        return nil

    elseif Resource == Resource_list.Get_Output_level then
        local Side = Constants.Block_sides[Instance]
        local Level = redstone.getAnalogOutput(Side)
        return Level
    
    elseif Resource == Resource_list.Set_value then
        local Side = Constants.Block_sides[Instance]

        if Value == "true" or tonumber(Value) > 0 then
            redstone.setOutput(Side, true)
        else
            redstone.setOutput(Side, false)
        end
        return nil
    
    elseif Resource == Resource_list.Get_value then
        local Side = Constants.Block_sides[Instance]
        local Level = redstone.getAnalogInput(Side)
        return Level

    end

    return nil
end

function Execute_file_system(Instance, Resource, Value)
    if Resource == Resource_list.Set_delete then
        fs.delete(Value)
        return nil
    end
end

function Generate_object(Object, Instance, Resource, Value)
    local Smart_object = {
        ["Object"]   = Object,
        ["Instance"] = Instance,
        ["Resource"] = Resource,
        ["Value"]    = Value
    }

    return Smart_object
end

function Debug_log_smart_object(Smart_object)
    term.clear()
    term.setCursorPos(1,1)
    term.write("Object   " .. Smart_object.Object)
    term.setCursorPos(1,2)
    term.write("Instance " .. Smart_object.Instance)
    term.setCursorPos(1,3)
    term.write("Resource " .. Smart_object.Resource)
    term.setCursorPos(1,4)
    term.write("Value    " .. Smart_object.Value)
end

Object_list = {
    ["Device"]            = 1,
    ["Redstone"]          = 2,
    ["File_system"]       = 3,
    ["Kinetic_capacity"]  = 4,
    ["Kinetic_speed"]     = 5,
    ["Kinetic_direction"] = 6,
    ["Kinetic_stress"]    = 7
}

Resource_list = {
    ["Set_Output_level"] = 1,
    ["Get_Output_level"] = 2,
    ["Set_SW_version"]   = 3,
    ["Get_SW_version"]   = 4,
    ["Set_sleep"]        = 5,
    ["Get_sleep"]        = 6,
    ["Set_delete"]       = 7,
    ["Set_reboot"]       = 9,
    ["Set_shutdown"]     = 11,
    ["Set_max_value"]    = 13,
    ["Get_max_value"]    = 14,
    ["Set_min_value"]    = 15,
    ["Get_min_value"]    = 16,
    ["Set_value"]        = 17,
    ["Get_value"]        = 18
}