local waywall = require("waywall")
local config = require("main")
local u = require("modules.utils")

local plug = require("plug")
plug.setup({
    config = config,
    path = "~/.local/share/waywall/plugins",
    plugins = {
        u.plugin("temporary_ninbot"),
        u.plugin("music_overlay", { overlay = true }),
        u.plugin("rsg_utils", { dependencies = { u.plugin("pie_lock") } }),
        u.plugin("command_line"),
    }
})

waywall.listen("state", function()
    local state = waywall.state()
    if state.screen == "wall" then
        waywall.exec(os.getenv("HOME") .. "/mcsr/scripts/adw_jude.sh")
    end
end)

return config
