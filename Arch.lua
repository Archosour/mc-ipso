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