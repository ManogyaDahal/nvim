local ok, hop = pcall(require, "hop")
if not ok then
  return
end

local directions = require("hop.hint").HintDirection

vim.keymap.set("", "s", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, { remap = true })

vim.keymap.set("", "S", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, { remap = true })

vim.keymap.set("", "t", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
end, { remap = true })

vim.keymap.set("", "T", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
end, { remap = true })

hop.setup({})
