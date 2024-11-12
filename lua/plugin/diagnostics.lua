return {
  {
    "folke/trouble.nvim",
    keys = {
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "luozhiya/lsp-virtual-improved.nvim",
    event = { "LspAttach" },
    config = function()
      require("lsp-virtual-improved").setup({
        severity = nil, -- Same usage as virtual_text.severity
        spacing = 4, -- Same usage as virtual_text.spacing
        prefix = "●", -- Same usage as virtual_text.prefix
        suffix = "", -- Same usage as virtual_text.suffix
        current_line = "default", -- Current Line: 'only', 'hide', 'default'
        code = nil, -- Show diagnostic code.
      })

      -- local diagnostics = {
      --   virtual_text = false,
      --   virtual_improved = {
      --     current_line = 'only';
      --   }
      -- }

      -- vim.diagnostic.config(diagnostics);
    end,
  },
}
