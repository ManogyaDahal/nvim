local ok, conform = pcall(require, "conform")
if not ok then
	return
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
		go = { "gofmt" },
		python = { "usort" },
		c = { "clang_format" },
		cpp = { "clang_format" },
		bash = { "shfmt" },
		sh = { "shfmt" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
	},
	format_on_save = false,
})
