local waywall = require("waywall")
local config = require("main")
local u = require("utils")

local plug = require("plug")
plug.setup({
    config = config,
    path = "~/.local/share/waywall/plugins",
    plugins = {
        u.plugin("temporary_ninbot"),
        u.plugin("music_overlay", { overlay = false }),
        u.plugin("pie_lock"),
        u.plugin("command_line"),
    }
})

return config
