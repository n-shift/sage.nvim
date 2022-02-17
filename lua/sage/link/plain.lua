local plain = {}
local utils = require("sage.utils")

function plain.set_link()
    local word = utils.get_word()
    local line = utils.get_line()
    local uri = utils.prompt("Uri: ")
    local word_start = utils.word_nearby(line, word)

    local editable = { line:sub(1, word_start), line:sub(word_start + 1 + #word) }

    local link = string.format("[%s](%s)", word, uri)
    local modified_line = editable[1] .. link .. editable[2]
    vim.fn.setline(".", modified_line)
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
