local ok, telescope = pcall(require, "telescope")
if not ok then
	return
end

telescope.setup({
	defaults = {
		preview = { treesitter = false },
		color_devicons = true,
		sorting_strategy = "ascending",
		borderchars = {
			"", -- top
			"", -- right
			"", -- bottom
			"", -- left
			"", -- top-left
			"", -- top-right
			"", -- bottom-right
			"", -- bottom-left
		},
		path_displays = { "smart" },
		layout_config = {
			height = 100,
			width = 400,
			prompt_position = "top",
			preview_cutoff = 40,
		}
	}
})

local builtin = require("telescope.builtin")
local map = vim.keymap.set

map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fw", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
map("n", "<leader>fo", builtin.oldfiles, { desc = "Recent files" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
map("n", "<leader>fc", builtin.commands, { desc = "Commands" })
map("n", "<leader>fr", builtin.resume, { desc = "Resume last picker" })
map("n", "<leader>ss", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy find in current buffer" })
map("n", "<leader>gr", builtin.lsp_references, { desc = "LSP references" })
map("n", "<leader>ad", builtin.diagnostics, { desc = "Diagnostics" })
map("n", "gd", builtin.lsp_definitions, { desc = "Goto definition" })
map("n", "<leader>sm", builtin.man_pages, { desc = "Man pages" })
map("n", "<leader>si", builtin.lsp_implementations, { desc = "LSP implementations" })
map("n", "<leader>sT", builtin.lsp_type_definitions, { desc = "LSP type definitions" })
map("n", "<leader>st", builtin.builtin, { desc = "Telescope builtins" })
map("n", "<leader>sc", builtin.git_bcommits, { desc = "Git buffer commits" })
map("n", "<leader>sk", builtin.keymaps, { desc = "Keymaps" })
