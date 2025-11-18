local bufnoremap = require("vim.remap").bufnoremap
local remap      = require("vim.remap").remap

bufnoremap("n", "<leader>xf", "<cmd>w<cr><cmd>source %<cr>", { desc = "E[X]ecute [F]ile" })

