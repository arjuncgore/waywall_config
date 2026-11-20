return function(opts)
    return {
        url = "https://github.com/arjuncgore/ww_music_overlay",
        config = function(config)
            require("music_overlay.init").setup(config, {
                overlay = opts.overlay,
                look = {
                    X = 70,
                    Y = 1280,
                    color = '#000000',
                    size = 3,
                    max_len = 30,
                },
                previous = "F10",
                play_pause = "F11",
                next = "F12",
                args = opts.args,
            })
        end,
        name = "music_overlay",
        update_on_load = false,
    }
end
