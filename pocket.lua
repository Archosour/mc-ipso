os.loadAPI("Brave.lua")
os.loadAPI("Displays.lua")
os.loadAPI("IPSO.lua")

Displays.Print_display("Home")

Brave.Modem.open(1)
Brave.Log_clear()

local Recieved_messages = {{},{},{}}

function Update_message_table(Input_message)
    Recieved_messages[3] = Recieved_messages[2]
    Recieved_messages[2] = Recieved_messages[1]
    Recieved_messages[1] = Input_message
end

function Write_message_log()
    local n = 0

    for n = 1, #Recieved_messages, 1 do
        local Message = Recieved_messages[n]
        local Log = "nil " .. n

        

        if Message ~= nil and Message.Data ~= nil then
            Brave.Log("new scroll", true, false)
            Brave.Log(type(textutils.serialize(Message)), true, false) 

            local Day = Message.Server_day
            local Time = Brave.Round_decimal(Message.Server_time)
            local Package_type = Message.Package_type
            local Targets = Message.Targets
            local Sender = Message.Device_id
            local Value = Message.Data[1].Value
            Log = Day .. ":" .. Time .. ":" .. Sender .. ":" .. Targets[1] .. ":" .. Value

            
        end
        
        term.setCursorPos(1,15 + n)
        term.write(Log)
    end

end

while true do
    Input = {os.pullEvent("modem_message")}

    if Input[1] == "modem_message" then
        -- Recieved data is stored in field 5
        Input_message = textutils.unserialize(Input[5])

        Brave.Log("new message", true, false)
        Brave.Log(textutils.serialize(Input_message), true, false) 

        Update_message_table(Input_message)
        Write_message_log()
        term.setCursorPos(Displays.Neutral_pos.x, Displays.Neutral_pos.y)
        term.write("update: " .. os.time())
        

    end

    



end