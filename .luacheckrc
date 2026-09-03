-- luacheck configuration for a Neovim plugin.
--
-- Neovim embeds LuaJIT and injects the `vim` global at runtime, neither of
-- which luacheck can know about -- without this, every vim.* call is reported
-- as an undefined global and the whole file drowns in noise.

std = "luajit"

-- Read-only: the plugin uses the API but must never assign to `vim` itself.
read_globals = { "vim" }

-- Long explanatory comments are the house style in this codebase; line length
-- is not a defect worth failing a build over. Real problems -- undefined
-- globals, shadowing, unreachable code, unused variables -- still fail.
max_line_length = false
