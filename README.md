# nvim

Neovim configuration using `vim.pack` with a focus on a clean, minimal core and on-demand loading for heavier features.
![image](nvim-screenshot.png)

## Requirements

- Neovim 0.12+
- Git
- External tools for formatting (install only what you use):
  - `rustfmt`, `gofmt`, `black`, `usort`, `clang-format`, `shfmt`, `prettierd`

## Setup

Use this config as a separate app name:

- `NVIM_APPNAME=cool nvim` (put configs into the `~/.config/cool` directory for this to work)

Or copy it to `~/.config/nvim`.

## Plugin management

Plugins are declared in `lua/plugins/init.lua` and installed with:

- `:lua vim.pack.update()`

A lockfile is stored at `nvim-pack-lock.json`.

## LSP behavior

LSP servers are configured in `lua/core/lsp.lua` and are enabled on-demand per filetype via `FileType` autocmds. This avoids starting all servers at launch.

## Formatting

Formatting is provided by `conform.nvim`.

- Format manually with `<leader>fm`
- Format on save is disabled by default

## File explorer

`oil.nvim` replaces `nvim-tree` and opens as a floating window.

- Toggle with `<leader>e`

## Commenting

`Comment.nvim` is used for commenting.

- Toggle line comment: `<leader>/` (normal/visual)

## Terminal

`nvterm` provides terminals.

- Float: `Alt+i`
- Horizontal: `Alt+h`
- Vertical: `Alt+v`
- Exit terminal mode: `Ctrl+x`

Line numbers are enabled in terminal buffers.

## Statusline

`lualine` shows a friendly label:

- `nv-term` for terminal buffers
- `oil` for Oil buffers

## Lazy-loaded plugins

These are loaded only on demand (keymap or filetype):

- Harpoon: `<leader>a`, `<leader>o`
- Peek: `<leader>mp` or `markdown/vimwiki` filetype
- Vimwiki: `<leader>ww`, `<leader>wt`, `<leader>ws` or `vimwiki/wiki` filetype

## Keymaps (highlights)

- Buffer navigation: `<Tab>` / `<S-Tab>`
- Clear search highlight: `<Esc>`
- Centered search results: `n`, `N`
- Wrap-aware movement: `j`, `k`
- Yank to clipboard: `<leader>y`
- Delete without yanking: `<leader>d`
- Paste without yanking: `<leader>p` (visual)
- Split vertical: `<leader>sv`
- Close buffer: `<leader>x`

## Notes

- Diagnostics are configured in `lua/core/diagnostics.lua`
- `signcolumn` is always on to avoid line number shifting
- `nvim-cmp` is enabled (native autocomplete disabled)

If you want further optimization, extend lazy-loading for additional plugins or add more filetype triggers.
