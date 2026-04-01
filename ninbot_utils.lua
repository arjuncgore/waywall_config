local waywall = require("waywall")

local M = {}
local check_text = nil


local function send_input(command, params)
    local body = ""

    if params == nil then
        body = "{ " ..
            "\"command\": \"" .. command .. "\" " ..
            "}"
    else
        local parameter_parts = {}
        for k, v in pairs(params) do
            table.insert(parameter_parts,
                "\"" .. k .. "\": \"" .. tostring(v) .. "\"")
        end

        local parameters_string = table.concat(parameter_parts, ", ")
        body = "{ " ..
            "\"parameters\": { " .. parameters_string .. "}, " ..
            "\"command\": \"" .. command .. "\" " ..
            "}"
    end

    local tmpfile = os.getenv("HOME") .. "/.waywall_send_command.json"

    local f = io.open(tmpfile, "w")
    f:write(body)
    f:close()

    local exec_command = string.format(
        'curl -s -X POST http://localhost:52533/api/v1/send-command -H "Content-Type: application/json" --data-binary @%s',
        tmpfile
    )
    print(exec_command)

    waywall.exec(exec_command)
end


M.setup = function(config, cfg)
    -- waywall.listen("state", function()
    --     local state = waywall.state()
    --     if state.screen == "generating" then
    --         if check_text then
    --             check_text:close(); check_text = nil
    --         end
    --         check_text = waywall.text("Reset Ninjabrain Bot? [0/1]", { x = 200, y = 200, size = 4, color = "#FFFFFF" })
    --     end
    -- end)

    config.actions["P"] = function()
        send_input("toggle_lock", nil)
    end

    config.actions["*-C"] = function()
        if waywall.get_key("F3") then
            waywall.press_key("C")

            print("hererer")
            waywall.exec("echo wl-paste")
            waywall.exec("wl-paste > /home/arjungore/67")
            -- waywall.exec("curl -s -X POST http://localhost:52533/api/v1/send-command -H Content-Type: application/json")


            -- send_input("input_clipboard",
            --     { ["clipboardText"] = "/execute in minecraft:overworld run tp @s 0.00 0.00 0.00 0.00 0.00" })
        else
            return false
        end
    end
end

return M
