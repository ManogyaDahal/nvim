local opt = vim.opt
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

g.vimwiki_list = { { path = "~/.vimwiki/", ext = ".wiki" }, { path = "~/.personal/", ext = ".wiki" } }
g.vimwiki_ext2syntax = vim.empty_dict()
g.vimwiki_wikilocal_vars = {}
g.luasnippets_path = { vim.fn.stdpath("config") .. "/lua/custom/snippets" }

opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.wrap = false
opt.clipboard = "unnamedplus"
opt.iskeyword:append({ "-", "_" })
opt.isfname:append("@-@")
opt.scrolloff = 8
opt.colorcolumn = "80"
opt.hlsearch = false
opt.incsearch = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.showmode = false
opt.completeopt = { "menu", "menuone", "noselect" }
opt.winborder = "rounded"
opt.showtabline=0

autocmd("VimResized", { pattern = "*", command = "tabdo wincmd =" })

if g.neovide then
	opt.guifont = "Hack Nerd Font:h13"
	g.neovide_cursor_antialiasing = true
	g.neovide_transparency = 0.9
	g.neovide_padding_bottom = 0
	g.neovide_padding_top = 0
	g.neovide_padding_right = 0
	g.neovide_padding_left = 0
	g.neovide_confirm_quit = true
	g.neovide_fullscreen = false
	g.neovide_remember_window_size = true
	g.neovide_scale_factor = 0.8
	g.neovide_refresh_rate = 60
	g.neovide_cursor_animation_length = 0.1
	g.neovide_cursor_trail_size = 0.1
	g.neovide_cursor_vfx_opacity = 200.0
end
