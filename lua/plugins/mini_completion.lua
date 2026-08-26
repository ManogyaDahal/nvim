local ok, mini_completion = pcall(require, "mini.completion")
if not ok then
  return
end

vim.opt.pumheight = 10

local process_items = function(items, base)
  local kind_priority = { Text = -1 }
  local opts = { kind_priority = kind_priority }
  return mini_completion.default_process_items(items, base, opts)
end

mini_completion.setup({
  lsp_completion = {
    process_items = process_items,
  },
  window = {
    info = { height = 15, width = 60, border = "rounded" },
    signature = { height = 10, width = 60, border = "rounded" },
  },
})
