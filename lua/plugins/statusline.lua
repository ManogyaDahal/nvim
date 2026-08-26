local ok_lualine, lualine = pcall(require, "lualine")
if not ok_lualine then
  return
end

local function diff_source()
  local dict = vim.b.gitsigns_status_dict
  if not dict then
    return nil
  end
  return {
    added = dict.added or 0,
    modified = dict.changed or 0,
    removed = dict.removed or 0,
  }
end

local function lsp_clients()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if #clients == 0 then
    return "LSP: off"
  end
  local names = {}
  for _, c in ipairs(clients) do
    table.insert(names, c.name)
  end
  return " " .. table.concat(names, ",")
end

local custom_theme = require('lualine.themes.auto') -- Replace 'auto' with your theme name
local normal_bg = custom_theme.normal.a.bg
local normal_fg = custom_theme.normal.a.fg
custom_theme.insert.a = { bg = normal_bg, fg = normal_fg }
custom_theme.visual.a = { bg = normal_bg, fg = normal_fg }

lualine.setup({
  options = {
    theme = custom_theme,
    icons_enabled = true,
    globalstatus = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "branch", icon = "" },
      { "diff", source = diff_source },
    },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {
      lsp_clients,
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
})
