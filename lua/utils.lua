local M = {}

local function convert_volume(human_volume)
    human_volume = human_volume or 100
    local clamped_volume = math.max(0, math.min(100, human_volume))
    local paplay_volume = math.floor(clamped_volume * 655.36)
    return paplay_volume
end

-- Play a sound using paplay
M.play_sound = function(path, human_volume)
    local paplay_volume = convert_volume(human_volume)
    vim.system({ 'paplay', path, '--volume', tostring(paplay_volume) })
end

-- Good old path exists function
M.path_exists = function(path)
    local ok, err, code = os.rename(path, path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok, err
end

return M;
