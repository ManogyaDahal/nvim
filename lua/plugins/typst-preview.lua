local ok, typst_preview = pcall(require, "typst-preview")
if not ok then
  return
end

typst_preview.setup({
  open_cmd = "qutebrowser %s",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "typst",
  callback = function(ev)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, noremap = true, silent = true, desc = desc })
    end

    map("<leader>tp", "<cmd>TypstPreview<cr>", "Typst preview")
    map("<leader>tt", "<cmd>TypstPreviewToggle<cr>", "Typst preview toggle")
    map("<leader>ts", "<cmd>TypstPreviewStop<cr>", "Typst preview stop")
    map("<leader>tf", "<cmd>TypstPreviewFollowCursorToggle<cr>", "Typst follow cursor toggle")
    map("<leader>tc", "<cmd>TypstPreviewSyncCursor<cr>", "Typst sync cursor")
  end,
})
