local M = {}

-- Play a sound using paplay
M.play_sound = function (path)
    vim.fn.system(string.format("paplay %s &", path))
end

-- Good old path exists function 
M.path_exists = function (path)
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
