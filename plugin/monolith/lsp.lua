if vim.g.vim_distro ~= "monolith.nvim" then return end

local noremap = require("vim.remap").noremap
noremap("n", "<leader>lf", vim.lsp.buf.format, { desc = "[L]sp [F]ormat" })

