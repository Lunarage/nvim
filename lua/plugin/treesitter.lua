return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.cmd.normal("TSUpdate")
    end,
  },
}
