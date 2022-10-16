local wibox = require("wibox")
local beautiful = require("beautiful")

local function get_systray()
    local systray = wibox.widget.systray()
    return systray
end

return get_systray