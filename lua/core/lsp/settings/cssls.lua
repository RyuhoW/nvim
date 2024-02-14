local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local opts={
}

require'lspconfig'.cssls.setup {
    capabilities = capabilities,
}

return opts
