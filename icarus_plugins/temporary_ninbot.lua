return {
    url = "https://github.com/arjuncgore/ww_temporary_ninbot",
    config = function(config)
        require("temporary_ninbot.init").setup(config, {
            timer_length = 30
        })
    end,
    name = "temporary_ninbot",
    update_on_load = false,
}
