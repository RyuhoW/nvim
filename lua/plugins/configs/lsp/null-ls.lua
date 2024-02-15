local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

require("mason-null-ls").setup({
  ensure_installed = {
    'prettier',
    'sylua',
    'black',
    'flake8',
    'phpstan',
    'cppcheck',
    'clang_format',
    'eslint_d',
  },
  automatic_installation = false,
  automatic_setup = true,
})

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  debug = false,
  sources = {
  },
})
