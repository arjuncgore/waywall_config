local waywall = require("waywall")
local helpers = require("waywall.helpers")
local utils = require("utils")

local reload = function()
    print("sh -c \"echo 2 >> " .. os.getenv("HOME") .. "/.config/waywall/reload.lua\"")
    waywall.exec("sh -c \"echo 2 >> " .. os.getenv("HOME") .. "/.config/waywall/reload.lua\"")
end

local toggle_theme = function(x)
    if THEMES[x] then
        THEME = x
        local w, h = waywall.active_res()
        helpers.toggle_res(w, h)()
        helpers.toggle_res(w, h)()
    else
        return false
    end
end

local run_lua = function(line)
    local fn, err = load("return " .. line)
    if not fn then
        print(err)
        return nil
    end
    local response, result = pcall(fn)
    if not response then
        print(result)
        return nil
    end
    return result
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
        require("ww_command_line.init").setup(config, {
            start_key = "BACKSLASH",
            enter_key = "Return",
            look = {
                x = 200,
                y = 200,
                size = 7,
                color = "#FFFFFF",
                completion_color = "#444444"
            },
            add_inputs = {
                ["minus"] = "-",
                ["period"] = ".",
                ["shift-equal"] = "+",
            },
            commands = {
                ["quit"] = quit,
                ["mpk"] = mpk,
                ["solve"] = function(args)
                    local line = table.concat(args, " ")
                    print("line: " .. line)
                    local result = run_lua(line)
                    utils.print_len(result, 1)
                end,
                ["theme"] = function(args)
                    local args_str = table.concat(args, " ")
                    print("line: " .. args_str)
                    toggle_theme(tonumber(args_str))
                end,
                ["print"] = function(args)
                    local args_str = table.concat(args, " ", 2)
                    utils.print_len(args_str, args[1])
                end,
                ["reload"] = reload,
            },
            arbitrary_command = function(key)
                utils.print_len(key, 0.5)
            end,
            repeat_last_arbitrary = false
        })
    end,
    name = "ww_command_line",
    enabled = true,
    update_on_load = true,
}
