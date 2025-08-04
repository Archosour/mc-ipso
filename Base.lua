---Base implementation of default turtle API functions.
Turtle = {

    Forward = (
    ---Turtle moves forward
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
    ---Turtle moves backwards
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
    )
}

Turtle.Forward()