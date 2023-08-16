local play_sound = require("utils").play_sound

vim.api.nvim_create_augroup("reverb", {
    clear = true,
})
vim.api.nvim_create_autocmd("BufRead", {
    group = "reverb",
    pattern = "*",
    callback = function()
        play_sound("buf_read")
    end,
})
vim.api.nvim_create_autocmd("CursorMovedI", {
    group = "reverb",
    pattern = "*",
    callback = function()
        play_sound("cursor_moved")
    end,
})
vim.api.nvim_create_autocmd("InsertEnter", {
    group = "reverb",
    pattern = "*",
    callback = function()
        play_sound("insert_enter")
    end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    group = "reverb",
    pattern = "*",
    callback = function()
        play_sound("insert_leave")
    end,
})
vim.api.nvim_create_autocmd("ExitPre", {
    group = "reverb",
    pattern = "*",
    callback = function()
        play_sound("exit_pre")
    end,
})
vim.api.nvim_create_autocmd("BufWrite", {
    group = "reverb",
    pattern = "*",
    callback = function()
        -- only if the buffer has been modified
        local buf = vim.api.nvim_get_current_buf()
        local buf_modified = vim.api.nvim_buf_get_option(buf, "modified")
        if buf_modified then
            play_sound("buf_write")
        end
    end,
})
