-- ==== CONFIG ====
-- local primary_col = "#A9A8AF"
-- local secondary_col = "#877665"
-- local tertiary_col = "#574D43"
-- local shadow_col = "#8BB5C9"

local xkb_layout = "mc"

local tall_sens = 0.2
local normal_sens = 8.0

local keys = {
    thin           = "*-Alt_L",
    wide           = "*-B",
    tall           = "*-F4",

    toggle_ninbot  = "apostrophe",
    fullscreen     = "Shift-O",
    launch_paceman = "Shift-P",

    toggle_rebinds = "Insert",
    delete_worlds  = "End",

}


-- ==== PATHS ====
local home = os.getenv("HOME") .. "/"
local config_folder = home .. ".config/waywall/"

local background_path = config_folder .. "resources/background.png"
local tall_overlay_path = config_folder .. "resources/overlay_tall.png"
local wide_overlay_path = config_folder .. "resources/overlay_wide.png"
local thin_overlay_path = config_folder .. "resources/overlay_thin.png"
local overlay_path = config_folder .. "resources/measuring_overlay.png"

local pacem_path = home .. "mcsr/paceman-tracker-0.7.2.jar"
local nb_path = home .. "mcsr/Ninjabrain-Bot-1.5.1.jar"


-- ==== IMPORTS ====
local waywall = require("waywall")
local helpers = require("waywall.helpers")
local remaps = require("remaps")


-- ==== HELPERS ====
local thin_active = false
local remaps_active = true
local remaps_text = nil
local read_file = function(name)
    local file = io.open(config_folder .. name, "r")
    if file then
        local data = file:read("*a")
        file:close()
        return data
    else
        print("Error: File \"" .. name .. "\" not found.")
        return
    end
end
local is_ninb_running = function()
    local handle = io.popen("pgrep -f 'Ninjabrain.*jar'")
    if handle then
        local result = handle:read("*l")
        handle:close()
        return result ~= nil
    else
        print("Error: Command failed.")
        return
    end
end
local is_pacem_running = function()
    local handle = io.popen("pgrep -f 'paceman..*'")
    if handle then
        local result = handle:read("*l")
        handle:close()
        return result ~= nil
    else
        print("Error: Command failed.")
        return
    end
end


-- ==== MAIN CONFIG ====
local config = {
    input = {
        layout = xkb_layout,
        repeat_rate = 40,
        repeat_delay = 200,

        remaps = remaps.enabled,
        sensitivity = normal_sens,
        confine_pointer = true,
    },
    theme = {
        background_png = background_path,

        ninb_anchor = "topright",
        ninb_opacity = 1,
    },
    experimental = {
        debug = false,
        jit = false,
        tearing = false,
        scene_add_text = true,
    },
    shaders = {
        ["pie_chart"] = {
            vertex   = read_file("shaders/general.vert"),
            fragment = read_file("shaders/colors.glsl") .. "\n" .. read_file("shaders/pie_chart.frag"),
        },
        ["pie_border"] = {
            vertex   = read_file("shaders/general.vert"),
            fragment = read_file("shaders/colors.glsl") .. "\n" .. read_file("shaders/pie_border.frag"),
        },
        ["text"] = {
            vertex   = read_file("shaders/general.vert"),
            fragment = read_file("shaders/colors.glsl") .. "\n" .. read_file("shaders/text.frag"),
        },
        ["text_bg"] = {
            vertex   = read_file("shaders/general.vert"),
            fragment = read_file("shaders/colors.glsl") .. "\n" .. read_file("shaders/text_bg.frag"),
        },
        ["borders"] = {
            vertex   = read_file("shaders/general.vert"),
            fragment = read_file("shaders/colors.glsl") .. "\n" .. read_file("shaders/borders.frag"),
        },
    },
}


-- ==== MIRRORS ====
helpers.res_mirror( -- thin e_counter
    {
        src = { x = 1, y = 28, w = 49, h = 18 },
        dst = { x = 1500, y = 400, w = 343, h = 126 },
        depth = 2,
        shader = "text",
    },
    350, 1100
)
helpers.res_mirror( -- thin e_counter_bg
    {
        src = { x = 1, y = 28, w = 49, h = 18 },
        dst = { x = 1507, y = 407, w = 343, h = 126 },
        depth = 1,
        shader = "text_bg",
    },
    350, 1100
)
helpers.res_mirror( -- tall e_counter
    {
        src = { x = 1, y = 28, w = 49, h = 18 },
        dst = { x = 1500, y = 400, w = 343, h = 126 },
        depth = 2,
        shader = "text",
    },
    384, 16384
)
helpers.res_mirror( -- tall e_counter_bg
    {
        src = { x = 1, y = 28, w = 49, h = 18 },
        dst = { x = 1507, y = 407, w = 343, h = 126 },
        depth = 1,
        shader = "text_bg",
    },
    384, 16384
)
helpers.res_mirror( -- thin pie
    {
        src = { x = 21, y = 700, w = 318, h = 160 },
        dst = { x = 1517, y = 665, w = 367, h = 367 },
        depth = 2,
        shader = "pie_chart",
    },
    350, 1100
)
helpers.res_mirror( -- thin pie border
    {
        src = { x = 21, y = 700, w = 318, h = 160 },
        dst = { x = 1512, y = 660, w = 377, h = 377 },
        depth = 1,
        shader = "pie_border",
    },
    350, 1100
)
helpers.res_mirror( -- tall pie
    {
        src = { x = 54, y = 15984, w = 320, h = 160 },
        dst = { x = 1517, y = 665, w = 367, h = 367 },
        depth = 2,
        shader = "pie_chart",
    },
    384, 16384
)
helpers.res_mirror( -- tall pie border
    {
        src = { x = 54, y = 15984, w = 320, h = 160 },
        dst = { x = 1512, y = 660, w = 377, h = 377 },
        depth = 1,
        shader = "pie_border",
    },
    384, 16384
)
helpers.res_mirror( -- thin percentages
    {
        src = { x = 257, y = 879, w = 33, h = 25 },
        dst = { x = 1568, y = 1050, w = 264, h = 200 },
        depth = 2,
        shader = "text",
    },
    350, 1100
)
helpers.res_mirror( -- thin percentages_bg
    {
        src = { x = 257, y = 879, w = 33, h = 25 },
        dst = { x = 1576, y = 1058, w = 264, h = 200 },
        depth = 1,
        shader = "text_bg",
    },
    350, 1100
)
helpers.res_mirror( -- tall percentages
    {
        src = { x = 291, y = 16163, w = 33, h = 25 },
        dst = { x = 1568, y = 1050, w = 264, h = 200 },
        depth = 2,
        shader = "text",
    },
    384, 16384
)
helpers.res_mirror( -- tall percentages_bg
    {
        src = { x = 291, y = 16163, w = 33, h = 25 },
        dst = { x = 1576, y = 1058, w = 264, h = 200 },
        depth = 1,
        shader = "text_bg",
    },
    384, 16384
)
helpers.res_mirror( -- Eye Measure
    {
        src = { x = 177, y = 7902, w = 30, h = 580 },
        dst = { x = 94, y = 470, w = 900, h = 500 },
        depth = 2,
    },
    384, 16384
)


