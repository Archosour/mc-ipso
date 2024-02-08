os.loadAPI("Brave.lua")
os.loadAPI("IPSO.lua")
os.loadAPI("Config.lua")

local Device_type = ""
local Tab = 0

local Console_tab = multishell.getCurrent()
local Pc_label = os.getComputerLabel()

---Setup for the main loop.
---Primarly for checking Config and tasks than only run one time.
function Startup()
	Brave.Clear_term()
	if pocket then
		Tab = multishell.launch({}, "Pocket.lua", {"true"})
		
		multishell.setTitle(Tab, "Home")
		multishell.setTitle(Console_tab, "Con")
		multishell.setFocus(Tab)
	end

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

	if Device_type ~= "Network:Internet_gateway" then 
		-- give the gateways time to startup when area is loaded
		-- example when player log into the server.
		sleep(0.5)

		-- Make sure not all devices start at the same time.
		-- This spreads the load on the Gateways so thay can 
		-- handle more data
		local Random_wait_time = math.random(0, Config.Main_timer)
		print("Random startup sleep time: " .. Random_wait_time)
		sleep(Random_wait_time)

		Alive_message = Generate_alive_message()
		Brave.Modem.Transmit(Config.Channel_network, Alive_message)
	end

	Tab = multishell.launch({}, "Run_ipso.lua", {"false"})
	multishell.setTitle(Tab, "Ipso")
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

