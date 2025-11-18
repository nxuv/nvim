---@diagnostic disable: duplicate-set-field
local noremap = require("vim.remap").noremap
-- TODO: cleanup
return {
    -- A completion engine plugin for neovim written in Lua
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',    -- allows to use lsp
            'hrsh7th/cmp-buffer',      -- allows to use buffer text
            'hrsh7th/cmp-cmdline',     -- commandline!
            'dcampos/cmp-snippy',
            'dcampos/nvim-snippy',
            'honza/vim-snippets',
            'onsails/lspkind.nvim',
            -- neovim conf
            {
                'folke/lazydev.nvim',
                -- dir = "/g/al1-ce/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "wezterm-types", mods = { "wezterm" } },
                        { path = "xmake-luals-addon/library", files = { "xmake.lua" } },
                    }
                },
                dependencies = {
                    "justinsgithub/wezterm-types",
                    "LelouchHe/xmake-luals-addon"
                }
            }
        },
        config = function()

            local cmp = require("cmp")
            local lspkind = require("lspkind")

            lspkind.init({
                symbol_map = {
                    Text = "",
                    Method = "", -- 󰆧
                    Function = "󰊕",
                    Constructor = "",
                    Field = "󰜢",
                    Variable = "󰀫",
                    Class = "󰠱",
                    Interface = "",
                    Module = "",
                    Property = "󰓹",
                    Unit = "󰑭",
                    Value = "",
                    Enum = "󱡠",
                    Keyword = "󰌋",
                    Snippet = "",
                    Color = "󰏘",
                    File = "",
                    Reference = "",
                    Folder = "󰉋",
                    EnumMember = "",
                    Constant = "󰏿",
                    Struct = "󰙅",
                    Event = "",
                    Operator = "󰆕",
                    TypeParameter = "",
                },
            })

            local snippy = require("snippy")
            snippy.setup({})

            vim.snippet.expand = snippy.expand_snippet
            vim.snippet.active = snippy.is_active
            vim.snippet.stop = function() end
            vim.snippet.jump = function(direction)
                if direction == -1 then
                    if snippy.can_expand() then
                        return snippy.expand_or_advance()
                    else
                        return snippy.can_jump(1) and snippy.next()
                    end
                else
                    return snippy.can_jump(-1) and snippy.previous()
                end
            end

            ---@diagnostic disable-next-line: missing-fields
            cmp.setup({
                snippet = { expand = function(args) vim.snippet.expand(args.body) end, },
                mapping = {
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<Esc>'] = cmp.mapping(function(fallback)
                        if cmp.visible() and cmp.get_active_entry() then cmp.abort() else fallback() end
                    end),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-y>"] = cmp.mapping(cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true, }), { "i", "c" }),
                    -- ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true, }), { "i" }),
                    ["<CR>"] = cmp.mapping(function (fallback)
                        if cmp.visible() and cmp.get_active_entry() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true, })
                        else
                            fallback()
                        end
                    end
                    , { "i" }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = "snippy" },
                }, {
                    { name = 'buffer' },
                    { name = 'lazydev', group_index = 0 }
                    -- { name = 'otter' },
                }),
                window = {
                    completion = {
                        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                        col_offset = -3,
                        side_padding = 0,
                    },
                },
                ---@diagnostic disable-next-line: missing-fields
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(p_entry, p_vim_item)
                        local kind = lspkind.cmp_format({
                            mode = 'symbol_text',  -- show only symbol annotations
                            maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        })(p_entry, p_vim_item)
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        kind.kind = " " .. (strings[1] or "") .. ""
                        kind.menu = "" .. (strings[2] or "") .. ""

                        return kind
                    end
                },
                enabled = function()
                    local cmp_context = require("cmp.config.context")
                    -- disable completion in comments
                    local context = cmp_context
                    -- keep command mode completion enabled when cursor is in a comment
                    if vim.api.nvim_get_mode().mode == 'c' then
                        return true
                    else
                        return not context.in_treesitter_capture("comment")
                            and not context.in_syntax_group("Comment")
                    end
                end,
                view = { entries = { name = 'custom', selection_order = 'near_cursor' } }
            })

            local function jump_up() return vim.snippet.active { direction = -1 } and vim.snippet.jump(1) end
            local function jump_down() return vim.snippet.active { direction =  1 } and vim.snippet.jump(-1) end

            noremap({ "i", "s" }, "<C-k>", jump_up, { desc = "Jump up in snippet" })
            noremap({ "i", "s" }, "<C-j>", jump_down, { desc = "Jump down in snippet" })
            noremap({ "i", "s" }, "<C-up>", jump_up, { desc = "Jump up in snippet" })
            noremap({ "i", "s" }, "<C-down>", jump_down, { desc = "Jump down in snippet" })

            -- SEARCH COMPLETION SETUP

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = 'buffer' } },
                -- view = { entries = { name = 'wildmenu', separator = '  ' } },
                view = { entries = { name = "custom", selection_order = "near_cursor" } }
            })

            -- COMMANDLINE COMPLETION SETUP

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    { { name = 'path' } },
                    { { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' } } } }
                ),
                -- view = { entries = { name = 'wildmenu', separator = '  ' } },
                view = { entries = { name = "custom", selection_order = "near_cursor" } }
            })

        end
    }, -- autocompletion engine
}
