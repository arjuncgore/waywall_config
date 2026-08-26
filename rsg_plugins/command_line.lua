local waywall = require("waywall")
local helpers = require("waywall.helpers")

local quit = function()
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

local mpk = function()
    if waywall.state().screen == "inworld" then
        quit()
        waywall.sleep(300)
    end
    if waywall.state().screen == "title" then
        for _, key in ipairs({
            "Esc",
            "Esc",
            "Tab",
            "Space",
            "Backspace",
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
            waywall.sleep(10)
        end
    end
end

return {
    url = "https://github.com/arjuncgore/ww_command_line",
    config = function(config)
        require("command_line.init").setup(config, {
            start_key = "BACKSLASH",
            enter_key = "Return",
            look = {
                x = 200,
                y = 200,
                size = 7,
                color = "#FFFFFF"
            },
            commands = {
                ["quit"] = quit,
                ["mpk"] = mpk,
            },
            arbitrary_command = function(key)
                print(key)
            end,
        })
    end,
    name = "command_line",
    update_on_load = true,
}
