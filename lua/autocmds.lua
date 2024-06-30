local utils = require("utils")

local M = {}

vim.api.nvim_create_augroup("reverb", {
    clear = true,
})

local missing_sounds = {}

-- Autocmd callback
local cb = function(event, sound)
    if utils.path_exists(sound.path) then
        -- There could be other events?
        if event == "BufWrite" then
            -- only if the buffer has been modified ?
            local buf = vim.api.nvim_get_current_buf()
            local buf_modified = vim.api.nvim_buf_get_option(buf, "modified")
            if buf_modified then
                utils.play_sound(sound.path, sound.volume)
            end
        else
            utils.play_sound(sound.path, sound.volume)
        end
    else
        if not missing_sounds[sound.path] then
            missing_sounds[sound.path] = true
            print("file " .. sound.path .. "does not exist")
        end
    end
end

-- Options are loaded from lua/reverb.lua
M.load = function(opts)
    for _, sounds in pairs(opts) do
        for event, sound in pairs(sounds) do
            vim.api.nvim_create_autocmd(event, {
                group = "reverb",
                pattern = "*",
                callback = function()
                    cb(event, sound)
                end,
            })
        end
    end
end

return M
