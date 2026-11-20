local waywall = require("waywall")
local config = require("main")

local plug = require("plug")
plug.setup({

    dir = "ranked_plugins",
    config = config,
    path = "~/.local/share/waywall/plugins",
})

config.actions["Shift-F8"] = function()
    print(plug.update_all())
end

-- require("204wayt.init").setup(config, nil)

return config
