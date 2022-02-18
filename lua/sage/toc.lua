local utils = require("sage.utils")
local ts_utils = require("sage.ts_utils")

local function toc_line(x, content, formatted)
    local tabs = string.rep(" ", (x - 1) * 4)
    return string.format("%s* [%s](%s)", tabs, content, formatted)
end


local function toc()
    local headings_raw = ts_utils.get_named_node_content("atx_heading")
    headings_raw = vim.tbl_flatten(headings_raw)
    local headings_formatted = {}
    local headings = {}
    local header_x = {}
    for idx, heading in ipairs(headings_raw) do
        headings[idx] = utils.header_content(heading)[1]
        header_x[idx] = utils.header_content(heading)[2]
        headings_formatted[idx] = utils.header_format(heading)
    end

    local toc = {
        "Table of contents",
        "=================",
    }
    for idx = 1, #headings do
        table.insert(toc, toc_line(header_x[idx], headings[idx], headings_formatted[idx]))
    end
    
    local line = vim.fn.line(".")
    vim.fn.append(line, toc)
end

return toc
