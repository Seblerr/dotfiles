return {
  -- {
  --   'mfussenegger/nvim-dap',
  --   dependencies = {
  --     {
  --       "igorlfs/nvim-dap-view",
  --       enabled = false,
  --       keys = {
  --         { "<leader>du", function() require("dap-view").toggle(true) end,            desc = "Dap View toggle" },
  --         { "<leader>dw", function() require("dap-view").add_expr() end,              desc = "Dap View Watch" },
  --         { "<leader>ds", function() require("dap-view").jump_to_view("threads") end, desc = "Dap View Watch" },
  --       },
  --       opts = {
  --         winbar = {
  --           sections = { "watches", "breakpoints", "threads", "repl" },
  --         },
  --         switchbuf = "uselast"
  --       },
  --       config = function(_, opts)
  --         local dap, dv = require("dap"), require("dap-view")
  --         -- dap.defaults.fallback.switchbuf = "useopen"
  --         dv.setup(opts)
  --         dap.listeners.before.attach["dap-view-config"] = function()
  --           dv.open()
  --         end
  --         dap.listeners.before.launch["dap-view-config"] = function()
  --           dv.open()
  --         end
  --         dap.listeners.before.event_terminated["dap-view-config"] = function()
  --           dv.close()
  --         end
  --         dap.listeners.before.event_exited["dap-view-config"] = function()
  --           dv.close()
  --         end
  --       end
  --     },
  --     {
  --       'rcarriga/nvim-dap-ui',
  --       enable = true,
  --       dependencies = { "nvim-neotest/nvim-nio" },
  --       keys = {
  --         { "<leader>du", function() require("dapui").toggle() end,               desc = "Dap UI" },
  --         { "<leader>dr", function() require("dapui").open({ reset = true }) end, desc = "Reset Dap UI" },
  --         { "<leader>de", function() require("dapui").eval() end,                 desc = "Eval",        mode = { "n", "v" } },
  --         vim.keymap.set("n", "<leader>dw", function()
  --           require("dapui").elements.watches.add(vim.fn.expand("<cword>"))
  --         end, { desc = "Add variable under cursor to watch list" })
  --       },
  --       opts = {
  --         layouts = { {
  --           elements = { {
  --             id = "breakpoints",
  --             size = 0.2
  --           }, {
  --             id = "watches",
  --             size = 0.3
  --           }, {
  --             id = "stacks",
  --             size = 0.5
  --           } },
  --           position = "left",
  --           size = 25
  --         }, {
  --           elements = { {
  --             id = "repl",
  --             size = 0.5
  --           }, {
  --             id = "console",
  --             size = 0.5
  --           } },
  --           position = "bottom",
  --           size = 8
  --         } },
  --       },
  --       config = function(_, opts)
  --         local dap = require('dap')
  --         local dapui = require('dapui')
  --
  --         dapui.setup(opts)
  --
  --         dap.listeners.before.attach.dapui_config = function()
  --           dapui.open()
  --         end
  --         dap.listeners.before.launch.dapui_config = function()
  --           dapui.open()
  --         end
  --         dap.listeners.before.event_terminated.dapui_config = function()
  --           dapui.close()
  --         end
  --         dap.listeners.before.event_exited.dapui_config = function()
  --           dapui.close()
  --         end
  --       end
  --     },
  --   },
  --   keys = {
  --     { "<leader>dc", function() require('dap').continue() end,          "Start/continue debug" },
  --     { "<leader>db", function() require('dap').toggle_breakpoint() end, "Toggle breakpoint" },
  --     { "<leader>dv", function()
  --       local launch_path = require('seba.util').get_git_root() .. '/.vscode/launch.json'
  --       require('dap.ext.vscode').load_launchjs(launch_path, { cppdbg = { 'cc', 'cpp' } })
  --       vim.notify("Loaded launch.json", vim.log.levels.INFO)
  --     end, "Debug: Load launch.json" }
  --   },
  --   config = function()
  --     local dap = require 'dap'
  --
  --     -- Keymaps
  --     vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
  --     vim.keymap.set('n', '<leader>do', dap.step_out, { desc = 'Debug: Step Out' })
  --     vim.keymap.set('n', '<leader>dk', dap.down, { desc = 'Debug: Down' })
  --     vim.keymap.set('n', '<leader>dj', dap.up, { desc = 'Debug: Up' })
  --     vim.keymap.set('n', '<leader>dl', dap.step_over, { desc = 'Debug: Step Over' })
  --     vim.keymap.set('n', '<leader>dh', dap.step_back, { desc = 'Debug: Step Back' })
  --     vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'Debug: Terminate' })
  --     -- vim.keymap.set('n', '<leader>ds', dap.session, { desc = 'Debug: Terminate' })
  --     vim.keymap.set('n', '<leader>dB', function()
  --       dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  --     end, { desc = 'Debug: Set Breakpoint' })
  --
  --     dap.adapters.cppdbg = {
  --       id = 'cppdbg',
  --       type = 'executable',
  --       command = 'OpenDebugAD7'
  --     }
  --
  --     dap.configurations.cpp = {
  --       {
  --         name = "Launch file",
  --         type = "cppdbg",
  --         request = "launch",
  --         program = function()
  --           return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  --         end,
  --         cwd = '${workspaceFolder}',
  --         stopAtEntry = true,
  --       },
  --       {
  --         name = 'Attach to process',
  --         type = 'cppdbg',
  --         request = 'attach',
  --         program = function()
  --           return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  --         end,
  --         processId = "${command:pickProcess}"
  --       },
  --       {
  --         name = 'Attach to gdbserver :1234',
  --         type = 'cppdbg',
  --         request = 'launch',
  --         MIMode = 'gdb',
  --         miDebuggerServerAddress = 'localhost:1234',
  --         miDebuggerPath = '/usr/bin/gdb',
  --         cwd = '${workspaceFolder}',
  --         program = function()
  --           return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  --         end,
  --       },
  --     }
  --
  --     vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
  --   end,
  -- },

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
