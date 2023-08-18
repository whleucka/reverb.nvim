local settings = require("settings")
local autocmds = require("autocmds")

local M = {}

-- opts provided via setup, else default options (no sounds)
function M.setup(opts)
    opts = opts or {}
    local options = vim.tbl_deep_extend("force", settings.options, opts)
    -- Register the autocmd events
    autocmds.load(options)
end


return M;
