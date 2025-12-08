return {
    -- Colour picker and colour background
    {
        "uga-rosa/ccc.nvim",
        event = { "BufEnter", "BufNew" },
        opts = {
            highlighter = {
                auto_enable = true,
                lsp = true
            }
        },
        keys = {
            { "<leader>cp", "<cmd>CccPick<cr>", mode = "n", noremap = true, silent = true, desc = "Opens color picker" },
        },
    },
    {
        'jakemason/ouroboros',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            extension_preferences_table = {
                c = { h = 2, hpp = 1 },
                h = { c = 2, cpp = 1 },
                cpp = { hpp = 2, h = 1 },
                hpp = { cpp = 2, c = 1 },
            },
            switch_to_open_pane_if_possible = true,
        },
        cmd = "Ouroboros",
        ft = { "c", "cpp" },
        keys = {
            { "gh", "<cmd>Ouroboros<cr>", mode = "n", noremap = true, silent = true, desc = "Switch to header", ft = { "c", "cpp" } },
        }
    },
    {
        "nxuv/mdeval.nvim",
        event = "VimEnter",
        opts = {
            require_confirmation = false,
            always_multiline = true,
            results_label = "*Results:*",
            eval_options = {
                cpp = {
                    command = {"g++", "-std=c++20", "-O0"},
                    default_header = [[
                    #include <iostream>
                    #include <vector>
                    using namespace std;
                    ]],
                    default_footer = [[ ]],
                    extension = "cpp",
                    language_code = "cpp",
                },
                d = {
                    command = {"ldc2"},
                    language_code = "d",
                    exec_type = "compiled",
                    extension = "d",
                    output_flag = "-of",
                    default_header = [[ import std; void main() { ]],
                    default_footer = [[ } ]],
                },
            },
        },
        ft = { "md" },
        keys = {
            { "<leader>xc", "<cmd>lua require 'mdeval'.eval_code_block()<CR>", mode = "n", noremap = true, silent = true, desc = "E[X]ecute [C]ode Block" },
        },
    },

}
