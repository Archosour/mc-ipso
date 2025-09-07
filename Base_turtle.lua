---@type number
---Total number of slots available in a turtles inventory.
Turtle_inventory_size = 16

---Move the turtle forward one block.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Forward()
    local Result, Status = turtle.forward()

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Move the turtle backwards one block.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Back()
    local Result, Status = turtle.back()

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Move the turtle up one block.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Up()
    local Result, Status = turtle.up()

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end
---Move the turtle down one block.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Down()
    local Result, Status = turtle.down()

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Rotate the turtle 90 degrees to the left.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Turn_left()
    local Result, Status = turtle.turnLeft()

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Rotate the turtle 90 degrees to the right.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status  
function Turn_Right()
    local Result, Status = turtle.turnLeft()

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Attempt to break the block in front of the turtle.
---This requires a turtle tool capable of breaking the block. 
---Diamond pickaxes (mining turtles) can break any vanilla block, 
---but other tools (such as axes) are more limited.
---@param Side string Optional to which specific tool to use. Should be "left" or "right".
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Dig(Side)
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

---Attempt to break the block above the turtle.
---This requires a turtle tool capable of breaking the block. 
---Diamond pickaxes (mining turtles) can break any vanilla block, 
---but other tools (such as axes) are more limited.
---@param Side string Optional to which specific tool to use. Should be "left" or "right".
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Dig_up(Side)
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

---Attempt to break the block below the turtle.
---This requires a turtle tool capable of breaking the block. 
---Diamond pickaxes (mining turtles) can break any vanilla block, 
---but other tools (such as axes) are more limited.
---@param Side string Optional to which specific tool to use. Should be "left" or "right".
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Dig_Down(Side)
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

---Place a block or item into the world in front of the turtle.
---"Placing" an item allows it to interact with blocks and entities in front of the turtle. 
---For instance, buckets can pick up and place down fluids, and wheat can be used to breed cows. 
---However, you cannot use place to perform arbitrary block interactions, such as clicking buttons or flipping levers.
---@param Text string When placing a sign, set its contents to this text.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Place(Text)
    local Result, Status = turtle.place(Text)

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Place a block or item into the world above the turtle.
---"Placing" an item allows it to interact with blocks and entities above the turtle. 
---For instance, buckets can pick up and place down fluids, and wheat can be used to breed cows. 
---However, you cannot use place to perform arbitrary block interactions, such as clicking buttons or flipping levers.
---@param Text string When placing a sign, set its contents to this text.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Place_up(Text)
    local Result, Status = turtle.placeUp(Text)

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Place a block or item into the world below the turtle.
---"Placing" an item allows it to interact with blocks and entities below the turtle. 
---For instance, buckets can pick up and place down fluids, and wheat can be used to breed cows. 
---However, you cannot use place to perform arbitrary block interactions, such as clicking buttons or flipping levers.
---@param Text string When placing a sign, set its contents to this text.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Place_down(Text)
    local Result, Status = turtle.placeDown(Text)

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Drop the currently selected stack into the inventory in front of the turtle, 
---or as an item into the world if there is no inventory.
---@param Count number The number of items to drop. If not given, the entire stack will be dropped.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Drop(Count)
    local Result, Status = turtl.drop(Count)

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Drop the currently selected stack into the inventory above of the turtle, 
---or as an item into the world if there is no inventory.
---@param Count number The number of items to drop. If not given, the entire stack will be dropped.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Drop_up(Count)
    local Result, Status = turtle.dropUp(Count)

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Drop the currently selected stack into the inventory in below of the turtle, 
---or as an item into the world if there is no inventory.
---@param Count number The number of items to drop. If not given, the entire stack will be dropped.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Drop_down(Count)
    local Result, Status = turtle.dropDown(Count)

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Change the currently selected slot.
---The selected slot is determines what slot actions like drop or getItemCount act on.
---@param Slot number The slot to select.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Select(Slot)
    if Slot > Turtle_inventory_size then
        return false, "Slot out of range"
    end

    local Result = turtle.select(Slot)

    return Result, ""
end

---Get the number of items in the given slot.
---@param Slot number The slot we wish to check. Defaults to the selected slot.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Get_item_count(Slot)
    if Slot > Turtle_inventory_size then
        return false, "Slot out of range"
    end
    
    local Result = turtle.getItemCount(Slot)

    return Result, ""
