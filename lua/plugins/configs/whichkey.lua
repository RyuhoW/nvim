local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false,   -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true,      -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true,      -- default bindings on <c-w>
      nav = true,          -- misc bindings to work with windows
      z = true,            -- bindings for folds, spelling and others prefixed with z
      g = true,            -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>",   -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded",       -- none, single, double, shadow
    position = "bottom",      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },                                             -- min and max height of the columns
    width = { min = 20, max = 50 },                                             -- min and max width of the columns
    spacing = 3,                                                                -- spacing between columns
    align = "left",                                                             -- align columns left, center or right
  },
  ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true,                                                             -- show help message on the command line when the popup is visible
  triggers = "auto",                                                            -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Find files",
  },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["H"] = { "<cmd>split<CR>", "Horizontal split" },
  ["V"] = { "<cmd>vsplit<CR>", "Vertical split" },
  ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  ["T"] = { "<cmd>lua  vim.fn.feedkeys(':Template ')<cr>", "Template" },


  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope diagnostics bufnr=0<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
    F = { "<cmd>Prettier<cr>", "Prettier format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    q = { "<cmd>TodoQuickFix<cr>", "TodoQuickFix" },
    l = { "<cmd>TodoLocList<cr>", "TodoLocList" },
  },

  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },

  d = {
    name = "dap",
    d = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Breakpoint" },
    D = { "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" },
    e = { "<cmd>lua require('dap').continue()<CR>", "execution" },
    --[[ n = { "<cmd>lua require('dap').run_to_cursor()<CR>" }, ]]
    --[[ c = { "<cmd>lua require('dap').terminate()<CR>" }, ]]
    --[[ R = { "<cmd>lua require('dap').clear_breakpoints()<CR>" }, ]]
    --[[ e = { "<cmd>lua require('dap').set_exception_breakpoints({'all'})<CR>" }, ]]
    --[[ a = { "<cmd>lua require('dbugHelper').attach()<CR>" }, ]]
    --[[ A = { "<cmd>lua require('dbugHelper').attachToRemote()<CR>" }, ]]
    --[[ i = { "<cmd>lua require('dap.ui.widgets').hover()<CR>" }, ]]
    --[[ ? = {"local widgets = require ('dap.ui.widgets'); widgets.centered_float(widgets.scopes)<CR>"}, ]]
    --[[ k = { "<cmd>lua require('dap').up()<CR>", "Up" }, ]]
    --[[ j = { "<cmd>lua require('dap').down()<CR>", "Down" }, ]]
    r = { "<cmd>lua require('dap').repl.toggle({},'vsplit')<CR>", "Toogle" },
    u = { "<cmd>lua require('dapui').toggle()<CR>", "UI" },
    s = { "<cmd>Telescope dap frames<CR>", "Telescope frame" },
    b = { "<cmd>Telescope dap list_breakpoints<CR>", "Telescope list_breakpoints" },
  },

  C = {
    name = "Todo Comments",
    p = { "<cmd>lua perf()<CR>", "Performance" },
    h = { "<cmd>lua hack()<CR>", "Hack" },
    t = { "<cmd>lua todo()<CR>", "Todo" },
    f = { "<cmd>lua fix()<CR>", "Fix" },
    w = { "<cmd>lua warning()<CR>", "Warning" },
  },

  p = {
    name = "psql",
    e = { "<cmd>lua require('psql').query_current_line()<CR>", "execute_line" },
    E = { "<cmd>lua require('psql').query_selection()<CR>", "execute_selection" },
    r = { "<cmd>lua require('psql').query_paragraph()<CR>", "execute_paragraph" },
    w = { "<cmd>lua require('psql').close_latest_result()<CR>", "close_latest_result" },
    W = { "<cmd>lua require('psql').close_all_results()<CR>", "close_all_results" },
  },

  n = {
    name = "Neorg",
    c = { "<cmd>Neorg keybind norg core.dirman.new.note<CR>", "Create new note" },
    i = { "<cmd>lua Neorg inject-metadata<CR>", "Create metadata" },
    u = { "<cmd>lua Neorg update-metadata<CR>", "Update-metadata" },
    h = { "<cmd>lua Neorg workspace home<CR>", "home" },
    w = { "<cmd>lua Neorg workspace work<CR>", "work" },
    t = {
      name = "Todo",
      u = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_undon<CR>", "Mark Task as Undone" },
      p = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.pending<CR>", "Mark Task as Pending" },
      d = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_done<CR>", "Mark Task as Done" },
      h = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_on_hold<CR>", "Mark Task as on Hold" },
      c = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_cancelled<CR>", "Mark Task as on Cancelled" },
      r = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_recurring<CR>", "Mark Task as on Recurring" },
      i = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_importan<CR>", "Mark Task as on Importan" },
      C = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_cycle<CR>", "Mark Task as on Cycle" },
      R = { "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_cycle_reverse<CR>", "Mark Task as on cycle_reverse" },
    },
    T = {
      name = "TOC",
      l = { "<cmd>lua Neorg toc left<CR>", "Left TOC" },
      r = { "<cmd>lua Neorg toc right<CR>", "Right TOC" },
      q = { "<cmd>lua Neorg toc qflist<CR>", "Qflist TOC" },
    },
    j = {
      name = "journal",
      t = { "<cmd>lua Neorg journal today<CR>", "Today" },
      y = { "<cmd>lua Neorg journal yesterday<CR>", "yesterday" },
      T = { "<cmd>lua Neorg journal tomorrow<CR>", "Tomorrow" },
      o = { "<cmd>lua Neorg journal toc open<CR>", "TOC open" },
      u = { "<cmd>lua Neorg journal toc update<CR>", "TOC update" },
    },
  },
}

which_key.setup(setup)
which_key.register(mappings, opts)
