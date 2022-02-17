local heading = {}
local utils = require("sage.utils")
local ts_utils = require("sage.ts_utils")

function heading.completion()
    local atx_content = ts_utils.get_named_node_content("atx_heading")
    local setext_content = ts_utils.get_named_node_content("setext_heading")
    local merged = vim.tbl_flatten({atx_content, setext_content})
    local completion_text = table.concat(merged, "\n")
    return completion_text
end

function heading.set_link()
    local word = utils.get_word()

    local raw = utils.prompt("Heading: ", "SageHeadingCompletion")
    local formatted = utils.header_format(raw)

    local link = string.format("[%s](#%s)", word, formatted)
    utils.modify_line(link)
end

function heading.set_link_range()
    local positions = utils.range_pos()
    local chunk = vim.api.nvim_buf_get_lines(0, positions[1]-1, positions[3], true)
    local changing_chunk = utils.get_range()
    if not changing_chunk then
        return
    end

    local raw = utils.prompt("Heading: ", "SageHeadingCompletion")
    local formatted = utils.header_format(raw)
    chunk[1] = chunk[1]:gsub(changing_chunk, string.format("[%s](%s)", changing_chunk, formatted))
    vim.api.nvim_buf_set_lines(0, positions[1]-1, positions[3], true, chunk)
end

return heading
