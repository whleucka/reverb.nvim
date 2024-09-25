local settings = require("settings")
local autocmds = require("autocmds")

local M = {}

PLUGIN_ENABLED = true -- default

function M.enable()
    PLUGIN_ENABLED = true
    print("reverb.nvim: Plugin enabled")
end

function M.disable()
    PLUGIN_ENABLED = false
    print("reverb.nvim: Plugin disabled")
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


return M;
