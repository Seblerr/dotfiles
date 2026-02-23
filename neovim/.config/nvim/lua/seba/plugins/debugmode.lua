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
            default_section = "scopes"
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

      -- DAP Configs
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

      -- Icons
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "GitSignsChangeInline" })

      for name, sign in pairs(require('seba.util.icons').dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
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

      -- Keybind helper
      local debug_help_hydra = Hydra({
        name = "Debug Help",
        mode = "n",
        config = {
          color = "amaranth",
          invoke_on_body = true,
          hint = {
            position = "bottom",
            type = "window",
          },
        },
        heads = {
          { "<Esc>", nil, { exit = true, nowait = true } },
          { "?",     nil, { exit = true, nowait = true } },
          { "q",     nil, { exit = true, nowait = true } },
        },
        hint = [[
  [ Debug Hydra Bindings ]
  c: Continue     r: Run to cursor
  H: Step back    L: Step over   I: Step in
  O: Step out     t: Toggle BP   x: Clear BPs
  a: Watch expr   U: Toggle views X: Terminate
  J: Stack up     K: Stack down
  R: REPL         S: Scopes      T: Threads    W: Watches
  C: Console      B: Breakpoints q: Quit Hydra
  ]],
      })

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
          { "H", dap.step_back,                                 { desc = false } },
          { "L", dap.step_over,                                 { desc = false } },
          { "I", dap.step_into,                                 { desc = false } },
          { "O", dap.step_out,                                  { desc = false } },
          -- { "H", widgets.hover,                                 { desc = false } },
          { "J", dap.up,                                        { desc = false } },
          { "K", dap.down,                                      { desc = false } },
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
          { "?", function() debug_help_hydra:activate() end,    { desc = "show help" } },
          { "q", nil,                                           { exit = true, nowait = true, desc = false } },
        },
      })

      local function load_launch_json()
        local root = require('seba.util').get_git_root()
        if not root then
          vim.notify("Git root not found", vim.log.levels.WARN)
          return
        end
        local path = root .. "/.vscode/launch.json"
        if vim.fn.filereadable(path) == 1 then
          vscode.load_launchjs(path, { cppdbg = { "c", "cpp", "cc" } })
          vim.notify("Loaded launch.json from " .. path, vim.log.levels.INFO)
        end
      end
      load_launch_json()

      vim.keymap.set("n", "<leader>dl", load_launch_json, { desc = "Load launch.json" })
      vim.keymap.set("n", "<leader>dv", function() require("nvim-dap-virtual-text").toggle() end,
        { desc = "Toggle DAP virtual text" })
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    dependencies = "mfussenegger/nvim-dap",
    ft = "python",
    config = function()
      require("dap-python").setup("uv")

      -- Inject project env vars (vim.g.dap_python_env) into all Python DAP launches.
      -- Projects set this global in .nvim.lua (exrc).
      local dap = require("dap")
      local original_dap_run = dap.run
      ---@diagnostic disable-next-line: duplicate-set-field
      dap.run = function(config, opts)
        if config.type == "python" then
          if vim.g.dap_python_env then
            config.env = vim.tbl_extend("keep", config.env or {}, vim.g.dap_python_env)
          end
          if config.module == "pytest" then
            config.console = config.console or "integratedTerminal"
          end
        end
        return original_dap_run(config, opts)
      end
    end,
    keys = {
      { "<leader>dpt", function() require("dap-python").test_method() end,     desc = "Debug Method",    ft = "python" },
      { "<leader>dpc", function() require("dap-python").test_class() end,      desc = "Debug Class",     ft = "python" },
      { "<leader>dps", function() require('dap-python').debug_selection() end, desc = "Debug Selection", ft = "python" },
      {
        "<leader>dpf",
        function()
          require("dap").run({
            type = "python",
            request = "launch",
            name = "Pytest: Current File",
            module = "pytest",
            args = { vim.fn.expand("%:p") },
          })
        end,
        desc = "Debug File",
        ft = "python",
      }
    }
  }
}
