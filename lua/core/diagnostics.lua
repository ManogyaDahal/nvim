local sev = vim.diagnostic.severity

vim.diagnostic.config({
  virtual_text = { spacing = 2, source = "if_many", prefix = "●" },
  signs = {
    text = {
      [sev.ERROR] = "E",
      [sev.WARN] = "W",
      [sev.INFO] = "I",
      [sev.HINT] = "H",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many", max_width = 80, wrap_at = 80 },
})

vim.diagnostic.enable()
