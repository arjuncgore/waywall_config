local waywall = require("waywall")
local config = require("init")

local plug = require("plug.init")
plug.setup({

    dir = "rsg_plugins",
    config = config,
    path = "~/.local/waywall",
})

-- config.actions["F8"] = function()
--     print(plug.update_all())
-- end


config.actions["Shift-K"] = function()
    waywall.exec("pkill paceman")
end

-- require("waywordle.init").setup(config)

return config
