local Console_tab = multishell.getCurrent()
local Tab = 0

multishell.setTitle(Tab, "Home")
multishell.setTitle(Console_tab, "Con")
multishell.setFocus(Tab)

os.loadAPI("Brave.lua")
os.loadAPI("IPSO.lua")

local Console_tab = multishell.getCurrent()
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
	Tab = multishell.launch({}, "pocket.lua", {"true"})
	
	multishell.setTitle(Tab, "Home")
	multishell.setTitle(Console_tab, "Con")
	multishell.setFocus(Tab)

else
	Brave.Modem.open(1)

	Tab = multishell.launch({}, "run_ipso.lua", {"false"})
	multishell.setTitle(Tab, "Ipso")

	if Pc_label == "arch:Small_boiler" or Pc_label == "arch:Boiler_sup_1" or Pc_label == "arch:Boiler_prod1" then
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

	elseif Pc_label == "arch:fluid_tank_1" then
		while true do
			local Max_value = 15
			local Input_lava  = redstone.getAnalogInput("left")
			local Value_lava  = tostring(math.floor((Input_lava / Max_value) * 100)) .. "%"
			local Input_water = redstone.getAnalogInput("right")
			local Value_water = tostring(math.floor((Input_water / Max_value) * 100)) .. "%"
		
			local Water_object = IPSO.Generate_object(IPSO.Object_list.Volume, Constants.Fluid_type.water, IPSO.Resource_list.Set_percentage_value, Value_water)
			local Lava_object  = IPSO.Generate_object(IPSO.Object_list.Volume, Constants.Fluid_type.lava,  IPSO.Resource_list.Set_percentage_value, Value_lava)
		
			local Package = Brave.Generate_package({Water_object, Lava_object}, Brave.Package_types.Broadcast, {})
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
		Tab = multishell.launch({}, "monitor.lua", {"true"})
	
		multishell.setTitle(Tab, "Home")
		multishell.setTitle(Console_tab, "Con")
		multishell.setFocus(Tab)
	end
	
end