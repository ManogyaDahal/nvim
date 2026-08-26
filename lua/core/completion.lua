local M = {}

-- Tab completion
function M.smart_tab()
  if vim.fn.pumvisible() == 1 then
    return "<C-n>"
  end
  return "<Tab>"
end

-- Shift-Tab completion
function M.smart_s_tab()
  if vim.fn.pumvisible() == 1 then
    return "<C-p>"
  end
  return "<S-Tab>"
end

return M
