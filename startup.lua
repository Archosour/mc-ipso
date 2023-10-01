local Console_tab = multishell.getCurrent()
local Tab = 0

os.loadAPI("Brave.lua")
os.loadAPI("IPSO.lua")

local Pc_label = os.getComputerLabel()

function Run_kinetic_info(Peripheral_side, Speed_side, Stress_side)
	local Interface = peripheral.wrap(Peripheral_side)

	local RPM = math.abs(Interface.getKineticSpeed(Speed_side))
	local Direction = true
	local Stress = Interface.getKineticStress(Stress_side)
	local Capacity = Interface.getKineticCapacity(Stress_side)

	if RPM < 0 then Direction = false end

	local RPM_object 	   = IPSO.Generate_object(IPSO.Object_list.Kinetic_speed, 	  0, IPSO.Resource_list.Set_value, RPM)
	local Direction_object = IPSO.Generate_object(IPSO.Object_list.Kinetic_direction, 0, IPSO.Resource_list.Set_value, Direction)
	local Stress_object    = IPSO.Generate_object(IPSO.Object_list.Kinetic_stress,    0, IPSO.Resource_list.Set_value, Stress)
	local Capacity_object  = IPSO.Generate_object(IPSO.Object_list.Kinetic_capacity,  0, IPSO.Resource_list.Set_value, Capacity)

	local Package = Brave.Generate_package({RPM_object, Direction_object,Stress_object,Capacity_object}, Brave.Package_types.Broadcast, {})
	--Brave.Log(textutils.serialise(Package), true)
	Brave.Modem.transmit(1,1,Package)

end

if pocket then
	Tab = multishell.launch({}, "Pocket.lua", {"true"})
	
	multishell.setTitle(Tab, "Home")
	multishell.setTitle(Console_tab, "Con")
	multishell.setFocus(Tab)

