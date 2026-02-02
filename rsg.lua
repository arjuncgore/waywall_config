local waywall = require("waywall")
local config = require("init")

local plug = require("plug.init")
plug.setup({

    dir = "rsg_plugins",
    config = config,
    path = "~/.local/waywall",
})

config.actions["F8"] = function()
    print(plug.update_all())
end

config.actions["End"] = function()
    waywall.exec("/home/arjungore/mcsr/scripts/adw.sh")
end


return config
