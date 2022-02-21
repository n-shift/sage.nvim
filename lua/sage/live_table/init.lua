local live_table = {}
local utils = require("sage.utils")
local t_utils = require("sage.live_table.utils")

function live_table.row()
    local line = utils.get_line()
    _, live_table.linenr, _, _, _ = unpack(vim.fn.getcurpos())
    live_table.bufnr_init = vim.api.nvim_get_current_buf()
    local parsed = t_utils.parse_row(line)
    local text = t_utils.generate_text_table(parsed)
    t_utils.set({tbl = parsed, txt = text})
    local bufnr = t_utils.buf()
    vim.cmd("sbuffer "..bufnr)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, {"--!line", "return", t_utils.current_table.txt})
end

function live_table.range()
end

function live_table.table()
end

function live_table.apply()
    local bufnr = t_utils.bufnr
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
    local chunk = table.concat(lines, '\n')
    local table = loadstring(chunk)()
    local line = t_utils.decode_row(table)
    if lines[1] == "--!line" then
        vim.api.nvim_buf_set_lines(live_table.bufnr_init, live_table.linenr - 1, live_table.linenr, true, {line})
    end
end

return live_table
