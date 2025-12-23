local cfg = {
    fast_reset = "MB5",
    main_reset = "F6",
    thin_res = { w = 350, h = 1100 }
}

return {
    url = "https://github.com/arjuncgore/ww_rsg_utils",
    config = function(config)
        require("rsg_utils.init").setup(config, cfg)
    end,
    name = "rsg_utils",
    update_on_load = true,
}
