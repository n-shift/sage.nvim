local ts_utils = {}

function ts_utils.get_named_node_pos(type)
    local result = {}
    vim.treesitter.get_parser(0, "markdown"):for_each_tree(function(tree)
        local root = tree:root()
        local function lower(node)
            for child, _ in node:iter_children() do
                if child:type() == type then
                    table.insert(result, {child:range()})
                else
                    for _, node_child in ipairs(lower(child) or {}) do
                        table.insert(result, {node_child:range()})
                    end
                end
            end
        end
        lower(root)
    end)
    return result
end

-- row1 col1 row2 col2
function ts_utils.get_named_node_content(type)
    local result = {}
    local positions = ts_utils.get_named_node_pos(type)
    for _, node_pos in pairs(positions) do
        local start_row, start_col, end_row, end_col = unpack(node_pos)
        table.insert(result, vim.api.nvim_buf_get_lines(0, start_row, end_row, true))
    end

    return result
end

return ts_utils
