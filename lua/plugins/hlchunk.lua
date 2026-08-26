vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  once = true,
  callback = function()
    vim.cmd("packadd hlchunk.nvim")
    require("hlchunk").setup({})
  end,
})
