local ok, scrollEOF = pcall(require, "scrollEOF")
if not ok then
	return
end

scrollEOF.setup({})
