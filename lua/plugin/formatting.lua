return {
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        filetype = {
          lua = {
            require("formatter.filetypes.lua").stylua,
          },
          json = {
            require("formatter.filetypes.json").prettier,
          },
          yaml = {
            require("formatter.filetypes.yaml").yamlfmt,
          },
          go = {
            function()
              return {
                exe = "golines",
                args = {
                  "--max-len=100",
                  "--tab-len=2",
                },
                stdin = true,
              }
            end
          },
          markdown = {
            function()
              return {
                exe = "mdformat",
                args = {
                  "--wrap 100",
                  "-",
                },
                stdin = true,
              }
            end,
          },
        },
      })
    end,
  },
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = {
      "ga",
      { "ga", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" }
    },
    lazy = false,
  }
  -- {
  --   "lukas-reineke/lsp-format.nvim",
  --   config = function()
  --     require("lsp-format").setup({})
  --   end,
  -- },
}
