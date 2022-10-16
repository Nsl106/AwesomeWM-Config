local awful = require("awful")

local function get_taglist(s)
    local taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {font = "sans 24 bold"}
    }
    return taglist
end

return get_taglist
