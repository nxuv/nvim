---@diagnostic disable: missing-fields
return {
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        dependencies = { { "ms-jpq/coq_nvim", branch = "coq" }, },
        init = function()
            vim.g.coq_settings = {
                auto_start = 'shut-up',
                keymap = { manual_complete = "", }, display = {
                    icons = { mode = "none" },
                    statusline = { helo = false },
                    pum = { source_context = { "<", ">" }, ellipsis = "...", },
                    ghost_text = { context = { " <", ">" } },
                    preview = { border = "single", },
                },
                clients = {
                    tmux = { parent_scope = " <-", path_sep = " -> ", },
                    tags = { parent_scope = " <-", path_sep = " -> ", },
                    tree_sitter = { path_sep = " -> ", },
                    buffers = { parent_scope = " <-", },
                    registers = { register_scope = " -> ", },
                },
            }
        end,
        config = function()
            -- vim.lsp.config('luals', {
            --     cmd = {'lua-language-server'},
            --     filetypes = {'lua'},
            --     root_markers = {'.luarc.json', '.luarc.jsonc'},
            -- })

            vim.lsp.config("serve_d", { on_attach = function(client) client.server_capabilities.documentFormattingProvider = false end, })

            vim.lsp.config("vtsls", { init_options = { preferences = { disableSuggestions = true, }, }, })

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

            local coq = require("coq")

            for _, value in pairs(servers) do
                vim.lsp.config(value, coq.lsp_ensure_capabilities())
                vim.lsp.enable(value)
            end

            vim.api.nvim_create_autocmd(
                { "BufNewFile", "BufRead", "BufReadPost" },
                { pattern = { "*.md" }, callback = function(opt) vim.diagnostic.enable(false, { bufnr = opt.buf }) end }
            )
        end
    },
    -- show buffer diagnostic in top right corner
    { "ivanjermakov/troublesum.nvim", opts = { enabled = true, } },
    -- parser
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            local ts_config = require("nvim-treesitter.configs")
            ts_config.setup({
                -- A list of parser names, or 'all'
                ensure_installed = {
                    'c',
                    'lua',
                    'markdown',
                    'markdown_inline',
                    'regex',
                    'bash',
                    'vim',
                },
                sync_install = false,
                auto_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = true,
                    -- disable = { "d", 'dub', 'rdmd' },
                },
            })
        end
    },
    -- close inactive lsp clients
    {
        "al1-ce/garbage-day.nvim",
        -- dir = "/g/al1-ce/garbage-day.nvim",
        event = "VeryLazy",
        opts = {
            notifications = true,
            grace_period = 60 * 15,
            aggresive_mode = false,
            notification_engine = "fidget",
            excluded_lsp_clients = { "null-ls", "jdtls", "marksman", "dartls", "vtsls", "serve_d" }
        }
    },
}
