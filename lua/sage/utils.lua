local utils = {}

function utils.range_pos()
    local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
    local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))
    return {start_row, start_col, end_row, end_col}
end

function utils.get_range()
    local positions = utils.range_pos()
    local chunk = vim.api.nvim_buf_get_lines(0, positions[1]-1, positions[3], true)
    if #chunk == 1 then
        chunk[1] = chunk[1]:sub(positions[2]+1, positions[4]+1)
        return chunk[1]
    else
        return
    end
end

function utils.get_word()
    return vim.fn.expand("<cword>")
end

function utils.get_line()
    return vim.fn.getline(".")
end

function utils.prompt(prompt)
    return vim.fn.input(prompt)
end

return utils
