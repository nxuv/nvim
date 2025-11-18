if vim.g.vim_distro ~= "despair.nvim" then return end

local noremap = require("vim.remap").noremap

noremap("i", "<A-k>", "<esc>ddkPi", { desc = "Moves line up" })
noremap("i", "<A-j>", "<esc>ddpi", { desc = "Moves line down" })
noremap("i", "<A-up>", "<esc>ddkPi", { desc = "Moves line up" })
noremap("i", "<A-down>", "<esc>ddpi", { desc = "Moves line down" })

noremap("v", "<A-j>", [['xp`[' . getregtype()[0] . '`]']],    { desc = "Moves visual lines down", expr = true })
noremap("v", "<A-up>", [['xkP`[' . getregtype()[0] . '`]']],  { desc = "Moves visual lines up", expr = true })
noremap("v", "<A-down>", [['xp`[' . getregtype()[0] . '`]']], { desc = "Moves visual lines down", expr = true })
noremap("v", "<A-k>", [['xkP`[' . getregtype()[0] . '`]']],   { desc = "Moves visual lines up", expr = true })

