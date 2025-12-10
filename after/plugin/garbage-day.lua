require("modules").try_setup("garbage-day", {
    notifications = true,
    grace_period = 60 * 15,
    aggresive_mode = false,
    notification_engine = "fidget",
    excluded_lsp_clients = { "null-ls", "jdtls", "marksman", "dartls", "vtsls", "serve_d" }
})

