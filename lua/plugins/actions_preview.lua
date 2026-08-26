local ok, actions_preview = pcall(require, "actions-preview")
if not ok then
  return
end

actions_preview.setup({})
