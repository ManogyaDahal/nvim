local map = vim.keymap.set
local opts = function(desc) return { desc = desc, noremap = true, silent = true } end
local function mapn(lhs, rhs, desc, extra)
	local base = opts(desc)
	if extra then
		for k, v in pairs(extra) do
			base[k] = v
		end
	end
	map("n", lhs, rhs, base)
end
local completion = require("core.completion")
local function nomap(mode, lhs)
	pcall(vim.keymap.del, mode, lhs)
end

-- ─── Lazy loading ────────────────────────────────────────────────────────────

local lazy_loaded = {
	harpoon  = false,
	peek     = false,
	vimwiki  = false,
}

local function load_plugin(pkg_name, flag, setup_module)
	if lazy_loaded[flag] then
		return true
	end
	local ok = pcall(vim.cmd, "packadd " .. pkg_name)
	if not ok then
		vim.notify("Failed to packadd: " .. pkg_name, vim.log.levels.WARN)
		return false
	end
	if setup_module then
		ok = pcall(require, setup_module)
		if not ok then
			vim.notify("Failed to require: " .. setup_module, vim.log.levels.WARN)
			return false
		end
	end
	lazy_loaded[flag] = true
	return true
end

local function load_harpoon()  return load_plugin("harpoon",   "harpoon", "plugins.harpoon")  end
local function load_peek()     return load_plugin("peek.nvim", "peek",    "plugins.peek")      end
local function load_vimwiki()  return load_plugin("vimwiki",   "vimwiki", "plugins.vimwiki")   end

--- Returns (mark, ui) or (nil, nil) on failure.
local function harpoon()
	if not load_harpoon() then
		return nil, nil
	end
	local ok_m, mark = pcall(require, "harpoon.mark")
	local ok_u, ui   = pcall(require, "harpoon.ui")
	if not ok_m or not ok_u then
		return nil, nil
	end
	return mark, ui
end

-- ─── Autocmds ────────────────────────────────────────────────────────────────

vim.api.nvim_create_autocmd("FileType", {
	pattern  = { "markdown" },
	callback = load_peek,
})

vim.api.nvim_create_autocmd("BufReadPre", {
	pattern  = { "*.wiki", "*.md" },
	callback = function()
		load_vimwiki()
		load_peek()
	end,
})

-- ─── General mappings ────────────────────────────────────────────────────────

map("n", "Q",       "<nop>",          { desc = "Disable Ex mode" })
map("n", "<ESC>",   "<cmd>nohl<cr>",  { desc = "Clear highlight" })
map("n", "<Tab>",   "<cmd>bnext<cr>", { desc = "Goto next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Goto previous buffer" })

map("n", "n", "nzzzv", { desc = "Next search result centered" })
map("n", "N", "Nzzzv", { desc = "Previous search result centered" })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

map("n", "<C-u>", "<C-u>zz", { desc = "Move half page up and center" })
map("n", "<C-d>", "<C-d>zz", { desc = "Move half page down and center" })

map("n", "<C-h>", "<C-w>h", { desc = "Shift focus to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Shift focus to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Shift focus to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Shift focus to top window" })

map("n", "<leader>sv", "<C-w>v",          { desc = "Split window vertically" })
map("n", "<leader>cx", "<cmd>!chmod +x %<cr>", { desc = "Make current file executable", silent = true })

map("n", "<leader>w", ":write<CR>", { desc = "Save file" })
map("n", "<leader>x", ":quit<CR>", {desc="close the window"})

-- ─── Completion ──────────────────────────────────────────────────────────────

map("i", "<Tab>", function()
	return completion.smart_tab()
end, { expr = true, noremap = true, silent = true })

map("i", "<S-Tab>", function()
	return completion.smart_s_tab()
end, { expr = true, noremap = true, silent = true })