function main()
	Startup()

	if Device_type == "Network:Internet_gateway" then
		local URL = Config.Gateway_IPv4
		local Route = Config.Gateway_route

		-- The gateway cannot send a alive message during startup
		-- since the gatway is not open at that time.
		Alive_message = Generate_alive_message()
		Alive_JSON = textutils.serialiseJSON(textutils.unserialize(Alive_message))
		http.post(URL .. Route,'{ "Data" : ' .. Alive_JSON .. ', "Gateway_id" : ' .. os.getComputerID() .. ' }',{ ["Content-Type"] = "application/json"})

		while true do
			Input = {os.pullEvent("modem_message")}
		
			-- Recieved data is stored in field 5
			Input_message = textutils.unserialize(Input[5])
			Data_JSON = textutils.serialiseJSON(Input_message)
	
			http.post(URL .. Route,'{ "Data" : ' .. Data_JSON .. ', "Gateway_id" : ' .. os.getComputerID() .. ' }',{ ["Content-Type"] = "application/json"})
		end

	elseif Device_type == "Fluid:Tank" then
		while true do
			local Tank = peripheral.wrap(Config.Tank_side).getInfo()
			local Tank_slot = 1
			local Fluid_name = Tank.fluid
			local Fluid_level = Tank.amount
			local Fluid_max_value = Tank.capacity
			local Fluid_fill_ratio = Fluid_level / Fluid_max_value
			local Fluid_fill_percent  = tostring(math.ceil(Fluid_fill_ratio * 100)) .. "%"

			local Name_object  = IPSO.Generate_object(IPSO.Object_list.Volume, Tank_slot, IPSO.Resource_list.Set_Item_name, Fluid_name)
			local Level_object = IPSO.Generate_object(IPSO.Object_list.Volume, Tank_slot, IPSO.Resource_list.Set_value, Fluid_level)
			local Max_level_object = IPSO.Generate_object(IPSO.Object_list.Volume, Tank_slot, IPSO.Resource_list.Set_max_value, Fluid_max_value)
			local Fill_ratio_object = IPSO.Generate_object(IPSO.Object_list.Volume, Tank_slot, IPSO.Resource_list.Set_Filled_ratio, Fluid_fill_ratio)
			local Percent_object = IPSO.Generate_object(IPSO.Object_list.Volume, Tank_slot, IPSO.Resource_list.Set_percentage_value, Fluid_fill_percent)

			local Package = Brave.Generate_package({Name_object, Level_object, Max_level_object, Fill_ratio_object, Percent_object}, Brave.Package_types.Broadcast, {})
			Brave.Modem.Transmit(Config.Channel_network, Package)

			sleep(Config.Main_timer)
		end

	elseif Device_type == "Energy:Kinetic_system" then
		local StressOmeter = peripheral.wrap("left")
		local SpeedOmeter = peripheral.wrap("bottom")

		while true do
			local RPM = math.abs(SpeedOmeter.getSpeed())
			local Direction = true
			local Stress = StressOmeter.getStress()
			local Capacity = StressOmeter.getStressCapacity()

			if RPM < 0 then Direction = false end

			local RPM_object 	   = IPSO.Generate_object(IPSO.Object_list.Kinetic_speed, 	  0, IPSO.Resource_list.Set_value, RPM)
			local Direction_object = IPSO.Generate_object(IPSO.Object_list.Kinetic_direction, 0, IPSO.Resource_list.Set_value, Direction)
			local Stress_object    = IPSO.Generate_object(IPSO.Object_list.Kinetic_stress,    0, IPSO.Resource_list.Set_value, Stress)
			local Capacity_object  = IPSO.Generate_object(IPSO.Object_list.Kinetic_capacity,  0, IPSO.Resource_list.Set_value, Capacity)

			local Package = Brave.Generate_package({RPM_object, Direction_object,Stress_object,Capacity_object}, Brave.Package_types.Broadcast, {})
			Brave.Modem.Transmit(Config.Channel_network, Package)
			
			sleep(Config.Main_timer)
		end

	elseif Device_type == "Item:Vault_storage" then
		local Chest = peripheral.wrap(Config.Vault_side)
		
		while true do
			print("loop")
			local Info = Brave.Get_chest_inventory(Chest, false)
			
			local Items_stored = Info.Count
			local Items_capacity = Info.Max_count
			local First_item_stores = Info.First_item_name
			local Number_of_slots = Info.Size
			local Filled_ratio = Items_stored / Items_capacity
			local Item_name = Info.First_item_name
			local Slot = 1

			local Name_object      = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Item_name, Item_name)
			local Count_object     = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Stack_count, Info.Count)
			local Max_count_object = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Stack_max_count, Info.Max_count)
			local Percent_object   = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_percentage_value, Info.Filled_percentage)
			local Size_object      = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Size, Info.Size)
			local Ratio_object     = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Filled_ratio, Filled_ratio)

			local Package = Brave.Generate_package({Name_object, Count_object, Max_count_object, Percent_object, Size_object, Ratio_object}, Brave.Package_types.Broadcast, {})
			Brave.Modem.Transmit(Config.Channel_network, Package)
		
			sleep(Config.Main_timer)
		end

	elseif Device_type == "Item:Vault_overflow" then
		local Chest = peripheral.wrap(Config.Vault_side)
		local Redstone_level = true
		redstone.setOutput(Config.Overflow_redstone_side, Redstone_level)
		
		while true do
			print("loop")
			local Info = Brave.Get_chest_inventory(Chest, false)
			
			local Items_stored = Info.Count
			local Items_capacity = Info.Max_count
			local First_item_stores = Info.First_item_name
			local Number_of_slots = Info.Size
			local Filled_percentage = Items_stored / Items_capacity
			local Item_name = Info.First_item_name
			local Slot = 1

			if Filled_percentage > Config.Hysteresis_high then
				Redstone_level = false
			end	

			if Filled_percentage < Config.Hysteresis_low then
				Redstone_level = true
			end

			local Name_object      = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Item_name, Item_name)
			local Count_object     = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Stack_count, Info.Count)
			local Max_count_object = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Stack_max_count, Info.Max_count)
			local Percent_object   = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_percentage_value, Info.Filled_percentage)
			local Size_object      = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Size, Info.Size)
			local Output_object    = IPSO.Generate_object(IPSO.Object_list.Redstone, Constants.Block_side.front, IPSO.Resource_list.Set_Output_level, Redstone_level)

			local Package = Brave.Generate_package({Name_object, Count_object, Max_count_object, Percent_object, Size_object, Output_object}, Brave.Package_types.Broadcast, {})
			Brave.Modem.Transmit(Config.Channel_network, Package)
		
			redstone.setOutput(Config.Overflow_redstone_side, Redstone_level)

			sleep(Config.Main_timer)
		end

	elseif Device_type == "Item:Vault_compress" then
		local Chest = peripheral.wrap(Config.Vault_side)
		local Speed_controller = peripheral.wrap(Config.Speedcontroller_side)

		local Speed = 1
		
		while true do
			print("loop")
			local Info = Brave.Get_chest_inventory(Chest, false)
			
			local Items_stored = Info.Count
			local Items_capacity = Info.Max_count
			local First_item_stores = Info.First_item_name
			local Number_of_slots = Info.Size
			local Filled_percentage = Items_stored / Items_capacity
			local Item_name = Info.First_item_name
			local Slot = 1

			Speed = math.floor(255 * Filled_percentage)
			
			Speed_controller.setTargetSpeed(Speed)

			local Name_object      = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Item_name, Item_name)
			local Count_object     = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Stack_count, Info.Count)
			local Max_count_object = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Stack_max_count, Info.Max_count)
			local Percent_object   = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_percentage_value, Info.Filled_percentage)
			local Size_object      = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Size, Info.Size)
			local Speed_object     = IPSO.Generate_object(IPSO.Object_list.Kinetic_speed,   Slot, IPSO.Resource_list.Set_value, Speed)

			local Package = Brave.Generate_package({Name_object, Count_object, Max_count_object, Percent_object, Size_object, Speed_object}, Brave.Package_types.Broadcast, {})
			Brave.Modem.Transmit(Config.Channel_network, Package)

			sleep(Config.Main_timer)
		end

	elseif Device_type == "Item:Storage" then
		local Chest_side = Brave.Find_chest()
		local Chest = peripheral.wrap(Chest_side)

		while true do
			local Info = Brave.Get_chest_inventory(Chest, false)
			local Slot = 1

			local Slot_info = Info.Slot_info[Slot]
			
			local Item_name = Info.First_item_name

			local Name_object      = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Item_name, Item_name)
			local Count_object     = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Stack_count, Info.Count)
			local Max_count_object = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Stack_max_count, Info.Max_count)
			local Percent_object   = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_percentage_value, Info.Filled_percentage)
			local Ratio_object     = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Filled_ratio, Info.Filled_ratio)
			local Size_object      = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Size, Info.Size)

			local Package = Brave.Generate_package({Name_object, Count_object, Max_count_object, Percent_object, Size_object, Ratio_object}, Brave.Package_types.Broadcast, {})
			Brave.Modem.Transmit(Config.Channel_network, Package)
			
			sleep(Config.Main_timer)
		end

	elseif Device_type == "Clock:Season" then
		local Spring_side = "front"
		local Summer_side = "left"
		local Fall_side   = "back"
		local Winter_side = "right"

		while true do
			local Spring_day = redstone.getAnalogInput(Spring_side)
			local Summer_day = redstone.getAnalogInput(Summer_side)
			local Fall_day   = redstone.getAnalogInput(Fall_side)
			local Winter_day = redstone.getAnalogInput(Winter_side)

			local Season = 0
			local Season_day = 0
			local Season_object = {}
			local Season_day_object = {}

			if Spring_day > 0 then
				Season = Constants.Seasons.Spring
				Season_day = (Spring_day + 1) / 2

				Season_object     = IPSO.Generate_object(IPSO.Object_list.Time, 1, IPSO.Resource_list.Set_Season, Season)
				Season_day_object = IPSO.Generate_object(IPSO.Object_list.Time, 1, IPSO.Resource_list.Set_Season_day, Season_day)
			
			elseif Summer_day > 0 then
				Season = Constants.Seasons.Summer
				Season_day = (Summer_day + 1) / 2

				Season_object     = IPSO.Generate_object(IPSO.Object_list.Time, 1, IPSO.Resource_list.Set_Season, Season)
				Season_day_object = IPSO.Generate_object(IPSO.Object_list.Time, 1, IPSO.Resource_list.Set_Season_day, Season_day)
			
			elseif Fall_day > 0 then
				Season = Constants.Seasons.Fall
				Season_day = (Fall_day + 1) / 2

				Season_object     = IPSO.Generate_object(IPSO.Object_list.Time, 1, IPSO.Resource_list.Set_Season, Season)
				Season_day_object = IPSO.Generate_object(IPSO.Object_list.Time, 1, IPSO.Resource_list.Set_Season_day, Season_day)
			
			elseif Winter_day > 0 then
				Season = Constants.Seasons.Winter
				Season_day = (Winter_day + 1) / 2

				Season_object     = IPSO.Generate_object(IPSO.Object_list.Time, 1, IPSO.Resource_list.Set_Season, Season)
				Season_day_object = IPSO.Generate_object(IPSO.Object_list.Time, 1, IPSO.Resource_list.Set_Season_day, Season_day)
			
			else
				Season = Constants.Seasons.Undefined
				Season_day = 0

				Season_object     = IPSO.Generate_object(IPSO.Object_list.Time, 1, IPSO.Resource_list.Set_Season, Season)
				Season_day_object = IPSO.Generate_object(IPSO.Object_list.Time, 1, IPSO.Resource_list.Set_Season_day, Season_day)
			end

			local Package = Brave.Generate_package({Season_object, Season_day_object}, Brave.Package_types.Broadcast, {})
			Brave.Modem.transmit(1,1,Package)

			sleep(Config.Main_timer * 6)
		end

	elseif Device_type == "Fluid:Valve_control" then

		redstone.setOutput(Config.Valve_signal_side, Config.Valve_signal_default)

		while true do
			local Fluid_message = {os.pullEvent("modem_message")}
		
			-- Recieved data is stored in field 5
			Input_message = textutils.unserialize(Fluid_message[5])
			Client_id = Input_message.Device_id

			if Client_id == Config.Listen_for_client then
				Data = Input_message.Data
				Value = IPSO.Retrieve_value(Data, IPSO.Object_list.Volume, 1, IPSO.Resource_list.Set_Filled_ratio)

				if Value ~= "nil" then
					if Value > Config.Hysteresis_high then
						redstone.setOutput(Config.Valve_signal_side, false)
					elseif Value < Config.Hysteresis_low then
						redstone.setOutput(Config.Valve_signal_side, true)
					end
				end

			end
			
		end
	elseif Device_type == "Turtle:Mining" or Device_type == "Turtle:Latex" then
		shell.run("./Turtles.lua")
	end
end

main()

if Pc_label == "arch:monitor_0" then
	Tab = multishell.launch({}, "Monitor.lua", {"true"})

	multishell.setTitle(Tab, "Home")
	multishell.setTitle(Console_tab, "Con")
	multishell.setFocus(Tab)
end