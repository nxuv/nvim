---@diagnostic disable: missing-fields
return {
    {
        'williamboman/mason.nvim',
        event = "VimEnter",
        keys = {
            { "<leader>pm", "<cmd>Mason<cr>", mode = "n", noremap = true, silent = true, desc = "[P]lugin [M]ason" },
        },
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            'hrsh7th/nvim-cmp',
            'tamago324/nlsp-settings.nvim'
        },
        config = function()
            local mason        = require("mason")
            local masonconf    = require("mason-lspconfig")
            local nlspsettings = require("nlspsettings")
            local cmp_lsp      = require("cmp_nvim_lsp")

            mason.setup({})

            -- LINK: https://github.com/tamago324/nlsp-settings.nvim/tree/main/schemas/_generated
            nlspsettings.setup({
                config_home = vim.fn.stdpath('config') .. '/lspconf',
                local_settings_dir = ".lspconf",
                local_settings_root_markers_fallback = { '.git' },
                append_default_schemas = true,
                loader = 'json'
            })

            local function on_attach(_client, bufnr)
                vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
            end

            -- local global_capabilities = vim.lsp.protocol.make_client_capabilities()
            -- global_capabilities.textDocument.completion.completionItem.snippetSupport = true
            -- vim.lsp.config.default_config = vim.tbl_extend("force", vim.lsp.config.util.default_config, {
            --     capabilities = global_capabilities,
            -- })

            local vscodecap = { capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()), }

            -- if vim.fn.executable("dart")          then vim.lsp.config["dartls"].setup({})        end
            -- if vim.fn.executable("glsl_analyzer") then vim.lsp.config["glsl_analyzer"].setup({}) end

            local function gen_default_capabilities() cmp_lsp.default_capabilities() end

            -- https://github.com/williamboman/mason-lspconfig.nvim#automatic-server-setup-advanced-feature
            masonconf.setup({
                ensure_installed = { 'lua_ls', 'jsonls', 'marksman', 'cmake', 'bashls', 'vimls', },
                automatic_installation = true,
                handlers = {
                    -- function(server_name)
                    --     vim.lsp.config[server_name].setup({ on_attach = on_attach, capabilities = gen_default_capabilities() })
                    -- end,
                    ['serve_d'] = function()
                        vim.lsp.config.serve_d.setup({
                            capabilities = gen_default_capabilities(),
                            on_attach = function(client) client.server_capabilities.documentFormattingProvider = false end,
                        })
                    end,
                    ['cssls']  = function() vim.lsp.config.cssls.setup(vscodecap) end,
                    ['html']   = function() vim.lsp.config.html.setup(vscodecap) end,
                    ['jsonls'] = function() vim.lsp.config.jsonls.setup(vscodecap) end,
                    ['lua_ls'] = function()
                        if vim.fn.executable( "lua-language-server" ) then
                            vim.lsp.config.lua_ls.setup({ capabilities = gen_default_capabilities() })
                        end
                    end,
                    ['vtsls'] = function()
                        vim.lsp.config.vtsls.setup({
                            init_options = {
                                preferences = {
                                    disableSuggestions = true,
                                },
                            },
                        })
                    end,
                }
            })

            -- DISABLE marksman
            vim.api.nvim_create_autocmd(
                { "BufNewFile", "BufRead", "BufReadPost" },
                { pattern = { "*.md" }, callback = function(opt) vim.diagnostic.enable(false, { bufnr = opt.buf }) end }
            )
        end
    }
}
