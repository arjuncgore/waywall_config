local config = require("init")
local waywall = require("waywall")

local plug = require("plug.init")
plug.setup({

    dir = "ranked_plugins",
    config = config,
    path = "~/.local/waywall",
})

-- require("waywordle.init").setup(config)

-- require("204wayt.init").setup(config, nil)

-- require("nb_keys").setup(config)

return config
