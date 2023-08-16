local M = {}

local DEFAULT_OPTS = {
    sounds = {
        buf_read = nil,
        cursor_moved = nil,
        insert_enter = nil,
        insert_leave = nil,
        exit_pre = nil,
        buf_write = nil,
    }
}

M.options = DEFAULT_OPTS

return M;
