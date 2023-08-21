os.loadAPI("Brave.lua")
os.loadAPI("Displays.lua")
os.loadAPI("IPSO.lua")

Displays.Print_display("Home")

Brave.Modem.open(1)
Brave.Log_clear()

local Recieved_messages = {{},{},{}}

-- Moves all revieved messages one position in the Table
-- Newest iteration (1) will get the input message insterted
function Update_message_table(Input_message)
    local n = 0

    for n = #Recieved_messages, 1, -1 do
        if n ~= 1 then
            Recieved_messages[n] = Recieved_messages[n - 1]
        else
            Recieved_messages[n] = Input_message
        end
    end
end

function Write_message_log()
    local n = 0

    for n = 1, #Recieved_messages, 1 do
        local Message = Recieved_messages[n]
        local Log = ""

        if Message ~= nil and Message.Data ~= nil then
            --Brave.Log("new scroll", true, false)
            --Brave.Log(type(textutils.serialize(Message)), true, false) 

            local Day          = Message.Server_day
            local Time         = Brave.Round_decimal(Message.Server_time)
            local Package_type = Message.Package_type
            local Targets      = Message.Targets
            local Sender       = Message.Device_id
            local Value        = Message.Data[1].Value
                  Log          = Day .. ":" .. Time .. ":" .. Sender .. ":" .. Targets[1] .. ":" .. Value

        end
        
        term.setCursorPos(1,16 + n)
        term.write(Log)
    end
end

while true do
    Input = {os.pullEvent()}

    if Input[1] == "modem_message" then

        -- Recieved data is stored in field 5
        Input_message = textutils.unserialize(Input[5])

        -- can do used to debug incomming messages in Log file
        --Brave.Log("new message", true, false)
        --Brave.Log(textutils.serialize(Input_message), true, false) 

        Update_message_table(Input_message)
    end

    Write_message_log()
    term.setCursorPos(Displays.Neutral_pos.Pocket.x, Displays.Neutral_pos.Pocket.y)
    term.write("update: " .. os.time())
end