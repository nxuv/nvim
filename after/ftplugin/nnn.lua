vim.keymap.set('t', '<Esc>', function()
    vim.api.nvim_feedkeys(vim.keycode('q'), 'n', true)
end, { buffer = vim.api.nvim_get_current_buf() })
