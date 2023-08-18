local utils = require("utils")

local M = {}

vim.api.nvim_create_augroup("reverb", {
    clear = true,
})

-- Autocmd callback
local cb = function(event, path)
    if utils.path_exists(path) then
        -- There could be other events?
        if event == "BufWrite" then
            -- only if the buffer has been modified ?
            local buf = vim.api.nvim_get_current_buf()
            local buf_modified = vim.api.nvim_buf_get_option(buf, "modified")
            if buf_modified then
                utils.play_sound(path)
            end
        else
            utils.play_sound(path)
        end
    end
end

-- Options are loaded from lua/reverb.lua
M.load = function(opts)
    for _, sound in pairs(opts) do
        for event, path in pairs(sound) do
            vim.api.nvim_create_autocmd(event, {
                group = "reverb",
                pattern = "*",
                callback = function()
                    cb(event, path)
                end,
            })
        end
    end
end

return M
