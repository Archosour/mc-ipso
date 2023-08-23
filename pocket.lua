os.loadAPI("Brave.lua")
os.loadAPI("Displays.lua")
os.loadAPI("IPSO.lua")

--Displays.Print_display("Home")

Brave.Modem.open(1)
Brave.Log_clear()

local Current_display = "Home"
local New_display = ""
local Scroll_offset = 0

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

            if Targets[1] == nil then Targets[1] = "BC" end

            if Value ~= nil then
                Log = Day .. ":" .. Time .. ":" .. Sender .. ":" .. Targets[1] .. ":" .. Value
            end

        end
        
        term.setCursorPos(1,16 + n)
        term.write(Log)
    end
end

function Handle_display(Window)
    Displays.Print_display(Window)

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

            if Displays.Displays.Pocket[Current_display].Options[Option_selection].Discoverable == true then
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