end

---Get the remaining number of items which may be stored in this stack.
---@param Slot number The slot we wish to check. Defaults to the selected slot.
---@return boolean #true if successfull
---@return boolean #false if unsuccessfull
---@return string #status 
function Get_item_space(Slot)
    if Slot > Turtle_inventory_size then
        return false, "Slot out of range"
    end
    
    local Result = turtle.getItemSpace(Slot)

    return Result, ""
end

---Check if there is a solid block in front of the turtle. In this case, solid refers to any non-air or liquid block.
---@return boolean #true if solid block
---@return boolean #false if non solid or air
function Detect()
    local Result = turtle.detect()

    return Result
end

---Check if there is a solid block above the turtle. In this case, solid refers to any non-air or liquid block.
---@return boolean #true if solid block
---@return boolean #false if non solid or air
function Detect_up()
    local Result = turtle.detectUp()

    return Result
end

---Check if there is a solid block below the turtle. In this case, solid refers to any non-air or liquid block.
---@return boolean #true if solid block
---@return boolean #false if non solid or air
function Detect_down()
    local Result = turtle.detectDown()

    return Result
end

---Check if the block in front of the turtle is equal to the item in the currently selected slot.
---@return boolean #true if equal
---@return boolean #false if not equal
function Compare()
    local Result = turtle.compare()

    return Result
end

---Check if the block above the turtle is equal to the item in the currently selected slot.
---@return boolean #true if equal
---@return boolean #false if not equal
function Compare_up()
    local Result = turtle.compareUp()

    return Result
end

---Check if the block below the turtle is equal to the item in the currently selected slot.
---@return boolean #true if equal
---@return boolean #false if not equal
function Compare_down()
    local Result = turtle.compareDown()

    return Result
end

---Attack the entity in front of the turtle.
---@param Side any The specific tool to use
---@return boolean #Whether an entity was attacked
---@return string #The reason nothing was attacked
function Attack(Side)
    local Result, Status = turtle.attack(Side)

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Attack the entity above the turtle.
---@param Side any The specific tool to use
---@return boolean #Whether an entity was attacked
---@return string #The reason nothing was attacked
function Attack_up(Side)
    local Result, Status = turtle.attackUp(Side)

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Attack the entity below the turtle.
---@param Side any The specific tool to use
---@return boolean #Whether an entity was attacked
---@return string #The reason nothing was attacked
function Attack_down(Side)
    local Result, Status = turtle.attackDown(Side)

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Suck an item from the inventory in front of the turtle, or from an item floating in the world.
---This will pull items into the first acceptable slot, starting at the currently selected one.
---@param Count any The number of items to suck. If not given, up to a stack of items will be picked up
---@return boolean #Whether items were picked up
---@return string #The reason the no items were picked up
function Suck(Count)
    local Result, Status = turtle.suck(Count)

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Suck an item from the inventory above the turtle, or from an item floating in the world.
---This will pull items into the first acceptable slot, starting at the currently selected one.
---@param Count any The number of items to suck. If not given, up to a stack of items will be picked up
---@return boolean #Whether items were picked up
---@return string #The reason the no items were picked up
function Suck_up(Count)
    local Result, Status = turtle.suckUp(Count)

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Suck an item from the inventory below the turtle, or from an item floating in the world.
---This will pull items into the first acceptable slot, starting at the currently selected one.
---@param Count any The number of items to suck. If not given, up to a stack of items will be picked up
---@return boolean #Whether items were picked up
---@return string #The reason the no items were picked up
function Suck_down(Count)
    local Result, Status = turtle.suckDown(Count)

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Get the amount of fuel this turtle currently holds.
---@return number #The current amount of fuel a turtle this turtle has
---@return boolean #Fuel is required by config
function Get_fuel_level()
    local Result = turtle.getFuelLevel()

    if type(Result) == "string" then
        return 999999, false
    end

    return Result, true
end

