return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.cmd.normal("TSUpdate")
    end,
    config = function ()
      require('nvim-treesitter.configs').setup({
        highlight = { enable = true }
      })
    end
  },
}
