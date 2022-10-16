local awful = require("awful")
local hotkeys_popup	= require("awful.hotkeys_popup").widget
local gears = require("gears")

-- Global keys
awful.keyboard.append_global_keybindings({
    -- Modkey + s opens hotkey table
    awful.key({modkey}, "s", hotkeys_popup.show_help, {description = "show help", group = "awesome"}),

    -- Modkey + arrow keys moves between tags
    awful.key({modkey}, "Left", awful.tag.viewprev, {description = "view previous", group = "tag"}),
    awful.key({modkey}, "Right", awful.tag.viewnext, {description = "view next", group = "tag"}),

    -- Modkey + j/k moves between windows within a tag
    awful.key({modkey}, "k", function() awful.client.focus.byidx(1) end, {description = "focus next by index", group = "client"}),
    awful.key({modkey}, "j", function() awful.client.focus.byidx(-1) end, {description = "focus previous by index", group = "client"}),

    
    -- Modkey + j/k + shift reorders windows within a tag
    awful.key({modkey, "Shift"}, "k", function() awful.client.swap.byidx(1) end, {description = "swap with next client", group = "client"}),
    awful.key({modkey, "Shift"}, "j", function() awful.client.swap.byidx(-1) end, {description = "swap with previous client", group = "client"}),

    -- Modkey + tab returns to the last open window
    awful.key({modkey}, "Tab",
        function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise() end end,
        {description = "go back", group = "client"}),
    
    -- Modkey + enter opens a terminal
    awful.key({modkey}, "Return", function() awful.spawn(terminal) end, {description = "open a terminal", group = "launcher"}),

    -- Modkey + control + r restarts awesome
    awful.key({modkey, "Control"}, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),

    -- Modkey + control + q quits awesome
    awful.key({modkey, "Control"}, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),

    -- Modkey + u/i changes size of tiled windows
    awful.key({modkey}, "i", function() awful.tag.incmwfact(0.05) end, {description = "increase master width factor", group = "layout"}),
    awful.key({modkey}, "u", function() awful.tag.incmwfact(-0.05) end, {description = "decrease master width factor", group = "layout"}),

    -- Modkey + u/i + shift changes number of columns of tiled windows
    awful.key({modkey, "Shift"}, "i", function() awful.tag.incncol(1, nil, true) end, {description = "increase columns", group = "layout"}),
    awful.key({modkey, "Shift"}, "u", function() awful.tag.incncol(-1, nil, true) end, {description = "decrease columns", group = "layout"}),

    -- Modkey + space moves to the next tiling layout, adding shift moves to the previous
    awful.key({modkey}, "space", function() awful.layout.inc(1) end, {description = "select next", group = "layout"}),
    awful.key({modkey, "Shift"}, "space", function() awful.layout.inc(-1) end, {description = "select previous", group = "layout"}),

    -- Modkey + shift + n restores a minimized window
    awful.key({modkey, "Shift"}, "n",
        function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal("request::activate", "key.unminimize", {raise = true}) end end,
        {description = "restore minimized", group = "client"}),

    -- Modkey + r opens the run prompt
    awful.key({modkey}, "r", function() promptbox:run() end, {description = "run prompt", group = "launcher"})
})

-- Keys for each client
local clientkeys = {
    -- Modkey + f toggles fullscreen
    awful.key({modkey}, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, {description = "toggle fullscreen", group = "client"}),

    -- Modkey + shift + f toggles fullscreen
    awful.key({modkey, "Shift"}, "f", function(c)
        c.floating = not c.floating
    end, {description = "toggle floating", group = "client"}),

    -- Modkey + shift + s toggles sticky
    awful.key({modkey, "Shift"}, "s", function(c)
        c.sticky = not c.sticky
    end, {description = "toggle sticky", group = "client"}),

    -- Modkey + shift + o toggles ontop
    awful.key({modkey, "Shift"}, "o", function(c)
        c.ontop = not c.ontop
    end, {description = "toggle ontop", group = "client"}),

    -- Modkey + shift + c closes a client window
    awful.key({modkey, "Shift"}, "c", function(c) c:kill() end,
              {description = "close", group = "client"}),

    -- Modkey + n minimizes a window
    awful.key({modkey}, "n", function(c) c.minimized = true end, 
              {description = "minimize", group = "client"}),

    -- Modkey + m toggles maximized
    awful.key({modkey}, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, {description = "(un)maximize", group = "client"}),
}

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, tag_count do
    awful.keyboard.append_global_keybindings({
        awful.key({modkey}, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then tag:view_only() end
        end, {description = "view tag #" .. i, group = "tag"}),
        -- Toggle tag display.
        awful.key({modkey, "Control"}, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end, {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({modkey, "Shift"}, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:move_to_tag(tag) end
            end
        end, {description = "move focused client to tag #" .. i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({modkey, "Control", "Shift"}, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:toggle_tag(tag) end
            end
        end, {
            description = "toggle focused client on tag #" .. i,
            group = "tag"
        })
})
end

awful.mouse.append_client_mousebindings({
    awful.button({}, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end),

    awful.button({modkey}, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end),

    awful.button({modkey}, 3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end)
})

local menu = require("hash.menu") ()
awful.mouse.append_global_mousebindings({
    awful.button({}, 1, function() menu:hide() end),
    awful.button({}, 3, function() menu:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
})

return {global_keys = globalkeys, client_keys = clientkeys, client_mouse = clientbuttons, global_buttons = globalbuttons}

