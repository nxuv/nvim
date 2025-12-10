---@diagnostic disable

require("theme").setup()

if vim.g.vim_distro == "despair.nvim" then
    vim.treesitter.start = function(_b, _n) end
end

vim.g.mapleader      = ";"
vim.g.maplocalleader = ","

require("options")
require("keymap")

if vim.g.vim_distro == "monolith.nvim" then
    require("plugins")
end

