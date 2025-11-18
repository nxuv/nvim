-- Lazy
-- Plugin loading

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

lazy.setup({
    spec = { import = "plugin.sources" },
    change_detection = {
        enabled = false,
        notify = false,
    }
})

local noremap = require("vim.remap").noremap

noremap("n", "<leader>pi", "<cmd>Lazy install<cr>", { desc = "[P]lugin [I]nstall" })
noremap("n", "<leader>pc", "<cmd>Lazy clean<cr>", { desc = "[P]lugin [C]lean" })
noremap("n", "<leader>ps", "<cmd>Lazy sync<cr>", { desc = "[P]lugin [S]ync" })
noremap("n", "<leader>pu", "<cmd>Lazy update<cr>", { desc = "[P]lugin [U]pdate" })
noremap("n", "<leader>pg", "<cmd>Lazy<cr>", { desc = "[P]lugin [G]UI" })


