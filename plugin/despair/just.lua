if vim.g.vim_distro ~= "despair.nvim" then return end

local noremap = require("vim.remap").noremap
if vim.fn.executable("just") ~= 1 or vim.g.use_build_make then
    noremap("n", "<leader>bd", function() vim.cmd("make default") end)
    noremap("n", "<leader>bD", function() vim.cmd("make debug") end)
    noremap("n", "<leader>bb", function() vim.cmd("make build") end)
    noremap("n", "<leader>br", function() vim.cmd("make run") end)
    noremap("n", "<leader>bR", function() vim.cmd("make release") end)
    noremap("n", "<leader>bf", function() vim.cmd("make file " .. vim.fn.expand("%:p")) end)
    noremap("n", "<leader>bt", function() vim.cmd("make tags") end)
else
    noremap("n", "<leader>bd", function() vim.cmd("!just default") end)
    noremap("n", "<leader>bD", function() vim.cmd("!just debug") end)
    noremap("n", "<leader>bb", function() vim.cmd("!just build") end)
    noremap("n", "<leader>br", function() vim.cmd("!just run") end)
    noremap("n", "<leader>bR", function() vim.cmd("!just release") end)
    noremap("n", "<leader>bf", function() vim.cmd("!just file " .. vim.fn.expand("%:p")) end)
    noremap("n", "<leader>bt", function() vim.cmd("!just tags") end)
end


