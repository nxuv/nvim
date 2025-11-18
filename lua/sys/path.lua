-- Path
local M = {}

M.list_dir = function (dir)
    return vim.split(vim.fn.glob(dir .. "/*"), '\n', { trimempty = true })
end

return M

