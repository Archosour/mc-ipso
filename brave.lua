os.loadAPI("Constants.lua")

-- find the modem on any of the sides. input info needs to be boolean. 
-- will return side and bool if its wireless or not.
function Find_modem()
	local sides = Constants.Block_sides
	local n = 0
	for n = 1, #sides, 1 do
		if peripheral.getType(sides[n]) == "modem" then
			modem = peripheral.wrap(sides[n])
			if modem.isWireless() == true then
				return sides[n]
			end
			return nil
		end
	end
	return 
end

-- returns type of device, think of normal/advanced and turtle/computer/pocket as well.
function Get_device_type()
	if term.isColor() then
		if turtle then
			return "advTurtle"
		end
		if pocket then
			return "advPocket"
		end
		return "advComputer"
	end
	if not term.isColor() then
		if turtle then
			return "advTurtle"
		end
		if pocket then
			return "advPocket"
		end
		return "advComputer"
	end
end

-- protocol for transmitting data from one pc/turtle/pocket to another machine
function Generate_package(info, package_type, targets)
	local package = {}

	package["Version"] = 2 					    	-- protocal version
	package["Package_type"] = package_type
	package["Targets"] = targets
	package["Server_day"] = os.day() 				-- ingame day	
	package["Server_time"] = os.time() 				-- ingame time	
	package["Device_id"] = os.getComputerID() 		-- computer ID
	package["Device_type"] = Get_device_type()		-- deviceType
	package["Device_name"] = os.getComputerLabel()  -- machineType	
	package["Location_x"] = 0 						-- x-coordinate from GPS
	package["Location_y"] = 0 						-- y-coordinate from GPS
	package["Location_z"] = 0 						-- z-coordiante from GPS
	package["Data"] = info 							-- data

	-- importing given info into the message to send
	-- given info must be in a table
	return textutils.serialize(package)
end

Package_types = {
	["Broadcast"] = "Broadcast",
	["Targeted"]  = "Targeted"
}

function Log(Value, To_file)
	if type(Value) ~= "string" and type(Value) ~= "number" then return false end
	if To_file == nil then To_file = false end

	term.clear()
	term.setCursorPos(1,1)
	term.write("---- Error ----")
	term.setCursorPos(1,2)
	term.write(Value)

	if To_file ~= true then return true end
	
	local Time = os.time()
	local Day = os.day()
	local File = fs.open(Constants.Log_file_path,"a")
	local Log_string = Day .. ":" .. Time .. ":" .. Value
	File.writeLine(Log_string)
	File.close()

	return true
end

function Log_clear() 
	local File = fs.open(Constants.Log_file_path,"w")
	File.flush()
	File.close()
end

-- Setup --
Modem_side = Find_modem()
Modem = ""

if (Modem_side ~= nil) then
	Modem = peripheral.wrap(Modem_side)
else 
	term.blit("no modem found", "black", "red")
end

-- End of setup --