pcall(require, "luarocks.loader")

local awful = require("awful")
require("awful.autofocus")
require("beautiful").init(awful.util.getdir("config") .. "/themes/neon/theme.lua")
require("menubar")
require("hash.errors")

terminal = "alacritty"
file_explorer = "thunar"
editor = "code"
modkey = "Mod4"
browser = "firefox"

tag_count = 6

require("hash.layouts")

awful.screen.connect_for_each_screen(
    function(s)
        require("hash.wallpaper") (s)
        require("hash.wibar.wibar") (s)
    end)

require("hash.rules")

require("hash.signals")
awful.spawn.with_shell("~/.config/awesome/autorun.sh")