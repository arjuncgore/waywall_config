local M = {}
local waywall = require("waywall")

M.res_mirror = function(options, width, height)
    local mirror = nil

    waywall.listen("load", function()
        local active_width, active_height = waywall.active_res()

        if active_width == width and active_height == height then
            mirror = waywall.mirror(options)
        end
    end)

    return waywall.listen("resolution", function()
        local active_width, active_height = waywall.active_res()

        if active_width == width and active_height == height then
            if mirror then
                return
            end

            mirror = waywall.mirror(options)
        else
            if not mirror then
                return
            end

            mirror:close()
            mirror = nil
        end
    end)
end


M.res_image = function(path, options, width, height)
    local image = nil

    waywall.listen("load", function()
        local active_width, active_height = waywall.active_res()

        if active_width == width and active_height == height then
            image = waywall.image(path, options)
        end
    end)

    return waywall.listen("resolution", function()
        local active_width, active_height = waywall.active_res()

        if active_width == width and active_height == height then
            if image then
                return
            end

            image = waywall.image(path, options)
        else
            if not image then
                return
            end

            image:close()
            image = nil
        end
    end)
end

M.background = function(path, options)
    local image = nil

    waywall.listen("load", function()
        local active_width, active_height = waywall.active_res()

        if active_width ~= 0 or active_height ~= 0 then
            image = waywall.image(path, options)
        end
    end)

    return waywall.listen("resolution", function()
        local active_width, active_height = waywall.active_res()

        if active_width ~= 0 or active_height ~= 0 then
            if image then
                return
            end

            image = waywall.image(path, options)
        else
            if not image then
                return
            end

            image:close()
            image = nil
        end
    end)
end

return M
