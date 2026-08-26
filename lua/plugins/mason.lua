local ok, mason = pcall(require, "mason")
if not ok then
  return
end

mason.setup()

local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if not string.find(vim.env.PATH or "", mason_bin, 1, true) then
  vim.env.PATH = mason_bin .. ":" .. (vim.env.PATH or "")
end

local ok_registry, registry = pcall(require, "mason-registry")
if not ok_registry then
  return
end

local ensure_installed = {
  "lua-language-server",
  "eslint_d",
  "clangd",
  "rust-analyzer",
  "stylua",
  "usort",
  "prettierd",
  "prettier",
  "html-lsp",
  "clang-format",
  "deno",
  "typescript-language-server",
  "tailwindcss-language-server",
}

for _, pkg_name in ipairs(ensure_installed) do
  local ok_pkg, pkg = pcall(registry.get_package, pkg_name)
  if ok_pkg and not pkg:is_installed() then
    pkg:install()
  end
end
