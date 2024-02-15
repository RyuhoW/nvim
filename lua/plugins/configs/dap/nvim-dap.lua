local nvim_dap_ok, dap = pcall(require, "dap")
if not nvim_dap_ok then
  return
end

local servers = {
  "cppdbg",
  "php",
  "python",
  "js",
  "node2",
}

require('mason-nvim-dap').setup({
  ensure_installed = servers,
  handlers = {
    function(config)
      -- all sources with no handler get passed here

      -- Keep original functionality
      require('mason-nvim-dap').default_setup(config)
    end,

    cppdbg = function(config)
      config.adapters = {
        id = 'cppdbg',
        type = 'executable',
        command = '/usr/local/bin/extension/debugAdapters/bin/OpenDebugAD7',
      }

      config.configurations = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtEntry = true,
        },
      }
      require('mason-nvim-dap').default_setup(config) -- don't forget this!
    end,

    php = function(config)
      config.adapters = {
        type = 'executable',
        command = 'node',
        args = { '/usr/local/bin/vscode-php-debug/out/phpDebug.js' },
      }
      config.configurations = {
        {
          type = 'php',
          request = 'launch',
          name = 'Listen for Xdebug',
          port = 9003,
          program = "${file}", -- This configuration will launch the current file if used.
        },
      }
      require('mason-nvim-dap').default_setup(config) -- don't forget this!
    end,

    python = function(config)
      config.adapters = {
        type = 'executable',
        command = '/root/.local/share/nvim/mason/bin',
        args = {
          '-m',
          'debugpy.adapter',
        },
      }
      require('mason-nvim-dap').default_setup(config) -- don't forget this!
    end,

  },
})


dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
end

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = {"/root/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}"},
  }
}

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}

dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/root/vscode-chrome-debug/out/src/chromeDebug.js" } -- TODO adjust
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  }
}

dap.configurations.typescriptreact = { -- change to typescript if needed
  {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
  }
}


vim.keymap.set({ "n", "t" }, "<A-k>", function()
  dap.step_out()
end)
vim.keymap.set({ "n", "t" }, "<A-l>", function()
  dap.step_into()
end)
vim.keymap.set({ "n", "t" }, "<A-j>", function()
  dap.step_over()
end)
vim.keymap.set({ "n", "t" }, "<A-h>", function()
  dap.continue()
end)
