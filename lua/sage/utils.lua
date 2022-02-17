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

function utils.prompt(prompt, funcname)
    if funcname then
        local completion = "custom,"..funcname
        return vim.fn.input(prompt, "", completion)
    else
        return vim.fn.input(prompt)
    end
end

function utils.word_nearby(line, word)
    local current_pos = vim.fn.col(".")
    local without_word = vim.split(line, word)
    local modified = line:gsub(word, "")
    local occurence = (#line - #modified) / #word

    local len = 0
    for idx, unit in ipairs(without_word) do
        if idx == #without_word then break end
        if len < current_pos then
            len = len + #unit + #word
        elseif len >= current_pos then
            break
        end
    end

    return len - #word
end

function utils.modify_line(link)
    local word = utils.get_word()
    local line = utils.get_line()
    local word_start = utils.word_nearby(line, word)
    local editable = { line:sub(1, word_start), line:sub(word_start + 1 + #word) }
    local modified_line = editable[1]..link..editable[2]
    vim.fn.setline(".", modified_line)
end

function utils.remove_chars(str, chars)
    return utils.replace_chars(str, chars, "")
end

function utils.replace_chars(str, chars, replacement)
    chars = vim.split(chars, "")
    for _, char in ipairs(chars) do
        str = str:gsub(vim.pesc(char), replacement)
    end
    return str
end

function utils.header_format(raw)
    local preformatted = raw:gsub("# ", "")
    local remove = "#####!@$^&*()+=~`'\":;,.?№{}[]|/"
    local format_removed = utils.remove_chars(preformatted, remove)
    return utils.replace_chars(format_removed, " ", "-")
end

return utils
