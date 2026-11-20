local waywall = require("waywall")
local helpers = require("waywall.helpers")

local crosshair_image = nil
local crosshair_active = nil

local example_cfg = {
    resx = 2560,
    resy = 1440,
    size = 30,
    key = "Shift-I",
    path = os.getenv("HOME") .. "/.config/waywall/resources/crosshair.png",
}

local M = {}

helpers.res_image(example_cfg.path, {
    dst = {
        x = (example_cfg.resx - example_cfg.size) / 2,
        y = (example_cfg.resy - example_cfg.size) / 2,
        w = example_cfg.size,
        h = example_cfg.size,
    }
}, 384, 16384
)

M.setup = function(config, cfg)
    cfg = cfg or example_cfg
    config.actions[cfg.key] = function()
        if crosshair_image then
            crosshair_image:close(); crosshair_image = nil
        end
        if crosshair_active then
            crosshair_active = false
        else
            crosshair_active = true
            crosshair_image = waywall.image(cfg.path, {
                dst = {
                    x = (cfg.resx - cfg.size) / 2,
                    y = (cfg.resy - cfg.size) / 2,
                    w = cfg.size,
                    h = cfg.size,
                }
            })
        end
    end
end

return M
