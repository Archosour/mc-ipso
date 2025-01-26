os.loadAPI("Brave.lua")
os.loadAPI("IPSO.lua")
os.loadAPI("Config.lua")
os.loadAPI("Arch.lua")
os.loadAPI("Displays.lua")

local Device_type = ""
local Tab = 0

local Console_tab = ""

if term.isColor == true then
	Console_tab = multishell.getCurrent()
end 
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
	local Id_object 		= IPSO.Generate_object(IPSO.Object_list.Device,   0, IPSO.Resource_list.Set_UUID, os.getComputerID())
	local Label_object 		= IPSO.Generate_object(IPSO.Object_list.Device,   0, IPSO.Resource_list.Set_Label, os.getComputerLabel())
	local Block_type_object = IPSO.Generate_object(IPSO.Object_list.Device,   0, IPSO.Resource_list.Set_Block_type, Brave.Get_device_type())
	local Dev_type_object 	= IPSO.Generate_object(IPSO.Object_list.Device,   0, IPSO.Resource_list.Set_Type, Device_type)
	local GPSX_object 		= IPSO.Generate_object(IPSO.Object_list.GPS_x,    0, IPSO.Resource_list.Set_value, 0) -- GPS not yet implemented
	local GPSY_object 		= IPSO.Generate_object(IPSO.Object_list.GPS_y,    0, IPSO.Resource_list.Set_value, 0) -- GPS not yet implemented
	local GPSZ_object 		= IPSO.Generate_object(IPSO.Object_list.GPS_z,    0, IPSO.Resource_list.Set_value, 0) -- GPS not yet implemented
	local Protocol_object 	= IPSO.Generate_object(IPSO.Object_list.Protocol, 0, IPSO.Resource_list.Set_SW_version, Brave.Protocol_version)

	local Package = Brave.Generate_package({Id_object, Label_object, Block_type_object, Dev_type_object, GPSX_object, GPSY_object, GPSZ_object, Protocol_object}, Brave.Package_types.Broadcast, {})
	return Package
end

function Generate_inventory_message()
	local Object_table = {}

	for Slot = 1, 16, 1 do
		turtle.select(Slot)
		table.insert(Object_table, IPSO.Generate_object(IPSO.Object_list.Inventory_internal, Slot, IPSO.Resource_list.Set_Item_name, Arch.Get_item_name()))
		table.insert(Object_table, IPSO.Generate_object(IPSO.Object_list.Inventory_internal, Slot, IPSO.Resource_list.Set_Stack_count, turtle.getItemCount()))
	end

	local Inventory_message = Brave.Generate_package(Object_table, Brave.Package_types.Broadcast, {})
	return Inventory_message
end

function main()
	Startup()

	if Device_type == "Turtle:Mining" then
        term.clear()
        term.setCursorPos(1,1)
        term.write("Distance: ")
        local Distance = tonumber(read())
        --print("User input: " .. Distance)

		Displays.Print_display("Home", ["Distance: " .. Distance])

		local Inventory_message = Generate_inventory_message()
		Brave.Modem.Transmit(Config.Channel_network, Inventory_message)

		local Traveled = 0

		--Start with a clean inventory
		if Config.Chest_type_dump == "Ender chest" or Config.Chest_type_dump == "Ender" then
			Arch.Chest_dump()
		end
		
		for Traveled = 1, Distance, 1 do
			turtle.select(Get_minimal_slot())

			if turtle.getItemCount() > 0 then
				Arch.Chest_dump()
			end

			turtle.select(1)

			--offset due to starting on hight 1
			Arch.Tunnel_slice(Config.Tunnel_hight - 1)
			
			if Traveled ~= Distance then
				Arch.Refuel_upto(10)
				Arch.Forward()
			end
			
		end

		--End with a clean inventory
		if Config.Chest_type_dump == "Ender chest" or Config.Chest_type_dump == "Ender" then
			Arch.Chest_dump()
		end
		
	elseif Device_type == "Turtle:Latex" then
		local Chest = peripheral.wrap(Config.Vault_side)

		while true do
			print("loop")
			Latex_farm(Chest)

			sleep(Config.Main_timer)
		end
	end
end

function Latex_farm(Chest)
	local Size = Chest.size()

	if turtle.detectDown() == true then return end

	print("nothing found below")

	for Slot = 1, Size, 1 do
		local Slot_detail = Chest.getItemDetail(Slot)
		
		if Slot_detail ~= nil then
			if Slot_detail.displayName == "Oak Log" then
				print("oak log found")
				turtle.select(1)
				turtle.suck(1)
				turtle.placeDown()
				return
			end
		end
	end
end

function Get_minimal_slot()
	if (Config.Tunnel_hight <= 15) then return 12 end
	if (Config.Tunnel_hight < 20)  then return 11 end
	if (Config.Tunnel_hight >= 20) then return 10 end
end

main()