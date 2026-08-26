local status, peek = pcall(require, "peek")
if not status then
  return
end

local map = vim.keymap.set

peek.setup({
  auto_load = true,
  filetype = { "markdown", "vimwiki" },
  syntax = true,
  throttle_time = "auto",
  close_on_bdelete = true,
  theme = "dark",
  app = { "qutebrowser" },
})

vim.api.nvim_create_user_command("PeekToggle", function()
  if not peek.is_open() and vim.bo[vim.api.nvim_get_current_buf()].filetype == "markdown" then
    peek.open()
  elseif peek.is_open() then
    peek.close()
  end
end, {})

map("n", "<leader>mp", "<cmd>PeekToggle<CR>", { desc = "Toggle Peek.nvim [Markdown Preview]" })
