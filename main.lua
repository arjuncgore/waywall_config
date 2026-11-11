-- ==== CONFIG ====
-- local primary_col = "#A9A8AF"
-- local secondary_col = "#877665"
-- local tertiary_col = "#574D43"
-- local shadow_col = "#8BB5C9"

local xkb_layout  = "mc"

local normal_sens = 8.0
local tall_sens   = 0.2

-- resolutions
NORMAL            = { x = 2560, y = 1440 }
THIN              = { x = 350, y = 1440 }
WIDE              = { x = 2560, y = 400 }
TALL              = { x = 384, y = 16384 }
ED                = { x = 1500, y = 1440 }


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

THEME      = 1

THEMES     = {
    {
        description = "Finn and Jake",
        colors = {
            border_color  = "#9FA3B2",
            pie1_color    = "#3DC9A7",
            pie2_color    = "#E6B057",
            pie3_color    = "#F26B5E",
            text_color    = "#F2F2F7",
            text_bg_color = "#0A0A12"
        },
        measuring_overlay = os.getenv("HOME") .. "/.config/waywall/resources/faj/measuring_overlay.png",
        background = os.getenv("HOME") .. "/.config/waywall/resources/faj/background.png",
    },
    {
        description = "Simon and Marcy",
        colors = {
            border_color  = "#272420",
            pie1_color    = "#877665",
            pie2_color    = "#574D43",
            pie3_color    = "#272420",
            text_color    = "#272420",
            text_bg_color = "#CCCCCC"
        },
        measuring_overlay = os.getenv("HOME") .. "/.config/waywall/resources/sam/measuring_overlay.png",
        background = os.getenv("HOME") .. "/.config/waywall/resources/sam/background.png",
    },
    {
        description = "Lock in",
        colors = {
            border_color  = "#FFFFFF",
            pie1_color    = "#E446C4",
            pie2_color    = "#46CE66",
            pie3_color    = "#EC6E4E",
            text_color    = "#FFFFFF",
            text_bg_color = "#333333"
        },
        measuring_overlay = os.getenv("HOME") .. "/.config/waywall/resources/lockin/measuring_overlay.png",
        background = os.getenv("HOME") .. "/.config/waywall/resources/lockin/background.png",
    },
}


-- ==== PATHS ====
local home = os.getenv("HOME") .. "/"
local config_folder = home .. ".config/waywall/"

local tall_overlay_path = config_folder .. "resources/overlay_tall.png"
local wide_overlay_path = config_folder .. "resources/overlay_wide.png"
local thin_overlay_path = config_folder .. "resources/overlay_thin.png"
local ed_overlay_path = config_folder .. "resources/overlay_ed.png"

local pacem_path = home .. "mcsr/paceman-tracker-0.7.2.jar"
local nb_path = home .. "mcsr/Ninjabrain-Bot-1.5.2.jar"


-- ==== IMPORTS ====
local waywall  = require("waywall")
local helpers  = require("waywall.helpers")
local helpers2 = require("helpers_2")
local remaps   = require("remaps")


-- ==== HELPERS ====
NORMAL_REMAPS = remaps.enabled
PIE_MIRRORS = true
local thin_active = false
local remaps_active = true
local remaps_text = nil
local paceman_text = nil
Random_Ben = function()
    local path = os.getenv("HOME") .. "/storage/audio/ben/"
    local audios = { "ben", "hohoho", "no", "phone", "ugh", "yes" }
    local idx = math.floor((math.random() * 6 + 1))
    local filename = path .. audios[idx] .. ".mp3"
    waywall.exec("mpv --no-video " .. filename)
end
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
    -- local handle = io.popen("pgrep -f 'Ninjabrain.*jar'")
    local handle = io.popen("pgrep -f 'ninjabrain-bot'")
    -- local handle = io.popen("pgrep -f 'ninjabrain-bot-xwayland'")
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

local hex_to_vec = function(var, hex)
    hex = hex:match("^%s*(.-)%s*$")
    hex = hex:gsub("^#", "")
    hex = hex:lower()

    local hex_segs = {}
    for pair in hex:gmatch("%x%x") do
        table.insert(hex_segs, pair)
    end
    if #hex_segs == 3 then
        table.insert(hex_segs, "ff")
    end

    local r = tonumber(hex_segs[1], 16) / 255
    local g = tonumber(hex_segs[2], 16) / 255
    local b = tonumber(hex_segs[3], 16) / 255
    local a = tonumber(hex_segs[4], 16) / 255

    return "const vec4 " .. var .. " = vec4(" .. r .. ", " .. g .. ", " .. b .. ", " .. a .. ");"
end


local compile_colors = function(colors)
    local output = "precision highp float;\n\n"

    for name, hex in pairs(colors) do
        output = output .. hex_to_vec(name, hex) .. "\n\n"
    end

    return output
