return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "nvim-neotest/nvim-nio" },
      { "nvim-lua/plenary.nvim" },
      { "antoinemadec/FixCursorHold.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
      { "thenbe/neotest-playwright",      depencencies = { "nvim-telescope/telescope.nvim" } },
      { "nvim-neotest/neotest-jest" },
      { "marilari88/neotest-vitest" },
      -- {
      --   "mfussenegger/nvim-dap",
      --   config = function()
      --     local dap = require("dap")
      --     dap.adapters["pwa-node"] = {
      --       type = "server",
      --       host = "localhost",
      --       port = "${port}",
      --       executable = {
      --         command = "node",
      --         args = { "/usr/bin/dapDebugServer.js", "${port}" },
      --       },
      --     }
      --     dap.configurations.typescript = {
      --       {
      --         type = "pwa-node",
      --         request = "launch",
      --         name = "Launch file",
      --         runtimeExecutable = "deno",
      --         runtimeArgs = {
      --           "run",
      --           "--inspect-wait",
      --           "--allow-all",
      --         },
      --         program = "${file}",
      --         cwd = "${workspaceFolder}",
      --         attachSimplePort = 9229,
      --       },
      --     }
      --   end,
      -- },
    },
    cmd = { "Neotest" },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-jest"),
          require("neotest-vitest"),
          require("neotest-playwright").adapter(),
        },
      })
    end,
  },
  {
    "quolpr/quicktest.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "m00qek/baleia.nvim",
    },
    config = function()
      local qt = require("quicktest")
      qt.setup({
        adapters = {
          require("quicktest.adapters.vitest"),
          require("quicktest.adapters.golang")({
            additional_args = function(bufnr)
              return { '-race', '-count=1' }
            end
          }),
        },
      })

      vim.keymap.set("n", "<leader>tt", qt.toggle_win, { desc = "[T]oggle [T]est window" })
      vim.keymap.set("n", "<leader>tl", qt.run_line, { desc = "[T]est [L]ine" })
      vim.keymap.set("n", "<F5>", qt.run_file, { desc = "Test file" })
    end,
  },
}
