return {
    url = "https://github.com/arjuncgore/waywordle",
    config = function(config)
        return false
        -- require("waywordle.init").setup(config, {
        --     x = 200,
        --     y = 200,
        --     size = 7,
        --     start_key = "F7",
        --     colors = {
        --         text = "#FFFFFF",
        --         incorrect = "#3a3a3c",
        --         partial = "#f5793a",
        --         correct = "#85c0f9",
        --     }
        -- })
    end,
    name = "waywordle",
    update_on_load = false,
}
