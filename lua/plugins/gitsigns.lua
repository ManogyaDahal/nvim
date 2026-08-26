local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
	return
end

-- we need to understand more of this feature
 gitsigns.setup({})
