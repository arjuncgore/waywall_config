local config = require("init")
local waywall = require("waywall")

local plug = require("plug.init")
plug.setup({

    dir = "ranked_plugins",
    config = config,
    path = "~/.local/waywall",
})

return config
