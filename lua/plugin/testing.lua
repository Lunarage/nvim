return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-go",
      { "thenbe/neotest-playwright", depencencies = { "nvim-telescope/telescope.nvim" } },
    },
    config = function()
      local neotest = require("neotest")

      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
              diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      neotest.setup({
        adapters = {
          require("neotest-jest"),
          require("neotest-vitest"),
          require("neotest-playwright").adapter(),
          require("neotest-go"),
        },
      })

      vim.keymap.set("n", "<leader>tt", neotest.run.run, { desc = "Run nearest test" })
      vim.keymap.set("n", "<F5>", function()
        neotest.run.run({ strategy = "dap" })
      end, { desc = "Test file" })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.go = {
        type = "executable",
        command = "node",
        args = { os.getenv("HOME") .. "/dev/golang/vscode-go/extension/dist/debugAdapter.js" },
      }
      dap.configurations.go = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          showLog = false,
          program = "${file}",
          dlvToolPath = vim.fn.exepath("dlv"), -- Adjust to where delve is installed
        },
      }
    end,
  },
}
