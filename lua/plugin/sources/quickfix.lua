return {
    -- Goto quickfix files
    { 'yssl/QFEnter' },
    {
        'yorickpeterse/nvim-pqf',
        enabled = true,
        config = function()
            local pqf = require("pqf")
            pqf.setup({
                signs = {
                    error = { text = '', hl = "DiagnosticSignError" },
                    warning = { text = '', hl = "DiagnosticSignWarn" },
                    info = { text = '', hl = "DiagnosticSignInfo" },
                    hint = { text = '', hl = "DiagnosticSignHint" } -- note
                },
                show_multiple_lines = true,
                max_filename_length = 20,
            })
        end
    }
}
