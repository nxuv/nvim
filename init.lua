---@diagnostic disable

require "lua.globals"

require ("sys.config").setup()

if vim.g.vim_distro == "despair.nvim" then
    vim.treesitter.start = function(_b, _n) end
end

vim.g.mapleader      = ";"
vim.g.maplocalleader = ","

require "vim.options"
require "vim.keymaps"

if vim.g.vim_distro == "monolith.nvim" then
    require "plugin.loader"
    require "plugin.commands"
    require "plugin.notify"
end

