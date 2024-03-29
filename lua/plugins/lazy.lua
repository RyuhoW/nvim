local fn = vim.fn

local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if fn.empty(fn.glob(lazypath)) > 0 then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latestjstable release
    lazypath,
  })
  print("Installing lazy.nvim close and reopen Neovim.")
end
vim.opt.rtp:prepend(lazypath)

-- Use a protexted call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

vim.g.mapleader = " "

-- Install your plugins here
return lazy.setup({
  spec = {
    -- My plugins here
    "nvim-lua/popup.nvim",   -- An implementation of the Popup API from vim in Neovim
    "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
    "windwp/nvim-ts-autotag",
    "nvim-tree/nvim-web-devicons",
    "nvim-tree/nvim-tree.lua",
    "moll/vim-bbye",
    "nvim-lualine/lualine.nvim",
    "akinsho/toggleterm.nvim",
    "ahmedkhalf/project.nvim",
    "lewis6991/impatient.nvim",
    "goolord/alpha-nvim",
    "folke/which-key.nvim",
    "folke/neodev.nvim",
    "folke/todo-comments.nvim",
    { "glepnir/template.nvim", cmd = { "Template", "TemProject" } },
    "mzarnitsa/psql",
    "barrett-ruth/live-server.nvim",
    "dmmulroy/tsc.nvim",
    "MunifTanjim/prettier.nvim",
    { "echasnovski/mini.nvim", version = '*' },
    "RRethy/vim-illuminate",
    {
      "nvim-neorg/neorg",
      run = ":Neorg sync-parsers",
    },

    -- Colorsheme
    { "folke/tokyonight.nvim", lazy = false },
    "norcalli/nvim-colorizer.lua",

    -- cmp plugins
    "hrsh7th/nvim-cmp",         -- The completion plugin
    "hrsh7th/cmp-buffer",       -- buffer completions
    "hrsh7th/cmp-path",         -- path completions
    "hrsh7th/cmp-cmdline",      -- cmdline completions
    "saadparwaiz1/cmp_luasnip", -- snippet completions
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",

    -- snippets
    {
      "L3MON4D3/LuaSnip", --snippet engine
      version = "v2.*",
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "rafamadriz/friendly-snippets", -- a bunch of snippets to use

    -- LSP
    "neovim/nvim-lspconfig", -- enable LSP
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate"             -- :MasonUpdate updates registry contents
    },
    "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
    "jay-babu/mason-null-ls.nvim",
    "jose-elias-alvarez/null-ls.nvim",   -- LSP diagnostics and code actions

    -- DAP
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "jbyuki/one-small-step-for-vimkind",
    "jay-babu/mason-nvim-dap.nvim",
    "mxsdev/nvim-dap-vscode-js",

    -- Telescope
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-telescope/telescope-dap.nvim",

    -- Treesitter
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
    },
    "JoosepAlviste/nvim-ts-context-commentstring",

    -- Git
    "lewis6991/gitsigns.nvim",

    --PlantUML
    "weirongxu/plantuml-previewer.vim",
    "tyru/open-browser.vim",
    "aklt/plantuml-syntax",
  },
  defaults = { lazy = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
})
