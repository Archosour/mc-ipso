Neutral_pos = {["x"] = 1, ["y"] = 14}

local Displays = {
    ["Pocket"] = {
        ["Home"] = {
            "---------------------O----",
            "Alerts:              |Home",
            "---------------------O----",
            "Fluid tanks",
            "Energy",
            "Items",
            "Machines",
            "",
            "",
            "",
            "",
            "",
            "",
            "",
            "-------- Messages --------",
            "",
            "",
            ""
        },

        ["Fluid_tanks"] = {
            "---------------------O----",
            "Alerts:              |Home",
            "---------------------O----",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "-------- Messages ---O----",
            "",
            "",
            ""
        },

        ["Machines"] = {
            "---------------------O----",
            "Alerts:              |Home",
            "---------------------O----",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "                     |    ",
            "-------- Messages ---O----",
            "",
            "",
            ""
        }
    }
}

function Print_display(Display)
    if pocket then
        local Display = Displays.Pocket[Display]
        local Line = 0

        term.clear()

        for Line = 1, #Display, 1 do
            local Display_line = Display[Line]
            term.setCursorPos(1, Line)
            term.write(Display_line)
        end

    else
        term.clear()
        term.setCursorPos(1,1)
        term.write("Device type not supported")
    end

end