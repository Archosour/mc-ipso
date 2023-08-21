os.loadAPI("Brave.lua")
os.loadAPI("IPSO.lua")

Brave.Modem.open(1)
Brave.Log_clear()

function Run_ipso(Message)
  local Smart_objects = Message.Data

    for n = 1, #Smart_objects, 1 do
		    local Smart_object = Smart_objects[n]

        IPSO.Debug_log_smart_object(Smart_object)
        IPSO.Execute_object(Smart_object)
	  end
end

function ID_present(array)
  local ID = os.getComputerID()
  local n = 0

  for n = 1, #array, 1 do
    if array[n] == ID then return true end
  end

  return false
end

while true do
    Input = {os.pullEvent("modem_message")}

    -- Recieved data is stored in field 5
    Input_message = textutils.unserialize(Input[5])
    Brave.Log(textutils.serialize(Input_message), true) 

    if Input_message.Package_type == Brave.Package_types.Broadcast then
      Run_ipso(Input_message)
    end

    if ID_present(Input_message.Targets) == true then
      Run_ipso(Input_message)
    end
end