end


-- ==== MAIN CONFIG ====
local config = {
    input = {
        layout = xkb_layout,
        options = "caps:none",
        repeat_rate = 60,
        repeat_delay = 200,

        remaps = remaps.enabled,
        sensitivity = normal_sens,
        confine_pointer = true,
    },
    theme = {
        ninb_anchor = {
            position = "topleft",
            x = 10,
            y = 50
        },
        ninb_opacity = 1,
        cursor_theme = "crosshair-cursors",
        cursor_icon = "crosshair",
        cursor_size = 24,
    },
    experimental = {
        debug = false,
        jit = false,
        tearing = true,
    },
}


-- ==== MIRRORS ====
config.shaders = {}
for idx, theme in ipairs(THEMES) do
    local pie_chart = theme.description .. ": pie_chart"
    local pie_border = theme.description .. ": pie_border"
    local text = theme.description .. ": text"
    local text_bg = theme.description .. ": text_bg"
    local borders = theme.description .. ": borders"
    local background_path = theme.background
    local measuring_overlay = theme.measuring_overlay
    config.shaders[pie_chart] = {
        vertex   = read_file("shaders/general.vert"),
        fragment = compile_colors(theme.colors) .. read_file("shaders/pie_chart.frag"),
    }
    config.shaders[pie_border] = {
        vertex   = read_file("shaders/general.vert"),
        fragment = compile_colors(theme.colors) .. read_file("shaders/pie_border.frag"),
    }
    config.shaders[text] = {
        vertex   = read_file("shaders/general.vert"),
        fragment = compile_colors(theme.colors) .. read_file("shaders/text.frag"),
    }
    config.shaders[text_bg] = {
        vertex   = read_file("shaders/general.vert"),
        fragment = compile_colors(theme.colors) .. read_file("shaders/text_bg.frag"),
    }
    config.shaders[borders] = {
        vertex   = read_file("shaders/general.vert"),
        fragment = compile_colors(theme.colors) .. read_file("shaders/borders.frag"),
    }
    helpers2.res_mirror( -- thin e_counter
        {
            src = { x = 1, y = 28, w = 49, h = 18 },
            dst = { x = 1500, y = 400, w = 343, h = 126 },
            depth = 2,
            shader = text,
        },
        THIN.x, THIN.y,
        function() return THEME == idx end
    )
    helpers2.res_mirror( -- thin e_counter_bg
        {
            src = { x = 1, y = 28, w = 49, h = 18 },
            dst = { x = 1507, y = 407, w = 343, h = 126 },
            depth = 1,
            shader = text_bg,
        },
        THIN.x, THIN.y,
        function() return THEME == idx end
    )
    helpers2.res_mirror( -- tall e_counter
        {
            src = { x = 1, y = 28, w = 49, h = 18 },
            dst = { x = 1500, y = 400, w = 343, h = 126 },
            depth = 2,
            shader = text,
        },
        TALL.x, TALL.y,
        function() return THEME == idx end
    )
    helpers2.res_mirror( -- tall e_counter_bg
        {
            src = { x = 1, y = 28, w = 49, h = 18 },
            dst = { x = 1507, y = 407, w = 343, h = 126 },
            depth = 1,
            shader = text_bg,
        },
        TALL.x, TALL.y,
        function() return THEME == idx end
    )
    helpers2.res_mirror( -- thin pie
        {
            src = { x = 21, y = 1040, w = 318, h = 160 },
            dst = { x = 1517, y = 665, w = 367, h = 367 },
            depth = 2,
            shader = pie_chart,
        },
        THIN.x, THIN.y,
        function() return THEME == idx end
    )
    helpers2.res_mirror( -- thin pie border
        {
            src = { x = 21, y = 1040, w = 318, h = 160 },
            dst = { x = 1512, y = 660, w = 377, h = 377 },
            depth = 1,
            shader = pie_border,
        },
        THIN.x, THIN.y,
        function() return THEME == idx end
    )
    helpers2.res_mirror( -- tall pie
        {
            src = { x = 54, y = 15984, w = 320, h = 160 },
            dst = { x = 1517, y = 665, w = 367, h = 367 },
            depth = 2,
            shader = pie_chart,
        },
        TALL.x, TALL.y,
        function() return THEME == idx end
    )
    helpers2.res_mirror( -- tall pie border
        {
            src = { x = 54, y = 15984, w = 320, h = 160 },
            dst = { x = 1512, y = 660, w = 377, h = 377 },
            depth = 1,
            shader = pie_border,
        },
        TALL.x, TALL.y,
        function() return THEME == idx end
    )
    helpers2.res_mirror( -- thin percentages
        {
            src = { x = 257, y = 1219, w = 33, h = 25 },
            dst = { x = 1568, y = 1050, w = 264, h = 200 },
            depth = 2,
            shader = text,
        },
        THIN.x, THIN.y,
        function() return THEME == idx end
    )
    helpers2.res_mirror( -- thin percentages_bg
        {
            src = { x = 257, y = 1219, w = 33, h = 25 },
            dst = { x = 1576, y = 1058, w = 264, h = 200 },
            depth = 1,
            shader = text_bg,
        },
        THIN.x, THIN.y,
        function() return THEME == idx end
    )
    helpers2.res_mirror( -- tall percentages
        {
            src = { x = 291, y = 16163, w = 33, h = 25 },
            dst = { x = 1568, y = 1050, w = 264, h = 200 },
            depth = 2,
            shader = text,
        },
        TALL.x, TALL.y,
        function() return THEME == idx end
    )
    helpers2.res_mirror( -- tall percentages_bg
        {
            src = { x = 291, y = 16163, w = 33, h = 25 },
            dst = { x = 1576, y = 1058, w = 264, h = 200 },
            depth = 1,
            shader = text_bg,
        },
        TALL.x, TALL.y,
        function() return THEME == idx end
    )
    helpers2.res_mirror( -- Eye Measure
        {
            src = { x = 177, y = 7902, w = 30, h = 580 },
            dst = { x = 94, y = 470, w = 900, h = 500 },
            depth = 2,
        },
        TALL.x, TALL.y,
        function() return THEME == idx end
    )

    for i = 0, 3, 1 do
        helpers2.res_mirror( -- mob_spawner
            {
                src = { x = 2467, y = 1219 + 8 * i, w = 33, h = 9 },
                dst = { x = 2258, y = 1080, w = 33 * 8, h = 9 * 8 },
                depth = 3,
                color_key = { input = "#4de1ca", output = "#E6B057" }
            },
            0, 0,
            function() return THEME == idx end
        )
        helpers2.res_mirror( -- mob_spawner
            {
                src = { x = 2467, y = 1219 + 8 * i, w = 33, h = 9 },
                dst = { x = 2258 + 8, y = 1080 + 8, w = 33 * 8, h = 9 * 8 },
                depth = 2,
                color_key = { input = "#4de1ca", output = "#000000" }
            },
            0, 0,
            function() return THEME == idx end
        )
    end
    helpers2.res_mirror( -- Chat
        {
            src = { x = 53, y = 1391, w = 81, h = 9 },
            dst = { x = 200, y = 1080, w = 81 * 8, h = 9 * 8 },
            depth = 3,
            color_key = { input = "#FBFBFB", output = theme.colors.text_color }
        },
        THIN.x, THIN.y,
        function() return THEME == idx end
    )
    helpers2.res_mirror( -- Chat Shadow
        {
            src = { x = 53, y = 1391, w = 81, h = 9 },
            dst = { x = 200 + 8, y = 1080 + 8, w = 81 * 8, h = 9 * 8 },
            depth = 2,
            color_key = { input = "#FBFBFB", output = theme.colors.text_bg_color },
        },
        THIN.x, THIN.y,
        function() return THEME == idx end
    )


    -- ==== IMAGES ====
    helpers2.background( -- Background
        background_path,
        {
            dst = { x = 0, y = 0, w = 2560, h = 1440 },
            depth = -1,
        },
        function() return THEME == idx end
    )
    helpers2.res_image( -- Measuring Overlay
        measuring_overlay,
        {
            dst = { x = 94, y = 470, w = 900, h = 500 },
            depth = 3,
        },
        TALL.x, TALL.y,
        function() return THEME == idx end
    )
    helpers2.res_image( -- Thin Overlay
        thin_overlay_path,
        {
            dst = { x = 0, y = 0, w = 2560, h = 1440 },
            depth = 3,
            shader = borders,
        },
        THIN.x, THIN.y,
        function() return THEME == idx end
    )
    helpers2.res_image( -- ED Overlay
        ed_overlay_path,
        {
            dst = { x = 0, y = 0, w = 2560, h = 1440 },
            depth = 3,
            shader = borders,
        },
        ED.x, ED.y,
        function() return THEME == idx end
    )
    helpers2.res_image( -- Wide Overlay
        wide_overlay_path,
        {
            dst = { x = 0, y = 0, w = 2560, h = 1440 },
            depth = 3,
            shader = borders,
        },
        WIDE.x, WIDE.y,
        function() return THEME == idx end
    )
    helpers2.res_image( -- Tall Overlay
        tall_overlay_path,
        {
            dst = { x = 0, y = 0, w = 2560, h = 1440 },
            depth = 3,
            shader = borders,
        },
        TALL.x, TALL.y,
        function() return THEME == idx end
    )
