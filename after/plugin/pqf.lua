require("modules").try_setup("pqf", {
    signs = {
        error   = { text = '[x]', hl = "DiagnosticSignError" },
        warning = { text = '[w]', hl = "DiagnosticSignWarn" },
        info    = { text = '[i]', hl = "DiagnosticSignInfo" },
        hint    = { text = '[n]', hl = "DiagnosticSignHint" }
    },
    show_multiple_lines = true,
    max_filename_length = 20,
})

