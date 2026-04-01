local waywall = require("waywall")
local helpers = require("waywall.helpers")

local M = {}

M.send = function(config)
    -- ========================== BEGIN TEST

    require("ninbot_utils").setup(config, nil)

    local mpk = function()
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

    local example_cfg = {
        start_key = "BACKSLASH",
        look = {
            x = 200,
            y = 200,
            size = 7,
            color = "#FFFFFF"
        },
        commands = {
            ["mpk"] = function() mpk() end,
            ["quit"] = function() quit() end,
            ["test1"] = function() print("testing: test1") end,
            ["test2"] = function() print("testing: test2") end,
        },
        arbitrary_command = function(key)
            local t = nil
            t = waywall.text(key, { x = 500, y = 500, size = 4 })
            waywall.sleep(500)
            t:close()
            t = nil
        end,
    }



    require("ww_command_line.init").setup(config, example_cfg)

    -- ========================== END TEST
end

return M
