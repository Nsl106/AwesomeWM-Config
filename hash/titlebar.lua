local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local function get_titlebar(c)

    local titlebar_menu = awful.menu()

    local minimize = {
        "minimize", function() c.minimized = true end,
        beautiful.titlebar_minimize_button_normal
    }

    local sticky = {
        "sticky", function() c.sticky = not c.sticky end,
        beautiful.titlebar_sticky_button_normal_inactive
    }

    local sticky2 = {
        "sticky", function() c.sticky = not c.sticky end,
        beautiful.titlebar_sticky_button_normal_active
    }

    local ontop = {
        "on top", function() c.ontop = not c.ontop end,
        beautiful.titlebar_ontop_button_normal_inactive
    }

    local ontop2 = {
        "on top", function() c.ontop = not c.ontop end,
        beautiful.titlebar_ontop_button_normal_active
    }

    titlebar_menu:add(minimize, 1)
    titlebar_menu:add(sticky, 2)
    titlebar_menu:add(ontop, 3)

    -- Gets a rounded rectangle shape
    local function custom_shape(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end

    c.shape = custom_shape

    -- buttons for the titlebar
    local buttons = gears.table.join(awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.move(c)
    end), awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end))

    local menu_open = false

    local titlebar_menu_button = awful.titlebar.widget.button(c, 'menu',
                                                              function()
        -- Selector function, returns state of the button
        -- This function must return state of the button
        -- For example for maximized button it can be 'active' or 'inactive'
        return menu_open
    end, function() -- Action function, called as action(c, selector(c))
        -- Do something depends on client and state
        if menu_open then
            titlebar_menu:delete(1)
            titlebar_menu:delete(2)
            titlebar_menu:delete(3)
            titlebar_menu:add(minimize, 1)
            if c.sticky then
                titlebar_menu:add(sticky2, 2)
            else
                titlebar_menu:add(sticky, 2)
            end
            if c.ontop then
                titlebar_menu:add(ontop2, 3)
            else
                titlebar_menu:add(ontop, 3)
            end
            titlebar_menu:show()
            menu_open = false
        else
            titlebar_menu:delete(1)
            titlebar_menu:delete(2)
            titlebar_menu:delete(3)
            titlebar_menu:hide()
            menu_open = true
        end
    end)

    local titlebar = awful.titlebar(c):setup{
        { -- Left
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal
        },
        { -- Middle
            {align = "center", widget = awful.titlebar.widget.titlewidget(c)},
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        { -- Right
            titlebar_menu_button,
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }

    return titlebar
end

return get_titlebar
