local utils = require("utils")

local M = {}

vim.api.nvim_create_augroup("reverb", {
    clear = true,
})

local missing_sounds = {}

RUNNING_PROCESSES = 0

-- Autocmd callback
local cb = function(event, sound, player)
    local path = vim.fn.expand(sound.path)

    if RUNNING_PROCESSES >= 15 then
        return
    end

    -- Choose which player command should be used
    -- Choose paplay as default
    local player_function = utils.paplay_play_sound
    if player == "paplay" then
        player_function = utils.paplay_play_sound
    elseif player == "pw-play" then
        player_function = utils.pw_play_play_sound
    end

    if utils.path_exists(path) then
        -- There could be other events?
        if event == "BufWrite" then
            -- only if the buffer has been modified ?
            local buf = vim.api.nvim_get_current_buf()
            local buf_modified = vim.api.nvim_buf_get_option(buf, "modified")
            if buf_modified then
                RUNNING_PROCESSES = RUNNING_PROCESSES + 1
                player_function(path, sound.volume)
            end
        else
            RUNNING_PROCESSES = RUNNING_PROCESSES + 1
            player_function(path, sound.volume)
        end
    else
        if not missing_sounds[path] then
            missing_sounds[path] = true
            print("file " .. path .. "does not exist")
        end
    end
end

-- Options are loaded from lua/reverb.lua
M.load = function(opts)
    local sounds = opts.sounds
    for event, sound in pairs(sounds) do
        vim.api.nvim_create_autocmd(event, {
            group = "reverb",
            pattern = "*",
            callback = function()
                cb(event, sound, opts.player)
            end,
        })
    end
end

return M
