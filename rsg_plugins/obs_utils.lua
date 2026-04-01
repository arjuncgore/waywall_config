local cfg = {
    overlay = true,
    look = {
        x = 70,
        y = 1280,
        color = '#9FA32B',
        size = 3,
    },
    ws = "obsws://localhost:4455/aU1Vt3NniDIy1hzh",
    toggle_mute = "F9",
    delay = 500,
    source = "Mic/Aux",
}

return {
    url = "https://github.com/arjuncgore/ww_obs_utils",
    config = function(config)
        require("obs_utils.init").setup(config, cfg)
    end,
    name = "obs_utils",
    update_on_load = false,
}
