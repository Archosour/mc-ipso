-------------------{ Turtle API }-------------------
---  API for controlling a conputercraft turtle  ---
---  For normal operation it is depending on the ---
---  config.lua file for settings

os.loadAPI("Config.lua")

function Attack()
    return turtle.attack()
end

function Attack_up()
    return turtle.attackUp()
end

function Attack_down()
    return turtle.attackDown()
end

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
        for Attempt = 1, 255, 1 do
            if turtle.forward() == true then
                return true
            end

            Refuel()
            turtle.dig()
        end

        Attack()
    end

    print("101 Turtle could not move forward due to unknown reason")
    print("Fuel level: " .. turtle.getFuelLevel())
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

        Refuel()
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

        Refuel()
        Attack_down()
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

---Dig in front of the turtle. 
---@param Handle_gravel boolean Set to true if gravel is to be expected
---@return boolean Succes True if minging was succesfull
function Dig(Handle_gravel)
    local Current_slot = turtle.getSelectedSlot()

    if Handle_gravel == nil then Handle_gravel = false end

    --Placing a block will remove the fluid source block
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

---Dumps all items in a chest for collection. Special slots will be
---ignored like: fuel, chest and light. Nomater they are in use of not.
function Chest_dump()
    local Current_slot = turtle.getSelectedSlot()
    local Slot = 0

    --Place chest according to configurations
    Chest_dump_place()

    for Slot = 1, 16, 1 do
        if (Slot ~= Config.Fuel_slot) and (Slot ~= Config.Chest_slot) and (Slot ~= Config.Light_slot) then
            Chest_dump_drop(Slot)
        end

        -- To make sure of chest slot is empty before picking up 
        -- the ender chest at a later stage. Could result unto
        -- losing its chest and dumping everything on the floor
        -- next time it drops off items
        if (Slot == Config.Chest_slot and Config.Chest_dump_type == "Ender chest") then
            Chest_dump_drop(Slot)
        end
    end
    
    if Config.Light_block_type ~= "None" then
        Chest_dump_drop(Config.Light_slot)
    end

    if Config.Chest_dump_type == "None" then
        Chest_dump_drop(Config.Chest_slot)
    end

    if Config.Fuel_slot ~= 16 then
        Chest_dump_drop(Config.Fuel_slot)
    end

    Chest_dump_pick()
    turtle.select(Current_slot)

end

---Drop items into chest according the configurations
---@param Slot number Inventory slot
---@return boolean Succes true if items were send into the chest
function Chest_dump_drop(Slot)
    if Slot == nil then Slot = 1 end
    if Config.Chest_dump_type == "None" then return true end

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

---Places chest according to the configurations
function Chest_dump_place()
    if Config.Chest_dump_type == "None" then return end
    turtle.select(Config.Chest_slot)

    if Config.Chest_dump_type == "Ender chest" then
        while turtle.placeUp() == false do
            turtle.digUp()
        end
        
        turtle.placeUp()
        return
    end

    if Config.Chest_dump_type == "Normal" then
        turtle.turnLeft()
        turtle.turnLeft()
        Dig()
        turtle.place()
        return
    end

    ---If Config is set to 'None' or all else
    return
end

---Pick up the chest according to the configurations
function Chest_dump_pick()
    if Config.Chest_dump_type == "None" then return end
    turtle.select(Config.Chest_slot)

    if Config.Chest_dump_type == "Ender chest" then
        turtle.digUp()
        return
    end

    if Config.Chest_dump_type == "Normal" then
        turtle.turnLeft()
        turtle.turnLeft()
        Dig()
        return
    end

    ---If Config is set to 'None' or all else
    return
end

---Mine out a tunnel slice with a width of 3 blocks
---Turtle does not move into the wall at the start of the slice
---@param Input number Hight of the tunnel slice
function Tunnel_slice(Input)
    --Hight requires an offset since it starts already on level 1
    local Expected_hight = Input - 1
    local Hight = 0

    --Required fuel to perform the whole tunnel slice
    --Additional 2 for movement forward
    local Required_fuel = Expected_hight * 2 + 2
    local Traveled = 0
    local Save_traveled = 0

    Refuel_upto(Required_fuel)

    turtle.turnLeft()
    for Traveled = 0, Expected_hight, 1 do
        Dig(true)

        if Up() == false then
            break
        end

        Save_traveled = Traveled
    end

    Hight = Traveled

    Dig()
    turtle.turnRight()
    turtle.turnRight()
    Dig(true)

    if Config.Tunnel_width == 4 then
        if Forward() == false then
            print("375 Turtle failed to move forward in tunnel slice")
            print("Fuel level: " .. turtle.getFuelLevel())
        end
        Dig(true)
    end

    for Traveled = 0, Save_traveled, 1 do
        
        -- This needs to get a nicer handling
        if Down() == false then
            print("Block could not be mined, terminate program...")
            error("Block could not be mined, terminate program...")
        end

        Dig()
    end

    Dig()
    turtle.turnLeft()

    --Cleanup of posible gravel of the left side
    turtle.turnLeft()
    Dig(true)

    if Config.Tunnel_width == 4 then
        if Forward() == false then
            print("401 Turtle failed to move forward in tunnel slice")
            print("Fuel level: " .. turtle.getFuelLevel())
        end
        Dig(true)
    end

    --Reset orientation for new slice
    turtle.turnRight()
end

---Checks if light source has to be placed
---@param Distance number number horizontal of blocks traveled from start position
---@return boolean succes True if at the set interval by configuration file
function Light_check_distance(Distance)
    if Distance <= 1 then return false end

    if math.fmod(Distance, Config.Light_block_interval) == 0 then
        return true
    end

    return false
end

---Place light source according to the config file
function Light_place_block()
    if Config.Light_block_type == "None" then return end

    turtle.select(Config.Chest_slot)

    if Config.Light_block_type == "Torch" then
        turtle.turnLeft()
        turtle.place()
        turtle.turnLeft()
        return
    end

    if Config.Light_block_type == "Glowstone" then
        turtle.digDown()
        turtle.placeDown()
        return
    end

    return
end 