end
-- ==== RESOLUTIONS ====
local resolutions = {
    thin_old = helpers.ingame_only(function()
        if remaps_active then
            local act_width, act_height = waywall.active_res()
            if act_width == THIN.x and act_height == THIN.y then
                thin_active = false
                os.execute('echo "' .. 0 .. 'x' .. 0 .. '" > ~/.resize_state')
            else
                thin_active = true
                os.execute('echo "' .. THIN.x + 10 .. 'x' .. THIN.y .. '" > ~/.resize_state')
            end
            waywall.sleep(17)
            helpers.toggle_res(THIN.x, THIN.y)()
        else
            return false
        end
    end),

    thin = function()
        if remaps_active then
            local state = waywall.state()
            if state.inworld == "paused" then
                helpers.toggle_res(ED.x, ED.y)()
            else
                local act_width, act_height = waywall.active_res()
                if act_width == THIN.x and act_height == THIN.y then
                    thin_active = false
                    os.execute('echo "' .. 0 .. 'x' .. 0 .. '" > ~/.resize_state')
                else
                    thin_active = true
                    os.execute('echo "' .. THIN.x + 10 .. 'x' .. THIN.y .. '" > ~/.resize_state')
                end
                waywall.sleep(17)
                helpers.toggle_res(THIN.x, THIN.y)()
            end
        else
            return false
        end
    end,
    wide = helpers.ingame_only(function()
        if remaps_active then
            if not waywall.get_key("F3") then
                local act_width, act_height = waywall.active_res()
                if act_width == WIDE.x and act_height == WIDE.y then
                    os.execute('echo "' .. 0 .. 'x' .. 0 .. '" > ~/.resize_state')
                else
                    os.execute('echo "' .. WIDE.x .. 'x' .. WIDE.y + 10 .. '" > ~/.resize_state')
                end
                waywall.sleep(17)
                helpers.toggle_res(WIDE.x, WIDE.y)()
                thin_active = false
            else
                return false
            end
        else
            return false
        end
    end),
    tall = function()
        if remaps_active then
            if not waywall.get_key("F3") then
                local act_width, act_height = waywall.active_res()
                if act_width == TALL.x and act_height == TALL.y then
                    thin_active = false
                    os.execute('echo "' .. 0 .. 'x' .. 0 .. '" > ~/.resize_state')
                else
                    os.execute('echo "' .. TALL.x + 10 .. 'x' .. TALL.y .. '" > ~/.resize_state')
                end
                waywall.sleep(17)
                if thin_active then
                    helpers.toggle_res(THIN.x, THIN.y)()
                    helpers.toggle_res(TALL.x, TALL.y)()
                else
                    helpers.toggle_res(TALL.x, TALL.y, tall_sens)()
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
            -- waywall.exec("java -Dawt.useSystemAAFontSettings=on -jar " .. nb_path)
            waywall.exec("ninjabrain-bot")
            waywall.show_floating(true)
        else
            helpers.toggle_floating()
        end
    end,

    [keys.launch_paceman] = function()
        if paceman_text then return end
        if is_pacem_running() then
            print("Paceman Already Running")
            paceman_text = waywall.text("Paceman Already Running",
                { x = 10, y = 1390, color = "#FFFFFF", size = 3 })
            waywall.sleep(1500)
            paceman_text:close()
            paceman_text = nil
        else
            -- waywall.exec("java -jar " .. pacem_path .. " --nogui")
            waywall.exec("paceman-tracker --nogui")
            print("Paceman Running")
            paceman_text = waywall.text("Paceman Running",
                { x = 10, y = 1390, color = "#FFFFFF", size = 3 })
            waywall.sleep(1500)
            paceman_text:close()
            paceman_text = nil
        end
    end,

    [keys.toggle_rebinds] = function()
        if remaps_text then
            remaps_text:close(); remaps_text = nil
        end
        if remaps_active then
            remaps_active = false
            waywall.set_remaps(remaps.disabled)
            waywall.set_keymap({ layout = nil })
            remaps_text = waywall.text("Chat Mode", { x = 7, y = 1382, color = "#9FA32B", size = 4 })
        else
            remaps_active = true
            waywall.set_remaps(remaps.enabled)
            waywall.set_keymap({ layout = xkb_layout })
        end
    end,

    [keys.delete_worlds] = function()
        waywall.exec("/home/arjungore/mcsr/scripts/adw_jude.sh")
    end,

    ["F1"] = function()
        local state = waywall.state()
        if state.inworld == "paused" then
            helpers.toggle_res(ED.x, ED.y)()
        end
    end,

    ["escape"] = function()
        local act_width, act_height = waywall.active_res()
        if act_width == ED.x and act_height == ED.y then
            waywall.set_resolution(0, 0)
        end
        return false
    end,
}

require("test").send(config)

require("crosshair").setup(config)

require("pie_mirrors")

return config
