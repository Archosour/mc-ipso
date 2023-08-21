local Console_tab = multishell.getCurrent()
local Tab = multishell.launch({}, "pocket.lua")

multishell.setTitle(Tab, "Home")
multishell.setTitle(Console_tab, "Con")
multishell.setFocus(Tab)





