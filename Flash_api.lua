---Path to flash storage space (directory)
Path_to_flash = "Flash"

---Update the value in flash (file located in the flash directory).
---@param File_name string
---@param Value any
---@param Reset boolean
---@param Value_type_input string Defaults to "number"
function Update(File_name, Value, Reset, Value_type_input) 
	local Value_type = "nil"

	if Value_type == nil then Value_type = "number" end

	if (Reset == true) then
		Set(File_name, Value)
		return
	end
	
	local Current_value = Get(File_name)

	if Value_type == "number" then 
		local New_value = tonumber(Current_value) + tonumber(Value)
		Set(File_name, New_value)
	else
		print("Value type unknown: " .. Value_type)
	end

end

---Set a value in flash (file located in the flash directory). 
---Does replace the content previously stored.
---@param File_name string
---@param Value any
function Set(File_name, Value)
	if File_name == nil then
		print("Filename in Flash set was nil")
		return
	end

	local File_path = Path_to_flash .. "/" .. File_name

	local File = fs.open(File_path, "w")
	File.write(Value)

	File.close()
end

---Get a value from flash (file located in the flash folder).
---@param File_name string
---@return any
function Get(File_name)
	if File_name == nil then
		print("Filename in Flash get was nil, return 0")
		return 0
	end

	local File_path = Path_to_flash .. "/" .. File_name

	print("FilePath: " .. File_path)

	if fs.exists(File_path) == false then
		return 0
	end

	local File = fs.open(File_path, "r")
	local Value = File.readLine()

	File.close()

	if Value == nil then return 0 end
	return Value
end