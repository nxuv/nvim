require("modules").try_setup("nvim-treesitter.configs", {
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

