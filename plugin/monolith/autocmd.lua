---@diagnostic disable: missing-parameter
if vim.g.vim_distro ~= "monolith.nvim" then return end

local bufnoremap = require("vim.remap").bufnoremap
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('BindKSignature', { clear = true })
autocmd('BufEnter', {
    group = 'BindKSignature',
    callback = function()
        if vim.lsp.buf_is_attached() then
            bufnoremap("n", "K", vim.lsp.buf.signature_help, { desc = "Signature help" })
        end
    end
})


