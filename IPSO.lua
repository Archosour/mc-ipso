os.loadAPI("Constants.lua")
os.loadAPI("IPSO_object_list.lua")
os.loadAPI("IPSO_resource_list.lua")

Resource_list = IPSO_resource_list.List
Object_list = IPSO_object_list.List

function Execute_object(Smart_object)
    local Object    = Smart_object.Object_id
    local Instance  = Smart_object.Instance_id
    local Resource  = Smart_object.Resource_id
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

    elseif Resource == Resource_list.Set_Toggle_output_level then
        local Side = Constants.Block_sides[Instance]
        local Current_level = redstone.getOutput(Side)
        local New_level = not Current_level

        redstone.setOutput(Side, New_level)
        return nil
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
        ["Object_id"]   = Object,
        ["Instance_id"] = Instance,
        ["Resource_id"] = Resource,
        ["Value"]       = Value
    }

    return Smart_object
end

function Retrieve_value(Smart_objects, object, instance, resource)
    local n = 0

    for n = 1, #Smart_objects, 1 do
        local Object = Smart_objects[n]
        local Object_match = (Object.Object_id == object)
        local Instance_match = (Object.Instance_id == instance)
        local Resource_match = (Object.Resource_id == resource)

        --Brave.Log("retrieve value form object", true, false)
        --Brave.Log(textutils.serialise(Object), true, false)
        --Brave.Log(tostring(Object_match), true, false)
        --Brave.Log(object, true, false)
        --Brave.Log(Object.Instance, true, false)
        --Brave.Log(type(Object.Instance), true, false)
        --Brave.Log(tostring(Instance_match), true, false)
        --Brave.Log(instance, true, false)
        --Brave.Log(tostring(Resource_match), true, false)
        --Brave.Log(resource, true, false)
        
        if Object_match == true and Instance_match == true and Resource_match == true then
            return Object.Value
        end
    end

    -- if instance is not important, insert -1 as instance. 
    -- it will only search the first object
    if instance < 0 then
        local Instance = math.abs(instance)
        local Object = Smart_objects[Instance]
        --Brave.Log("object " .. tostring(object) .. " ==? " .. tostring(Object.Object), true, false)
        --Brave.Log("resource " .. tostring(resource) .. " ==? " .. tostring(Object.Resource), true, false)
        local Object_match = (Object.Object == object)
        local Resource_match = (Object.Resource == resource)
        if Object_match == true and Resource_match == true then
            return Object.Value
        end
    end

    Brave.Log("Smart object not found in message. Retrieve Value function in Brave", true, false)
    return "nil"
end

function Debug_log_smart_object(Smart_object)
    term.clear()
    term.setCursorPos(1,1)
    term.write("Object   " .. Smart_object.Object_id)
    term.setCursorPos(1,2)
    term.write("Instance " .. Smart_object.Instance_id)
    term.setCursorPos(1,3)
    term.write("Resource " .. Smart_object.Resource_id)
    term.setCursorPos(1,4)
    term.write("Value    " .. Smart_object.Value)
end