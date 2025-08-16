---Base implementation of default turtle API functions.
Turtle = {
    ---@type number
    ---Total number of slots available in a turtles inventory.
    Inventory_size = 16,

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
        function(Slot)
            if Slot > Inventory_size then
                return false, "Slot out of range"
            end

            local Result = turtle.select(Slot)

            return Result, ""
        end
    ),

    Get_item_count = (
        function(Slot)
            if Slot > Inventory_size then
                return false, "Slot out of range"
            end
            local Result = turtle.getItemCount(Slot)

            return Result, ""
        end
    ),

    Get_item_space = (
        function(Slot)
            if Slot > Inventory_size then
                return false, "Slot out of range"
            end
            local Result = turtle.getItemSpace(Slot)

            return Result, ""
        end
    ),

    Detect = (
        function()
            local Result = turtle.detect()

            return Result
        end
    ),

    Detect_up = (
        function()
            local Result = turtle.detectUp()

            return Result
        end
    ),

    Detect_down = (
        function()
            local Result = turtle.detectDown()

            return Result
        end
    )
}