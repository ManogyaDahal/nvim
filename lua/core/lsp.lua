local servers = {
  "rust_analyzer",
  "html",
  "cssls",
  "pylsp",
  "ts_ls",
  "lua_ls",
  "clangd",
  "bashls",
  "phpactor",
  "texlab",
  "gopls",
  "jdtls",
  "yamlls",
  "tailwindcss-language-server",
  "tinymist",
  "asm_lsp",
}

local ok_lspconfig = pcall(require, "lspconfig")
if not ok_lspconfig then
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_mini, mini_completion = pcall(require, "mini.completion")
if ok_mini and mini_completion.get_lsp_capabilities then
  capabilities = vim.tbl_deep_extend(
    "force",
    capabilities,
    mini_completion.get_lsp_capabilities()
  )
end



for _, server in ipairs(servers) do
  vim.lsp.config(server, { capabilities = capabilities })
end

vim.lsp.enable(servers)
