-- https://neovim.io/doc/user/pack.html
-- https://bower.sh/nvim-builtin-plugin-mgr
-- https://lsp-zero.netlify.app/docs/
if vim.version().minor == 12 then vim.notify("lua/plugins.lua(4): error: MIGRATE TO vim.pack", vim.log.levels.ERROR); return end

local packages = {}

vim.pack = {}
vim.pack.add = function(specs, _)
    for _, spec in pairs(specs) do
        table.insert(packages, spec)
    end
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.loop or vim.uv).fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath, })
end
vim.opt.rtp:prepend(lazypath)

vim.pack.add({
-- - ----------------------------------- DEPS ----------------------------------- -
    "https://github.com/nvim-lua/plenary.nvim",
-- - ---------------------------------- CODING ---------------------------------- -
    -- color picker + color backgrounds
    "https://github.com/catgoose/nvim-colorizer.lua",
    -- switch between c/cpp header and impl
    "https://github.com/jakemason/ouroboros.nvim",
    -- surround text
    "https://github.com/kylechui/nvim-surround",
    -- like make but for casey/just
    "https://github.com/nxuv/just.nvim",
    -- ripgrep in file
    "https://github.com/chrisgrieser/nvim-rip-substitute",
-- - ----------------------------------- LSP ------------------------------------ -
    -- autoconfig of lsp's
    "https://github.com/neovim/nvim-lspconfig",
    -- completion
    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-cmdline",
    "https://github.com/hrsh7th/cmp-path",
    -- show diagnostic number in top right
    "https://github.com/ivanjermakov/troublesum.nvim",
    -- language highlights and such
    "https://github.com/nvim-treesitter/nvim-treesitter",
    -- autoclose inactive lsp
    "https://github.com/nxuv/garbage-day.nvim",
-- - ------------------------------------ UI ------------------------------------ -
    -- file and other things picker
    "https://github.com/ibhagwan/fzf-lua",
    -- show lsp status in bottom right
    "https://github.com/j-hui/fidget.nvim",
    -- popup messages
    "https://github.com/rcarriga/nvim-notify",
    -- pretty quickfix
    "https://github.com/yorickpeterse/nvim-pqf",
    -- move windows around
    "https://github.com/sindrets/winshift.nvim",
    -- resize splits
    "https://github.com/mrjones2014/smart-splits.nvim",
    -- pretty tabs
    "https://github.com/nanozuki/tabby.nvim",
    -- NNN but in vim
    "https://github.com/luukvbaal/nnn.nvim"
})

require("lazy").setup({ spec = { packages }, change_detection = { enabled = false, notify = false, }, rocks = { enabled = false } })


