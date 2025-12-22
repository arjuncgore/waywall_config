local M = {}

--- @param module_name string
--- @return table | nil
--- @return string | nil
function M.Prequire(module_name)
	local ok, mod = pcall(require, module_name)
	if not ok then
		return nil, mod -- returns nil and the error message
	end
	return mod, nil -- returns the loaded module
end

return M
