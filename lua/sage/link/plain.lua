local plain = {}
local utils = require("sage.utils")

function plain.set_link()
    local uri = utils.prompt("Uri: ")
    local link = string.format("[%s](%s)", word, uri)
    utils.modify_line(link)
end

function plain.set_link_range()
    local positions = utils.range_pos()
    local chunk = vim.api.nvim_buf_get_lines(0, positions[1]-1, positions[3], true)
    local changing_chunk = utils.get_range()
    if not changing_chunk then
        return
    end
    local uri = utils.prompt("Uri: ")
    chunk[1] = chunk[1]:gsub(changing_chunk, string.format("[%s](%s)", changing_chunk, uri))
    vim.api.nvim_buf_set_lines(0, positions[1]-1, positions[3], true, chunk)
end

return plain
