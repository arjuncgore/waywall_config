local waywall = require("waywall")
local helpers = require("waywall.helpers")

local M = {}

local obj = nil
M.print_len = function(msg, length, opts)
    opts = opts or {
        x = 200,
        y = 400,
        size = 7,
        color = "#FFFFFF"
    }

    if obj then
        obj:close()
        obj = nil
    end
    obj = waywall.text(msg, opts)
    if length ~= 0 then
        waywall.sleep(length * 1000)
        obj:close()
        obj = nil
    end
    return
end

return M
