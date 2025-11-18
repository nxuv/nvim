return {
    {
        'numToStr/Comment.nvim',
        lazy = false,
        opts = {
            ignore = "^$",
            mappings = {
                ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                basic = true,
                ---Extra mapping; `gco`, `gcO`, `gcA`
                extra = true,
            }
        }
    },
}

