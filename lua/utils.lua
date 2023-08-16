local settings = require("settings")

local M = {}

M.play_sound = function (event)
    if settings.options.sounds[event] == nil then
        return
    end
    vim.fn.system(string.format("paplay %s &", settings.options.sounds[event]))
end

return M;
