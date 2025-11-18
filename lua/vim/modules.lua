-- Modules
local M = {}

M.load = function(m)
    local ok, err = pcall(require, m)
    if not ok then
        vim.notify("Package \"" .. m .. "\" failed to load. \n\n" .. err, vim.log.levels.error)
        return nil
    end
    return err
end

M.load_call = function(m, func, ...)
    local ok, err = pcall(require, m)
    if not ok then
        vim.notify("Package \"" .. m .. "\" failed to load. \n\n" .. err, vim.log.levels.error)
        return
    end

    if err[func] ~= nil then
        err[func](...)
    end
end

M.can_load = function(module)
    local ok, _   = pcall(require, module)
    if not ok then
        return false
    else
        return true
    end
end

return M
