os.loadAPI("Config.lua")

---Try to refuel fron the fuel slot. This slot is let
---in the config file
---@return boolean Succes true if succesfull
function Refuel()
    local Current_slot = turtle.getSelectedSlot()

    turtle.select(Config.Fuel_slot)
    local Succes = turtle.refuel(1)
    turtle.select(Current_slot)

    return Succes
end

---Refuel until a target level is reached. 
---@param Target_level number Level to refuel upto
---@return boolean Succes true if succesfull
---@return integer Count Number of consumed items to reach target
function Refuel_upto(Target_level)
    local Count = 0
    while turtle.getFuelLevel() <= Target_level do
        if Refuel() == false then
            return false, Count
        end

        Count = Count + 1
    end

    return true, Count
end

---Returns true is current slot contains a fuel item
---@return Boolean
function Is_fuel()
    return turtle.refuel(0)
end

---Return name of item in current slot.
---returns "no item" if slot is empty
---@return string
function Get_item_name()
    local Name = "no item"
    local Item_detail = turtle.getItemDetail()

    if Item_detail ~= nil then
        Name = Item_detail.name
    end

    return Name
end

---Try to move the turtle forward by one block.
---Turtle will try to mine or attack if required
---@return boolean Succes true if succesfull
function Forward()
    local Try = 0
    local Attempt = 0

    for Try = 1, 3, 1 do
        for Attempt = 1, 3, 1 do
            if turtle.forward() == true then
                return true
            end

            turtle.dig()
        end

        Attack()
    end

    return false
end

---Move the turtle forward by a number of blocks
---@param Distance number Number of blocks to travel
---@return boolean Succes true if succesfull
---@return integer Traveled Distance traveled
function Move_forward(Distance)
    local Traveled = 0
    if Distance == nil then Distance = 1 end

    for Traveled = 1, Distance, 1 do
        if Forward() == false then
            return false, Traveled
        end
    end

    return true, Traveled
end

---Try to move the turtle up by one block.
---Turtle will try to mine or attack if required
---@return boolean Succes true if succesfull
function Up()
    local Try = 0
    local Attempt = 0
    
    for Try = 1, 3, 1 do
        for  Attempt = 1, 3, 1 do
            if turtle.up() == true then
                return true
            end

            turtle.digUp()
            
        end

        Attack_up()
    end

    return false
end

---Move the turtle up by a number of blocks
---@param Distance number Number of blocks to travel
---@return boolean Succes true if succesfull
---@return integer Traveled Distance traveled
function Move_up(Distance)
    local Traveled = 0
    if Distance == nil then Distance = 1 end

    for Traveled = 1, Distance, 1 do
        if Up() == false then
            return Traveled
        end
    end

    return Traveled
end

---Try to move the turtle down by one block.
---Turtle will try to mine or attack if required
---@return boolean Succes true if succesfull
function Down()
    local Try = 0
    local Attempt = 0
    
    for Try = 1, 3, 1 do
        for Attempt = 1, 3, 1 do
            if turtle.Down() == true then
                return true
            end

            turtle.digDown()
            
        end

        Attack_Down()
    end

    return false
end

---Move the turtle down by a number of blocks
---@param Distance number Number of blocks to travel
---@return boolean Succes true if succesfull
---@return integer Traveled Distance traveled
function Move_down(Distance)
    local Traveled = 0
    if Distance == nil then Distance = 1 end

    for Traveled = 1, Distance, 1 do
        if Down() == false then
            return Traveled
        end
    end

    return Traveled
end

function Attack()
    return turtle.attack()
end

function Attack_up()
    return turtle.attackUp()
end

function Attack_down()
    return turtle.attackDown()
end