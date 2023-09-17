local Pc_label = os.getComputerLabel()

Neutral_pos = {
    ["Pocket"] = {["x"] = 1, ["y"] = 15},
    ["Monitor"] = {["x"] = 1, ["y"] = 15},
    ["Advanced_computer"] = {["x"] = 1, ["y"] = 13}
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

function Print_display(Display, Peripheral)

    Brave.Log("Display type; " .. type(Display), true, false)
    Brave.Log("Display     ; " .. Display, true, false)

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

    elseif Pc_label == "arch:monitor_0" then
        local Display_background = Displays.Monitor[Display].Background
        local Display_options    = Displays.Monitor[Display].Options
        local Line = 0

        Peripheral.clear()

        for Line = 1, #Display_background, 1 do
            local Display_line = Display_background[Line]
            Peripheral.setCursorPos(1, Line)
            Peripheral.write(Display_line)
        end

        Print_terminal(Display)

    else
        term.clear()
        term.setCursorPos(1,1)
        term.write("Device type not supported")
    end
end