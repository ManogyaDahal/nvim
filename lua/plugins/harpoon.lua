local ok, mark = pcall(require, "harpoon.mark")
if not ok then
  vim.notify("harpoon.mark not found", vim.log.levels.WARN)
  return
end

local ok_ui, ui = pcall(require, "harpoon.ui")
if not ok_ui then
  vim.notify("harpoon.ui not found", vim.log.levels.WARN)
  return
end

local keymap = vim.keymap.set
local opts = function(desc) return { desc = desc, noremap = true, silent = true } end

keymap("n", "<leader>a", mark.add_file,        opts("Harpoon add file"))
keymap("n", "<leader>o", ui.toggle_quick_menu, opts("Harpoon quick menu"))

for i = 1, 4 do
  keymap("n", "<leader>" .. i, function()
    ui.nav_file(i)
  end, opts("Harpoon file " .. i))
end
