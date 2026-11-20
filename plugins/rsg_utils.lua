local waywall = require("waywall")

local cfg = {
    fast_reset = "MB5",
    main_reset = "F6",
    thin_res = { w = 350, h = 1440 },
    text = {
        enabled = true,
        text = "reset mode",
        x = 10,
        y = 1382,
        size = 4,
        color = "#9FA32B"
    }
}

return function(opts)
    return {
        url = "https://github.com/arjuncgore/ww_rsg_utils",
        config = function(config)
            local rsg_utils = require("rsg_utils.init")
            rsg_utils.setup(config, cfg)
            NORMAL_REMAPS = rsg_utils.normal_remaps()
        end,
        name = "rsg_utils",
        update_on_load = true,
        dependencies = opts.dependencies
    }
end
