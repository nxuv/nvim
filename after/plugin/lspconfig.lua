local noremap = require("remap").noremap

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
        local opts = { buffer = event.buf }

        noremap("n", "<leader>lf", function() vim.lsp.buf.format({async = true}) end, opts)

        noremap("n", "gd", vim.lsp.buf.definition, opts)
        noremap("n", "gD", vim.lsp.buf.declaration, opts)

        noremap("n", "K", vim.lsp.buf.hover, opts)

    end
})

if vim.g.vim_distro ~= "monolith.nvim" then return end

-- https://mason-registry.dev/registry/list

-- vim.lsp.config('luals', {
--     cmd = {'lua-language-server'},
--     filetypes = {'lua'},
--     root_markers = {'.luarc.json', '.luarc.jsonc'},
-- })

vim.lsp.config("serve_d", {
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
    end
})

vim.lsp.config("vtsls", {
    init_options = { preferences = { disableSuggestions = true, } }
})

local servers = {
    "lua_ls",   -- lua
    "bashls",   -- bash
    "clangd",   -- c/c++
    "jsonls",   -- json
    "marksman", -- markdown
    "serve_d",  -- d
    "vimls",    -- vim
    "vtsls",    -- javascript
}

if require("modules").can_load("cmp_nvim_lsp") then
    local cmp_lsp = require("cmp_nvim_lsp")
    for _, value in pairs(servers) do
        vim.lsp.config(value, cmp_lsp.default_capabilities())
    end
end

for _, value in pairs(servers) do
    vim.lsp.enable(value)
end

vim.api.nvim_create_autocmd(
    { "BufNewFile", "BufRead", "BufReadPost" },
    {
        pattern = { "*.md" }, callback = function(opt)
            vim.diagnostic.enable(false, { bufnr = opt.buf })
        end
    }
)

