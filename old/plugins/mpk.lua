local waywall = require("waywall")

return function(cfg, config)
    config.actions[cfg.launch] = function()
        for _, key in ipairs({
            "Tab",
            "Space",
            "Tab",
            "Tab",
            "Tab",
            "Space",
            "Tab",
            "Space",
            "Space",
            "Tab",
            "Tab",
            "Tab",
            "Tab",
            "Tab",
            "Tab",
            "Space",
        }) do
            waywall.press_key(key)
        end
    end

    config.actions[cfg.quit] = function()
        for _, key in ipairs({
            "Esc",
            "Esc",
            "Tab",
            "Space",
            "Esc",
            "Tab",
            "Tab",
            "Tab",
            "Tab",
            "Tab",
            "Tab",
            "Tab",
            "Tab",
            "Space",
        }) do
            waywall.press_key(key)
        end
    end
end
