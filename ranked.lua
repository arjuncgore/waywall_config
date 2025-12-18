-- ==== CONFIG ====
local primary_col = "#272420"
local secondary_col = "#877665"
local tertiary_col = "#574D43"
local shadow_col = "#CCCCCC"

local tall_sens = 0.2220668274200729
local normal_sens = 8.02844218054619

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

-- ==== PLUGINS CONFIG ====
local plugins = {
    {
        name = "media_keys",
        cfg = {
            overlay = false,
            mute = "F9",
            previous = "F10",
            play_pause = "F11",
            next = "F12",
            obs_pw = "aU1Vt3NniDIy1hzh",
        }
    },
    -- {
    --     name = "mpk",
    --     cfg = {
    --         launch = "8",
    --         quit = "9",
    --     }
    -- }
}


-- ==== PATHS ====
local home = os.getenv("HOME") .. "/"
local config_folder = home .. ".config/waywall/"

local background_path = config_folder .. "resources/background.png"
local tall_overlay_path = config_folder .. "resources/overlay_tall.png"
local wide_overlay_path = config_folder .. "resources/overlay_wide.png"
local thin_overlay_path = config_folder .. "resources/overlay_thin.png"
local overlay_path = config_folder .. "resources/measuring_overlay.png"

local pacem_path = home .. "mcsr/paceman-tracker-0.7.1.jar"
local nb_path = home .. "mcsr/Ninjabrain-Bot-1.5.1.jar"


-- ==== IMPORTS ====
local waywall = require("waywall")
local helpers = require("waywall.helpers")
local remaps = require("remaps")


-- ==== HELPERS ====
local thin_active = false
local remaps_active = true
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
        layout = "us",
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
            vertex = read_file("shaders/pie_chart.vert"),
            fragment = read_file("shaders/pie_chart.frag"),
        },
        ["thin_percentages"] = {
            vertex = read_file("shaders/percentages.vert"),
            fragment = read_file("shaders/thin_percentages.frag"),
        },
        ["tall_percentages"] = {
            vertex = read_file("shaders/percentages.vert"),
            fragment = read_file("shaders/tall_percentages.frag"),
        },
    },
}


-- ==== MIRRORS ====
helpers.res_mirror( -- thin e_counter
    {
        src = { x = 1, y = 28, w = 49, h = 18 },
        dst = { x = 1500, y = 400, w = 343, h = 126 },
        depth = 1,
        color_key = { input = "#dddddd", output = primary_col },
    },
    350, 1100
)
helpers.res_mirror( -- tall e_counter
    {
        src = { x = 1, y = 28, w = 49, h = 18 },
        dst = { x = 1500, y = 400, w = 343, h = 126 },
        depth = 1,
        color_key = { input = "#dddddd", output = primary_col },
    },
    384, 16384
)
helpers.res_mirror( -- thin pie
    {
        src = { x = 21, y = 700, w = 318, h = 160 },
        dst = { x = 1517, y = 665, w = 367, h = 367 },
        depth = 1,
        shader = "pie_chart",
    },
    350, 1100
)
helpers.res_mirror( -- tall pie
    {
        src = { x = 54, y = 15984, w = 320, h = 160 },
        dst = { x = 1517, y = 665, w = 367, h = 367 },
        depth = 1,
        shader = "pie_chart",
    },
    384, 16384
)
helpers.res_mirror( -- thin percentages
    {
        src = { x = 257, y = 879, w = 33, h = 25 },
        dst = { x = 1568, y = 1050, w = 264, h = 200 },
        depth = 1,
        shader = "thin_percentages",
    },
    350, 1100
)
helpers.res_mirror( -- tall percentages
    {
        src = { x = 291, y = 16163, w = 33, h = 25 },
        dst = { x = 1568, y = 1050, w = 264, h = 200 },
        depth = 1,
        shader = "tall_percentages",
    },
    384, 16384
)
helpers.res_mirror( -- Eye Measure
    {
        src = { x = 177, y = 7902, w = 30, h = 580 },
        dst = { x = 94, y = 470, w = 900, h = 500 },
        depth = 1,
    },
    384, 16384
)



-- ==== IMAGES ====
helpers.res_image( -- Measuring Overlay
    overlay_path,
    {
        dst = { x = 94, y = 470, w = 900, h = 500 },
        depth = 2,
    },
    384, 16384
)

helpers.res_image( -- Thin Overlay
    thin_overlay_path,
    {
        dst = { x = 0, y = 0, w = 2560, h = 1440 },
        depth = 2,
    },
    350, 1100
)

helpers.res_image( -- Wide Overlay
    wide_overlay_path,
    {
        dst = { x = 0, y = 0, w = 2560, h = 1440 },
        depth = 2,
    },
    2560, 400
)

helpers.res_image( -- Tall Overlay
    tall_overlay_path,
    {
        dst = { x = 0, y = 0, w = 2560, h = 1440 },
        depth = 2,
    },
    384, 16384
)

-- ==== RESOLUTIONS ====
local resolutions = {
    thin = function()
        if remaps_active then
            helpers.ingame_only(helpers.toggle_res(350, 1100))()
            local act_width, act_height = waywall.active_res()
            if act_width == 350 and act_height == 1100 then
                thin_active = true
            else
                thin_active = false
            end
        end
    end,
    wide = function()
        if remaps_active then
            if not waywall.get_key("F3") then
                helpers.ingame_only(helpers.toggle_res(2560, 400))()
                thin_active = false
            else
                return false
            end
        end
    end,
    tall = function()
        if remaps_active then
            if not waywall.get_key("F3") then
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
    end,

    [keys.toggle_rebinds] = function()
        if remaps_active then
            remaps_active = false
            waywall.set_remaps(remaps.disabled)
            waywall.set_keymap({ layout = "us" })
        else
            remaps_active = true
            waywall.set_remaps(remaps.enabled)
            waywall.set_keymap({ layout = "mc" })
        end
    end,

}

-- ==== PLUGINS ====
for _, p in ipairs(plugins) do
    require("plugins." .. p.name)(p.cfg, config)
end

return config
