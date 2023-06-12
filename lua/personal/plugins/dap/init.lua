return {
  { "theHamsta/nvim-dap-virtual-text" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap"
    },
    init = function()
      require("personal.plugins.dap.remap")
      require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      dap.adapters.node2 = {
        type = 'executable',
        command = 'node',
        args = { os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js' },
      }
      dap.configurations.javascript = {
        {
          -- For this to work you need to make sure the node process is started with the `--inspect` flag.
          name = 'Attach to process',
          type = 'node2',
          request = 'attach',
          restart = true,
          stopOnEntry = false,
          processId = require 'dap.utils'.pick_process,
          protocol = "inspector"
        },
      }
      dap.configurations.typescript = {
        {
          -- For this to work you need to make sure the node process is started with the `--inspect` flag.
          name = 'Attach to process',
          type = 'node2',
          request = 'attach',
          restart = true,
          stopOnEntry = false,
          processId = require 'dap.utils'.pick_process,
          protocol = "inspector"
        },
      }
    end
  },
}
