local config = require("init")

local plug = require("plug.init")
plug.setup({

    dir = "plugins",
    config = config,
})

print(plug.update({ name = "paceman_overlay" }))

return config
