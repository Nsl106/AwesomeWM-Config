local awful = require("awful")
local beautiful = require("beautiful")

local function get_promptbox()
    local promptbox = awful.widget.prompt()
    promptbox.font = beautiful.promptbox_font
    return promptbox
end

return get_promptbox
