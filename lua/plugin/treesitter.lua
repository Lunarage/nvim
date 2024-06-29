return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.cmd.normal("TSUpdate")
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "javascript",
          "tsx",
          "typescript",
          "json",
          "toml",
          "bash",
          "ini",
          "vimdoc",
          "markdown",
          "markdown_inline",
          "prisma",
          "python",
          "query"
        },
        highlight = { enable = true },
      })
    end,
  },
}
