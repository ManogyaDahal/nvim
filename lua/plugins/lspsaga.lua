local ok, _ = pcall(require, "lspsaga")
if not ok then
	return
end

require("lspsaga").setup({
	ui = {
		border = vim.o.winborder,
		devicon = true,
		foldericon = true,
		title = true,
		use_nerd = true,
	},
	-- Only the breadcrumb (symbol_in_winbar) is desired. All other LSP Saga
	-- services are left unmapped/unbound and quiet. The flags below disable the
	-- ones that register autocmds/signs automatically.
	lightbulb = {
		enable = false,
	},
	beacon = {
		enable = false,
	},
	implement = {
		enable = false,
	},
	symbol_in_winbar = {
		enable = true,
		separator = " › ",
		hide_keyword = false,
		show_file = true,
		folder_level = 1,
		color_mode = true,
		delay = 300,
	},
})

require("lspsaga.symbol.winbar").get_bar()
