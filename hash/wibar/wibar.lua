local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

local get_wibar = function(s)
    -- Each screen has its own tag table.
    local names = {"1", "2", "3", "4", "5", "6"}
    local l = awful.layout.suit
    local layouts = {
        l.fair, l.magnifier, l.fair.horizontal, l.tile, l.fair, l.max
    }
    awful.tag(names, s, layouts)

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.

    -- Margin between the wiboxes and the edges of the screen
    local margin = 10
    -- Margin between the bottom of the wiboxes and the top of a window
    local marginBottom = 5
    -- Height of the wiboxes
    local wibox_height = 25

    -- Width of the left sidebar, not including margins
    local leftWidth = 125
    -- Width of the right sidebar, not including margins
    local rightWidth = 125

    -- Sets the center bar to the maximum width accounting for the two side bars and margins
    local centerWidth = s.geometry.width -
                            ((margin * 4) + leftWidth + rightWidth)

    -- Gets a rounded rectangle shape
    local function custom_shape(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end

    local function createWibox(arg)
        return wibox({
            screen = s,
            stretch = false,
            width = arg.width,
            height = wibox_height,
            shape = custom_shape,
            visible = true,
            x = arg.position,
            y = margin,
            bg = beautiful.bg_systray
        })
    end

    s.wiboxLeft = createWibox({width = leftWidth, position = margin})
    s.wiboxCenter = createWibox({
        width = centerWidth,
        position = leftWidth + (margin * 2)
    })
    s.wiboxRight = createWibox({
        width = rightWidth,
        position = s.geometry.width - (rightWidth + margin)
    })

    local function addWiboxStruts(wibox)
        wibox:struts({top = wibox_height + margin + marginBottom})
    end

    addWiboxStruts(s.wiboxLeft)
    addWiboxStruts(s.wiboxCenter)
    addWiboxStruts(s.wiboxRight)

    -- Add widgets to the wibox
    s.wiboxLeft:setup{
        {
            layout = wibox.layout.fixed.horizontal,
            require("hash.wibar.widgets.taglist") (s)
        },
        halign = "left",
        layout = wibox.container.place
    }

    promptbox = require("hash.wibar.widgets.promptbox")(s)

    s.wiboxCenter:setup{
        {
            layout = wibox.layout.fixed.horizontal,
            promptbox,
            require("hash.wibar.widgets.systray")(s),
            require("hash.wibar.widgets.tasklist")(s),
            spacing = 10
        },
        halign = "left",
        layout = wibox.container.place
    }

    s.wiboxRight:setup({
        {
            layout = wibox.layout.fixed.horizontal,
            require("hash.wibar.widgets.clock")(s),
            require("hash.wibar.widgets.layoutbox")(s),
            spacing = 10
        },
        halign = "center",
        layout = wibox.container.place
    })
end

return get_wibar
