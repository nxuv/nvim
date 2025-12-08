if vim.g.vim_distro ~= "despair.nvim" or vim.fn.executable("just") ~= 1 or vim.g.use_build_make then return end

local noremap = require("vim.remap").noremap
if vim.fn.executable("just") ~= 1 or vim.g.use_build_make then
    noremap("n", "<leader>bb", function() vim.cmd("make") end)
    noremap("n", "<leader>br", function() vim.cmd("make run") end)
else
    noremap("n", "<leader>bb", function() vim.cmd("!just build") end)
    noremap("n", "<leader>br", function() vim.cmd("!just run") end)
end


