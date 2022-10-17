local gears = require("gears")

local function set_shape(c)
    -- Gets a rounded rectangle shape
    local function custom_shape(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 8)
    end

    c.shape = custom_shape
end

return set_shape