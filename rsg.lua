local waywall = require("waywall")
local config = require("main")

local plug_repo = "https://github.com/its-saanvi/plug.waywall"
local waywall_share = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share") .. "/waywall"
local plug_path = waywall_share .. "/plug"
local file, err = io.open(plug_path .. "/.check_temp", "w")
if not file and err then
	if string.find(err, "No such file or directory") then
		if not os.execute("mkdir -p " .. waywall_share) then
			print("Failed to create waywall share directory")
		end
		if not os.execute("git clone " .. plug_repo .. " " .. plug_path) then
			print("Failed to clone plug.waywall")
		end
	end
else
	file:close()
	os.remove(plug_path .. "/.check_temp")
end
package.path = package.path .. ";" .. waywall_share .. "/plug/?/init.lua" .. ";" .. plug_path .. "/?.lua"

local plug = require("plug")
plug.setup({

    dir = "rsg_plugins",
    config = config,
    path = "~/.local/share/waywall/plugins",
})

config.actions["Shift-F8"] = function()
    print(plug.update_all())
end

-- require("waywordle.init").setup(config)

return config
