return {
  {
    "lewis6991/hover.nvim",
    config = function()
      require("hover").setup({
        init = function()
          require("hover.providers.lsp")
          require("hover.providers.fold_preview")
          require("hover.providers.dictionary")
          require("hover.providers.diagnostic")
        end,
        preview_opts = { border = "single" },
        preview_window = true,
        title = true,
      })
      vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
    end,
  },
}
