return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvimtools/hydra.nvim",
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {}
      },
      {
        "igorlfs/nvim-dap-view",
        keys = {
          { "<leader>du", function() require("dap-view").toggle(true) end, desc = "Dap View toggle" },
        },
        opts = {
          winbar = {
            sections = { "scopes", "watches", "breakpoints", "threads", "repl", "console" },
            default_section = "scopes",
            controls = { enabled = true }
          },
          windows = {
            position = "right",
          },
          switchbuf = "uselast"
        }
      }
    },
    keys = {
      "<leader>dd",
    },
    config = function()
      local dap = require("dap")
      local dv = require("dap-view")
      local Hydra = require("hydra")
      local vscode = require("dap.ext.vscode")
      local widgets = require("dap.ui.widgets")

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
      }

      local function load_launch_json()
        local root = require('seba.util').get_git_root()
        if not root then
          vim.notify("Git root not found", vim.log.levels.WARN)
          return
        end
        local path = root .. "/.vscode/launch.json"
        if vim.fn.filereadable(path) == 1 then
          vim.keymap.set('n', '<leader>du', function() require("dapui").toggle() end, { desc = "Dap UI" })
          vscode.load_launchjs(path, { cppdbg = { "c", "cpp", "cc" } })
          vim.notify("Loaded launch.json from " .. path, vim.log.levels.INFO)
        else
          vim.notify("launch.json not found at " .. path, vim.log.levels.WARN)
        end
      end

      dap.listeners.before.attach["dap-view-config"] = function()
        dv.open()
      end
      dap.listeners.before.launch["dap-view-config"] = function()
        dv.open()
      end
      dap.listeners.before.event_terminated["dap-view-config"] = function()
        dv.close(true)
      end
      dap.listeners.before.event_exited["dap-view-config"] = function()
        dv.close(true)
      end

      -- Update statusline
      local original_mode = require("mini.statusline").section_mode
      local function set_statusline()
        require("mini.statusline").section_mode = function()
          return "DEBUG", "MiniStatuslineModeOther"
        end
      end

      local function restore_mode()
        require("mini.statusline").section_mode = original_mode
      end

      Hydra({
        config = {
          hint = false,
          color = 'pink',
          invoke_on_body = true,
          on_enter = function()
            set_statusline()
          end,
          on_exit = function()
            restore_mode()
          end
        },
        mode = "n",
        body = "<leader>dd",
        heads = {
          { "c", dap.continue,                                  { desc = false } },
          { "r", dap.run_to_cursor,                             { desc = false } },
          { "L", dap.step_over,                                 { desc = false } },
          { "I", dap.step_into,                                 { desc = false } },
          { "O", dap.step_out,                                  { desc = false } },
          { "H", widgets.hover,                                 { desc = false } },
          { "J", dap.down,                                      { desc = false } },
          { "K", dap.up,                                        { desc = false } },
          { "t", dap.toggle_breakpoint,                         { desc = false } },
          { "x", dap.clear_breakpoints,                         { desc = false } },
          { "X", dap.terminate,                                 { desc = false } },
          { "a", dv.add_expr,                                   { desc = false } },
          { "R", function() dv.jump_to_view("repl") end,        { desc = false } },
          { "S", function() dv.jump_to_view("scopes") end,      { desc = false } },
          { "T", function() dv.jump_to_view("threads") end,     { desc = false } },
          { "W", function() dv.jump_to_view("watches") end,     { desc = false } },
          { "C", function() dv.jump_to_view("console") end,     { desc = false } },
          { "B", function() dv.jump_to_view("breakpoints") end, { desc = false } },
          { "U", function() dv.toggle(true) end,                { desc = false } },
          { "q", nil,                                           { exit = true, nowait = true, desc = false } },
        },
      })

      vim.api.nvim_create_user_command("LoadLaunchJson", function()
        load_launch_json()
      end, { desc = "Load .vscode/launch.json from project root" })
      load_launch_json()

      vim.keymap.set("n", "<leader>dv", function() require("nvim-dap-virtual-text").toggle() end,
        { desc = "Toggle DAP virtual text" })
    end,
  }
}
