local waywall = require("waywall")
local config = require("main")

local plug = require("plug")
plug.setup({

    dir = "icarus_plugins",
    config = config,
    path = "~/.local/share/waywall/plugins",
})

config.actions["Shift-F8"] = function()
    print(plug.update_all())
end

-- require("waywordle.init").setup(config)

return config
