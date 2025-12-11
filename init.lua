---@diagnostic disable

require("theme").setup()

if not vim.g.plugins_enabled or not vim.fn.executable("tree-sitter") then
    vim.treesitter.start = function(_b, _n) end
end

vim.g.mapleader      = ";"
vim.g.maplocalleader = ","

require("options")
require("keymap")

if vim.g.plugins_enabled then require("plugins") end

