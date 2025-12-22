local plug = require("plug.init")
plug.setup({
    -- Use a custom directory for plugins with each .lua returning a plugin spec.
    -- This setting is relative to the .config directory.
    -- Eg: This would search for plugins in ~/.config/waywall/plugins.
    dir = "plugins",
    config = config,

    -- Or specify a list of plugin specs.
    -- plugins = {
    -- 	{
    --    -- 	Set source URL for the plugin
    -- 		url = "https://example.com/author/sample",
    -- 		name = "sample", -- Optional name for the plugin
    -- 		config = function(config) -- `config` is the waywall config table.
    --      -- See sample/init.lua for an example plugin
    -- 			print(require("sample.init").loaded)
    -- 		end,
    -- 		enabled = false, -- Optional, set to true to enable the plugin
    -- 		dependencies = {
    --      -- Optional, list of plugin specs that this plugin depends on
    -- 		}
    -- 		update_on_load = false, -- Optional, set to true to update the plugin on load
    -- 	},
    -- },
})

-- Update plugin with name "<name>"
-- Returns true if successful, false otherwise.
-- You can set it to a keybind through waywall.
local success = plug.update({ name = "<name>" })

-- Update all plugins
-- Returns true if successful, false otherwise.
-- You can also set it to a keybind through waywall.
local success_all = plug.update_all()
