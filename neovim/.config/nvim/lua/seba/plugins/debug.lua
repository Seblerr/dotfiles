return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { "nvim-neotest/nvim-nio" },
        keys = {
          { "<leader>du", function() require("dapui").toggle() end,               desc = "Dap UI" },
          { "<leader>dr", function() require("dapui").open({ reset = true }) end, desc = "Reset Dap UI" },
          { "<leader>de", function() require("dapui").eval() end,                 desc = "Eval",        mode = { "n", "v" } },
        },
        config = function()
          local dap = require('dap')
          local dapui = require('dapui')

          dapui.setup()

          dap.listeners.before.attach.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.launch.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
          end
          dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
          end
        end
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    keys = {
      { "<leader>dc", function() require('dap').continue() end,          "Start/continue debug" },
      { "<leader>db", function() require('dap').toggle_breakpoint() end, "Toggle breakpoint" },
      { "<leader>dv", function()
        local launch_path = require('seba.util').get_git_root() .. '/.vscode/launch.json'
        require('dap.ext.vscode').load_launchjs(launch_path, { cppdbg = { 'cc', 'cpp' } })
        vim.notify("Loaded launch.json", vim.log.levels.INFO)
      end, "Debug: Load launch.json" }
    },
    config = function()
      local dap = require 'dap'

      -- Keymaps
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>dj', dap.down, { desc = 'Debug: Down' })
      vim.keymap.set('n', '<leader>dk', dap.up, { desc = 'Debug: Up' })
      vim.keymap.set('n', '<leader>dl', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<leader>dh', dap.step_back, { desc = 'Debug: Step Back' })
      vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'Debug: Terminate' })
      vim.keymap.set('n', '<leader>ds', dap.session, { desc = 'Debug: Terminate' })
      vim.keymap.set('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Breakpoint' })

      dap.adapters.cppdbg = {
        id = 'cppdbg',
        type = 'executable',
        command = 'OpenDebugAD7'
      }

      dap.configurations.cpp = {
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
        {
          name = 'Attach to process',
          type = 'cppdbg',
          request = 'attach',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          processId = "${command:pickProcess}"
        },
        {
          name = 'Attach to gdbserver :1234',
          type = 'cppdbg',
          request = 'launch',
          MIMode = 'gdb',
          miDebuggerServerAddress = 'localhost:1234',
          miDebuggerPath = '/usr/bin/gdb',
          cwd = '${workspaceFolder}',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
        },
      }

      -- Visual
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      local icons = require("seba.util.icons")
      for name, sign in pairs(icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    ft = "python",
    keys = {
      { "<leader>dpt", function() require("dap-python").test_method() end,     desc = "Debug Method",    ft = "python" },
      { "<leader>dpc", function() require("dap-python").test_class() end,      desc = "Debug Class",     ft = "python" },
      { "<leader>dps", function() require('dap-python').debug_selection() end, desc = "Debug Selection", ft = "python" }
    },
    config = function()
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
    end
  }

}
