local waywall = require("waywall")
local helpers = require("waywall.helpers")

local M = {}

M.send = function(config)
    -- ========================== BEGIN TEST


    -- local binds = {
    --     decrement = "*-comma",
    --     increment = "*-period",
    --     undo = "*-bracketleft",
    --     redo = "*-bracketright",
    --     reset = "*-equal",
    --     lock = "*-grave",
    -- }
    --
    -- for action, bind in pairs(binds) do
    --     config.actions[bind] = function()
    --         waywall.exec("ninjabrain-bot-xwayland " .. action)
    --     end
    -- end

    -- require("ww_resize_animations.init").setup(config, {
    --     speed = 4,
    --     fps = 20,
    --     normal_res = { w = 2560, h = 1440 },
    --     resolutions = {
    --         { key = "*-L", w = 350, h = 1100 }
    --     }
    -- })

    -- ========================== END TEST
end

return M
