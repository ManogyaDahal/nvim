local keymap = vim.keymap.set

local function toggle_undotree()
  vim.cmd.UndotreeToggle()
  local undotree_win = vim.fn.win_findbuf(vim.fn.bufnr("undotree"))[1]
  if undotree_win then
    vim.api.nvim_win_set_width(undotree_win, 35)
  end
end

keymap("n", "<leader>u", toggle_undotree, { desc = "Toggle Undotree" })
