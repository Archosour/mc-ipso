os.loadAPI("Config.lua")

---Try to refuel fron the fuel slot. This slot is let
---in the config file
---@return boolean Succes true if succesfull
function Refuel()
    local Current_slot = turtle.getSelectedSlot()

    print("pre refuel" .. turtle.getFuelLevel())

    turtle.select(Config.Fuel_slot)
    local Succes = turtle.refuel(1)
    turtle.select(Current_slot)

    print("post refuel" .. turtle.getFuelLevel())

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

---Checks if there is still enough fuel stored
---@param Required number Required fuel
---@return boolean 
function Fuel_check(Required)
    local Fuel_level = turtle.getFuelLevel()

    if Required < Fuel_level then return true end

    return false
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
            if turtle.down() == true then
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

function Dig(Handle_gravel)
    local Current_slot = turtle.getSelectedSlot()

    if Handle_gravel == nil then Handle_gravel = false end

    if Config.Clear_fluids == true then
        turtle.select(1)
        turtle.place()
        turtle.select(Current_slot)
    end

    if Handle_gravel == false then
        return turtle.dig()
    end

    while turtle.dig() == true do
        sleep(0.2)
    end

    return true
end

function Chest_dump()
    local Current_slot = turtle.getSelectedSlot()
    local Slot = 0

    Chest_dump_place()

    for Slot = 1, 16, 1 do
        if (Slot ~= Config.Fuel_slot) && (Slot ~= Config.Chest_slot) && (Slot ~= Config.Light_slot) then
            Chest_dump_drop(Slot)
        end
    end
    
    if Config.Light_block_type ~= "None" then
        Chest_dump_drop(Config.Light_slot)
    end

    if Config.Chest_dump_type ~= "None" then
        Chest_dump_drop(Config.Chest_slot)
    end

    if Config.Fuel_slot ~= 16 then
        Chest_dump_drop(Config.Fuel_slot)
    end

    Chest_dump_pick()
    turtle.select(Current_slot)

end

function Chest_dump_drop(Slot)
    if Slot == nil then Slot = 1 end

    turtle.select(Slot)

    if Config.Chest_dump_type == "Ender chest" then
        return turtle.dropUp()
    end

    if Config.Chest_dump_type == "Normal" then
        return turtle.drop()
    end

    ---If Config is set to 'None' or all else
    return false
end

function Chest_dump_place()
    turtle.select(Config.Chest_slot)

    if Config.Chest_dump_type == "Ender chest" then
        turtle.digUp()
        turtle.placeUp()
    end

    if Config.Chest_dump_type == "Normal" then
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.dig()
        turtle.place()
    end

    ---If Config is set to 'None' or all else
    return
end

function Chest_dump_pick()
    turtle.select(Config.Chest_slot)

    if Config.Chest_dump_type == "Ender chest" then
        turtle.digUp()
    end

    if Config.Chest_dump_type == "Normal" then
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.dig()
    end

    ---If Config is set to 'None' or all else
    return
end

function Tunnel_slice(Hight)
    local Required_fuel = (Hight - 1) * 2
    local Traveled = 0

    Refuel_upto(Required_fuel)

    turtle.turnLeft()
    for Traveled = 0, Hight - 1, 1 do
        Dig(true)
        Up()
    end

    Dig()
    turtle.turnRight()
    turtle.turnRight()
    Dig(true)

    for Traveled = 0, Hight - 1, 1 do
        Down()
        Dig()
    end

    Dig()
    turtle.turnLeft()

    --Cleanup of posible gravel
    turtle.turnLeft()
    Dig(true)
    turtle.turnRight()

end