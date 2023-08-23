Neutral_pos = {
    ["Pocket"] = {["x"] = 1, ["y"] = 15}
}

Displays = {
    ["Pocket"] = {
        ["Home"] = {
            ["Background"] = {
                "---------------------O----",
                "Alerts:              |Home",
                "---------------------O----",
                "",
                "",
                "",
                "",
                "",
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
            ["Options"] = {
                [1] = {
                    ["Name"] = "Energy",
                    ["Discoverable"] = true
                }
            }
        },
        

        ["Energy"] = {
            ["Background"] = {
                "---------------------O----",
                "Alerts:              |Home",
                "---------------------O----",
                "                          ",
                "                          ",
                "                          ",
                "                          ",
                "                          ",
                "                          ",
                "                          ",
                "                          ",
                "                          ",
                "                          ",
                "                          ",
                "                          ",
                "-------- Messages --------",
                "",
                "",
                ""
            },
            ["Options"] = {
                [1] = {
                    ["Name"] = "Small boiler",
                    ["Discoverable"] = false
                }
                
            }
        }
    }
}

function Print_display(Display)

    Brave.Log("Display type; " .. type(Display), true, false)
    Brave.Log("Display     ; " .. Display, true, false)

    if pocket then
        local Display_background = Displays.Pocket[Display].Background
        local Display_options = Displays.Pocket[Display].Options
        local Line = 0

        term.clear()

        for Line = 1, #Display_background, 1 do
            local Display_line = Display_background[Line]
            term.setCursorPos(1, Line)
            term.write(Display_line)
        end

        if #Display_options == 0 or Display_options == nil then return end

        Line = 0
        for Line = 1, #Display_options, 1 do
            local Option_line = Display_options[Line].Name
            term.setCursorPos(1, Line + 3)
            term.write(Option_line)
        end



    else
        term.clear()
        term.setCursorPos(1,1)
        term.write("Device type not supported")
    end

end