-- ─── Clipboard / paste ───────────────────────────────────────────────────────
map("n", "<leader>y", [["+y]],  { desc = "Yank to system clipboard" })
map("v", "<leader>y", [["+y]],  { desc = "Yank to system clipboard (visual)" })
map("n", "<leader>d", [["_d]], { desc = "Delete without yanking" })
map("x", "<leader>y", [["_dP]], { desc = "Paste over without losing clipboard" })

-- ─── Comments ────────────────────────────────────────────────────────────────

map("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

map("v", "<leader>/", function()
	local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.api.nvim_feedkeys(esc, "nx", false)
	require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comment (visual)" })

-- ─── Formatting ──────────────────────────────────────────────────────────────

map("n", "<leader>fm", function()
	require("conform").format({ lsp_format = "fallback" })
end, { desc = "Format buffer" })

-- ─── LSP / Diagnostics ───────────────────────────────────────────────────────

mapn("K", function()
	vim.lsp.buf.hover({ border = "rounded", max_width = 80 })
end, "Hover documentation")
mapn("gD", vim.lsp.buf.declaration, "Goto declaration")
mapn("gi", vim.lsp.buf.implementation, "Goto implementation")
mapn("<leader>lf", vim.lsp.buf.format, "Format buffer")
mapn("<leader>d", vim.diagnostic.open_float, "Open diagnostic float")
mapn("<leader>ca", function()
	require("actions-preview").code_actions()
end, "Code actions preview")

-- ─── Harpoon ─────────────────────────────────────────────────────────────────

map("n", "<leader>a", function()
	local mark, _ = harpoon()
	if mark then mark.add_file() end
end, opts("Harpoon add file"))

map("n", "<leader>o", function()
	local _, ui = harpoon()
	if ui then ui.toggle_quick_menu() end
end, opts("Harpoon quick menu"))

for i = 1, 4 do
	map("n", "<leader>" .. i, function()
		local _, ui = harpoon()
		if ui then ui.nav_file(i) end
	end, opts("Harpoon file " .. i))
end

-- ─── Peek (markdown preview) ─────────────────────────────────────────────────

map("n", "<leader>mp", function()
	if load_peek() then vim.cmd("PeekToggle") end
end, opts("Toggle Peek.nvim [Markdown Preview]"))

-- ─── Vimwiki ─────────────────────────────────────────────────────────────────

map("n", "<leader>ww", function()
	if load_vimwiki() then vim.cmd("VimwikiIndex") end
end, opts("Vimwiki index"))

map("n", "<leader>wt", function()
	if load_vimwiki() then vim.cmd("VimwikiTabIndex") end
end, opts("Vimwiki tab index"))

map("n", "<leader>ws", function()
	if load_vimwiki() then vim.cmd("VimwikiUISelect") end
end, opts("Vimwiki select wiki"))

-- ─── File explorer ───────────────────────────────────────────────────────────

map("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>", opts("Toggle NvimTree"))

map("n", "<leader>ex", function()
	if vim.bo.filetype == "oil" then
		vim.cmd("close")
	else
		require("oil").open_float()
	end
end, opts("Toggle Oil (float)"))

nomap("n", "<C-n>")

-- ─── Terminal ────────────────────────────────────────────────────────────────

map({ "n", "t" }, "<A-i>", function()
	require("nvterm.terminal").toggle("float")
end, opts("Toggle floating terminal"))

map({ "n", "t" }, "<A-h>", function()
	require("nvterm.terminal").toggle("horizontal")
end, opts("Toggle horizontal terminal"))

map({ "n", "t" }, "<A-v>", function()
	require("nvterm.terminal").toggle("vertical")
end, opts("Toggle vertical terminal"))

map("t", "<C-x>", "<C-\\><C-n>", opts("Exit terminal mode"))

-- ─── Telescope ───────────────────────────────────────────────────────────────

map("n", "<leader><space>", "<cmd>Telescope buffers<cr>", opts("View buffers"))
map("n", "<leader>fd",
	"<cmd>lua require('telescope.builtin').live_grep{ search_dirs={'%:p'} }<CR>",
	opts("Grep in current buffer"))

-- ─── Build / run ─────────────────────────────────────────────────────────────

map("n", "<leader>cc", function()
	require("nvterm.terminal").send("cargo run", "vertical")
end, opts("Cargo run in vertical terminal"))

map("n", "<leader>cr", function()
	local file_path = vim.fn.expand("%")
	local filename  = vim.fn.expand("%:t"):match("^([^.]+)")
	require("nvterm.terminal").send(
		"clear && rustc " .. file_path .. " && ./" .. filename, "vertical")
end, opts("Rustc compile and run"))

map("n", "<leader>lx",
	"<cmd>!latexmk -pdf " .. vim.fn.expand("%") .. " 2>&1 > /dev/null<cr>",
	opts("Compile latex document into pdf"))

map("n", "<leader>bl", function()
	local file_path = vim.fn.expand("%")
	require("nvterm.terminal").send("python3 " .. file_path, "horizontal")
end, opts("Run python file in terminal"))

map("n", "<leader>gc", function()
	local file_path = vim.fn.expand("%")
	local filename  = vim.fn.expand("%:t"):match("^([^.]+)") .. ".out"
	require("nvterm.terminal").send(
		"clear && g++ -o " .. filename .. ' "' .. file_path .. '" && ./' .. filename,
		"vertical")
end, opts("G++ compile and run"))
