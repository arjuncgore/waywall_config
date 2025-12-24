local config = require("init")

local plug = require("plug.init")
plug.setup({

    dir = "ranked_plugins",
    config = config,
    path = "~/.local/waywall",
})

return config
