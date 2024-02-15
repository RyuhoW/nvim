require("nvim-dap-virtual-text").setup()

require('dap').set_log_level('INFO')
vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🌟", texthl = "", linehl = "", numhl = "" })

