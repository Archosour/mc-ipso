local Console_tab = multishell.getCurrent()
local Tab = 0

multishell.setTitle(Tab, "Home")
multishell.setTitle(Console_tab, "Con")
multishell.setFocus(Tab)

os.loadAPI("Brave.lua")
os.loadAPI("IPSO.lua")

local Console_tab = multishell.getCurrent()
local Pc_label = os.getComputerLabel()

if pocket then
	Tab = multishell.launch({}, "pocket.lua", {"true"})
	
	multishell.setTitle(Tab, "Home")
	multishell.setTitle(Console_tab, "Con")
	multishell.setFocus(Tab)

else
	Brave.Modem.open(1)

	Tab = multishell.launch({}, "run_ipso.lua", {"false"})
	multishell.setTitle(Tab, "Ipso")

	if Pc_label == "arch:Small_boiler" or Pc_label == "arch:Boiler_sup_1" then
		local Interface = peripheral.wrap("bottom")

		while true do
			local RPM = math.abs(Interface.getKineticSpeed("bottom"))
			local Direction = true
			local Stress = Interface.getKineticStress("right")
			local Capacity = Interface.getKineticCapacity("right")

			if RPM < 0 then Direction = false end

			local RPM_object 	   = IPSO.Generate_object(IPSO.Object_list.Kinetic_speed, 	  0, IPSO.Resource_list.Set_value, RPM)
			local Direction_object = IPSO.Generate_object(IPSO.Object_list.Kinetic_direction, 0, IPSO.Resource_list.Set_value, Direction)
			local Stress_object    = IPSO.Generate_object(IPSO.Object_list.Kinetic_stress,    0, IPSO.Resource_list.Set_value, Stress)
			local Capacity_object  = IPSO.Generate_object(IPSO.Object_list.Kinetic_capacity,  0, IPSO.Resource_list.Set_value, Capacity)
			local Package = Brave.Generate_package({RPM_object, Direction_object,Stress_object,Capacity_object}, Brave.Package_types.Broadcast, {})

			--Brave.Log(textutils.serialise(Package), true)
			Brave.Modem.transmit(1,1,Package)

			sleep(10)
		end
	end
end