---Refuel this turtle.
---While most actions a turtle can perform (such as digging or placing blocks) are free, moving consumes fuel from the turtle's internal buffer. 
---If a turtle has no fuel, it will not move.
---refuel refuels the turtle, consuming fuel items (such as coal or lava buckets) from the currently selected slot and converting them into energy. 
---This finishes once the turtle is fully refuelled or all items have been consumed.
---@param Count any The maximum number of items to consume. One can pass 0 to check if an item is combustable or not
---@return boolean #true If the turtle was refuelled
---@return string #The reason the turtle was not refuelled
function Refuel(Count)
    local Result, Status = turtle.refuel(Count)

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Compare the item in the currently selected slot to the item in another slot.
---@param Slot any #The slot to compare to
---@return boolean #If the two items are equal
function Compare_to(Slot)
    local Result = turtle.compareTo(Slot)

    return Result
end

---Move an item from the selected slot to another one.
---@param Slot any #The slot to move this item to
---@param Count any #The maximum number of items to move
---@return boolean If some items were successfully moved
---@return string
function Transfer_to(Slot, Count)
    local Result = turtle.transferTo(Slot, Count)

    return Result
end

---Get the currently selected slot.
---@return number #The current slot
function Get_selected_slot()
    local Result = turtle.getSelectedSlot()

    return Result
end

---Get the maximum amount of fuel this turtle can hold.
---By default, normal turtles have a limit of 20,000 and advanced turtles of 100,000.
---@return number #The maximum amount of fuel a turtle can hold
function Get_fuel_limit()
    local Result = turtle.getFuelLevel()

    if type(Result) == "string" then
        return 999999
    end

    return Result
end

---Equip (or unequip) an item on the left side of this turtle.
---This finds the item in the currently selected slot and attempts to equip it to the left side of the turtle. 
---The previous upgrade is removed and placed into the turtle's inventory.
---If there is no item in the slot, the previous upgrade is removed, but no new one is equipped.
---@return boolean #If the item was equipped
---@return string #The reason equipping this item failed
function Equip_left()
    local Result, Status = turtle.equipLeft()

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Equip (or unequip) an item on the right side of this turtle.
---This finds the item in the currently selected slot and attempts to equip it to the right side of the turtle. 
---The previous upgrade is removed and placed into the turtle's inventory.
---If there is no item in the slot, the previous upgrade is removed, but no new one is equipped.
---@return boolean #If the item was equipped
---@return string #The reason equipping this item failed
function Equip_right()
    local Result, Status = turtle.equipRight()

    if Result == true then
        return true, ""
    else
        return false, Status
    end
end

---Get the upgrade currently equipped on the left of the turtle.
---@return boolean #True if information could be retrieved
---@return table #Item details
function Get_equiped_left()
    local Result = turtle.getEquipedLeft()

    if type(Result) == "table" then
        return true, Result
    end

    return false, nil
end

---Get the upgrade currently equipped on the right of the turtle.
---@return boolean #True if information could be retrieved
---@return table #Item details
function Get_equiped_right()
    local Result = turtle.getEquipedRight()

    if type(Result) == "table" then
        return true, Result
    end

    return false, nil
end

---Get information about the block in front of the turtle.
---@return boolean #Whether there is a block in front of the turtle
---@return table #Information about the block in front, or a message explaining that there is no block
---@return string #Error message if one
function Inspect()
    local Result, Data = turtle.inspect()

    if type(Data) == "table" then
        return Result, Data, ""
    end

    return Result, nil, Data
end

---Get information about the block above the turtle.
---@return boolean #Whether there is a block above the turtle
---@return table #Information about the block in front, or a message explaining that there is no block
---@return string #Error message if one
function Inspect_up()
    local Result, Data = turtle.inspectUp()

    if type(Data) == "table" then
        return Result, Data, ""
    end

    return Result, nil, Data
end

---Get information about the block below the turtle.
---@return boolean #Whether there is a block below the turtle
---@return table #Information about the block in front, or a message explaining that there is no block
---@return string #Error message if any
function Inspect_down()
    local Result, Data = turtle.inspectDown()

    if type(Data) == "table" then
        return Result, Data, ""
    end

    return Result, nil, Data
end

---Get detailed information about the items in the given slot.
---@param Slot number #The slot to get information about. Defaults to the selected slot
---@param Detailed boolean #Whether to include "detailed" information. When true the method will contain much more information about the item at the cost of taking longer to run.
---@return table #Item detail table
---@return string #Error message if any
function Get_item_detail(Slot, Detailed)
    local Data = turtle.getItemDetail(Slot, Detailed)

    if type(Data) == "table" then
        return Data, ""
    end

    return nil, Data
end