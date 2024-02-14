local lspconfig = require('lspconfig')

local opts ={
   handlers = {
      -- Don't open quickfix list in case of multiple definitions. At the
      -- moment, this conflicts the `a = function()` code style because
      -- sumneko_lua treats both `a` and `function()` to be definitions of `a`.
      ['textDocument/definition'] = function(_, result, ctx, _)
        -- Adapted from source:
        -- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp/handlers.lua#L341-L366
        if result == nil or vim.tbl_isempty(result) then return nil end
        local client = vim.lsp.get_client_by_id(ctx.client_id)

        local res = vim.tbl_islist(result) and result[1] or result
        vim.lsp.util.jump_to_location(res, client.offset_encoding)
      end,
    },
    cmd = { sumneko_binary, '-E', sumneko_root .. '/main.lua' },
    on_attach = function(client, bufnr)
      on_attach_custom(client, bufnr)
      -- Reduce unnecessarily long list of completion triggers for better
      -- `MiniCompletion` experience
      client.server_capabilities.completionProvider.triggerCharacters = { '.', ':' }
    end,
    root_dir = function(fname) return lspconfig.util.root_pattern('.git')(fname) or lspconfig.util.path.dirname(fname) end,

	settings = {
      Lua = {
             diagnostics = {
          -- Get the language server to recognize common globals
          globals = { 'vim', 'describe', 'it', 'before_each', 'after_each' },
          disable = { 'need-check-nil' },
        },
        workspace = {
                -- Make the server aware of Neovim runtime files
          library = { [vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true },
        },
    },
		-- Lua = {
		-- 	diagnostics = {
		-- 		globals = { "vim" },
		-- 	},
		-- 	workspace = {
		-- 		library = {
		-- 			[vim.fn.expand("$VIMRUNTIME/lua")] = true,
		-- 			[vim.fn.stdpath("config") .. "/lua"] = true,
		-- 		},
		-- 	},
		-- },
	},
}
lspconfig.sumneko_lua.setup {}

return opts
