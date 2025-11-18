-- Color
---@diagnostic disable: undefined-field
---@diagnostic disable: param-type-mismatch
local M = {
    on_reload_listeners = {},
    distro = {},
    theme = {},
    dependency = {
        failed = "",
    },
}

M.distro.config_loc = vim.fn.fnamemodify(vim.fn.expand("$HOME"), ":p:h") .. "/.config/neovim-distro.lua"

M.distro.source = function()
    local f = io.open(M.distro.config_loc, "r")
    if not f then
        f = io.open(M.distro.config_loc, "w")
        if not f then vim.notify("Failed to write to distro config!"); return end
        f:write("vim.g.vim_distro = 'despair.nvim'")
    end
    f:close()
    vim.cmd("source " .. M.distro.config_loc)
end

M.distro.set = function()
    -- print(vim.inspect(name))

    local new_dist = "monolith.nvim"
    if vim.g.vim_distro == new_dist then new_dist = "despair.nvim" end

    vim.loop.fs_open(M.distro.config_loc, "w", 432, function(err, fd)
        vim.loop.fs_write(fd, "vim.g.vim_distro = '" .. new_dist .. "'", nil, function()
            vim.loop.fs_close(fd)
        end)
    end)
end

M.theme.on_reload = function(func) table.insert(M.on_reload_listeners, func) end
M.theme.on_reload_now = function(func) func(); table.insert(M.on_reload_listeners, func) end

M.theme.config_loc = vim.fn.fnamemodify(vim.fn.expand("$HOME"), ":p:h") .. "/.config/neovim-theme.lua"

M.theme.source = function()
    local f = io.open(M.theme.config_loc, "r")
    if not f then
        f = io.open(M.theme.config_loc, "w")
        if not f then vim.notify("Failed to write to theme config!"); return end
        f:write("vim.cmd.colorscheme('despair')")
    end
    f:close();
    vim.cmd("source " .. M.theme.config_loc)
end

M.theme.set = function(name)
    -- TODO: apply also to lualine
    local colorscheme = name:match("^[^:]+")
    pcall(function() vim.cmd("colorscheme " .. colorscheme) end)

    for _, f in ipairs(M.on_reload_listeners) do
        pcall(f)
        print(vim.inspect(f))
    end

    vim.loop.fs_open(M.theme.config_loc, "w", 432, function(err, fd)
        vim.loop.fs_write(fd, "vim.cmd.colorscheme('" .. name .. "')", nil, function()
            vim.loop.fs_close(fd)
        end)
    end)
end

M.dependency.fail_required = function (dep)
    M.dependency.failed = M.dependency.failed .. "\n" .. dep
end

---@param _deps string[]
M.dependency.check_required = function (_deps)
    local cond = true
    for _, val in ipairs(_deps) do
        if vim.fn.executable(val) ~= 1 then
            require("lua.error")("'Failed to find " .. val .. " binary on system'")
            -- sysdepman.add_dep(table.concat(deps, "\n"))
            M.dependency.fail_required(val .. "\n")
            cond = false
        end
    end
    return cond
end

M.setup = function()
    M.distro.source();
    M.theme.source();

    if vim.g.vim_distro == "monolith.nvim" then
        M.dependency.check_required({
            "aplay",
            "cc",
            "curl",
            "fd",
            "fzf",
            "git",
            "gzip",
            "node",
            "rg",
            "tar",
            "tree-sitter",
            "unzip",
        })
    else
        M.dependency.check_required({
            "rg"
        })
    end


    if M.dependency.failed ~= "" then vim.notify("Missing required dependencies:\n" .. M.dependency.failed) end
end

return M


