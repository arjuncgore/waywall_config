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

local pie_lock_cfg = {
    hotbar_keys = {
        { typed = "1", number = "1", alternative = "Y" },
        { typed = "2", number = "2", alternative = "J" },
        { typed = "3", number = "3", alternative = "M" },
        { typed = "4", number = "4", alternative = "N" },
        { typed = "5", number = "5", alternative = "F13" },
        { typed = "6", number = "6", alternative = "F14" },
        { typed = "7", number = "7", alternative = "F15" },
        { typed = "8", number = "8", alternative = "F16" },
        { typed = "9", number = "9", alternative = "F17" },
        { typed = "Z", number = "0", alternative = "U" },
    },
    text = {
        enabled = true,
        text = "unlocked",
        x = 2300,
        y = 1382,
        size = 4,
        color = "#9FA32B",
    },
    toggle_key = "*-GRAVE",
    remaps_table = NORMAL_REMAPS,
    locked_hook = function()
        PIE_MIRRORS = false
        waywall.set_resolution(0, 0)
    end,
    unlocked_hook = function()
        PIE_MIRRORS = true
        waywall.set_resolution(0, 0)
    end,
}

return {
    url = "https://github.com/arjuncgore/ww_rsg_utils",
    config = function(config)
        local rsg_utils = require("rsg_utils.init")
        rsg_utils.setup(config, cfg)
        NORMAL_REMAPS = rsg_utils.normal_remaps()
    end,
    name = "rsg_utils",
    update_on_load = true,
    dependencies = {
        {
            url = "https://github.com/arjuncgore/ww_pie_lock",
            config = function(config)
                local pie_lock = require("pie_lock.init")

                pie_lock.setup(config, pie_lock_cfg)
                NORMAL_REMAPS = pie_lock.normal_remaps()
            end,
            name = "pie_lock",
            update_on_load = true,
            enabled = true
        }
    }
}
