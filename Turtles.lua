os.loadAPI("Brave.lua")
os.loadAPI("IPSO.lua")
os.loadAPI("Config.lua")
os.loadAPI("Arch.lua")

local Device_type = ""
local Tab = 0

local Console_tab = multishell.getCurrent()
local Pc_label = os.getComputerLabel()

---Setup for the main loop.
---Primarly for checking Config and tasks than only run one time.
function Startup()
	Brave.Clear_term()
	print("Turtle scripts")
	print("PC ID: " .. tostring(os.getComputerID()))
	print("PC label: " .. tostring(os.getComputerLabel()))

	if Config == nil then
		print("No config.lua file found. run 'Update' to add config file")
		while true do end
    end

	if Config.Device_type == nil then
		print("No device type found in Config")
		while true do end
	end
	Device_type = Config.Device_type
	print("Device type: " .. Device_type)

	Brave.Modem.open(Config.Channel_network)
end

---Generate Alive message.
---This message contains general information about the device.
---The content can be captured by the backend to show activity.
---Does not send the message.
---@return String #Package ready to be send over the network
function Generate_alive_message()
	local object1 = IPSO.Generate_object(IPSO.Object_list.Device, 0, IPSO.Resource_list.Set_UUID, os.getComputerID())
	local object2 = IPSO.Generate_object(IPSO.Object_list.Device, 0, IPSO.Resource_list.Set_Label, os.getComputerLabel())
	local object3 = IPSO.Generate_object(IPSO.Object_list.Device, 0, IPSO.Resource_list.Set_Block_type, Brave.Get_device_type())
	local object7 = IPSO.Generate_object(IPSO.Object_list.Device, 0, IPSO.Resource_list.Set_Type, Device_type)
	local object4 = IPSO.Generate_object(IPSO.Object_list.GPS_x, 0, IPSO.Resource_list.Set_value, 0) -- GPS not yet implemented
	local object5 = IPSO.Generate_object(IPSO.Object_list.GPS_y, 0, IPSO.Resource_list.Set_value, 0) -- GPS not yet implemented
	local object6 = IPSO.Generate_object(IPSO.Object_list.GPS_z, 0, IPSO.Resource_list.Set_value, 0) -- GPS not yet implemented
	local object8 = IPSO.Generate_object(IPSO.Object_list.Protocol, 0, IPSO.Resource_list.Set_SW_version, Brave.Protocol_version)

	local Package = Brave.Generate_package({object1, object2, object3, object4, object5, object6, object7, object8}, Brave.Package_types.Broadcast, {})
	return Package
end

function Generate_inventory_message()
	local Object_table = {}

	for Slot = 1, 16, 1 do
		turtle.select(Slot)
		table.insert(Object_table, IPSO.Generate_object(IPSO.Object_list.Inventory_internal, Slot, IPSO.Resource_list.Set_Item_name, Arch.Get_item_name()))
		table.insert(Object_table, IPSO.Generate_object(IPSO.Object_list.Inventory_internal, Slot, IPSO.Resource_list.Set_Stack_count, turtle.getItemCount()))
	end

	return Object_table
end

function main()
	Startup()

	if Device_type == "Turtle:Mining" then
        term.clear()
        term.setCursorPos(1,1)
        term.write("Distance: ")
        local Distance = read()
        print("User input: " .. Distance)

		local Inventory_message = Generate_inventory_message()
		Brave.Modem.Transmit(Config.Channel_network, Inventory_message)
	end
end

main()