else
	Brave.Modem.open(1)

	Tab = multishell.launch({}, "Run_ipso.lua", {"false"})
	multishell.setTitle(Tab, "Ipso")

	if Pc_label == "arch:Small_boiler" or Pc_label == "arch:Boiler_sup_1" or Pc_label == "arch:Boiler_prod1" or Pc_label == "arch:ore_processing" then
		local Update_timer = os.startTimer(1)
		local Last_timer = 0
		local Count = 0
		local Last_slow_timer = 0

		while true do
			local Input = {os.pullEvent()}

			if Input[1] == "timer" then
				Count = Count + 1
				Update_timer = os.startTimer(1)

				if (Count - Last_slow_timer) >= 10 then
					print("slow timer: " .. Count .. ":" .. Last_slow_timer)
					Last_slow_timer = Count
					Run_kinetic_info("bottom", "bottom", "right")
				end
				
				local Interface = peripheral.wrap("bottom")
				if math.abs(Interface.getKineticSpeed("bottom")) == 0 then
					print("Kinetic system locked up")
					Run_kinetic_info("bottom", "bottom", "right")
				end
			end
		end

	elseif Pc_label == "arch:boiler_1_fuel" then
		while true do
			local Max_value = 15
			local Input_lava  = redstone.getAnalogInput("left")
			local Value_lava  = tostring(math.floor((Input_lava / Max_value) * 100)) .. "%"

			local Lava_object = IPSO.Generate_object(IPSO.Object_list.Volume, Constants.Fluid_type.lava,  IPSO.Resource_list.Set_percentage_value, Value_lava)
		
			local Package = Brave.Generate_package({Lava_object}, Brave.Package_types.Broadcast, {})
			Brave.Log(textutils.serialise(Package), true)
			Brave.Modem.transmit(1,1,Package)

			sleep(10)
		end
	
	elseif Pc_label == "arch:boiler_1_cool" then
		while true do
			local Max_value = 15
			local Input_water = redstone.getAnalogInput("left")
			local Value_water = tostring(math.floor((Input_water / Max_value) * 100)) .. "%"
		
			local Water_object = IPSO.Generate_object(IPSO.Object_list.Volume, Constants.Fluid_type.water, IPSO.Resource_list.Set_percentage_value, Value_water)
		
			local Package = Brave.Generate_package({Water_object}, Brave.Package_types.Broadcast, {})
			Brave.Log(textutils.serialise(Package), true)
			Brave.Modem.transmit(1,1,Package)

			sleep(10)
		end

	elseif Pc_label == "arch:spare_tank" then
		while true do
			local Max_value = 15
			local Input_water = redstone.getAnalogInput("left")
			local Value_water = tostring(math.floor((Input_water / Max_value) * 100)) .. "%"
		
			local EXP_object = IPSO.Generate_object(IPSO.Object_list.Volume, Constants.Fluid_type.EXP, IPSO.Resource_list.Set_percentage_value, Value_water)
		
			local Package = Brave.Generate_package({EXP_object}, Brave.Package_types.Broadcast, {})
			Brave.Log(textutils.serialise(Package), true)
			Brave.Modem.transmit(1,1,Package)

			sleep(10)
		end

	elseif Pc_label == "arch:obsidian_tank" or Pc_label == "arch:netherrack_tank" then
		while true do
			local Max_value = 15
			local Input_water = redstone.getAnalogInput("left")
			local Value_water = tostring(math.floor((Input_water / Max_value) * 100)) .. "%"
		
			local Lava_object = IPSO.Generate_object(IPSO.Object_list.Volume, Constants.Fluid_type.lava, IPSO.Resource_list.Set_percentage_value, Value_water)
		
			local Package = Brave.Generate_package({Lava_object}, Brave.Package_types.Broadcast, {})
			Brave.Log(textutils.serialise(Package), true)
			Brave.Modem.transmit(1,1,Package)

			sleep(10)
		end

	elseif Pc_label == "yk2" or Pc_label == "yk3" or Pc_label == "yk4" then
		while true do
			local Input = {os.pullEvent("redstone")}
			local object2 = IPSO.Generate_object(IPSO.Object_list.Redstone, Constants.Block_side.right, IPSO.Resource_list.Set_Toggle_output_level, 0)
			local object3 = IPSO.Generate_object(IPSO.Object_list.Device,0, IPSO.Resource_list.Set_sleep, 5.5)
			local Package = Brave.Generate_package({object2, object3}, Brave.Package_types.Targeted, {7})
			Brave.Log(textutils.serialise(Package), true)
			Brave.Modem.transmit(1,1,Package)
			sleep(3)
		end

	elseif Pc_label == "arch:monitor_0" then
		Tab = multishell.launch({}, "Monitor.lua", {"true"})
	
		multishell.setTitle(Tab, "Home")
		multishell.setTitle(Console_tab, "Con")
		multishell.setFocus(Tab)

	elseif Pc_label == "arch:test-2" or Pc_label == "arch:boiler_1_solid" or Pc_label == "arch:boiler_1_sugar" then
		local Chest_side = Brave.Find_chest()
		local Chest = peripheral.wrap(Chest_side)
		while true do
			local Info = Brave.Get_chest_inventory(Chest, false)
			local Slot = 1

			Brave.Log(textutils.serialize(Info), true)
			local Slot_info = Info.Slot_info[Slot]
			
			--if Slot_info ~= nil then
				local Item_name = Info.First_item_name

				local Name_object      = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Item_name, Item_name)
				local Count_object     = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Stack_count, Info.Count)
				local Max_count_object = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Stack_max_count, Info.Max_count)
				local Percent_object   = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_percentage_value, Info.Filled_percentage)
				local Size_object      = IPSO.Generate_object(IPSO.Object_list.Inventory_chest, Slot, IPSO.Resource_list.Set_Size, Info.Size)

				local Package = Brave.Generate_package({Name_object, Count_object, Max_count_object, Percent_object, Size_object}, Brave.Package_types.Broadcast, {})
				Brave.Log(textutils.serialise(Package), true)
				Brave.Modem.transmit(1,1,Package)
			--end
			
			sleep(10)
		end
	end
	
end