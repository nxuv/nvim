---@diagnostic disable

local fzfp         = require("plugin.utils.fzf")
local colsch       = require("sys.config")
local colorschemes = require("fzf-lua.providers.colorschemes").colorschemes
local can_load = require("vim.modules").can_load

vim.api.nvim_create_user_command("Colorschemes", function()
    colorschemes({
        actions = {
            ["default"] = function(selected, opts) colsch.theme.set(selected[1]) end
        }
    })
end, {})

local template = require("plugin.utils.templates")

vim.api.nvim_create_user_command('Template', template.paste_template, { range = false, nargs = '+', complete = template.autocomplete, })
if can_load("fzf-lua") then vim.api.nvim_create_user_command('TemplateSelect', template.select, {}) end