-- ==== IMAGES ====
helpers.res_image( -- Measuring Overlay
    overlay_path,
    {
        dst = { x = 94, y = 470, w = 900, h = 500 },
        depth = 3,
    },
    384, 16384
)
helpers.res_image( -- Thin Overlay
    thin_overlay_path,
    {
        dst = { x = 0, y = 0, w = 2560, h = 1440 },
        depth = 3,
        shader = "borders",
    },
    350, 1100
)
helpers.res_image( -- Wide Overlay
    wide_overlay_path,
    {
        dst = { x = 0, y = 0, w = 2560, h = 1440 },
        depth = 3,
        shader = "borders",
    },
    2560, 400
)
helpers.res_image( -- Tall Overlay
    tall_overlay_path,
    {
        dst = { x = 0, y = 0, w = 2560, h = 1440 },
        depth = 3,
        shader = "borders",
    },
    384, 16384
)

-- ==== RESOLUTIONS ====
local resolutions = {
    thin = function()
        if remaps_active then
            local act_width, act_height = waywall.active_res()
            if act_width == 350 and act_height == 1100 then
                thin_active = false
                os.execute('echo "' .. 0 .. 'x' .. 0 .. '" > ~/.resize_state')
            else
                thin_active = true
                os.execute('echo "' .. 360 .. 'x' .. 1110 .. '" > ~/.resize_state')
            end
            waywall.sleep(17)
            helpers.ingame_only(helpers.toggle_res(350, 1100))()
        else
            return false
        end
    end,
    wide = function()
        if remaps_active then
            if not waywall.get_key("F3") then
                local act_width, act_height = waywall.active_res()
                if act_width == 2560 and act_height == 400 then
                    os.execute('echo "' .. 0 .. 'x' .. 0 .. '" > ~/.resize_state')
                else
                    os.execute('echo "' .. 2560 .. 'x' .. 410 .. '" > ~/.resize_state')
                end
                waywall.sleep(17)
                helpers.ingame_only(helpers.toggle_res(2560, 400))()
                thin_active = false
            else
                return false
            end
        else
            return false
        end
    end,
    tall = function()
        if remaps_active then
            if not waywall.get_key("F3") then
                local act_width, act_height = waywall.active_res()
                if act_width == 384 and act_height == 16384 then
                    thin_active = false
                    os.execute('echo "' .. 0 .. 'x' .. 0 .. '" > ~/.resize_state')
                else
                    os.execute('echo "' .. 394 .. 'x' .. 16384 .. '" > ~/.resize_state')
                end
                waywall.sleep(17)
                if thin_active then
                    helpers.toggle_res(350, 1100)()
                    helpers.toggle_res(384, 16384)()
                else
                    helpers.toggle_res(384, 16384, tall_sens)()
                end
                thin_active = false
            else
                return false
            end
        else
            return false
        end
    end,
}


-- ==== CONFIG ACTIONS ====
config.actions = {
    [keys.thin] = resolutions.thin,
    [keys.wide] = resolutions.wide,
    [keys.tall] = resolutions.tall,

    [keys.fullscreen] = waywall.toggle_fullscreen,

    [keys.toggle_ninbot] = function()
        if not is_ninb_running() then
            waywall.exec("java -Dawt.useSystemAAFontSettings=on -jar " .. nb_path)
            waywall.show_floating(true)
        else
            helpers.toggle_floating()
        end
    end,

    ["*-C"] = function()
        if waywall.get_key("F3") then
            waywall.show_floating(true)
            return false
        else
            return false
        end
    end,

    [keys.launch_paceman] = function()
        if not is_pacem_running() then
            waywall.exec("java -jar " .. pacem_path .. " --nogui")
        end
        print(is_pacem_running())
    end,

    [keys.toggle_rebinds] = function()
        if remaps_text then
            remaps_text:close(); remaps_text = nil
        end
        if remaps_active then
            remaps_active = false
            waywall.set_remaps(remaps.disabled)
            waywall.set_keymap({ layout = "us" })
            remaps_text = waywall.text("Chat Mode", { x = 50, y = 1350, color = "#9FA32B", size = 3 })
        else
            remaps_active = true
            waywall.set_remaps(remaps.enabled)
            waywall.set_keymap({ layout = xkb_layout })
        end
    end,

}

return config
