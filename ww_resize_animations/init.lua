local waywall = require("waywall")

local animating = false
local M = {}

local animate_resolution = function(w0, h0, w1, h1, speed, fps, restore)
    if animating then return end
    animating = true

    local step = 1 / fps
    local elapsed = 0
    local last_w, last_h = w0, h0

    while true do
        elapsed = elapsed + step
        local tau = math.min(speed * elapsed, 1)

        if tau >= 1 then
            if restore then
                waywall.set_resolution(0, 0)
            else
                waywall.set_resolution(w1, h1)
            end
            break
        end

        local e = (tau - 1) ^ 3 + 1
        local w = math.floor(w0 + (w1 - w0) * e)
        local h = math.floor(h0 + (h1 - h0) * e)

        if w ~= last_w or h ~= last_h then
            waywall.set_resolution(w, h)
            last_w, last_h = w, h
        end

        waywall.sleep(math.floor(step * 1000))
    end

    animating = false
end

M.setup = function(config, cfg)
    for _, resolution in pairs(cfg.resolutions) do
        config.actions[resolution.key] = function()
            local w0, h0 = waywall.active_res()
            if w0 == resolution.w and h0 == resolution.h then
                animate_resolution(w0, h0, cfg.normal_res.w, cfg.normal_res.h, cfg.speed, cfg.fps, true)
            else
                animate_resolution(w0, h0, resolution.w, resolution.h, cfg.speed, cfg.fps, false)
            end
        end
    end
end

return M
