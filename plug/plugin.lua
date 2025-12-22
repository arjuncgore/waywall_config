local types = require("plug.types")
local utils = require("plug.utils")

local M = {}

M.loaded_plugins = {}

--- @param spec table<string, any>
--- @param config table<any, any>
--- @return string | nil
function M.load_from_spec(spec, config)
    if not spec.url then
        return "load spec: failed to load plugin: url not provided"
    end

    --- @type PluginSpec | nil, string | nil
    local pspec, err = types.PluginSpec.new(spec.url, spec.name, spec.config, spec.enabled)
    if not pspec then
        return "load spec: failed to load plugin: " .. err
    end

    local deps = spec.dependencies
    if deps and type(deps) == "table" then
        for _, dep in ipairs(deps) do
            local err2 = M.load_from_spec(dep, config)
            if err2 then
                return "load spec: failed to load plugin dependency: " .. err2
            end
        end
    end

    local success1, err1 = pspec:load()
    if not success1 then
        return "load spec: failed to load plugin: " .. err1
    end

    if spec.update_on_load then
        local success2, err2 = pspec:update()
        if not success2 then
            return "load spec: failed to update plugin: " .. err2
        end
    end

    local plugin = utils.Prequire(pspec.name .. ".init")
    if not plugin then
        return "load plugin: failed to load plugin init"
    end

    if pspec.config then
        pspec.config(config)
    end

    M.loaded_plugins[#M.loaded_plugins + 1] = pspec.name
    return nil
end

--- @param name string
--- @return boolean, string | nil
function M.update_from_name(name)
    -- Dummy plugin spec
    local pspec, err = types.PluginSpec.new("", name, nil, true)
    if not pspec then
        return false, "failed to create plugin spec: " .. err
    end
    local success, err2 = pspec:update()
    if not success then
        return false, "failed to update plugin: " .. err2
    end
    return true, nil
end

--- @return boolean, string | nil
function M.update_all()
    for _, name in ipairs(M.loaded_plugins) do
        local success, err = M.update_from_name(name)
        if not success then
            return false, "failed to update plugin: " .. err
        end
    end
    return true, nil
end

return M
