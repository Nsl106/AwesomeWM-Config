local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local function get_layoutbox()
    beautiful.layout_tile 		= gears.color.recolor_image(beautiful.layout_tile, beautiful.fg_normal)
    beautiful.layout_fairh 		= gears.color.recolor_image(beautiful.layout_fairh, beautiful.fg_normal)
    beautiful.layout_fairv 		= gears.color.recolor_image(beautiful.layout_fairv, beautiful.fg_normal)
    beautiful.layout_floating 	= gears.color.recolor_image(beautiful.layout_floating, beautiful.fg_normal)
    beautiful.layout_magnifier 	= gears.color.recolor_image(beautiful.layout_magnifier, beautiful.fg_normal)
    beautiful.layout_max 		= gears.color.recolor_image(beautiful.layout_max, beautiful.fg_normal)
    beautiful.layout_fullscreen	= gears.color.recolor_image(beautiful.layout_fullscreen, beautiful.fg_normal)
    beautiful.layout_tilebottom	= gears.color.recolor_image(beautiful.layout_tilebottom, beautiful.fg_normal)
    beautiful.layout_tileleft 	= gears.color.recolor_image(beautiful.layout_tileleft, beautiful.fg_normal)
    beautiful.layout_tiletop 	= gears.color.recolor_image(beautiful.layout_tiletop, beautiful.fg_normal)
    beautiful.layout_spiral 	= gears.color.recolor_image(beautiful.layout_spiral, beautiful.fg_normal)
    beautiful.layout_dwindle 	= gears.color.recolor_image(beautiful.layout_dwindle, beautiful.fg_normal)

    local layoutbox = awful.widget.layoutbox(s)
    layoutbox:buttons({
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)
    })
    return layoutbox
end
return get_layoutbox
