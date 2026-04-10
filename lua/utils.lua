local M = {}
local uv = vim.uv
local state = require("state")

-- Returns a value between 0.0 and 1.0
local function convert_volume(human_volume)
    human_volume = human_volume or 100
    local clamped_volume = math.max(0, math.min(100, human_volume))
    local normalized_volume = clamped_volume / 100.0
    return normalized_volume
end

-- Spawn a player process and handle cleanup
local function spawn_player(cmd, args)
    local handle
    handle = uv.spawn(cmd, { args = args }, function(code)
        state.running_processes = state.running_processes - 1
        if handle and not handle:is_closing() then
            handle:close()
        end
        if code ~= 0 then
            vim.schedule(function()
                vim.notify("reverb.nvim: Couldn't play sound, exit code: " .. code, vim.log.levels.ERROR)
            end)
        end
    end)
    if handle == nil then
        vim.notify("reverb.nvim: Could not spawn " .. cmd, vim.log.levels.ERROR)
    end
end

-- Play a sound using paplay
M.paplay_play_sound = function(path, human_volume)
    local volume = math.floor(convert_volume(human_volume) * 65536.0)
    spawn_player('paplay', { path, '--volume', tostring(volume) })
end

-- Play a sound using pw-play
M.pw_play_play_sound = function(path, human_volume)
    local volume = convert_volume(human_volume)
    spawn_player('pw-play', { path, '--volume', tostring(volume) })
end

-- Play a sound using mpv
M.mpv_play_sound = function(path, human_volume)
    local volume = convert_volume(human_volume) * 100
    spawn_player('mpv', { path, '--volume=' .. tostring(volume), '--no-keep-open' })
end

-- Check if a file exists using libuv
M.path_exists = function(path)
    local stat = uv.fs_stat(path)
    return stat ~= nil
end

return M
