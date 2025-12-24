local config = require("init")

local plug = require("plug.init")
plug.setup({

    dir = "plugins",
    config = config,
    path = "~/.local/waywall",
})

config.actions["F8"] = function()
    print(plug.update_all())
end

return config
