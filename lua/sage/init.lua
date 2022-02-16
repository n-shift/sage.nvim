local sage = {}

function sage.range_pos()
    local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
    local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))
    return {start_row, start_col, end_row, end_col}
end

function sage.get_range()
    local positions = sage.range_pos()
    local chunk = vim.api.nvim_buf_get_lines(0, positions[1]-1, positions[3], true)
    if #chunk == 1 then
        chunk[1] = chunk[1]:sub(positions[2]+1, positions[4]+1)
        return chunk[1]
    else
        return
    end
end

function sage.get_word()
    return vim.fn.expand("<cword>")
end

function sage.get_line()
    return vim.fn.getline(".")
end

function sage.prompt(prompt)
    return vim.fn.input(prompt)
end

function sage.set_link()
    local word = sage.get_word()
    local line = sage.get_line()
    local uri = sage.prompt("Uri: ")
    line = line:gsub(word, string.format("[%s](%s)", word, uri))
    vim.fn.setline(".", line)
end

function sage.set_link_range()
    local positions = sage.range_pos()
    local chunk = vim.api.nvim_buf_get_lines(0, positions[1]-1, positions[3], true)
    local changing_chunk = sage.get_range()
    if not changing_chunk then
        return
    end
    local uri = sage.prompt("Uri: ")
    chunk[1] = chunk[1]:gsub(changing_chunk, string.format("[%s](%s)", changing_chunk, uri))
    vim.api.nvim_buf_set_lines(0, positions[1]-1, positions[3], true, chunk)
end

return sage
