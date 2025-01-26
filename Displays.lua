os.loadAPI("Constants.lua")
os.loadAPI("Config.lua")

local Pc_label = os.getComputerLabel()

Neutral_pos = {
    ["Pocket"] = {["x"] = 1, ["y"] = 15},
    ["Monitor"] = {["x"] = 1, ["y"] = 15},
    ["Advanced_computer"] = {["x"] = 1, ["y"] = 13},
    ["Turtle"] = {["x"] = 1, ["y"] = 1}
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
                },
                [2] = {
                    ["Name"] = "Fluid",
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
            }
        },

        ["Fluid"] = {
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
            }
        }
    },

    ["Monitor"] = {
        ["Home"] = {
            ["Background"] = {
                "                            ___              __   ",
                "Alerts:                    /   |  __________/ /_  ",
                "                          / /| | / ___/ ___/ __ \\",
                "                         / ___ |/ /  / /__/ / / / ",
                "                        /_/  |_/_/   \\___/_/ /_/ ",
                "--------------------------------------------------",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "-------------------- Messages --------------------",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  "
            },
            ["Options"] = {
                [1] = {
                    ["Name"] = "Energy",
                    ["Discoverable"] = true
                },
                [2] = {
                    ["Name"] = "Fluid",
                    ["Discoverable"] = true
                },
                [3] = {
                    ["Name"] = "Items",
                    ["Discoverable"] = true
                }
            }
        },
        
        ["Energy"] = {
            ["Background"] = {
                "                            ___              __   ",
                "Alerts:                    /   |  __________/ /_  ",
                "                          / /| | / ___/ ___/ __ \\",
                "                         / ___ |/ /  / /__/ / / / ",
                "                        /_/  |_/_/   \\___/_/ /_/ ",
                "-------------------- Energy ----------------------",
                "     Name         Stress    Capacity   %     RPM  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "-------------------- Messages --------------------",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  "
            },
            ["Options"] = {
            }
        },

        ["Fluid"] = {
            ["Background"] = {
                "                            ___              __   ",
                "Alerts:                    /   |  __________/ /_  ",
                "                          / /| | / ___/ ___/ __ \\",
                "                         / ___ |/ /  / /__/ / / / ",
                "                        /_/  |_/_/   \\___/_/ /_/ ",
                "--------------------- Fluid ----------------------",
                "    Name           Type                 %         ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "-------------------- Messages --------------------",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  "
            },
            ["Options"] = {
            }
        },
        ["Items"] = {
            ["Background"] = {
                "                            ___              __   ",
                "Alerts:                    /   |  __________/ /_  ",
                "                          / /| | / ___/ ___/ __ \\",
                "                         / ___ |/ /  / /__/ / / / ",
                "                        /_/  |_/_/   \\___/_/ /_/ ",
                "--------------------- Items ----------------------",
                "    Name           Item                 %         ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "-------------------- Messages --------------------",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  ",
                "                                                  "
            },
            ["Options"] = {
            }
        }
    },

    ["Advanced_computer"] = {
        ["Home"] = {
            ["Background"] = {
                "----------------------------------------------o----",
                "Alerts:                                       |Home",
                "----------------------------------------------o----",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "------------------ Messages -----------------------",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   "
            },
            ["Options"] = {
                [1] = {
                    ["Name"] = "Energy",
                    ["Discoverable"] = true
                },
                [2] = {
                    ["Name"] = "Fluid",
                    ["Discoverable"] = true
                },
                [3] = {
                    ["Name"] = "Items",
                    ["Discoverable"] = true
                }
            }
        },
        
        ["Energy"] = {
            ["Background"] = {
                "----------------------------------------------o----",
                "Alerts:                                       |Home",
                "----------------------------------------------o----",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "------------------ Messages -----------------------",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   "
            },
            ["Options"] = {
            }
        },

        ["Fluid"] = {
            ["Background"] = {
                "----------------------------------------------o----",
                "Alerts:                                       |Home",
                "----------------------------------------------o----",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "------------------ Messages -----------------------",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   "
            },
            ["Options"] = {
            }
        },

        ["Items"] = {
            ["Background"] = {
                "----------------------------------------------o----",
                "Alerts:                                       |Home",
                "----------------------------------------------o----",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "------------------ Messages -----------------------",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   ",
                "                                                   "
            },
            ["Options"] = {
            }
        }
    },

    ["Turtle"] = {
        ["Home"] = {
            ["Background"] = {
                "                                   ___ ",
                "                                  /   |",
                "                                 / /| |",
                "                                / ___ |",
                "                               /_/  |_/",
                "                              ---------",
                "                                       ",
                "                                       ",
                "                                       ",
                "                                       ",
                "                                       ",
                "                                       ",
                "                                       "
            },
            ["Options"] = {
            }
        }
    }
}

function Print_terminal(Display) 
    local Display_background = Displays.Advanced_computer[Display].Background
    local Display_options    = Displays.Advanced_computer[Display].Options
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
end

function Print_display(Display, Aditional_info)

    if pocket then
        local Display_background = Displays.Pocket[Display].Background
        local Display_options    = Displays.Pocket[Display].Options
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

    elseif turtle then
        local Display_background = Displays.Turtle[Display].Background
        local Display_options    = Displays.Turtle[Display].Options
        local Line = 0

        term.clear()

        for Line = 1, #Display_background, 1 do
            local Display_line = Display_background[Line]
            term.setCursorPos(1, Line)
            term.write(Display_line)
        end

        term.setCursorPos(Neutral_pos["Turtle"]["x"], Neutral_pos["Turtle"]["y"])
        term.write("Label: " .. os.getComputerLabel())
        term.setCursorPos(Neutral_pos["Turtle"]["x"], Neutral_pos["Turtle"]["y"] + 1)
        term.write("ID   : " .. Config.Device_type)
        term.setCursorPos(Neutral_pos["Turtle"]["x"], Neutral_pos["Turtle"]["y"] + 2)
        term.write("PC ID: " .. os.getComputerID())

        local Turtle_specialty_row = Neutral_pos["Turtle"]["y"] + 4

        if Config.Device_type == "Turtle:Mining" then
            term.setCursorPos(Neutral_pos["Turtle"]["x"], Turtle_specialty_row)
            term.write("Fuel slot:    " .. Config.Fuel_slot)
            term.setCursorPos(Neutral_pos["Turtle"]["x"], Turtle_specialty_row + 1)
            term.write("Chest type:   " .. Config.Chest_dump_type)
            term.setCursorPos(Neutral_pos["Turtle"]["x"], Turtle_specialty_row + 2)
            term.write("Chest slot:   " .. Config.Chest_slot)
            term.setCursorPos(Neutral_pos["Turtle"]["x"], Turtle_specialty_row + 3)
            term.write("Tunnel hight: " .. Config.Tunnel_hight)
            term.setCursorPos(Neutral_pos["Turtle"]["x"], Turtle_specialty_row + 4)
            term.write("Tunnel width: " .. Config.Tunnel_width)
        end

        local Turtle_adition_row = Turtle_specialty_row + 6

        if (#Aditional_info > 0) then
            for Line = 1, #Aditional_info, 1 do
                term.setCursorPos(Neutral_pos["Turtle"]["x"], Turtle_adition_row + Line - 1)
                term.write(Aditional_info[Line])
            end
        end

    else
        term.clear()
        term.setCursorPos(1,1)
        term.write("Device type not supported")
    end
end