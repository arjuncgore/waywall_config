return {
    url = "https://github.com/arjuncgore/ww_temporary_ninbot",
    config = function(config)
        require("temporary_ninbot.init").setup(config, {
            timer_length = 0
        })
    end,
    dependencies = {
        {
            url = "https://github.com/arjuncgore/waywall-floating",
            name = "waywall-floating",
        }
    },
    name = "temporary_ninbot",
    update_on_load = false,
}
