local wibox = require("wibox")
local beautiful = require("beautiful")

local function get_clock()
    local clock = wibox.widget.textclock('%I:%M %P')
    clock.font = beautiful.bold_font
    return clock
end

return get_clock