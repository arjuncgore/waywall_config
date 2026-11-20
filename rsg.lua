local waywall = require("waywall")
local config = require("main")

local plug = require("plug")
plug.setup({

    dir = "rsg_plugins",
    config = config,
    path = "~/.local/share/waywall/plugins",
})

config.actions["Shift-F8"] = function()
    print(plug.update_all())
end

waywall.listen("state", function()
    local state = waywall.state()
    if state.screen == "wall" then
        waywall.exec(os.getenv("HOME") .. "/mcsr/scripts/adw_jude.sh")
    end
end)

-- require("waywordle.init").setup(config)

return config
