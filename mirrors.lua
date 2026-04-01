local waywall = require("waywall")
local helpers = require("waywall.helpers")

-- CHANGE PIE DIR
local pie_dst_2 = { x = 2414, y = 1350, w = 130, h = 70 }
local pie_dst_2_sh = { x = 2404, y = 1340, w = 150, h = 90 }
local pie_dst_1 = { x = 2264, y = 1350, w = 130, h = 70 }
local pie_dst_1_sh = { x = 2254, y = 1340, w = 150, h = 90 }
-- tick
for i = 0, 6, 1 do
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 13, h = 7 },
            dst = pie_dst_2,
            depth = 3,
            color_key = { input = "#6543CA", output = "#6543CA" }
        },
        0, 0
    )
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 1, h = 1 },
            dst = pie_dst_2_sh,
            depth = 2,
            color_key = { input = "#6543CA", output = "#000000" }
        },
        0, 0
    )
end
-- level
for i = 0, 6, 1 do
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 13, h = 7 },
            dst = pie_dst_2,
            depth = 3,
            color_key = { input = "#63cbc2", output = "#63cbc2" }
        },
        0, 0
    )
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 1, h = 1 },
            dst = pie_dst_2_sh,
            depth = 2,
            color_key = { input = "#63cbc2", output = "#000000" }
        },
        0, 0
    )
end
-- entities
for i = 0, 6, 1 do
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 13, h = 7 },
            dst = pie_dst_2,
            depth = 5,
            color_key = { input = "#e145c2", output = "#e145c2" }
        },
        0, 0
    )
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 1, h = 1 },
            dst = pie_dst_2_sh,
            depth = 4,
            color_key = { input = "#e145c2", output = "#000000" }
        },
        0, 0
    )
end
-- blockEntities
for i = 0, 6, 1 do
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 13, h = 7 },
            dst = pie_dst_2,
            depth = 5,
            color_key = { input = "#c4c46d", output = "#c4c46d" }
        },
        0, 0
    )
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 1, h = 1 },
            dst = pie_dst_2_sh,
            depth = 4,
            color_key = { input = "#c4c46d", output = "#000000" }
        },
        0, 0
    )
end

-- gameRenderer
for i = 0, 6, 1 do
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 13, h = 7 },
            dst = pie_dst_1,
            depth = 5,
            color_key = { input = "#c2cbc2", output = "#c2cbc2" }
        },
        0, 0
    )
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 1, h = 1 },
            dst = pie_dst_1_sh,
            depth = 4,
            color_key = { input = "#c2cbc2", output = "#000000" }
        },
        0, 0
    )
end
-- level
for i = 0, 6, 1 do
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 13, h = 7 },
            dst = pie_dst_1,
            depth = 3,
            color_key = { input = "#63cbc2", output = "#63cbc2" }
        },
        0, 0
    )
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 1, h = 1 },
            dst = pie_dst_1_sh,
            depth = 2,
            color_key = { input = "#63cbc2", output = "#000000" }
        },
        0, 0
    )
end
-- entities
for i = 0, 6, 1 do
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 13, h = 7 },
            dst = pie_dst_1,
            depth = 5,
            color_key = { input = "#e145c2", output = "#e145c2" }
        },
        0, 0
    )
    helpers.res_mirror(
        {
            src = { x = 2230, y = 1220 + 8 * i, w = 1, h = 1 },
            dst = pie_dst_1_sh,
            depth = 4,
            color_key = { input = "#e145c2", output = "#000000" }
        },
        0, 0
    )
end
