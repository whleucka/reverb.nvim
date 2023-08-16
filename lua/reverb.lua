local settings = require("settings")

function M.setup(opts)
    opts = opts or {}
    settings.options = vim.tbl_deep_extend("force", settings.options, opts)
end

require("autocmds")

return M;
