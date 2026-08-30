require("mini.indentscope").setup({
  options = {
    indent_at_cursor = false,
    try_as_border = true,
  },
  symbol = '╎',
})
vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", {
  fg = "#5c5c74", -- Change this to your desired hex color
  nocombine = true,
})
