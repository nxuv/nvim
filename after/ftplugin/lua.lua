local bufnoremap = require("vim.remap").bufnoremap

bufnoremap("n", "<leader>xf", "<cmd>w<cr><cmd>source %<cr>", { desc = "E[X]ecute [F]ile" })
bufnoremap("n", "<leader>xc", "V:lua<cr>", { desc = "E[X]ecute Lua" })
bufnoremap("x", "<leader>xc", ":lua<cr>", { desc = "E[X]ecute Lua" })

