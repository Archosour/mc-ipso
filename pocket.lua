os.loadAPI("Brave.lua")
os.loadAPI("Displays.lua")
os.loadAPI("IPSO.lua")

Brave.Modem.open(1)
Brave.Log_clear()

local Current_display = "Home"
local New_display = ""
local Scroll_offset = 0
local System_pause = false

local Recieved_messages = {{},{},{}}
local Recieved_energy_messages = {[2] = {}, [3] = {}, [6] = {}}
local Recieved_fluid_messages = {[5] = {}, [16] = {}, [17] = {}}

-- Moves all revieved messages one position in the Table
-- Newest iteration (1) will get the input message insterted
function Update_message_table(Input_message)
    local Device_id = Input_message.Device_id
    local n = 0

    for n = #Recieved_messages, 1, -1 do
        if n ~= 1 then
            Recieved_messages[n] = Recieved_messages[n - 1]
        else
            Recieved_messages[n] = Input_message
        end
    end

    Brave.Log("object recieved from device: " .. Device_id, true, false) 

    --Brave.Log("Potential energy message", true, false)
    --Brave.Log(textutils.serialise(Input_message), true, false)
    --Brave.Log(tostring(Recieved_energy_messages[Device_id] ~= nil), true, false)
    if Recieved_energy_messages[Device_id] ~= nil then
        Recieved_energy_messages[Device_id] = Input_message
        Brave.Log("added object to energy for device: " .. Device_id, true, false)
    end

    if Recieved_fluid_messages[Device_id] ~= nil then
        Recieved_fluid_messages[Device_id] = Input_message
        Brave.Log("added object to fluid for device: " .. Device_id, true, false)
        --Brave.Log(textutils.serialise(Recieved_energy_messages), true, false)
    end

end

function Generate_message_log(n)
    local Message = Recieved_messages[n]
    local Log = "nil"

    if Message == nil      then return Log end
    if Message.Data == nil then return Log end
    --Brave.Log("new scroll", true, false)
    --Brave.Log(type(textutils.serialize(Message)), true, false) 

    local Day          = Message.Server_day
    local Time         = Brave.Round_decimal(Message.Server_time)
    local Package_type = Message.Package_type
    local Targets      = Message.Targets
    local Sender       = Message.Device_id
    local Value        = Message.Data[1].Value

    if Targets[1] == nil then Targets[1] = "BC" end

    if Value ~= nil then
        Log = Day .. ":" .. Time .. ":" .. Sender .. ":" .. Targets[1] .. ":" .. Value
    end

    return Log

end

function Write_message_log()
    local n = 0

    for n = 1, #Recieved_messages, 1 do
        if n >= 4 then return end
        local Log = Generate_message_log(n)
        term.setCursorPos(1,16 + n)
        term.write(Log)
    end
end

function Handle_display(Window)
    Displays.Print_display(Window)

    --Brave.Log("Display handle", true, false)
    --Brave.Log(Window, true, false) 
    --Brave.Log(tostring(Window == "Energy"), true, false) 

    if Window == "Energy" then
        local n = 0
        local Number_of_messages = Brave.Get_table_length(Recieved_energy_messages)
        --Brave.Log("Energy windows found", true, false) 
        --Brave.Log(Number_of_messages, true, false) 
        --Brave.Log(textutils.serialise(Recieved_energy_messages), true, false) 

        for id, Message in pairs(Recieved_energy_messages) do
            --local Message = Recieved_energy_messages[n]
            local Smart_objects = Message.Data
            if Message.Device_name ~= nil then
                local Name = string.match(Message.Device_name, ":(.*)")
                local Stress    = IPSO.Retrieve_value(Smart_objects, IPSO.Object_list.Kinetic_stress   , 0, IPSO.Resource_list.Set_value)
                local Speed     = IPSO.Retrieve_value(Smart_objects, IPSO.Object_list.Kinetic_speed    , 0, IPSO.Resource_list.Set_value)
                local Direction = IPSO.Retrieve_value(Smart_objects, IPSO.Object_list.Kinetic_direction, 0, IPSO.Resource_list.Set_value)
                local Capacity  = IPSO.Retrieve_value(Smart_objects, IPSO.Object_list.Kinetic_capacity , 0, IPSO.Resource_list.Set_value)
                local Percent   = Brave.Get_percentage(Stress, Capacity)

                --Brave.Log("Energy display handle", true, false)
                --Brave.Log(type(textutils.serialize(Message)), true, false) 
                --Brave.Log(Name, true, false)
                --Brave.Log(Stress, true, false)
                --Brave.Log(Speed, true, false)
                --Brave.Log(Direction, true, false)
                --Brave.Log(Capacity, true, false)
                --Brave.Log(Percent, true, false)

                local Line = string.format("%s:%d:%d:%s", Name, Stress, Speed, Percent)
                --Brave.Log(Line, true, false)

                term.setCursorPos(1, n + 4)
                term.write(Line)

                n = n + 1
            end
        end

    elseif Window == "Fluid" then
        local n = 0
        for id, Message in pairs(Recieved_fluid_messages) do
            local Smart_objects = Message.Data
            if Message.Device_name ~= nil then
                local Name = string.match(Message.Device_name, ":(.*)")
                local Value = IPSO.Retrieve_value(Smart_objects, IPSO.Object_list.Volume, -1, IPSO.Resource_list.Set_percentage_value)
                local Fluid_type = Constants.Fluid_types[Smart_objects[1].Instance]

                local Line = string.format("%s:%s:%s", Name, Fluid_type, Value)

                term.setCursorPos(1, n + 4)
                term.write(Line)
                n = n + 1
            end
        end
    end
end

function Go_Home()
    New_display = "Home"
    Scroll_offset = 0
end

-------{ Main }-------

Handle_display(Current_display)

while true do
    Input = {os.pullEvent()}
    Brave.Log(textutils.serialize(Input), true, false)

    if Input[1] == "key" then
        if Input[2] == Constants.Keyboard_keys.Pause_break then
            System_pause =  not System_pause
        end

        if Input[2] == Constants.Keyboard_keys.Home then
            Go_Home()
        end
    end

    -- if system is not paused, then react on events.
    -- if system is paused, then all events are ignored.
    if System_pause ~= true then

        if Input[1] == "modem_message" then

            -- Recieved data is stored in field 5
            Input_message = textutils.unserialize(Input[5])

            -- can do used to debug incomming messages in Log file
            --Brave.Log("new message", true, false)
            --Brave.Log(textutils.serialize(Input_message), true, false) 

            Update_message_table(Input_message)

        elseif Input[1] == "mouse_click" then
            local X = Input[3]
            local Y = Input[4]

            if Y == 2 and X > 22 then 
                Go_Home() 
            end
        
            if Y >= 4 and Y <= 15 then
                local Option_selection = Y - 3 + Scroll_offset
                local Selected_option = Displays.Displays.Pocket[Current_display].Options[Option_selection]

                if Selected_option ~= nil and Selected_option.Discoverable == true then
                    New_display = Displays.Displays.Pocket[Current_display].Options[Option_selection].Name
                else
                    New_display = Current_display
                end
                
                Brave.Log("new display; " .. New_display, true, false)

            end

            Current_display = New_display
        end

        Handle_display(Current_display)

        Write_message_log()
        term.setCursorPos(Displays.Neutral_pos.Pocket.x, Displays.Neutral_pos.Pocket.y)
        term.write("update: " .. os.time())
    end
end