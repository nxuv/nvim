---@diagnostic disable: missing-fields
return {
    -- show buffer diagnostic in top right corner
    {
        "ivanjermakov/troublesum.nvim",
        opts = {
            enabled = true,
        }
    },
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
        dependencies = "neovim/nvim-lspconfig",
        event = "VeryLazy",
        opts = {
            notifications = true,
            grace_period = 60 * 15,
            aggresive_mode = false,
            notification_engine = "fidget",
            excluded_lsp_clients = {
                "null-ls", "jdtls", "marksman", "dartls", "vtsls"
            }
        }
    },
}
