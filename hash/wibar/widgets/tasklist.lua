local awful = require("awful")

local function get_tasklist(s)
    local tasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags
    }
    return tasklist
end

return get_tasklist
