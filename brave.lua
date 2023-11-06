os.loadAPI("Constants.lua")
os.loadAPI("Config.lua")

-- Can be used to overrule input for logging to a log file.
-- Due to the large number of posible logs it is not reasonable
-- to disable all of them at time of release.
-- When set to nil there is no overrule, function input will 
-- be used as normal. Log files take up a lot of space.
-- If set to true, then all log action will be written to log file
-- if set to false, then nothing will be written to log file.
local Overrule_log_to_file = false

local Device_type = ""

-- find the modem on any of the sides.
-- will return side if its wireless.
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

-- find the monitor on any of the sides.
-- will return side if its of type Color.
function Find_monitor()
	local sides = Constants.Block_sides
	local n = 0
	for n = 1, #sides, 1 do
		if peripheral.getType(sides[n]) == "monitor" then
			modem = peripheral.wrap(sides[n])
			if modem.isColor() == true then
				return sides[n]
			end
			return nil
		end
	end
	return 
end

-- find the chest on any of the sides.
-- will return side if its found.
function Find_chest()
	local sides = Constants.Block_sides
	local n = 0
	for n = 1, #sides, 1 do
		if peripheral.getType(sides[n]) == "quark:variant_chest" then
			return sides[n]
		end
	end
	return 
end

function Get_chest_inventory(Peripheral, Only_first_item)
	local Size = Peripheral.size()
	local Slot = 0
	local Total = 0
	local Max = 0
	local First_found = false
	local Info = {
		["Size"] = Size,
		["Max_count"] = 0,
		["Count"] = 0,
		["Slot_info"] = {},
		["Filled_percentage"] = "",
		["Filled_ratio"] = 0,
		["First_item_name"] = ""
	}

	for Slot = 1, Size, 1 do
		local Slot_detail = Peripheral.getItemDetail(Slot)
		if Slot_detail ~= nil then

			if First_found == false and Slot_detail.displayName ~= nil then
				Info.First_item_name = Slot_detail.displayName
				First_found = true
			end

			Info.Slot_info[Slot]   = Slot_detail
			Info.Max_count 		   = Info.Max_count + Slot_detail.maxCount
			Info.Count 	   		   = Info.Count     + Slot_detail.count
		else 
			Info.Max_count 	   	   = Info.Max_count + 64 --max stack size for most items is 64
		end

		local Filled_ratio = Info.Count / Info.Max_count
		Info.Filled_percentage = tostring(math.floor(Filled_ratio * 100)) .. "%"
		Info.Filled_ratio = Filled_ratio

		if Only_first_item == true and Slot == 1 then
			return Info
		end
	end

	return Info
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

	package["Version"] = 3 					    	-- protocol version
	package["Package_type"] = package_type			-- Broadcast, targeted as examples
	package["Targets"] = targets					-- table with target IDs
	package["Server_day"] = os.day() 				-- ingame day
	package["Server_time"] = os.time() 				-- ingame time
	package["Device_id"] = os.getComputerID() 		-- computer ID
	package["Device_type"] = Device_type			-- Device type / function
	package["Device_name"] = os.getComputerLabel()  -- machineType
	package["Hardware_type"] = Get_device_type()	-- HardwareType pocket, turtle, pc, advanced
	package["Location_x"] = 0 						-- x-coordinate from GPS
	package["Location_y"] = 0 						-- y-coordinate from GPS
	package["Location_z"] = 0 						-- z-coordiante from GPS
	package["Data"] = info 							-- data, as table of smart objects

	-- importing given info into the message to send
	-- given info must be in a table
	return textutils.serialize(package)
end

Package_types = {
	["Broadcast"] = "Broadcast",
	["Targeted"]  = "Targeted"
}

function Log(Value, To_file, To_screen)
	if type(Value) ~= "string" and type(Value) ~= "number" then Value = "Brave: Invalid Value recieved!" end
	if To_file == nil then To_file = true end
	if To_screen == nil then To_screen = false end

	if Overrule_log_to_file ~= nil then To_file = Overrule_log_to_file end

	if To_screen == true then
		term.clear()
		term.setCursorPos(1,1)
		term.write("---- Error ----")
		term.setCursorPos(1,2)
		term.write(Value)
	end
	
	if To_file == true then
		local Time = os.time()
		local Day = os.day()
		local File = fs.open(Constants.Log_file_path,"a")
		local Log_string = Day .. ":" .. Time .. ":" .. Value
		File.writeLine(Log_string)
		File.close()
	end

	return true
end

function Log_clear() 
	local File = fs.open(Constants.Log_file_path,"w")
	File.flush()
	File.close()
end

function Round_decimal(Value, Positions)
	if Positions == nil or tonumber(Positions) == 1 then
		return string.format("%2.1f", Value)
	end

	return 0
end

function Get_percentage(Input1, Input2)
	if Input1 == nil then return "nil%" end
	if Input2 == nil then return "nil%" end

	local Percent = math.floor((Input1 / Input2) * 100)
	return tostring(Percent) .. "%"
end

function Get_table_length(Table)
	local Count = 0
	if Table == nil then 
		Log("table was nil", true, false)
		return 0 
	end
	if type(Table) ~= "table" then 
		Log("table type was not table", true, false)
		return 0 
	end

	for i,j in pairs(Table) do
		Count = Count + 1
	end

	return Count
end

-- Setup --
Modem_side = Find_modem()
Modem = ""

if (Modem_side ~= nil) then
	Modem = peripheral.wrap(Modem_side)
else 
	term.blit("no modem found", "black", "red")
end

if Config.Device_type ~= nil then
	Device_type = Config.Device_type
else 
	Device_type = "Undefined"
end

function Modem.Transmit(Channel, Message)
	Modem.transmit(Channel, Channel, Message)
end

-- End of setup --