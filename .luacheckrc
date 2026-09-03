-- luacheck configuration for a Neovim plugin.
--
-- Neovim embeds LuaJIT and injects the `vim` global at runtime, neither of
-- which luacheck can know about -- without this, every vim.* call is reported
-- as an undefined global and the whole file drowns in noise.

std = "luajit"

-- `globals`, not `read_globals`. The Neovim API is genuinely assignable --
-- `vim.bo.modifiable = false`, `vim.opt.x`, `vim.g.y` are all normal usage --
-- and read_globals reports every one of them as "setting read-only field of
-- global vim". Declaring it read-only is simply wrong about the API.
globals = { "vim" }

-- Long explanatory comments are the house style in this codebase; line length
-- is not a defect worth failing a build over.
max_line_length = false

-- Callback signatures are fixed by the caller (nvim autocmds, plugin APIs,
-- picker `on_select(component, item)` handlers), so a callback that ignores an
-- argument it is handed is correct code, not dead code. Enforcing this would
-- mean renaming ~9 parameters to `_name` purely to satisfy the linter.
-- Unused *locals* and unused *values* are still reported -- only arguments are
-- exempt.
unused_args = false
