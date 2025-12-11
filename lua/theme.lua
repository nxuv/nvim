---@diagnostic disable: unused-local, undefined-field
-- Borders
local M = {
    on_reload_listeners = {},

    plugins = {},

    theme = {},

    dependency = {
        failed = "",
    },

    border_normal = { "┌", " ", "┐", " ", "┘", " ", "└", " " },
    border_normal_full = {"┌", "─", "┐", "│", "┘", "─", "└" , "│" },
    border_telescope = { " ", " ", " ", " ", "┌", "┐", "┘", "└" },
    border_telescope_bottom = { " ", " ", " ", " ", "├", "┤", "┘", "└" },
    border_telescope_top = { " ", " ", " ", " ", "┌", "┐", " ", " " },
    border_winsep = {"─", "│", "┌", "┐", "└" ,"┘" },
    border_winsep_no_corners = {"─", "│", "├", "┤", "├" ,"┤" },
}

-- Highlight groups
M.get_highlight = function(group_name)
	local group_id = vim.fn.synIDtrans(vim.fn.hlID(group_name));
	return {
		fg            = vim.fn.synIDattr(group_id, "fg#"),
		bg            = vim.fn.synIDattr(group_id, "bg#"),
		sp            = vim.fn.synIDattr(group_id, "sp#"),
		bold          = vim.fn.synIDattr(group_id, "bold")          == "1",
		standout      = vim.fn.synIDattr(group_id, "standout")      == "1",
		underline     = vim.fn.synIDattr(group_id, "underline")     == "1",
		undercurl     = vim.fn.synIDattr(group_id, "undercurl")     == "1",
		underdouble   = vim.fn.synIDattr(group_id, "underdouble")   == "1",
		underdotted   = vim.fn.synIDattr(group_id, "underdotted")   == "1",
		underdashed   = vim.fn.synIDattr(group_id, "underdashed")   == "1",
		strikethrough = vim.fn.synIDattr(group_id, "strikethrough") == "1",
		italic        = vim.fn.synIDattr(group_id, "italic")        == "1",
		reverse       = vim.fn.synIDattr(group_id, "reverse")       == "1",
		nocombine     = vim.fn.synIDattr(group_id, "nocombine")     == "1",
		ctermfg       = vim.fn.synIDattr(group_id, "ctermfg"),
		ctermbg       = vim.fn.synIDattr(group_id, "ctermbg")
	}
end

M.get_colors = function()
    return {
        replace = M.get_highlight('Keyword').fg    or "#fe0000",
        insert  = M.get_highlight('PmenuSbar').bg  or "#fe0000",
        visual  = M.get_highlight('Number').fg     or "#fe0000",
        command = M.get_highlight('Identifier').fg or "#fe0000",
        fore    = M.get_highlight('Normal').fg     or "#fe0000",
        back    = M.get_highlight('Normal').bg     or "#fe0000"
    }
end

M.get_theme = function()
    local S = {}
    local colors = M.get_colors()

    S = {
        normal = {
            a = { bg = colors.back, fg = colors.fore, gui = 'bold' },
            b = { bg = colors.back, fg = colors.fore },
            c = { bg = colors.back, fg = colors.fore },
        },
        insert = {
            a = { bg = colors.insert, fg = colors.fore, gui = 'bold' },
            b = { bg = colors.back, fg = colors.insert },
            c = { bg = colors.back, fg = colors.fore },
        },
        replace = {
            a = { fg = colors.replace, gui = 'bold,reverse' },
            b = { bg = colors.back, fg = colors.replace },
            c = { bg = colors.back, fg = colors.fore },
        },
        visual = {
            a = { fg = colors.visual, gui = 'bold,reverse' },
            b = { bg = colors.back, fg = colors.visual },
            c = { bg = colors.back, fg = colors.fore },
        },
        command = {
            a = { fg = colors.command, gui = 'bold,reverse' },
            b = { bg = colors.back, fg = colors.command },
            c = { bg = colors.back, fg = colors.fore },
        },
    }

    S.terminal = S.command
    S.inactive = S.normal

    return S
end

M.plugins.config_dir = vim.fn.stdpath("data") .. "/config"
M.plugins.config_loc = M.plugins.config_dir .. "/plugins.lua"

M.plugins.source = function()
    if vim.fn.isdirectory(M.plugins.config_dir) == 0 then
        vim.fn.mkdir(M.plugins.config_dir, "p")
    end
    local f = io.open(M.plugins.config_loc, "r")
    if not f then
        f = io.open(M.plugins.config_loc, "w")
        if not f then vim.notify("Failed to write to plugins config!"); return end
        f:write("vim.g.plugins_enabled = false")
    end
    f:close()
    vim.cmd("source " .. M.plugins.config_loc)
end

M.plugins.toggle = function()
    if vim.g.plugins_enabled then
        vim.g.plugins_enabled = false
    else
        vim.g.plugins_enabled = true
    end

    local f = io.open(M.plugins.config_loc, "w")
    if not f then
       vim.notify("Failed to write to plugins config!");
       return
    end
    f:write("vim.g.plugins_enabled = " .. tostring(vim.g.plugins_enabled))
    f:close();
end

M.theme.on_reload = function(func) table.insert(M.on_reload_listeners, func) end
M.theme.on_reload_now = function(func) func(); table.insert(M.on_reload_listeners, func) end

M.theme.config_dir = vim.fn.stdpath("data") .. "/config"
M.theme.config_loc = M.theme.config_dir .. "/theme.lua"

M.theme.source = function()
    if vim.fn.isdirectory(M.theme.config_dir) == 0 then
        vim.fn.mkdir(M.theme.config_dir, "p")
    end
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
        -- print(vim.inspect(f))
    end

    local f = io.open(M.theme.config_loc, "w")
    if not f then
       vim.notify("Failed to write to theme config!");
       return
    end
    f:write("vim.cmd.colorscheme('" .. name .. "')")
    f:close();
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
    M.plugins.source();
    M.theme.source();

    if vim.g.plugins_enabled then
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


