local opts = {
  filetypes = {
    "json", "jsonc",
  }
}


require 'lspconfig'.biome.setup {}

return opts
