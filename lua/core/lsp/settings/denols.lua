local opts =
    vim.g.markdown_fenced_languages = {
      "ts=typescript"
    }

require 'lspconfig'.denols.setup {}

return opts
