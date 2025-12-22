-- ==== CONFIG ====
local look         = {
    X = 20,
    Y = 1380,
    color = '#000000',
    size = 3,
}

-- ==== VARS ====
local waywall      = require("waywall")
local MK           = {}
local text_handle  = nil
local layout       = ""
local artist       = ""
local album        = ""
local title        = ""

-- ==== FUNCTIONS ====
MK.update_overlay  = function()
    local handle_artist = io.popen("playerctl metadata --format {{artist}}")
    local handle_album  = io.popen("playerctl metadata --format {{album}}")
    local handle_title  = io.popen("playerctl metadata --format {{title}}")

    if handle_artist then
        artist = handle_artist:read("*l")
        handle_artist:close()
    else
        artist = "not found"
    end
    if handle_album then
        album = handle_album:read("*l")
        handle_album:close()
    else
        album = "not found"
    end
    if handle_title then
        title = handle_title:read("*l")
        handle_title:close()
    else
        title = "not found"
    end
end
MK.enable_overlay  = function()
    MK.update_overlay()

    if text_handle then
        text_handle:close()
        text_handle = nil
    end

    -- ==== CONFIGURE THE LOOK OF THE OVERLAY HERE ====
    if artist ~= "" then
        layout = artist .. ": " .. title
    else
        layout = title
    end

    text_handle = waywall.text(layout,
        { x = look.X, y = look.Y, color = look.color, size = look.size })
end
MK.disable_overlay = function()
    if text_handle then
        text_handle:close(); text_handle = nil
    end
end


-- ==== ACTIONS ====
return function(cfg, config)
    waywall.listen("state", function()
        -- Update on state update
        if cfg.overlay then
            MK.enable_overlay()
        end
    end)


    config.actions[cfg.previous] = function()
        waywall.exec("playerctl previous")
        waywall.sleep(100)
        if cfg.overlay then
            MK.enable_overlay()
        end
    end

    config.actions[cfg.play_pause] = function()
        waywall.exec("playerctl play-pause")
        waywall.sleep(100)
        if cfg.overlay then
            MK.enable_overlay()
        end
    end

    config.actions[cfg.next] = function()
        waywall.exec("playerctl next")
        waywall.sleep(100)
        if cfg.overlay then
            MK.enable_overlay()
        end
    end

    config.actions[cfg.mute] = function()
        waywall.exec("obs-cmd --websocket obsws://localhost:4455/" .. cfg.obs_pw .. " audio toggle Mic/Aux")
    end
end
