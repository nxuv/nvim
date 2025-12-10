local bufnoremap = require("remap").bufnoremap

bufnoremap("n", "<leader>xf", "<cmd>w<cr><cmd>source %<cr>", { desc = "E[X]ecute [F]ile" })

