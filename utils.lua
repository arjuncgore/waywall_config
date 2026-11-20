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
local obj2 = nil
M.print_len2 = function(msg, length, opts)
    opts = opts or {
        x = 200,
        y = 400,
        size = 7,
        color = "#FFFFFF"
    }

    if obj2 then
        obj2:close()
        obj2 = nil
    end
    obj2 = waywall.text(msg, opts)
    if length ~= 0 then
        waywall.sleep(length * 1000)
        obj2:close()
        obj2 = nil
    end
    return
end

return M
