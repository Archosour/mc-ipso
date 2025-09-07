---@type number
---Total number of slots available in a turtles inventory.
Turtle_inventory_size = 16

---Base implementation of default turtle API functions.
Turtle = {
    
    Forward = (
    ---Move the turtle forward one block.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function()
            local Result, Status = turtle.forward()

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end 
    ),

    Back = (
    ---Move the turtle backwards one block.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function()
            local Result, Status = turtle.back()

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ), 

    Up = (
    ---Move the turtle up one block.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function()
            local Result, Status = turtle.up()

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Down = (
    ---Move the turtle down one block.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function()
            local Result, Status = turtle.down()

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Turn_left = (
    ---Rotate the turtle 90 degrees to the left.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function()
            local Result, Status = turtle.turnLeft()

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Turn_right = (
    ---Rotate the turtle 90 degrees to the right.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status  
        function()
            local Result, Status = turtle.turnLeft()

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Dig = (
    ---Attempt to break the block in front of the turtle.
    ---This requires a turtle tool capable of breaking the block. 
    ---Diamond pickaxes (mining turtles) can break any vanilla block, 
    ---but other tools (such as axes) are more limited.
    ---@param Side string Optional to which specific tool to use. Should be "left" or "right".
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function(Side)
            if Side ~= "left" and Side ~= "right" and Side ~= nil then
                return false, "Invalid side input"
            end

            local Result, Status = turtle.dig(Side)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Dig_up = (
    ---Attempt to break the block above the turtle.
    ---This requires a turtle tool capable of breaking the block. 
    ---Diamond pickaxes (mining turtles) can break any vanilla block, 
    ---but other tools (such as axes) are more limited.
    ---@param Side string Optional to which specific tool to use. Should be "left" or "right".
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function(Side)
            if Side ~= "left" and Side ~= "right" and Side ~= nil then
                return false, "Invalid side input"
            end

            local Result, Status = turtle.digUp(Side)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Dig_down = (
    ---Attempt to break the block below the turtle.
    ---This requires a turtle tool capable of breaking the block. 
    ---Diamond pickaxes (mining turtles) can break any vanilla block, 
    ---but other tools (such as axes) are more limited.
    ---@param Side string Optional to which specific tool to use. Should be "left" or "right".
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function(Side)
            if Side ~= "left" and Side ~= "right" and Side ~= nil then
                return false, "Invalid side input"
            end

            local Result, Status = turtle.dig(Side)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Place = (
    ---Place a block or item into the world in front of the turtle.
    ---"Placing" an item allows it to interact with blocks and entities in front of the turtle. 
    ---For instance, buckets can pick up and place down fluids, and wheat can be used to breed cows. 
    ---However, you cannot use place to perform arbitrary block interactions, such as clicking buttons or flipping levers.
    ---@param Text string When placing a sign, set its contents to this text.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function(Text)
            local Result, Status = turtle.place(Text)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Place_up = (
    ---Place a block or item into the world above the turtle.
    ---"Placing" an item allows it to interact with blocks and entities above the turtle. 
    ---For instance, buckets can pick up and place down fluids, and wheat can be used to breed cows. 
    ---However, you cannot use place to perform arbitrary block interactions, such as clicking buttons or flipping levers.
    ---@param Text string When placing a sign, set its contents to this text.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function(Text)
            local Result, Status = turtle.placeUp(Text)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Place_down = (
    ---Place a block or item into the world below the turtle.
    ---"Placing" an item allows it to interact with blocks and entities below the turtle. 
    ---For instance, buckets can pick up and place down fluids, and wheat can be used to breed cows. 
    ---However, you cannot use place to perform arbitrary block interactions, such as clicking buttons or flipping levers.
    ---@param Text string When placing a sign, set its contents to this text.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function(Text)
            local Result, Status = turtle.placeDown(Text)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Drop = (
    ---Drop the currently selected stack into the inventory in front of the turtle, 
    ---or as an item into the world if there is no inventory.
    ---@param Count number The number of items to drop. If not given, the entire stack will be dropped.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function(Count)
            local Result, Status = turtl.drop(Count)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Drop_up = (
    ---Drop the currently selected stack into the inventory above of the turtle, 
    ---or as an item into the world if there is no inventory.
    ---@param Count number The number of items to drop. If not given, the entire stack will be dropped.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function(Count)
            local Result, Status = turtle.dropUp(Count)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Drop_down = (
    ---Drop the currently selected stack into the inventory in below of the turtle, 
    ---or as an item into the world if there is no inventory.
    ---@param Count number The number of items to drop. If not given, the entire stack will be dropped.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function(Count)
            local Result, Status = turtle.dropDown(Count)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Select = (
    ---Change the currently selected slot.
    ---The selected slot is determines what slot actions like drop or getItemCount act on.
    ---@param Slot number The slot to select.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function(Slot)
            if Slot > Turtle_inventory_size then
                return false, "Slot out of range"
            end

            local Result = turtle.select(Slot)

            return Result, ""
        end
    ),

    Get_item_count = (
    ---Get the number of items in the given slot.
    ---@param Slot number The slot we wish to check. Defaults to the selected slot.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function(Slot)
            if Slot > Turtle_inventory_size then
                return false, "Slot out of range"
            end
            local Result = turtle.getItemCount(Slot)

            return Result, ""
        end
    ),

    Get_item_space = (
    ---Get the remaining number of items which may be stored in this stack.
    ---@param Slot number The slot we wish to check. Defaults to the selected slot.
    ---@return boolean #true if successfull
    ---@return boolean #false if unsuccessfull
    ---@return string #status 
        function(Slot)
            if Slot > Turtle_inventory_size then
                return false, "Slot out of range"
            end
            local Result = turtle.getItemSpace(Slot)

            return Result, ""
        end
    ),

    Detect = (
    ---Check if there is a solid block in front of the turtle. In this case, solid refers to any non-air or liquid block.
    ---@return boolean #true if solid block
    ---@return boolean #false if non solid or air
        function()
            local Result = turtle.detect()

            return Result
        end
    ),

    Detect_up = (
    ---Check if there is a solid block above the turtle. In this case, solid refers to any non-air or liquid block.
    ---@return boolean #true if solid block
    ---@return boolean #false if non solid or air
        function()
            local Result = turtle.detectUp()

            return Result
        end
    ),

    Detect_down = (
    ---Check if there is a solid block below the turtle. In this case, solid refers to any non-air or liquid block.
    ---@return boolean #true if solid block
    ---@return boolean #false if non solid or air
        function()
            local Result = turtle.detectDown()

            return Result
        end
    ),

    Compare = (
    ---Check if the block in front of the turtle is equal to the item in the currently selected slot.
    ---@return boolean #true if equal
    ---@return boolean #false if not equal
        function()
            local Result = turtle.compare()

            return Result
        end
    ),

    Compare_up = (
    ---Check if the block above the turtle is equal to the item in the currently selected slot.
    ---@return boolean #true if equal
    ---@return boolean #false if not equal
        function()
            local Result = turtle.compareUp()

            return Result
        end
    ),

    Compare_down = (
    ---Check if the block below the turtle is equal to the item in the currently selected slot.
    ---@return boolean #true if equal
    ---@return boolean #false if not equal
        function()
            local Result = turtle.compareDown()

            return Result
        end
    ),

    Attack = (
        function(Side)
            local Result, Status = turtle.attack(Side)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Attack_up = (
        function(Side)
            local Result, Status = turtle.attackUp(Side)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Attack_down = (
        function(Side)
            local Result, Status = turtle.attackDown(Side)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Suck = (
        function(Count)
            local Result, Status = turtle.suck(Count)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Suck_up = (
        function(Count)
            local Result, Status = turtle.suckUp(Count)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Suck_down = (
        function(Count)
            local Result, Status = turtle.suckDown(Count)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    ---Get the amount of fuel this turtle currently holds.
    ---@return number #Current fuel slot.
    ---@return boolean #Fuel is required by config.
    Get_fuel_level = (
        function()
            local Result = turtle.getFuelLevel()

            if type(Result) == "string" then
                return 999999, false
            end

            return Result, true
        end
    ),

    Refuel = (
        function(Count)
            local Result, Status = turtle.refuel(Count)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Compare_to = (
        function(Slot)
            local Result, Status = turtle.compareTo(Slot)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Transfer_to = (
        function(Slot, Count)
            local Result, Status = turtle.transferTo(Slot, Count)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Get_selected_slot = (
        function()
            local Result = turtle.getSelectedSlot()

            return Result
        end
    ),

    Equip_left = (
        function()
            local Result, Status = turtle.equipLeft()

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Equip_right = (
        function()
            local Result, Status = turtle.equipRight()

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    ),

    Get_equiped_left = (
        function()
            local Result = turtle.getEquipedLeft()

            if type(Result) == "table" then
                return true, Result
            end

            return false, nil
        end
    ),

    Get_equiped_right = (
        function()
            local Result = turtle.getEquipedRight()

            if type(Result) == "table" then
                return true, Result
            end

            return false, nil
        end
    ),

    Inspect = (
        function()
            local Result, Data = turtle.inspect()

            if Result == true then
                return Result, Data, ""
            end

            return Result, nil, Data
        end
    ),

    Inspect_up = (
        function()
            local Result, Data = turtle.inspectUp()

            if Result == true then
                return Result, Data, ""
            end

            return Result, nil, Data
        end
    ),

    Inspect_down = (
        function()
            local Result, Data = turtle.inspectDown()

            if Result == true then
                return Result, Data, ""
            end

            return Result, nil, Data
        end
    ),

    Get_item_detail = (
        function(Slot, Detailed)
            local Result, Data = turtle.getItemDetail(Slot, Detailed)

            if Result == true then
                return Result, Data, ""
            end

            return Result, nil, Data
        end
    ),
}