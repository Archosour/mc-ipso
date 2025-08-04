---Base implementation of default turtle API functions.
Turtle = {

    Forward = (
    ---Move the turtle forward one block.
    ---@return boolean true if successfull
    ---@return boolean false if unsuccessfull
    ---@return string status 
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
    ---@return boolean true if successfull
    ---@return boolean false if unsuccessfull
    ---@return string status 
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
    ---@return boolean true if successfull
    ---@return boolean false if unsuccessfull
    ---@return string status 
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
    ---@return boolean true if successfull
    ---@return boolean false if unsuccessfull
    ---@return string status 
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
    ---@return boolean true if successfull
    ---@return boolean false if unsuccessfull
    ---@return string status 
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
    ---@return boolean true if successfull
    ---@return boolean false if unsuccessfull
    ---@return string status 
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
    ---@return boolean true if successfull
    ---@return boolean false if unsuccessfull
    ---@return string status 
        function(Side)
            if Side != "left" && Side != "right" && Side != nil then
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
    ---@return boolean true if successfull
    ---@return boolean false if unsuccessfull
    ---@return string status 
        function(Side)
            if Side != "left" && Side != "right" && Side != nil then
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
    ---@return boolean true if successfull
    ---@return boolean false if unsuccessfull
    ---@return string status 
        function(Side)
            if Side != "left" && Side != "right" && Side != nil then
                return false, "Invalid side input"
            end

            local Result, Status = turtle.dig(Side)

            if Result == true then
                return true, ""
            else
                return false, Status
            end
        end
    )
}