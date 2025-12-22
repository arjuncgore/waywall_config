local globals = require("plug.globals")

local M = {}

--- @class PluginSpec
--- @field url string
--- @field name string | nil
--- @field config fun(config: table<any, any>) | nil
--- @field enabled boolean
local PluginSpec = {}

--- @param url string
--- @param name string | nil
--- @param config fun() | nil
--- @param enabled boolean | nil
--- @return PluginSpec | nil, string | nil
function PluginSpec.new(url, name, config, enabled)
	if not name then
		local start = url:match(".*/()")
		if not start then
			return nil, "failed to parse url for name"
		end
		name = url:sub(start)
		Log:debug("PluginSpec: name not provided, using " .. name)
	end
	local self = setmetatable({}, { __index = PluginSpec })
	self.url = url
	self.name = name
	self.config = config
	self.enabled = (function()
		if enabled == nil then
			return true
		end
		return enabled
	end)()
	return self, nil
end

--- @return boolean, string | nil
function PluginSpec:load()
	if not self.enabled then
		return true, nil
	end
	local store_path = globals.PLUG_CONFIG_DIR .. self.name
	local file, err = io.open(store_path .. "/.check_temp", "w")
	if not file and err then
		if string.find(err, "No such file or directory") then
			-- Plugin not found, clone it
			if not os.execute("mkdir -p " .. globals.PLUG_CONFIG_DIR) then
				return false, "failed to create plugin directory"
			end
			-- Use git to clone the plugin
			local command = "git clone " .. self.url .. " " .. store_path
			if not os.execute(command) then
				return false, "failed to clone plugin"
			end
		else
			return false, err
		end
	end
	if file then
		io.close(file)
	end
	os.remove(store_path .. "/.check_temp")
	return true, nil
end

--- @return boolean, string | nil
function PluginSpec:update()
	local store_path = globals.PLUG_CONFIG_DIR .. self.name
	-- Check if the plugin is a git plugin
	local file, err = io.open(store_path .. "/.git/.check_temp", "w")
	if not file and err then
		if string.find(err, "No such file or directory") then
			Log:warn("update: plugin: '" .. self.name .. "' is not a git plugin")
			return true, nil
		end
		return false, "failed to check if plugin is a git plugin: " .. err
	end
	if file then
		io.close(file)
	end
	os.remove(store_path .. "/.git/.check_temp")

	local file2, err2 = io.open(store_path .. "/.check_temp", "w")
	if not file2 and err2 then
		return false, "plugin not loaded: " .. err2
	end
	if file2 then
		io.close(file2)
		-- For now, only considering git repos with "main" as the main branch
		local command = "git -C " .. store_path .. " pull origin main"
		if not os.execute(command) then
			return false, "failed to update plugin"
		end
	end
	os.remove(store_path .. "/.check_temp")
	return true, nil
end

--- @class SetupOpts
--- @field dir string | nil
--- @field plugins PluginSpec[] | nil
--- @field config table<any, any>
local SetupOpts = {}

--- @class UpdateOpts
--- @field name string
local UpdateOpts = {}

M.PluginSpec = PluginSpec
M.SetupOpts = SetupOpts
M.UpdateOpts = UpdateOpts

return M
