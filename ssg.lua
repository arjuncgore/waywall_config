local waywall = require("waywall")
local helpers = require("waywall.helpers")

local remapped_kb = {
    ["MB4"] = "F3",
    ["CAPSLOCK"] = "RIGHTSHIFT",
}

local config = {
    input = {
        repeat_rate = 60,
        repeat_delay = 200,

        sensitivity = 8.0,
        confine_pointer = true,

        remaps = remapped_kb
    },
    theme = {
        background = "#303030ff",
        cursor_theme = "crosshair-cursors",
        cursor_icon = "crosshair",
        cursor_size = 24,
    },

    experimental = {
        tearing = true,
    },
}

config.actions = {
    ["Shift-O"] = waywall.toggle_fullscreen,
}

return config
