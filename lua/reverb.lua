local settings = require("settings")
local autocmds = require("autocmds")
local state = require("state")

local M = {}

function M.enable()
    state.enabled = true
    vim.notify("reverb.nvim: Plugin enabled", vim.log.levels.INFO)
end

function M.disable()
    state.enabled = false
    vim.notify("reverb.nvim: Plugin disabled", vim.log.levels.INFO)
end

function M.toggle()
    if state.enabled then
        M.disable()
    else
        M.enable()
    end
end

-- opts provided via setup, else default options (no sounds)
function M.setup(opts)
    opts = opts or {}
    local options = vim.tbl_deep_extend("force", settings.options, opts)
    -- Register the autocmd events
    autocmds.load(options)
end

-- register enable/disable
vim.api.nvim_create_user_command("ReverbEnable", M.enable, {})
vim.api.nvim_create_user_command("ReverbDisable", M.disable, {})
vim.api.nvim_create_user_command("ReverbToggle", M.toggle, {})

return M;
