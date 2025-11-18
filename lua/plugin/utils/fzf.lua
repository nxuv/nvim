-- FZF
---@diagnostic disable: duplicate-set-field
local can_load = require("vim.modules").can_load

local M = {}

if not can_load("fzf-lua") then return M end

local fzf             = require("fzf-lua")
local fzfutil         = require("fzf-lua.utils")
local builtin         = require("fzf-lua.previewer.builtin")

local function reverse(tab)
    for i = 1, #tab / 2, 1 do
        tab[i], tab[#tab - i + 1] = tab[#tab - i + 1], tab[i]
    end
    return tab
end

---@param actions table
---@param opts table?
M.create_picker = function(actions, opts)
    actions = actions or {}
    opts = vim.tbl_extend("force", { actions = actions }, opts or {})

    local c_opts = opts
    return function(list)
        fzf.fzf_exec(list, c_opts)
    end
end

---@alias preview_func function(string, number)

---@param actions table
---@param populate_preview_func preview_func
---@param opts table?
M.create_picker_preview = function(actions, populate_preview_func, opts)
    opts = vim.tbl_extend("force", { actions = actions }, opts or {})

    local Previewer = builtin.base:extend()

    function Previewer:new(o, _opts, fzf_win)
        Previewer.super.new(self, o, _opts, fzf_win)
        setmetatable(self, Previewer)
        return self
    end

    function Previewer:populate_preview_buf(entry_str)
        local bufnr = self:get_tmp_buffer()
        populate_preview_func(entry_str, bufnr)
        self:set_preview_buf(bufnr)
        if type(self.title) == "string" then self.win:update_title(" " .. self.title .. " ") end
        self.win:update_scrollbar()
    end

    function Previewer:gen_winopts()
        local new_winopts = {
            -- wrap    = false,
            -- number  = false
            cursorline = false,
        }
        return vim.tbl_extend("force", self.winopts, new_winopts)
    end

    opts.previewer = Previewer
    return M.create_picker(actions, opts)
end

local hl_ns_id = vim.api.nvim_create_namespace("fzf_projects_win_hl")

local function parse_line_hl(line)
    local ret = {}
    if line:starts_with("[1;34m") then
        ret.hl = "Function"
    elseif line:starts_with("[1;32m") then
        ret.hl = "String"
    elseif line:starts_with("[35m") then
        ret.hl = "Float"
    elseif line:starts_with("[1;4;33m") then
        ret.hl = "Special"
    elseif line:starts_with("[1;33m") then
        ret.hl = "Special"
    elseif line:starts_with("[") then
        ret.hl = "Error"
    else
        ret.hl = "Normal"
    end
    ret.text = fzfutil.strip_ansi_coloring(line)
    if ret.text:ends_with("*") then
        ret.text = ret.text:sub(1, #ret.text - 1)
    end
    -- ret.text = line
    -- TODO: asdf
    return ret
end

local function get_dir_entries(dir)
    return vim.fn.split(
        vim.fn.system("eza -1a --color=always --no-symlinks --git-ignore --group-directories-first -F=always " .. dir),
        "\n"
    )
end

M.populate_preview_eza = function(entry_str, bufnr)
    local entries = get_dir_entries(entry_str)
    for i, entry in ipairs(entries) do
        local l = parse_line_hl(entry)
        vim.api.nvim_buf_set_lines(bufnr, i - 1, i + 1, false, { l.text })
        vim.api.nvim_buf_set_extmark(bufnr, hl_ns_id, i - 1, 0, {
            line_hl_group = l.hl,
            priority = 100,
        })
    end
end

return M

