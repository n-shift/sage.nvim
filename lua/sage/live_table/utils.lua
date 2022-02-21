local table_utils = {}

function table_utils.buf()
    local bufnr = vim.api.nvim_create_buf(true, true)
    table_utils.bufnr = bufnr
    return bufnr
end

function table_utils.parse_row(row)
    return vim.split(row, "|")
end

function table_utils.generate_text_table(parsed)
    return vim.inspect(parsed)
end

table_utils.current_table = {}

function table_utils.set(object)
    table_utils.current_table = object
end

function table_utils.decode_row(row)
    return table.concat(row, "|")
end

return table_utils
