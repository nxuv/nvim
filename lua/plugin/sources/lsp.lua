---@diagnostic disable: missing-fields, undefined-global
return {
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        dependencies = {
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',    -- allows to use lsp
            'hrsh7th/cmp-buffer',      -- allows to use buffer text
            'hrsh7th/cmp-cmdline',     -- commandline!
        },
        config = function()
            -- vim.lsp.config('luals', {
            --     cmd = {'lua-language-server'},
            --     filetypes = {'lua'},
            --     root_markers = {'.luarc.json', '.luarc.jsonc'},
            -- })

            -- - -------------------------------- LSP setup --------------------------------- -

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

            local cmp_lsp = require("cmp_nvim_lsp")

            for _, value in pairs(servers) do
                vim.lsp.config(value, cmp_lsp.default_capabilities())
                vim.lsp.enable(value)
            end

            vim.api.nvim_create_autocmd(
                { "BufNewFile", "BufRead", "BufReadPost" },
                { pattern = { "*.md" }, callback = function(opt) vim.diagnostic.enable(false, { bufnr = opt.buf }) end }
            )

            -- - -------------------------------- CMP setup --------------------------------- -

            local cmp = require("cmp")

            local function reformatString(str, minwidth, maxwidth, ellipsis_char)
                if vim.fn.strchars(str) > maxwidth then
                    return vim.fn.strcharpart(str, 0, maxwidth) .. (ellipsis_char ~= nil and ellipsis_char or "")
                else
                    return str .. string.rep(' ', minwidth - vim.fn.strchars(str))
                end
            end

            local confirm_or_cr = cmp.mapping(function (fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true, })
                else fallback() end
            end, { "i" })

            local confirm_or_escape = cmp.mapping(function (fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.complete(); cmp.close(); vim.cmd("stopinsert");
                else fallback() end
            end, { "i" })

            local next_item = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            local prev_item = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })

            cmp.setup({
                mapping = {
                    ['<C-e>'] = cmp.mapping.abort(), ['<Esc>'] = confirm_or_escape, ["<CR>"] = confirm_or_cr,
                    ["<C-n>"] = next_item, ["<Tab>"] = next_item, ["<C-p>"] = prev_item, ["<S-Tab>"] = prev_item,
                    ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true, }), { "i", "c" }),
                },
                -- { name = "nvim_lsp", entry_filter = function(e, _) return cmp.lsp.CompletionItemKind.Snippet ~= e:get_kind() end }
                sources = cmp.config.sources({ { name = 'nvim_lsp' }, }, { { name = 'buffer' }, }),
                window = {
                    completion = {
                        col_offset = -3,
                        border = "none",
                        scrollbar = false,
                    },
                    documentation = { border = "single", }
                },
                -- experimental = { ghost_text = "Comment" },
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = function(p_entry, p_vim_item)
                        local entry = p_vim_item

                        entry.menu = p_entry.source.name
                        entry.abbr = reformatString("" .. entry.abbr, 25, 50, '...')
                        entry.kind = "[" .. entry.kind .. "]"

                        if     entry.menu == "cmdline"  then entry.menu = "<CM>"
                        elseif entry.menu == "buffer"   then entry.menu = "<BF>"
                        elseif entry.menu == "nvim_lsp" then entry.menu = "<LS>"
                        else   entry.menu = "<" .. entry.menu .. ">" end

                        return entry
                    end
                },
                view = { entries = { name = 'custom', selection_order = 'near_cursor' } }
            })


            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = 'buffer' } },
                view = { entries = { name = "custom", selection_order = "near_cursor" } }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources( { { name = 'path' } }, { { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } } }),
                view = { entries = { name = "custom", selection_order = "near_cursor" } }
            })
        end -- config
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
