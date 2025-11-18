return {
    -- Alisgn text [ glip= ]
    {
        'tommcdo/vim-lion',
        config = function()
            vim.g.lion_create_map = 1
            vim.g.lion_squeeze_spaces = 1
        end
    },
    -- cool smart surrounding cs ys ds
    {
        -- 'tpope/vim-surround',
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true
    },

}
