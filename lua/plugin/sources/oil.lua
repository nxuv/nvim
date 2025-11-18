return {
    {
        "stevearc/oil.nvim",
        enabled = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            default_file_explorer = false,
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<cr>"] = "actions.select",
                ["<C-s>"] = "actions.select_vsplit",
                ["<C-h>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["q"] = "actions.close",
                ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["gh"] = { desc = "Open home directory", callback = function(opts) require("oil").open("~")  end },
                ["gc"] = "actions.open_cwd",
            },
            use_default_keymaps = false,
            delete_to_trash = true,
            view_options = {
                show_hidden = true
            }
        },
        -- event = "VimEnter",
        keys = {
            { "<leader>fo",         "<cmd>Oil<cr>",                               mode = "n", noremap = true, silent = true, desc = "Opens parent directory" },
            -- { "<leader>-", function() require("oil").toggle_float() end, mode = "n", noremap = true, silent = true, desc = "Opens parent directory in float" },
        },
    }
}
