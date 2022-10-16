local awful = require("awful")
local beautiful = require("beautiful")
local hotkeys_popup	= require("awful.hotkeys_popup").widget

local function get_menu()
    local awesome_path = string.format("%s/.config/awesome/", os.getenv("HOME"))

    local awesomemenu = {
        {
            "hotkeys",
            function()
                hotkeys_popup.show_help(nil, awful.screen.focused())
            end
        }, 
        {"edit config", terminal .. " -e " .. editor .. " " .. awesome_path},
        {"restart", awesome.restart}, {"quit", function() awesome.quit() end}
    }

    local mainmenu = awful.menu({
        items = {
            {"awesome", awesomemenu, beautiful.awesome_icon},
            {"terminal", terminal}, {"file explorer", file_explorer},
            {"browser", browser}
        }
    })

    return mainmenu
end

return get_menu
